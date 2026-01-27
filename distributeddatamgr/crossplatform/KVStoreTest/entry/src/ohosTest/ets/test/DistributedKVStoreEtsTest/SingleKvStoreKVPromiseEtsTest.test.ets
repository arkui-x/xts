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
const KEY_TEST_INT_ELEMENT = 'key_test_int';
const KEY_TEST_FLOAT_ELEMENT = 'key_test_float';
const KEY_TEST_BOOLEAN_ELEMENT = 'key_test_boolean';
const KEY_TEST_STRING_ELEMENT = 'key_test_string';

const VALUE_TEST_INT_ELEMENT = 123;
const VALUE_TEST_FLOAT_ELEMENT = 321.12;
const VALUE_TEST_BOOLEAN_ELEMENT = true;
const VALUE_TEST_STRING_ELEMENT = 'value-string-001';

const TEST_BUNDLE_NAME = 'com.example.kvstoretest';
const TEST_STORE_ID = 'storeId';
let kvManager: factory.KVManager | null = null;
let kvStore: factory.SingleKVStore | null = null;

function putBatchString(len: number, prefix: string) {
  let entries: factory.Entry[] = [];
  for (let i = 0; i < len; i++) {
    let entry: factory.Entry = {
      key : prefix + i,
      value : {
        type : factory.ValueType.STRING,
        value : 'batch_test_string_value'
      }
    }
    entries.push(entry);
  }
  return entries;
}
export default function SingleKvStorePromiseTest(){
  describe('SingleKvStorePromiseTest', () => {
    const options: factory.Options = {
      createIfMissing : true,
      kvStoreType : factory.KVStoreType.SINGLE_VERSION,
      securityLevel : factory.SecurityLevel.S3,
    }

    beforeAll(async (done: Function) => {
      context = AppStorage.get<common.UIAbilityContext>("TestAbilityContext") as common.UIAbilityContext;
      const config: factory.KVManagerConfig = {
        bundleName : TEST_BUNDLE_NAME,
        context: context
      }
      console.info('beforeAll config:'+ JSON.stringify(config));
      kvManager = factory.createKVManager(config)
      console.info('beforeAll end');
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
      await kvManager!.getKVStore(TEST_STORE_ID, options).then((store: factory.SingleKVStore) => {
        kvStore = store;
        console.info('beforeEach getKVStore success');
        done();
      }).catch((err: BusinessError) => {
        console.error('beforeEach getKVStore err ' + `, error code is ${err.code}, message is ${err.message}`);
        done();
      });
    })

    afterEach(async (done: Function) => {
      console.info('afterEach');
      await kvManager!.closeKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID).then(async () => {
        console.info('afterEach closeKVStore success');
        await kvManager!.deleteKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID).then(() => {
          console.info('afterEach deleteKVStore success');
          kvStore = null;
          done();
        }).catch((err: BusinessError) => {
          console.error('afterEach deleteKVStore err ' + `, error code is ${err.code}, message is ${err.message}`);
          done();
        });
      }).catch((err: BusinessError) => {
        console.error('afterEach closeKVStore err ' + `, error code is ${err.code}, message is ${err.message}`);
        done();
      });
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0950
     * @tc.desc   Test Js Api SingleKvStore.Put(String) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, null).then((data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0100 put success');
          expect(null).assertFail();
          done();
        }).catch((error: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0100 put error' + `, error code is ${error.code}, message is ${error.message}`);
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(e.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0970
     * @tc.desc   Test Js Api SingleKvStore.Put(String) testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0200');
      try {
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, '').then((data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0200 put success');
          expect(data == undefined).assertTrue();
          done();
        }).catch((error: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0200 put error' + `, error code is ${error.code}, message is ${error.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0200 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0960
     * @tc.desc   Test Js Api SingleKvStore.Put(String) testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0300');
      try {
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT).then((data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0300 put success');
          expect(data == undefined).assertTrue();
          done();
        }).catch((error: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0300 put error' + `, error code is ${error.code}, message is ${error.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0300 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0980
     * @tc.desc   Test Js Api SingleKvStore.Put(String) testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400');
      try {
        let str = '';
        for (let i = 0 ; i < 4095; i++) {
          str += 'x';
        }
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, str).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_STRING_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400 get success data ' + data);
            expect(str == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((error: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400 put error' + `, error code is ${error.code}, message is ${error.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTSTRING_PROMISE_0400 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0400
     * @tc.desc   Test Js Api SingleKvStoreGetString testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_STRING_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100 get success');
            expect(VALUE_TEST_STRING_ELEMENT == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((error: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100 put error' + `, error code is ${error.code}, message is ${error.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0460
     * @tc.desc   Test Js Api SingleKvStoreGetString testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0200');
      try {
        await kvStore!.get(KEY_TEST_STRING_ELEMENT).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0200 get success1 '+data);
          expect(null).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0200 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETSTRING_PROMISE_0200 get e ' + `, error code is ${e.code}, message is ${e.message}`);
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0940
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_INT_ELEMENT, VALUE_TEST_INT_ELEMENT).then((data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0880
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200');
      try {
        let intValue = 987654321;
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200 get success');
            expect(intValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0200 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0920
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300');
      try {
        let intValue = Number.MAX_VALUE;
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300 intValue ' + intValue);
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300 get success, data ' + data);
            expect(intValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0300 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0930
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400');
      try {
        let intValue = Number.MIN_VALUE;
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400 intValue ' + intValue);
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400 get success, data ' + data);
            expect(intValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0400 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })


    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0890
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 005
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500');
      try {
        let intValue = Number.NaN;
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500 intValue ' + intValue);
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500 get success, data ' + data);
            expect(Number.isNaN(data)).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0500 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0900
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 006
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600');
      try {
        let intValue = Number.NEGATIVE_INFINITY;
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600 intValue ' + intValue);
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600 get success, data ' + data);
            expect(intValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0600 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0910
     * @tc.desc   Test Js Api SingleKvStore.Put(Int) testcase 007
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700');
      try {
        let intValue = Number.POSITIVE_INFINITY;
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700 intValue ' + intValue);
        await kvStore!.put(KEY_TEST_INT_ELEMENT, intValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700 get success, data ' + data);
            expect(intValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTINT_PROMISE_0700 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0300
     * @tc.desc   Test Js Api SingleKvStoreGetInt testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_INT_ELEMENT, VALUE_TEST_INT_ELEMENT).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100 get success');
            expect(VALUE_TEST_INT_ELEMENT == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETINT_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBOOLEAN_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0860
     * @tc.desc   Test Js Api SingleKvStore.Put(Bool) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBOOLEAN_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBOOLEAN_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_BOOLEAN_ELEMENT, VALUE_TEST_BOOLEAN_ELEMENT).then((data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBOOLEAN_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBOOLEAN_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBOOLEAN_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETBOOLEAN_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0290
     * @tc.desc   Test Js Api SingleKvStoreGetBool testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETBOOLEAN_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SingleKvStoreGetBoolPromiseTest001');
      try {
        let boolValue = false;
        await kvStore!.put(KEY_TEST_BOOLEAN_ELEMENT, boolValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETBOOLEAN_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_BOOLEAN_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETBOOLEAN_PROMISE_0100 get success');
            expect(boolValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETBOOLEAN_PROMISE_0100 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETBOOLEAN_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETBOOLEAN_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTFLOAT_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0870
     * @tc.desc   Test Js Api SingleKvStore.Put(Float) testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTFLOAT_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTFLOAT_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, VALUE_TEST_FLOAT_ELEMENT).then((data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTFLOAT_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTFLOAT_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTFLOAT_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0850
     * @tc.desc   Test Js Api SingleKvStoreGetFloat testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100');
      try {
        let floatValue = 123456.654321;
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, floatValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_FLOAT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100 get success');
            expect(floatValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0900
     * @tc.desc   Test Js Api SingleKvStoreGetFloat testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200');
      try {
        let floatValue = 123456.0;
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, floatValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_FLOAT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200 get success');
            expect(floatValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0200 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_1000
     * @tc.desc   Test Js Api SingleKvStoreGetFloat testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300');
      try {
        let floatValue = 123456.00;
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, floatValue).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.get(KEY_TEST_FLOAT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300 get success');
            expect(floatValue == data).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300 get fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETFLOAT_PROMISE_0300 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0130
     * @tc.desc   Test Js Api SingleKvStoreDeleteString testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100');
      try {
        let str = 'this is a test string';
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, str).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_STRING_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100 delete success');
            expect(data == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0090
     * @tc.desc   Test Js Api SingleKvStoreDeleteString testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200');
      try {
        let str = '';
        for (let i = 0 ; i < 4096; i++) {
          str += 'x';
        }
        await kvStore!.put(KEY_TEST_STRING_ELEMENT, str).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_STRING_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200 delete success');
            expect(data == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0200 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0080
     * @tc.desc   Test Js Api SingleKvStoreDeleteString testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0300');
      try {
        await kvStore!.delete(KEY_TEST_STRING_ELEMENT).then((data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0300 delete success');
          expect(data == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0300 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETESTRING_PROMISE_0300 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0120
     * @tc.desc   Test Js Api SingleKvStoreDeleteInt testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_INT_ELEMENT, VALUE_TEST_INT_ELEMENT).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_INT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100 delete success');
            expect(data == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEINT_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0110
     * @tc.desc   Test Js Api SingleKvStoreDeleteFloat testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_FLOAT_ELEMENT, VALUE_TEST_FLOAT_ELEMENT).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_FLOAT_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100 delete success');
            expect(data == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEFLOAT_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0100
     * @tc.desc   Test Js Api SingleKvStoreDeleteBool testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100');
      try {
        await kvStore!.put(KEY_TEST_BOOLEAN_ELEMENT, VALUE_TEST_BOOLEAN_ELEMENT).then(async (data) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.delete(KEY_TEST_BOOLEAN_ELEMENT).then((data) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100 delete success');
            expect(data == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBOOLEAN_PROMISE_0100 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0050
     * @tc.desc   Test Js Api SingleKvStore.Delete() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0100');
      try {
        await kvStore!.delete("KEY_TEST_STRING_ELEMENTS").then((data) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0100 delete success');
          expect(data == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0100 delete fail err ' + err);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0100 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0060
     * @tc.desc   Test Js Api SingleKvStore.Delete() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200');
      try {
        await kvStore!.put("name", "Bob").then(async (data) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.delete("name").then((data) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200 delete success');
            expect(data == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0200 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0070
     * @tc.desc   Test Js Api SingleKvStore.Delete() testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300');
      try {
        await kvStore!.put("number", "123").then(async (data) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300 put success');
          expect(data == undefined).assertTrue();
          await kvStore!.delete("number").then((data) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300 delete success');
            expect(data == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300 delete fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300 put fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch (e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEPREDICATES_PROMISE_0300 put e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0520
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100');
      try {
        let entries = putBatchString(10, 'batch_test_string_key');
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_string_key').then((entrys) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100 getEntries success');
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100 ' + JSON.stringify(entries));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 'batch_test_string_value').assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100 getEntries fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0510
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_number_key').then((entrys) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200 getEntries success');
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 222).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200 getEntries fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0200 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0500
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_number_key').then((entrys) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300 getEntries success');
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 2.0).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300 getEntries fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0300 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0490
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_number_key').then((entrys) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400 getEntries success');
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == 2.00).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400 getEntries fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0400 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0470
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 005
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_bool_key').then((entrys) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500 getEntries success');
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value == bo).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500 getEntries fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0500 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0480
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 006
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_bool_key').then((entrys) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600 getEntries success');
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value.toString() == arr.toString()).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600 getEntries fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCH_PROMISE_0600 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0450
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100 putBatch success');
          expect(err == undefined).assertTrue();
          let query = new factory.Query();
          query.prefixKey("batch_test_");
          await kvStore!.getEntries(query).then((entrys) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100 getEntries success');
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100 entrys.length: ' + entrys.length);
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0440
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'key_test_int';
          let entry: factory.Entry = {
            key: key + i,
            value: {
              type: factory.ValueType.INTEGER,
              value: '123'
            }
          }
          entries.push(entry);
        }
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0100 putBatch success');
          expect(err == undefined).assertTrue();
          let query = new factory.Query();
          query.prefixKey("key_test_");
          await kvStore!.getEntries(query).then((entrys) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200 getEntries success');
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200 entrys.length: ' + entrys.length);
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200 delete fail ' + err);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200 delete fail ' + err);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0200 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0430
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'key_test_boolean';
          let entry: factory.Entry = {
            key: key + i,
            value: {
              type: factory.ValueType.BOOLEAN,
              value: 'true'
            }
          }
          entries.push(entry);
        }
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300 putBatch success');
          expect(err == undefined).assertTrue();
          let query = new factory.Query();
          query.prefixKey("key_test_");
          await kvStore!.getEntries(query).then((entrys) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300 getEntries success');
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300 entrys.length: ' + entrys.length);
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0300 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0410
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'key_test_float';
          let entry: factory.Entry = {
            key: key + i,
            value: {
              type: factory.ValueType.FLOAT,
              value: '321.12'
            }
          }
          entries.push(entry);
        }
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400 putBatch success');
          expect(err == undefined).assertTrue();
          let query = new factory.Query();
          query.prefixKey("key_test_");
          await kvStore!.getEntries(query).then((entrys) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400 getEntries success');
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400 entrys.length: ' + entrys.length);
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0400 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0420
     * @tc.desc   Test Js Api SingleKvStore.PutBatch() testcase 005
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500');
      try {
        let entries: factory.Entry[] = [];
        for (let i = 0; i < 10; i++) {
          let key = 'key_test_string';
          let entry: factory.Entry = {
            key: key + i,
            value: {
              type: factory.ValueType.STRING,
              value: 'value-string-001'
            }
          }
          entries.push(entry);
        }
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 putBatch success');
          expect(err == undefined).assertTrue();
          let query = new factory.Query();
          query.prefixKey("key_test_");
          await kvStore!.getEntries(query).then((entrys) => {
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 getEntries success');
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 entrys.length: ' + entrys.length);
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 entrys[1]: ' + JSON.stringify(entrys[1]));
            expect(entrys.length == 10).assertTrue();
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 entrys[0]: ' + JSON.stringify(entrys[0]));
            console.log('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 entrys[0]: ' + JSON.stringify(entrys[0].value));
            expect(entrys[0].value.value == 'value-string-001').assertTrue();
            done();
          });
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_PUTBATCHVALUE_PROMISE_0500 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0530
     * @tc.desc   Test Js Api SingleKvStoreDeleteBatch testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.deleteBatch(keys).then((err) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100 deleteBatch success');
            expect(err == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100 deleteBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0540
     * @tc.desc   Test Js Api SingleKvStoreDeleteBatch testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0200');
      try {
        let keys = ['batch_test_string_key1', 'batch_test_string_key2'];
        await kvStore!.deleteBatch(keys).then((err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0200 deleteBatch success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0200 deleteBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0200 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0550
     * @tc.desc   Test Js Api SingleKvStoreDeleteBatch testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300');
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
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300 putBatch success');
          expect(err == undefined).assertTrue();
          let keys = ['batch_test_string_key1', 'batch_test_string_keya'];
          await kvStore!.deleteBatch(keys).then((err) => {
            console.info('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300 deleteBatch success');
            expect(err == undefined).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300 deleteBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_DELETEBATCHVALUE_PROMISE_0300 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0020
     * @tc.desc   Test Js Api SingleKvStoreGetResultSet testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100');
      try {
        let resultSet: factory.KVStoreResultSet | null = null;
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
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100 putBatch success');
          expect(err == undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.getResultSet('batch_test_string_key').then((result) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100 getResultSet success');
          resultSet = result;
          expect(resultSet.getCount() == 10).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.closeResultSet(resultSet).then((err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100 closeResultSet success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0040
     * @tc.desc   Test Js Api SingleKvStoreGetResultSet testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200');
      try {
        let resultSet: factory.KVStoreResultSet | null = null;
        await kvStore!.getResultSet('batch_test_string_key').then((result) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200 getResultSet success');
          resultSet = result;
          expect(resultSet.getCount() == 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.closeResultSet(resultSet).then((err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200 closeResultSet success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0200 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0370
     * @tc.desc   Test Js Api SingleKvStoreGetResultSet testcase 005
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500');
      try {
        let resultSet: factory.KVStoreResultSet | null = null;
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
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500 putBatch success');
          expect(err == undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        let query = new factory.Query();
        query.prefixKey("batch_test");
        await kvStore!.getResultSet(query).then((result) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500 getResultSet success');
          resultSet = result;
          expect(resultSet.getCount() == 10).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.closeResultSet(resultSet).then((err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500 closeResultSet success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0500 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0380
     * @tc.desc   Test Js Api SingleKvStoreGetResultSet testcase 006
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600');
      try {
        let resultSet: factory.KVStoreResultSet | null = null;
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
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600 putBatch success');
          expect(err == undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        let query = new factory.Query();
        query.prefixKey("batch_test");
        await kvStore!.getResultSet(query).then((result) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600 getResultSet success');
          resultSet = result;
          expect(resultSet.getCount() == 10).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.closeResultSet(resultSet).then((err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600 closeResultSet success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0600 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0360
     * @tc.desc   Test Js Api SingleKvStore.GetResultSet() testcase 007
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.log('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700');
      try {
        let entries: factory.Entry[] = [];
        let resultSet: factory.KVStoreResultSet | null = null;
        for (let i = 0; i < 10; i++) {
          let key = 'name_';
          let value = 'Bob_'
          let entry: factory.Entry = {
            key : key + i,
            value : {
              type : factory.ValueType.STRING,
              value :value + i
            }
          }
          entries.push(entry);
        }
        await kvStore!.putBatch(entries).then(async (err) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700 putBatch success');
          expect(err == undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        let query = new factory.Query();
        query.prefixKey("name_");
        await kvStore!.getResultSet(query).then((result) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700 getResultSet success');
          resultSet = result;
          expect(resultSet.getCount() == 10).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.closeResultSet(resultSet).then((err) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700 closeResultSet success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0700 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0350
     * @tc.desc   Test Js Api SingleKvStore.GetResultSet() testcase 008
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.log('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800');
      try {
        let resultSet: factory.KVStoreResultSet | null = null;
        let query = new factory.Query();
        await kvStore!.getResultSet(query).then((result) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800 getResultSet success');
          resultSet = result;
          expect(resultSet.getCount() == 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.closeResultSet(resultSet).then((err) => {
          console.log('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800 closeResultSet success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      } catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSET_PROMISE_0800 e' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0270
     * @tc.desc   Test Js Api SingleKvStoreCloseResultSet testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0100');
      try {
        console.info('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0100 success');
        let resultSet = null;
        await kvStore!.closeResultSet(resultSet).then(() => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0100 closeResultSet success');
          expect(null).assertFail();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0100 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(e.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0280
     * @tc.desc   Test Js Api SingleKvStoreCloseResultSet testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200');
      try {
        let resultSet: factory.KVStoreResultSet | undefined = undefined;
        await kvStore!.getResultSet('batch_test_string_key').then((result) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200 getResultSet success');
          resultSet = result;
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        await kvStore!.closeResultSet(resultSet).then((err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200 closeResultSet success');
          expect(err == undefined).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200 closeResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_CLOSERESULTSET_PROMISE_0200 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSIZE_PROMISE_0100
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvPromiseEtsApiTest_0390
     * @tc.desc   Test Js Api SingleKvStoreGetResultSize testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSIZE_PROMISE_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSIZE_PROMISE_0100');
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
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSIZE_PROMISE_0100 putBatch success');
          expect(err == undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_SETSYNCRANGE_PROMISE_0100 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
        });
        let query = new factory.Query();
        query.prefixKey("batch_test");
        await kvStore!.getResultSize(query).then((resultSize) => {
          console.info('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSIZE_PROMISE_0100 getResultSet success');
          expect(resultSize == 10).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSIZE_PROMISE_0100 getResultSet fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('SUB_DDM_DKV_SINGLEKVSTORE_GETRESULTSIZE_PROMISE_0100 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })

  })
}