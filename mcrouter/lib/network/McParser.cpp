/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the LICENSE
 * file in the root directory of this source tree.
 */
#include "McParser.h"

#include <algorithm>
#include <new>
#include <utility>

#include <folly/Format.h>
#include <folly/ThreadLocal.h>
#include <folly/experimental/JemallocNodumpAllocator.h>
#include <folly/io/Cursor.h>
#include <folly/lang/Bits.h>
#include <glog/logging.h>

#include "mcrouter/lib/Clocks.h"
#include "mcrouter/lib/network/CaretProtocol.h"

namespace facebook {
namespace memcache {

namespace {
// Adjust buffer size after this many CPU cycles (~2 billion)
constexpr uint64_t kAdjustBufferSizeCpuCycles = 1UL << 31;
// Max allowed body size is 1GB.
constexpr size_t kMaxBodySize = 1UL << 30;

#ifdef FOLLY_JEMALLOC_NODUMP_ALLOCATOR_SUPPORTED

folly::ThreadLocal<folly::JemallocNodumpAllocator> allocator;

folly::IOBuf copyToNodumpBuffer(
    const CaretMessageInfo& umMsgInfo,
    const folly::IOBuf& readBuffer) {
  // Allocate buffer
  const size_t bufSize = umMsgInfo.headerSize + umMsgInfo.bodySize;
  void* p = allocator->allocate(bufSize);
  if (!p) {
    LOG(WARNING) << "Not enough memory to create a nodump buffer";
    throw std::bad_alloc();
  }
  // Copy data
  folly::io::Cursor c(&readBuffer);
  c.pull(p, readBuffer.length());
  // Transfer ownership to a new IOBuf
  return folly::IOBuf(
      folly::IOBuf::TAKE_OWNERSHIP,
      p,
      bufSize,
      readBuffer.length(),
      folly::JemallocNodumpAllocator::deallocate,
      reinterpret_cast<void*>(allocator->getFlags()));
}

#endif

} // namespace

McParser::McParser(
    ParserCallback& callback,
    size_t minBufferSize,
    size_t maxBufferSize,
    const bool useJemallocNodumpAllocator,
    ConnectionFifo* debugFifo)
    : callback_(callback),
      bufferSize_(minBufferSize),
      maxBufferSize_(maxBufferSize),
      debugFifo_(debugFifo),
      readBuffer_(folly::IOBuf::CREATE, bufferSize_),
      useJemallocNodumpAllocator_(useJemallocNodumpAllocator) {
#ifndef FOLLY_JEMALLOC_NODUMP_ALLOCATOR_SUPPORTED
  useJemallocNodumpAllocator_ = false;
#endif
}

void McParser::reset() {
  readBuffer_.clear();
}

std::pair<void*, size_t> McParser::getReadBuffer() {
  assert(!readBuffer_.isChained());
  readBuffer_.unshareOne();
  if (!readBuffer_.length()) {
    assert(readBuffer_.capacity() > 0);
    /* If we read everything, reset pointers to 0 and re-use the buffer */
    readBuffer_.clear();
  } else if (readBuffer_.headroom() > 0) {
    /* Move partially read data to the beginning */
    readBuffer_.retreat(readBuffer_.headroom());
  } else {
    /* Reallocate more space if necessary */
    readBuffer_.reserve(0, bufferSize_);
  }
  return std::make_pair(readBuffer_.writableTail(), readBuffer_.tailroom());
}

bool McParser::readCaretData() {
  while (readBuffer_.length() > 0) {
    // Parse header
    ParseStatus parseStatus;
    parseStatus =
        caretParseHeader(readBuffer_.data(), readBuffer_.length(), msgInfo_);

    if (parseStatus == ParseStatus::NotEnoughData) {
      return true;
    }

    if (parseStatus != ParseStatus::Ok) {
      callback_.parseError(
          carbon::Result::REMOTE_ERROR,
          folly::sformat(
              "Error parsing {} header", mc_protocol_to_string(protocol_)));
      return false;
    }

    const auto messageSize = msgInfo_.headerSize + msgInfo_.bodySize;

    // Case 0: There was an overflow. Return an error and let mcrouter close the
    // connection.
    if (messageSize == 0) {
      LOG(ERROR)
          << "Got a 0 size message, likely due to overflow. Returning a parse error.";
      return false;
    }

    // Parse message body
    // Case 1: Entire message (and possibly part of next) is in the buffer
    if (readBuffer_.length() >= messageSize) {
      if (UNLIKELY(debugFifo_ && debugFifo_->isConnected())) {
        debugFifo_->startMessage(MessageDirection::Received, msgInfo_.typeId);
        debugFifo_->writeData(readBuffer_.writableData(), messageSize);
      }

      bool cbStatus;
      cbStatus = callback_.caretMessageReady(msgInfo_, readBuffer_);

      if (!cbStatus) {
        readBuffer_.clear();
        return false;
      }
      readBuffer_.trimStart(messageSize);
      continue;
    }

    // Case 2: We don't have full header, so return to wait for more data
    if (readBuffer_.length() < msgInfo_.headerSize) {
      return true;
    }

    // Case 3: We have the full header, but not the full body. If needed,
    // reallocate into a buffer large enough for full header and body. Then
    // return to wait for remaining data.
    if (readBuffer_.length() + readBuffer_.tailroom() < messageSize) {
      assert(!readBuffer_.isChained());
      if (messageSize > kMaxBodySize) {
        LOG(ERROR) << "Body size was " << messageSize
                   << ", but max size allowed is " << kMaxBodySize;
        return false;
      }
      readBuffer_.unshareOne();
      bufferSize_ = std::max<size_t>(bufferSize_, messageSize);
      readBuffer_.reserve(
          0 /* minHeadroom */,
          bufferSize_ - readBuffer_.length() /* minTailroom */);
    }
#ifdef FOLLY_JEMALLOC_NODUMP_ALLOCATOR_SUPPORTED
    if (useJemallocNodumpAllocator_) {
      readBuffer_ = copyToNodumpBuffer(msgInfo_, readBuffer_);
    }
#endif
    return true;
  }

  // We parsed everything, read buffer is empty.
  // Try to shrink it to reduce memory footprint
  if (bufferSize_ > maxBufferSize_) {
    auto curCycles = cycles::getCpuCycles();
    if (curCycles > lastShrinkCycles_ + kAdjustBufferSizeCpuCycles) {
      lastShrinkCycles_ = curCycles;
      bufferSize_ = maxBufferSize_;
      readBuffer_ = folly::IOBuf(folly::IOBuf::CREATE, bufferSize_);
    }
  }
  return true;
}

bool McParser::readDataAvailable(size_t len) {
  // Caller is responsible for ensuring the read buffer has enough tailroom
  readBuffer_.append(len);
  if (UNLIKELY(readBuffer_.length() == 0)) {
    return true;
  }

  if (UNLIKELY(!seenFirstByte_)) {
    seenFirstByte_ = true;
    protocol_ = determineProtocol(*readBuffer_.data());
    if (protocol_ == mc_ascii_protocol) {
      outOfOrder_ = false;
    } else {
      assert(protocol_ == mc_caret_protocol);
      outOfOrder_ = true;
    }
  }

  if (protocol_ == mc_ascii_protocol) {
    callback_.handleAscii(readBuffer_);
    return true;
  }
  return readCaretData();
}

} // namespace memcache
} // namespace facebook
