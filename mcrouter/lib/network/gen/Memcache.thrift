/*
 *  Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 *  This source code is licensed under the MIT license found in the LICENSE
 *  file in the root directory of this source tree.
 *
 */

/*
 *  THIS FILE IS AUTOGENERATED. DO NOT MODIFY IT; ALL CHANGES WILL BE LOST IN
 *  VAIN.
 *
 *  @generated
 */
include "mcrouter/lib/carbon/carbon.thrift"
include "mcrouter/lib/carbon/carbon_result.thrift"
include "mcrouter/lib/network/gen/Common.thrift"

cpp_include "<mcrouter/lib/carbon/CarbonProtocolReader.h>"

namespace cpp2 facebook.memcache.thrift

struct MemcacheRequestCommon {
  1: optional i64 (cpp.type = "uint64_t") beforeLatencyUs
  2: optional i64 (cpp.type = "uint64_t") afterLatencyUs
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

")
struct McGetRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i64 (cpp.type = "uint64_t") flags
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McGetReply {
  1: carbon_result.Result result
  2: optional binary (cpp.type = "folly::IOBuf") value
  3: i64 (cpp.type = "uint64_t") flags
  4: string message
  5: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McSetRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
  3: i64 (cpp.type = "uint64_t") flags
  4: binary (cpp.type = "folly::IOBuf") value
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McSetReply {
  1: carbon_result.Result result
  2: i64 (cpp.type = "uint64_t") flags
  3: binary (cpp.type = "folly::IOBuf") value
  4: string message
  5: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McDeleteRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i64 (cpp.type = "uint64_t") flags
  3: i32 exptime
  4: binary (cpp.type = "folly::IOBuf") value
  5: map<string, i64 (cpp.type = "uint64_t")> (cpp.type = "std::unordered_map<std::string, uint64_t>") attributes
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McDeleteReply {
  1: carbon_result.Result result
  2: i64 (cpp.type = "uint64_t") flags
  3: binary (cpp.type = "folly::IOBuf") value
  4: string message
  5: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McLeaseGetRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i64 (cpp.type = "uint64_t") flags
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McLeaseGetReply {
  1: carbon_result.Result result
  2: i64 leaseToken
  3: optional binary (cpp.type = "folly::IOBuf") value
  4: i64 (cpp.type = "uint64_t") flags
  5: string message
  6: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McLeaseSetRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
  3: i64 (cpp.type = "uint64_t") flags
  4: binary (cpp.type = "folly::IOBuf") value
  5: i64 leaseToken
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McLeaseSetReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McAddRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
  3: i64 (cpp.type = "uint64_t") flags
  4: binary (cpp.type = "folly::IOBuf") value
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McAddReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McReplaceRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
  3: i64 (cpp.type = "uint64_t") flags
  4: binary (cpp.type = "folly::IOBuf") value
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McReplaceReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McGetsRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i64 (cpp.type = "uint64_t") flags
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McGetsReply {
  1: carbon_result.Result result
  2: i64 (cpp.type = "uint64_t") casToken
  3: optional binary (cpp.type = "folly::IOBuf") value
  4: i64 (cpp.type = "uint64_t") flags
  5: string message
  6: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McCasRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
  3: i64 (cpp.type = "uint64_t") flags
  4: binary (cpp.type = "folly::IOBuf") value
  5: i64 (cpp.type = "uint64_t") casToken
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McCasReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McIncrRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i64 delta
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McIncrReply {
  1: carbon_result.Result result
  2: i64 delta
  3: string message
  4: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McDecrRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i64 delta
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McDecrReply {
  1: carbon_result.Result result
  2: i64 delta
  3: string message
  4: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McMetagetRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McMetagetReply {
  1: carbon_result.Result result
  2: i32 age
  3: i32 exptime
  4: i16 ipv
  5: string ipAddress
  6: string message
  7: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McAppendRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
  3: i64 (cpp.type = "uint64_t") flags
  4: binary (cpp.type = "folly::IOBuf") value
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McAppendReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McPrependRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
  3: i64 (cpp.type = "uint64_t") flags
  4: binary (cpp.type = "folly::IOBuf") value
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McPrependReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McTouchRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 exptime
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McTouchReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McFlushReRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McFlushReReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McFlushAllRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: carbon.IOBufKey key
  2: i32 delay
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McFlushAllReply {
  1: carbon_result.Result result
  2: string message
  3: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McGatRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: i32 exptime
  2: carbon.IOBufKey key
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McGatReply {
  1: carbon_result.Result result
  2: optional binary (cpp.type = "folly::IOBuf") value
  3: i64 (cpp.type = "uint64_t") flags
  4: string message
  5: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McGatsRequest {
  -1: MemcacheRequestCommon memcacheRequestCommon (cpp.mixin)
  1: i32 exptime
  2: carbon.IOBufKey key
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
struct McGatsReply {
  1: carbon_result.Result result
  2: i64 (cpp.type = "uint64_t") casToken
  3: optional binary (cpp.type = "folly::IOBuf") value
  4: i64 (cpp.type = "uint64_t") flags
  5: string message
  6: i16 appSpecificErrorCode
}(cpp.methods = "
  template <class V>
  void visitFields(V&& v);
  template <class V>
  void visitFields(V&& v) const;

  template <class Writer>
  void serialize(Writer&& writer) const;

  void deserialize(carbon::CarbonProtocolReader& reader);

",
cpp.virtual
)
