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

export default function singleKvStoreEnumTest(){
  describe('singleKvStoreEnumTest', () => {

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTOREENUM_STRING_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_2100
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
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_0600
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
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_0500
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
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_0200
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
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_0100
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
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_0400
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
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_2000
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
     * @tc.number SUB_DistributedData_KVStore_SDK_DisKVSingleKvStoreEnumEtsApiTest_1600
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

  })
}
