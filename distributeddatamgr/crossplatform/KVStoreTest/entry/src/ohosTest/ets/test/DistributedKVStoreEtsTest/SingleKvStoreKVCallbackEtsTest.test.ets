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
import common from "@ohos.app.ability.common";
import { BusinessError } from '@kit.BasicServicesKit';

let context: common.UIAbilityContext;
const KEY_TEST_INT_ELEMENT = 'key_test_int_2';
const KEY_TEST_FLOAT_ELEMENT = 'key_test_float_2';
const KEY_TEST_BOOLEAN_ELEMENT = 'key_test_boolean_2';
const KEY_TEST_STRING_ELEMENT = 'key_test_string_2';

const VALUE_TEST_INT_ELEMENT = 1234;
const VALUE_TEST_FLOAT_ELEMENT = 4321.12;
const VALUE_TEST_BOOLEAN_ELEMENT = true;
const VALUE_TEST_STRING_ELEMENT = 'value-string-002';

const TEST_BUNDLE_NAME = 'com.example.kvstoretest';
const TEST_STORE_ID = 'storeId';
let kvManager: factory.KVManager | null = null;
let kvStore: factory.SingleKVStore | null = null;

export default function SingleKvStoreCallbackTest(){
  describe('SingleKvStoreCallbackTest', () => {
    const options: factory.Options = {
      createIfMissing : true,
      kvStoreType : factory.KVStoreType.SINGLE_VERSION,
      securityLevel : factory.SecurityLevel.S3,
    }

    beforeAll(async (done: Function) => {
      context = AppStorage.get<common.UIAbilityContext>("TestAbilityContext") as common.UIAbilityContext;
      const config: factory.KVManagerConfig = {
        bundleName : TEST_BUNDLE_NAME,
        context:context
      }
      console.info('beforeAll config:'+ JSON.stringify(config));
      kvManager = factory.createKVManager(config)
      done();
    })

    afterAll(async (done: Function) => {
      console.info('afterAll');
      kvManager = null;
      kvStore = null;
      done();
    })

    beforeEach(async (done: Function) => {
      console.info('beforeEach' + JSON.stringify(options));
      await kvManager!.getKVStore(TEST_STORE_ID, options, (err, store: factory.SingleKVStore) => {
        kvStore = store;
        console.info('beforeEach getKVStore success');
        done();
      });
    })

    afterEach(async (done: Function) => {
      console.info('afterEach');
      try {
        await kvManager!.closeKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID, async (err, data) => {
          console.info('afterEach closeKVStore success: function err is: '+err);
          await kvManager!.deleteKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID, (err, data) => {
            console.info('afterEach deleteKVStore success: function err is: '+err);
            kvStore = null;
            done();
          });
        });
      } catch (e) {
        console.error('afterEach closeKVStore err ' + `, error code is ${e.code}, message is ${e.message}`);
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0800
     * @tc.desc   Test Js Api SingleKvStore.Put(String) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutStringCallbackTest001');
      try {
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStorePutStringCallbackTest001 put success');
          } else {
            console.error('SingleKvStorePutStringCallbackTest001 put fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
          }
          done();
        });
      }catch (e) {
        console.error('SingleKvStorePutStringCallbackTest001 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0700
     * @tc.desc   Test Js Api SingleKvStore.Put(String) testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutStringCallbackTest002');
      try {
        let str = '';
        for (let i = 0 ; i < 4095; i++) {
          str += 'x';
        }
        await kvStore!.put(KEY_TEST_STRING_ELEMENT+'102', str, async (err, data) => {
          console.info('SingleKvStorePutStringCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_STRING_ELEMENT+'102', (err, data) => {
            console.info('SingleKvStorePutStringCallbackTest002 get success');
            expect(str == data).assertTrue();
            done();
          });
        });
      }catch (e) {
        console.error('SingleKvStorePutStringCallbackTest002 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0200
     * @tc.desc   Test Js Api SingleKvStore.GetString() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('SingleKvStoreGetStringCallbackTest001');
      try{
        await kvStore!.get(KEY_TEST_STRING_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreGetStringCallbackTest001 get success');
            expect(null).assertFail();
          } else {
            console.error('SingleKvStoreGetStringCallbackTest001 get fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(err.code == 15100004).assertTrue();
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreGetStringCallbackTest001 get e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0900
     * @tc.desc   Test Js Api SingleKvStore.GetString() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreGetStringCallbackTest002');
      try{
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT, async (err, data) => {
          console.info('SingleKvStoreGetStringCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_STRING_ELEMENT, (err, data) => {
            console.info('SingleKvStoreGetStringCallbackTest002 get success');
            expect((err == undefined) && (VALUE_TEST_STRING_ELEMENT == data)).assertTrue();
            done();
          });
        })
      }catch(e) {
        console.error('SingleKvStoreGetStringCallbackTest002 get e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0500
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutIntCallbackTest001');
      try {
        await kvStore!.put(KEY_TEST_INT_ELEMENT, VALUE_TEST_INT_ELEMENT, async (err, data) => {
          console.info('SingleKvStorePutIntCallbackTest001 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT, (err, data) => {
            console.info('SingleKvStorePutIntCallbackTest001 get success');
            expect((err == undefined) && (VALUE_TEST_INT_ELEMENT == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStorePutIntCallbackTest001 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0600
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1000
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutIntCallbackTest002');
      try {
        let intValue = 987654321;
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue, async (err, data) => {
          console.info('SingleKvStorePutIntCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT, (err, data) => {
            console.info('SingleKvStorePutIntCallbackTest002 get success');
            expect((err == undefined) && (intValue == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStorePutIntCallbackTest002 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0700
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0400
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutIntCallbackTest003');
      try {
        let intValue = Number.MIN_VALUE;
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue, async (err, data) => {
          console.info('SingleKvStorePutIntCallbackTest003 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT, (err, data) => {
            console.info('SingleKvStorePutIntCallbackTest003 get success');
            expect((err == undefined) && (intValue == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStorePutIntCallbackTest003 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0800
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0300
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutIntCallbackTest004');
      try {
        let intValue = Number.MAX_VALUE;
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue, async (err, data) => {
          console.info('SingleKvStorePutIntCallbackTest004 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT, (err, data) => {
            console.info('SingleKvStorePutIntCallbackTest004 get success');
            expect((err == undefined) && (intValue == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStorePutIntCallbackTest004 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0900
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0600
     * @tc.desc   Test Js Api SingleKvStore.GetInt() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreGetIntCallbackTest001');
      try {
        await kvStore!.put(KEY_TEST_INT_ELEMENT, VALUE_TEST_INT_ELEMENT, async (err, data) => {
          console.info('SingleKvStoreGetIntCallbackTest001 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT, (err, data) => {
            console.info('SingleKvStoreGetIntCallbackTest001 get success');
            expect((err == undefined) && (VALUE_TEST_INT_ELEMENT == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStoreGetIntCallbackTest001 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1000
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_0100
     * @tc.desc   Test Js Api SingleKvStore.GetInt() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('SingleKvStoreGetIntCallbackTest002');
      try {
        await kvStore!.get(KEY_TEST_INT_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreGetIntCallbackTest002 get success');
            expect(null).assertFail();
          } else {
            console.error('SingleKvStoreGetIntCallbackTest002 get fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(err.code == 15100004).assertTrue();
          }
          done();
        })
      }catch(e) {
        console.error('SingleKvStoreGetIntCallbackTest002 put e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_1100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2000
     * @tc.desc   Test Js Api SingleKvStore.Put(Bool) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutBoolCallbackTest001');
      try {
        await kvStore!.put(KEY_TEST_BOOLEAN_ELEMENT, VALUE_TEST_BOOLEAN_ELEMENT, (err, data) => {
          console.info('SingleKvStorePutBoolCallbackTest001 put success');
          expect(err == undefined).assertTrue();
          done();
        });
      }catch(e) {
        console.error('SingleKvStorePutBoolCallbackTest001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1300
     * @tc.desc   Test Js Api SingleKvStore.GetBool() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('SingleKvStoreGetBoolCallbackTest001');
      try {
        await kvStore!.get(KEY_TEST_BOOLEAN_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreGetBoolCallbackTest001 get success');
            expect(null).assertFail();
          } else {
            console.error('SingleKvStoreGetBoolCallbackTest001 get fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(err.code == 15100004).assertTrue();
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreGetBoolCallbackTest001 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2500
     * @tc.desc   Test Js Api SingleKvStore.GetBool() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreGetBoolCallbackTest002');
      try {
        await kvStore!.put(KEY_TEST_BOOLEAN_ELEMENT, VALUE_TEST_BOOLEAN_ELEMENT, async (err, data) => {
          console.info('SingleKvStoreGetBoolCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_BOOLEAN_ELEMENT, (err, data) => {
            console.info('SingleKvStoreGetBoolCallbackTest002 get success');
            expect((err == undefined) && (VALUE_TEST_BOOLEAN_ELEMENT == data)).assertTrue();
            done();
          });
        })
      }catch(e) {
        console.error('SingleKvStoreGetBoolCallbackTest002 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_1400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2100
     * @tc.desc   Test Js Api SingleKvStore.Put(Float) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUT_CALLBACK_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutFloatCallbackTest001');
      try {
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, VALUE_TEST_FLOAT_ELEMENT, (err, data) => {
          console.info('SingleKvStorePutFloatCallbackTest001 put success');
          expect(err == undefined).assertTrue();
          done();
        });
      }catch(e) {
        console.error('SingleKvStorePutFloatCallbackTest001 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2200
     * @tc.desc   Test Js Api SingleKvStore.Put(Float) testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutFloatCallbackTest002');
      try {
        let floatValue = 123456.654321;
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, floatValue, async (err, data) => {
          console.info('SingleKvStorePutFloatCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_FLOAT_ELEMENT, (err, data) => {
            console.info('SingleKvStorePutFloatCallbackTest002 get success');
            expect((err == undefined) && (floatValue == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStorePutFloatCallbackTest002 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1600
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2400
     * @tc.desc   Test Js Api SingleKvStore.Put(Float) testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutFloatCallbackTest003');
      try {
        let floatValue = 123456.0;
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, floatValue, async (err, data) => {
          console.info('SingleKvStorePutFloatCallbackTest003 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_FLOAT_ELEMENT, (err, data) => {
            console.info('SingleKvStorePutFloatCallbackTest003 get success');
            expect((err == undefined) && (floatValue == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStorePutFloatCallbackTest003 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1700
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2300
     * @tc.desc   Test Js Api SingleKvStore.Put(Float) testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutFloatCallbackTest004');
      try {
        let floatValue = 123456.00;
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, floatValue, async (err, data) => {
          console.info('SingleKvStorePutFloatCallbackTest004 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_FLOAT_ELEMENT, (err, data) => {
            console.info('SingleKvStorePutFloatCallbackTest004 get success');
            expect((err == undefined) && (floatValue == data)).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.error('SingleKvStorePutFloatCallbackTest004 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1800
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1400
     * @tc.desc   Test Js Api SingleKvStore.GetFloat() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GET_CALLBACK_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('SingleKvStoreGetFloatCallbackTest001');
      try {
        await kvStore!.get(KEY_TEST_FLOAT_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreGetFloatCallbackTest001 get success');
            expect(null).assertFail();
          } else {
            console.error('SingleKvStoreGetFloatCallbackTest001 get fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(err.code == 15100004).assertTrue();
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreGetFloatCallbackTest001 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_1900
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1800
     * @tc.desc   Test Js Api SingleKvStore.DeleteString() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteStringCallbackTest001');
      try {
        await kvStore!.delete(KEY_TEST_STRING_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreDeleteStringCallbackTest001 delete success');
          } else {
            console.error('SingleKvStoreDeleteStringCallbackTest001 delete fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreDeleteStringCallbackTest001 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2000
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2900
     * @tc.desc   Test Js Api SingleKvStore.DeleteString() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteStringCallbackTest002');
      try {
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT, async (err, data) => {
          console.info('SingleKvStoreDeleteStringCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_STRING_ELEMENT, (err, data) => {
            console.info('SingleKvStoreDeleteStringCallbackTest002 delete success');
            expect(err == undefined).assertTrue();
            done();
          });
        })
      }catch(e) {
        console.error('SingleKvStoreDeleteStringCallbackTest002 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1700
     * @tc.desc   Test Js Api SingleKvStore.DeleteInt() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteIntCallbackTest001');
      try{
        await kvStore!.delete(KEY_TEST_INT_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreDeleteIntCallbackTest001 get success');
          } else {
            console.error('SingleKvStoreDeleteIntCallbackTest001 get fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreDeleteIntCallbackTest001 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2800
     * @tc.desc   Test Js Api SingleKvStore.DeleteInt() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteIntCallbackTest002');
      try{
        await kvStore!.put(KEY_TEST_INT_ELEMENT, VALUE_TEST_INT_ELEMENT, async (err, data) => {
          console.info('SingleKvStoreDeleteIntCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_INT_ELEMENT, (err, data) => {
            console.info('SingleKvStoreDeleteIntCallbackTest002 delete success');
            expect(err == undefined).assertTrue();
            done();
          });
        })
      }catch(e) {
        console.error('SingleKvStoreDeleteIntCallbackTest002 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1600
     * @tc.desc   Test Js Api SingleKvStore.DeleteFloat() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteFloatCallbackTest001');
      try{
        await kvStore!.delete(KEY_TEST_FLOAT_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreDeleteFloatCallbackTest001 get success');
          } else {
            console.error('SingleKvStoreDeleteFloatCallbackTest001 get fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreDeleteFloatCallbackTest001 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2700
     * @tc.desc   Test Js Api SingleKvStore.DeleteFloat() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteFloatCallbackTest002');
      try{
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, VALUE_TEST_FLOAT_ELEMENT, async (err, data) => {
          console.info('SingleKvStoreDeleteFloatCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_FLOAT_ELEMENT, (err, data) => {
            console.info('SingleKvStoreDeleteFloatCallbackTest002 delete success');
            expect(err == undefined).assertTrue();
            done();
          });
        })
      }catch(e) {
        console.error('SingleKvStoreDeleteFloatCallbackTest002 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1500
     * @tc.desc   Test Js Api SingleKvStore.DeleteBool() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteBoolCallbackTest001');
      try{
        await kvStore!.delete(KEY_TEST_BOOLEAN_ELEMENT, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreDeleteBoolCallbackTest001 get success');
          } else {
            console.error('SingleKvStoreDeleteBoolCallbackTest001 get fail' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreDeleteBoolCallbackTest001 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2600
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_2600
     * @tc.desc   Test Js Api SingleKvStore.DeleteBool() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteBoolCallbackTest002');
      try{
        await kvStore!.put(KEY_TEST_BOOLEAN_ELEMENT, VALUE_TEST_BOOLEAN_ELEMENT, async (err, data) => {
          console.info('SingleKvStoreDeleteBoolCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_BOOLEAN_ELEMENT, (err, data) => {
            console.info('SingleKvStoreDeleteBoolCallbackTest002 delete success');
            expect(err == undefined).assertTrue();
            done();
          });
        })
      }catch(e) {
        console.error('SingleKvStoreDeleteBoolCallbackTest002 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2700
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1900
     * @tc.desc   Test Js Api SingleKvStore.Delete() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2700');
      try {
        await kvStore!.delete(KEY_TEST_STRING_ELEMENT, (err, data) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2700 delete err: ' + err);
          expect(err == undefined).assertTrue();
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2700 expect fin');
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2700 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(e.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2800
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_1100
     * @tc.desc   Test Js Api SingleKvStore.Delete() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETE_CALLBACK_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log('SingleKvStoreDeletePredicatesCallbackTest002');
      try {
        await kvStore!.put("name", "Bob", async (err, data) => {
          console.log('SingleKvStoreDeletePredicatesCallbackTest002 put success');
          expect(err == undefined).assertTrue();
          await kvStore!.delete("name", (err, data) => {
            console.log('SingleKvStoreDeletePredicatesCallbackTest002 delete success');
            expect(err == undefined).assertTrue();
            done();
          });
        })
      }catch(e) {
        console.error('SingleKvStoreDeletePredicatesCallbackTest002 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_3900
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5400
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutBatchEntryCallbackTest001');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_string_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.STRING,
              value : 'batch_test_string_value'
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStorePutBatchEntryCallbackTest001 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStorePutBatchEntryCallbackTest001 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_string_key', (err,entrys) => {
            console.info('SingleKvStorePutBatchEntryCallbackTest001 getEntries success');
            console.info('SingleKvStorePutBatchEntryCallbackTest001 entrys.length: ' + entrys.length);
            console.info('SingleKvStorePutBatchEntryCallbackTest001 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 'batch_test_string_value').assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStorePutBatchEntryCallbackTest001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4000
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5300
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutBatchEntryCallbackTest002');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_number_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.INTEGER,
              value : 222
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStorePutBatchEntryCallbackTest002 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStorePutBatchEntryCallbackTest002 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_number_key', (err,entrys) => {
            console.info('SingleKvStorePutBatchEntryCallbackTest002 getEntries success');
            console.info('SingleKvStorePutBatchEntryCallbackTest002 entrys.length: ' + entrys.length);
            console.info('SingleKvStorePutBatchEntryCallbackTest002 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 222).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStorePutBatchEntryCallbackTest002 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5200
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutBatchEntryCallbackTest003');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_number_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.FLOAT,
              value : 2.0
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStorePutBatchEntryCallbackTest003 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStorePutBatchEntryCallbackTest003 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_number_key', (err,entrys) => {
            console.info('SingleKvStorePutBatchEntryCallbackTest003 getEntries success');
            console.info('SingleKvStorePutBatchEntryCallbackTest003 entrys.length: ' + entrys.length);
            console.info('SingleKvStorePutBatchEntryCallbackTest003 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 2.0).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStorePutBatchEntryCallbackTest003 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5100
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutBatchEntryCallbackTest004');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_number_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.DOUBLE,
              value : 2.00
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStorePutBatchEntryCallbackTest004 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStorePutBatchEntryCallbackTest004 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_number_key', (err,entrys) => {
            console.info('SingleKvStorePutBatchEntryCallbackTest004 getEntries success');
            console.info('SingleKvStorePutBatchEntryCallbackTest004 entrys.length: ' + entrys.length);
            console.info('SingleKvStorePutBatchEntryCallbackTest004 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 2.00).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStorePutBatchEntryCallbackTest004 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_4900
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 005
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutBatchEntryCallbackTest005');
      try {
        let bo = false;
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_bool_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.BOOLEAN,
              value : bo
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStorePutBatchEntryCallbackTest005 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStorePutBatchEntryCallbackTest005 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_bool_key', (err,entrys) => {
            console.info('SingleKvStorePutBatchEntryCallbackTest005 getEntries success');
            console.info('SingleKvStorePutBatchEntryCallbackTest005 entrys.length: ' + entrys.length);
            console.info('SingleKvStorePutBatchEntryCallbackTest005 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == bo).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStorePutBatchEntryCallbackTest005 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5000
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 006
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStorePutBatchEntryCallbackTest006');
      try {
        let arr = new Uint8Array([21,31]);
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_bool_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.BYTE_ARRAY,
              value : arr
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStorePutBatchEntryCallbackTest006 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStorePutBatchEntryCallbackTest006 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_bool_key', (err,entrys) => {
            console.info('SingleKvStorePutBatchEntryCallbackTest006 getEntries success');
            console.info('SingleKvStorePutBatchEntryCallbackTest006 entrys.length: ' + entrys.length);
            console.info('SingleKvStorePutBatchEntryCallbackTest006 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value.toString() == arr.toString()).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStorePutBatchEntryCallbackTest006 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5600
     * @tc.desc   Test Js Api SingleKvStore.DeleteBatch() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_CALLBACK_4500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteBatchCallbackTest001');
      try {
        let entries: factory.Entry[] = [];
        let keys: string[] = [];
        for (let i = 0; i < 5; i++) {
          let key = 'batch_test_string_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.STRING,
              value : 'batch_test_string_value'
            }
          }
          entries.push(entry);
          keys.push(key + i);
        }
        console.info('SingleKvStoreDeleteBatchCallbackTest001 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStoreDeleteBatchCallbackTest001 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.deleteBatch(keys, async (err, data) => {
            console.info('SingleKvStoreDeleteBatchCallbackTest001 deleteBatch success');
            expect(err == undefined).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStoreDeleteBatchCallbackTest001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCH_CALLBACK_4600
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5700
     * @tc.desc   Test Js Api SingleKvStore.DeleteBatch() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCH_CALLBACK_4600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteBatchCallbackTest002');
      try {
        let keys = ['batch_test_string_key1', 'batch_test_string_key2'];
        await kvStore!.deleteBatch(keys, (err, data) => {
          console.info('SingleKvStoreDeleteBatchCallbackTest002 deleteBatch success');
          expect(err == undefined).assertTrue();
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreDeleteBatchCallbackTest002 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCH_CALLBACK_4700
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_5500
     * @tc.desc   Test Js Api SingleKvStore.DeleteBatch() testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCH_CALLBACK_4700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreDeleteBatchCallbackTest003');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_string_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.STRING,
              value : 'batch_test_string_value'
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStoreDeleteBatchCallbackTest003 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStoreDeleteBatchCallbackTest003 putBatch success');
          expect(err == undefined).assertTrue();
          let keys = ['batch_test_string_key1', 'batch_test_string_keya'];
          await kvStore!.deleteBatch(keys, async (err, data) => {
            console.info('SingleKvStoreDeleteBatchCallbackTest003 deleteBatch success');
            expect(err == undefined).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStoreDeleteBatchCallbackTest003 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULT_CALLBACK_7500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_4000
     * @tc.desc   Test Js Api SingleKvStore.GetResultSet() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULT_CALLBACK_7500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreGetResultSetCallbackTest001');
      try {
        let resultSet: factory.KVStoreResultSet;
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_string_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.STRING,
              value : 'batch_test_string_value'
            }
          }
          entries.push(entry);
        }
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStoreGetResultSetCallbackTest001 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getResultSet('batch_test_string_key', async (err, result) => {
            console.info('SingleKvStoreGetResultSetCallbackTest001 getResultSet success');
            resultSet = result;
            expect(resultSet.getCount() == 10).assertTrue();
            await kvStore!.closeResultSet(resultSet, (err, data) => {
              console.info('SingleKvStoreGetResultSetCallbackTest001 closeResultSet success');
              expect(err == undefined).assertTrue();
              done();
            })
          });
        });
      }catch(e) {
        console.error('SingleKvStoreGetResultSetCallbackTest001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULT_CALLBACK_7800
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_4700
     * @tc.desc   Test Js Api SingleKvStore.GetResultSet() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULT_CALLBACK_7800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log('SingleKvStoreGetResultSetPredicatesCallbackTest001');
      try {
        let resultSet: factory.KVStoreResultSet | null = null;
        let query = new factory.Query();
        await kvStore!.getResultSet(query).then((result) => {
          console.log('SingleKvStoreGetResultSetPredicatesCallbackTest001 getResultSet success');
          resultSet = result;
        }).catch((err: BusinessError) => {
          console.error('SingleKvStoreGetResultSetPredicatesCallbackTest001 getResultSet fail ' + err +`, error code is ${err.code}, message is ${err.message}`);
          expect(err == undefined).assertTrue();
        });
        await kvStore!.closeResultSet(resultSet, async (err, data) => {
          console.info('SingleKvStoreGetResultSetPredicatesCallbackTest001 closeResultSet success');
          done();
        })
      } catch(e) {
        console.error('SingleKvStoreGetResultSetPredicatesCallbackTest001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULT_CALLBACK_7900
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_3800
     * @tc.desc   Test Js Api SingleKvStore.CloseResultSet() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULT_CALLBACK_7900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('SingleKvStoreCloseResultSetCallbackTest001');
      try {
        console.info('SingleKvStoreCloseResultSetCallbackTest001 success');
        let resultSet = null;
        await kvStore!.closeResultSet(resultSet, (err, data) => {
          if (err == undefined) {
            console.info('SingleKvStoreCloseResultSetCallbackTest001 closeResultSet success');
            expect(null).assertFail();
          } else {
            console.info('SingleKvStoreCloseResultSetCallbackTest001 closeResultSet fail');
          }
          done();
        });
      }catch(e) {
        console.error('SingleKvStoreCloseResultSetCallbackTest001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(e.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULT_CALLBACK_8000
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_3700
     * @tc.desc   Test Js Api SingleKvStore.CloseResultSet() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULT_CALLBACK_8000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreCloseResultSetCallbackTest002');
      try {
        let resultSet: factory.KVStoreResultSet | null = null;
        await kvStore!.getResultSet('batch_test_string_key', async (err, result) => {
          console.info('SingleKvStoreCloseResultSetCallbackTest002 getResultSet success');
          resultSet = result;
          await kvStore!.closeResultSet(resultSet, (err, data) => {
            if (err == undefined) {
              console.info('SingleKvStoreCloseResultSetCallbackTest002 closeResultSet success');
              expect(err == undefined).assertTrue();
            } else {
              console.info('SingleKvStoreCloseResultSetCallbackTest002 closeResultSet fail');
              expect(null).assertFail();
            }
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStoreCloseResultSetCallbackTest002 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETENTRIES_CALLBACK_8300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvCallbackEtsApiTest_4800
     * @tc.desc   Test Js Api SingleKvStore.GetEntries() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETENTRIES_CALLBACK_8300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('SingleKvStoreGetEntriesCallbackTest001');
      try {
        let arr = new Uint8Array([21,31]);
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'batch_test_bool_key';
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.BYTE_ARRAY,
              value : arr
            }
          }
          entries.push(entry);
        }
        console.info('SingleKvStoreGetEntriesCallbackTest001 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('SingleKvStoreGetEntriesCallbackTest001 putBatch success');
          expect(err == undefined).assertTrue();
          let query = new factory.Query();
          query.prefixKey("batch_test");
          await kvStore!.getEntries(query, (err,entrys) => {
            console.info('SingleKvStoreGetEntriesCallbackTest001 getEntries success');
            console.info('SingleKvStoreGetEntriesCallbackTest001 entrys.length: ' + entrys.length);
            console.info('SingleKvStoreGetEntriesCallbackTest001 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value.toString() == arr.toString()).assertTrue();
                    console.info('SingleKvStoreGetEntriesCallbackTest001 success');
            done();
          });
        });
      }catch(e) {
        console.error('SingleKvStoreGetEntriesCallbackTest001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })
  })
}