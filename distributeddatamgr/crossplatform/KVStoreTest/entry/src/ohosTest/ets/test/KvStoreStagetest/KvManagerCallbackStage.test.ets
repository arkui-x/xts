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
import factory from '@ohos.data.distributedKVStore';
import common from "@ohos.app.ability.common";

const TEST_BUNDLE_NAME = 'com.example.kvstoretest';
const TEST_STORE_ID = 'storeId';
const STORE_KEY = 'key_test_string';
const STORE_VALUE = 'value-test-string';
let kvManager: factory.KVManager | null = null;
let kvStore: factory.SingleKVStore | null = null;
let context: common.UIAbilityContext;

function sleep(ms:number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function kvManagerCallbackStageTest(){
  describe('kvManagerCallbackStageTest', () => {
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
      kvManager = factory.createKVManager(config);
      console.info('beforeAll end');
      done();
    })

    afterAll(async (done: Function) =>  {
      console.info('afterAll');
      await sleep(500);
      kvManager = null;
      kvStore = null;
      done();
    })

    beforeEach(async (done: Function) =>  {
      console.info('beforeEach');
      done();
    })

    afterEach(async (done: Function) =>  {
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
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore109
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_4500
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 109
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore109', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVManagerGetKVStore109');
      const optionsInfo: factory.Options = {
        createIfMissing : true,
        kvStoreType : factory.KVStoreType.SINGLE_VERSION,
        securityLevel : factory.SecurityLevel.S3,
      }
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo, (err, store: factory.SingleKVStore) => {
          console.info('testKVManagerGetKVStore109 getKVStore success');
          expect((err == undefined) && (store != null)).assertTrue();
          kvStore = store;
          done();
        });
      } catch (e) {
        console.info('testKVManagerGetKVStore109 getKVStore e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore110
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_3700
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 110
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore110', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVManagerGetKVStore110');
      const optionsInfo: factory.Options = {
        createIfMissing : true,
        kvStoreType : factory.KVStoreType.SINGLE_VERSION,
        securityLevel : factory.SecurityLevel.S3,
      }
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo, (err, store: factory.SingleKVStore) => {
          console.info('testKVManagerGetKVStore110 getKVStore success');
          expect((err == undefined) && (store != null)).assertTrue();
          kvStore = store;
          done();
        });
      } catch (e) {
        console.info('testKVManagerGetKVStore110 getKVStore e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore111
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_4700
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 111
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore111', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVManagerGetKVStore111');
      const optionsInfo: factory.Options = {
        createIfMissing : true,
        kvStoreType : factory.KVStoreType.SINGLE_VERSION,
        securityLevel : factory.SecurityLevel.S3,
      }
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo, (err, store: factory.SingleKVStore) => {
          console.info('testKVManagerGetKVStore111 getKVStore success');
          expect((err == undefined) && (store != null)).assertTrue();
          kvStore = store;
          done();
        });
      } catch (e) {
        console.info('testKVManagerGetKVStore111 getKVStore e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore116
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_5200
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 116
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore116', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVManagerGetKVStore116');
      const optionsInfo: factory.Options = {
        createIfMissing : true,
        kvStoreType : factory.KVStoreType.SINGLE_VERSION,
        securityLevel : factory.SecurityLevel.S3,
      }
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo, (err, store: factory.SingleKVStore) => {
          console.info('testKVManagerGetKVStore116 getKVStore success');
          expect((err === undefined) && (store !== undefined)).assertTrue();
          done();
        });
      } catch (e) {
        console.info('testKVManagerGetKVStore116 getKVStore e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore117
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_5300
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 117
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore117', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVManagerGetKVStore117');
      const optionsInfo: factory.Options = {
        createIfMissing : true,
        kvStoreType : factory.KVStoreType.SINGLE_VERSION,
        securityLevel : factory.SecurityLevel.S3,
      }
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo, (err, store: factory.SingleKVStore) => {
          console.info('testKVManagerGetKVStore117 getKVStore success');
          expect((err === undefined) && (store !== undefined)).assertTrue();
          done();
        });
      } catch (e) {
        console.info('testKVManagerGetKVStore117 getKVStore e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerCloseKVStore103
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_0700
     * @tc.desc   Test Js Api KVManager.CloseKVStore testcase 103
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_testEtsKVManagerCloseKVStore103', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) =>  {
      console.info('testKVManagerCloseKVStore103');
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, options, async (err, store: factory.SingleKVStore) => {
          console.info('testKVManagerCloseKVStore103 getKVStore success');
          kvStore = store;
          try {
            await kvManager!.closeKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID, (err, data) => {
              console.info('testKVManagerCloseKVStore103 closeKVStore success');
            });
            done();
          } catch (e) {
            console.info('testKVManagerCloseKVStore103 closeKVStore e ' + `, error code is ${e.code}, message is ${e.message}`);
            expect(e.code == 401).assertTrue();
            done();
          }
        });
      } catch (ee) {
        console.info('testKVManagerCloseKVStore103 getKVStore ee ' + `, error code is ${ee.code}, message is ${ee.message}`);
        expect(ee.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerDeleteKVStore101
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_1100
     * @tc.desc   Test Js Api KVManager.DeleteKVStore testcase 101
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerDeleteKVStore101', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVManagerDeleteKVStore101');
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, options, async (err, store: factory.SingleKVStore) => {
          console.info('testKVManagerDeleteKVStore101 getKVStore success');
          kvStore = store;
          await kvManager!.deleteKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID, (err, data) => {
            console.info('testKVManagerDeleteKVStore101 deleteKVStore success');
            expect((err == undefined) && (data == undefined)).assertTrue();
            done();
          });
        });
      } catch (e) {
        console.info('testKVManagerDeleteKVStore101 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerDeleteKVStore103
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_1300
     * @tc.desc   Test Js Api KVManager.DeleteKVStore testcase 103
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerDeleteKVStore103', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVManagerDeleteKVStore103');
      try {
        await kvManager!.deleteKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID, (err, data) => {
          if (err == undefined){
            console.info('testKVManagerDeleteKVStore103 deleteKVStore success');
          } else {
            console.info('testKVManagerDeleteKVStore103 deleteKVStore fail');
          }
          done();
        });
      } catch (e) {
        console.info('testKVManagerDeleteKVStore103 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsKVStorePut100
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_0100
     * @tc.desc   Test Js Api KVManager.Put testcase 100
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVStorePut100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) =>  {
      console.info('testKVStorePut100');
      try {
        await kvManager!.getKVStore(TEST_STORE_ID, options, async (err, store: factory.SingleKVStore) => {
          console.info('testKVStorePut100 getKVStore success');
          kvStore = store;
          await kvStore.put(STORE_KEY, STORE_VALUE, (err, data) => {
            if (err != undefined){
              console.info('testKVStorePut100 put callback fail');
            } else {
              console.info('testKVStorePut100 put callback success');
            }
            done();
          });
        });
      } catch (e) {
        console.info('testKVStorePut100 callback e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })
  })
}