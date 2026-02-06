/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from "@ohos/hypium";
import factory from '@ohos.data.distributedKVStore'

class KvConstants implements factory.Constants {
  MAX_KEY_LENGTH: number = 1024;
  MAX_VALUE_LENGTH: number = 4194303;
  MAX_KEY_LENGTH_DEVICE: number = 896;
  MAX_STORE_ID_LENGTH: number = 128;
  MAX_QUERY_LENGTH: number = 512000;
  MAX_BATCH_SIZE: number = 128;
}

export default function singleKvStoreEnumTest(){
  describe('singleKvStoreEnumTest', () => {

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_STRING_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_STRING_0100
     * @tc.desc   Test Js Enum Value Valuetype.STRING
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_STRING_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let string = factory.ValueType.STRING;
      console.info('string = ' + string);
      expect(string == 0).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_INTEGER_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_INTEGER_0100
     * @tc.desc   Test Js Enum Value Valuetype.INTEGER
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_INTEGER_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let integer = factory.ValueType.INTEGER;
      console.info('integer = ' + integer);
      expect(integer == 1).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_FLOAT_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_FLOAT_0100
     * @tc.desc   Test Js Enum Value Valuetype.FLOAT
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_FLOAT_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let float = factory.ValueType.FLOAT;
      console.info('float = ' + float);
      expect(float == 2).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_BYTEARRAY_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_BYTEARRAY_0100
     * @tc.desc   Test Js Enum Value Valuetype.BYTEARRAY
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_BYTEARRAY_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let byteArray = factory.ValueType.BYTE_ARRAY;
      console.info('byteArray = ' + byteArray);
      expect(byteArray == 3).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_BOOLEAN_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_BOOLEAN_0100
     * @tc.desc   Test Js Enum Value Valuetype.BOOLEAN
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_BOOLEAN_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let boolean = factory.ValueType.BOOLEAN;
      console.info('boolean = ' + boolean);
      expect(boolean == 4).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_DOUBLE_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_DOUBLE_0100
     * @tc.desc   Test Js Enum Value Valuetype.DOUBLE
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_DOUBLE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let double = factory.ValueType.DOUBLE;
      console.info('double = ' + double);
      expect(double == 5).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_SINGLE_VERSION_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_SINGLE_VERSION_0100
     * @tc.desc   Test Js Enum Value Kvstoretype.SINGLE_VERSION
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_SINGLE_VERSION_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let single = factory.KVStoreType.SINGLE_VERSION;
      console.info('single = ' + single);
      expect(single == 1).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_S1_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_S1_0100
     * @tc.desc   Test Js Enum Value Securitylevel.S1
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_S1_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let s3 = factory.SecurityLevel.S3;
      console.info('s3 = ' + s3);
      expect(s3 == 5).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_KEY_LENGTH_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_KEY_LENGTH_0100
     * @tc.desc   Test Js Enum Value Constants.MAX_KEY_LENGTH
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_KEY_LENGTH_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let constants: KvConstants = new KvConstants();
      let maxKeyLength: number= constants.MAX_KEY_LENGTH;
      console.info('maxKeyLength = ' + maxKeyLength);
      expect(maxKeyLength == 1024).assertTrue();
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_VALUE_LENGTH_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_VALUE_LENGTH_0100
     * @tc.desc   Test Js Enum Value Constants.MAX_VALUE_LENGTH
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_VALUE_LENGTH_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let constants: KvConstants = new KvConstants();
      let maxValueLength: number = constants.MAX_VALUE_LENGTH;
      console.info('maxValueLength = ' + maxValueLength);
      expect(maxValueLength == 4194303).assertTrue();
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_KEY_LENGTH_DEVICE_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_KEY_LENGTH_DEVICE_0100
     * @tc.desc   Test Js Enum Value Constants.MAX_KEY_LENGTH_DEVICE
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_KEY_LENGTH_DEVICE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let constants: KvConstants = new KvConstants();
      let maxKeyLengthDevice = constants.MAX_KEY_LENGTH_DEVICE;
      console.info('maxKeyLengthDevice = ' + maxKeyLengthDevice);
      expect(maxKeyLengthDevice == 896).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_STORE_ID_LENGTH_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_STORE_ID_LENGTH_0100
     * @tc.desc   Test Js Enum Value Constants.MAX_STORE_ID_LENGTH
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_STORE_ID_LENGTH_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let constants: KvConstants = new KvConstants();
      let maxStoreIdLength = constants.MAX_STORE_ID_LENGTH;
      console.info('maxStoreIdLength = ' + maxStoreIdLength);
      expect(maxStoreIdLength == 128).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_QUERY_LENGTH_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_QUERY_LENGTH_0100
     * @tc.desc   Test Js Enum Value Constants.MAX_QUERY_LENGTH
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_QUERY_LENGTH_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let constants: KvConstants = new KvConstants();
      let maxQueryLength = constants.MAX_QUERY_LENGTH;
      console.info('maxQueryLength = ' + maxQueryLength);
      expect(maxQueryLength == 512000).assertTrue()
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_BATCH_SIZE_0100
     * @tc.number ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_BATCH_SIZE_0100
     * @tc.desc   Test Js Enum Value Constants.MAX_BATCH_SIZE
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_MAX_BATCH_SIZE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let constants: KvConstants = new KvConstants();
      let maxBatchSize = constants.MAX_BATCH_SIZE;
      console.info('maxBatchSize = ' + maxBatchSize);
      expect(maxBatchSize == 128).assertTrue()
    })
  })
}
