/*
 *  Copyright (c) 2017-present, Facebook, Inc.
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

namespace cpp2 hellogoodbye.thrift

struct HelloRequest {
  1: carbon.IOBufKey key
  2: i64 (cpp.type = "uint64_t") shardId
}

struct HelloReply {
  1: carbon_result.Result result
  2: string message
}

struct GoodbyeRequest {
  1: carbon.IOBufKey key
  2: i64 (cpp.type = "uint64_t") shardId
}

struct GoodbyeReply {
  1: carbon_result.Result result
  2: string message
}
