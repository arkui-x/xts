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
import { BusinessError } from '@kit.BasicServicesKit';

const TEST_BUNDLE_NAME = 'com.example.kvstoretest';
const TEST_STORE_ID = 'storeId';
let kvManager: factory.KVManager | null = null;
let kvStore: factory.SingleKVStore | null = null;
const STORE_KEY = 'key_test_string';
const STORE_VALUE = 'value-test-string';
let kvStoreNew: factory.SingleKVStore | null = null;
let context: common.UIAbilityContext;

function sleep(ms:number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function kvManagerPromiseStageTest(){
  describe('kvManagerPromiseStageTest', () => {
    const options: factory.Options = {
      createIfMissing: true,
      kvStoreType: factory.KVStoreType.SINGLE_VERSION,
      securityLevel: factory.SecurityLevel.S3,
    }

    beforeAll(async (done: Function) => {
      context = AppStorage.get<common.UIAbilityContext>("TestAbilityContext") as common.UIAbilityContext;
      const config: factory.KVManagerConfig = {
        bundleName: TEST_BUNDLE_NAME,
        context: context
      }
      console.info('beforeAll');
      kvManager = factory.createKVManager(config)
      kvManager.getKVStore(TEST_STORE_ID, options).then((store: factory.SingleKVStore) => {
        console.info("beforeAll getKVStore success");
        kvStoreNew = store;
        done();
      }).catch((err: BusinessError) => {
        console.info("beforeAll getKVStore err: "  + JSON.stringify(err));
        done();
      });
    })

    afterAll(async (done: Function) => {
      console.info('afterAll');
      await sleep(500);
      kvManager = null;
      kvStore = null;
      done();
    })

    beforeEach(async (done: Function) => {
      console.info('beforeEach');
      done();
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
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore003
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_2000
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 003
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testKVManagerGetKVStore003');
      const optionsInfo: factory.Options = {
        createIfMissing: true,
        kvStoreType: factory.KVStoreType.SINGLE_VERSION,
        securityLevel: factory.SecurityLevel.S3,
      }
      await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo).then((store: factory.SingleKVStore) => {
        console.info('testKVManagerGetKVStore003 getKVStore success');
        kvStore = store;
        expect(store != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.info('testKVManagerGetKVStore003 getKVStore err ' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err !=null ).assertTrue();
        done();
      });
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore004
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_2100
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 004
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testKVManagerGetKVStore004');
      const optionsInfo: factory.Options = {
        createIfMissing: false,
        kvStoreType: factory.KVStoreType.SINGLE_VERSION,
        securityLevel: factory.SecurityLevel.S3,
      }
      await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo).then((store: factory.SingleKVStore) => {
        console.info('testKVManagerGetKVStore004 getKVStore success');
        expect(store != null).assertTrue();
      }).catch((err: BusinessError) => {
        console.info('testKVManagerGetKVStore004 getKVStore err ' + err);
      });
      done();
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore008
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_2500
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 008
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testKVManagerGetKVStore008');
      const optionsInfo: factory.Options = {
        createIfMissing: true,
        kvStoreType: factory.KVStoreType.SINGLE_VERSION,
        securityLevel: factory.SecurityLevel.S3,
      }
      await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo).then((store: factory.SingleKVStore) => {
        console.info('testKVManagerGetKVStore008 getKVStore success' + store);
        expect(store != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.info('testKVManagerGetKVStore008 getKVStore err ' + err);
        expect(err !=null ).assertTrue();
        done();
      });
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore014
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_3100
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 014
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_testEtsKVManagerGetKVStore014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('testKVManagerGetKVStore014');
      const optionsInfo: factory.Options = {
        createIfMissing: true,
        kvStoreType: factory.KVStoreType.SINGLE_VERSION,
        securityLevel: factory.SecurityLevel.S3,
      }
      await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo).then((store: factory.SingleKVStore) => {
        console.info('testKVManagerGetKVStore014 getKVStore success' + store);
        expect(store != null).assertTrue();
      }).catch((err: BusinessError) => {
        console.info('testKVManagerGetKVStore014 getKVStore err ' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      });
      done();
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore015
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_3200
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 015
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_testEtsKVManagerGetKVStore015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testKVManagerGetKVStore015');
      const optionsInfo: factory.Options = {
        createIfMissing: true,
        kvStoreType: factory.KVStoreType.SINGLE_VERSION,
        securityLevel: factory.SecurityLevel.S3,
      }
      await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo).then((store: factory.SingleKVStore) => {
        console.info('testKVManagerGetKVStore015 getKVStore success' + store);
        expect(store != null).assertTrue();
      }).catch((err: BusinessError) => {
        console.info('testKVManagerGetKVStore015 getKVStore err ' + err);
        expect(err != null).assertTrue();
      });
      done();
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerGetKVStore016
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_3300
     * @tc.desc   Test Js Api KVManager.GetKVStore testcase 016
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerGetKVStore016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testKVManagerGetKVStore016');
      const optionsInfo: factory.Options = {
        createIfMissing: true,
        kvStoreType: factory.KVStoreType.SINGLE_VERSION,
        securityLevel: factory.SecurityLevel.S3,
      }
      await kvManager!.getKVStore(TEST_STORE_ID, optionsInfo).then((store: factory.SingleKVStore) => {
        console.info('testKVManagerGetKVStore016 getKVStore success' + store);
        expect(store != null).assertTrue();
      }).catch((err: BusinessError) => {
        console.info('testKVManagerGetKVStore016 getKVStore err ' + err);
        expect(err != null).assertTrue();
      });
      done();
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerCloseKVStore001
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_0400
     * @tc.desc   Test Js Api KVManager.CloseKVStore testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVManagerCloseKVStore001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('testEtsKVManagerCloseKVStore001');
      kvManager!.getKVStore(TEST_STORE_ID, options, async (err, store: factory.SingleKVStore) => {
        kvStore = store;
        console.info('testKVManagerCloseKVStore001 getKVStore success');
        await kvManager!.closeKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID);
        console.info('testKVManagerCloseKVStore001 closeKVStore redo.');
        await kvManager!.closeKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID).then((err) => {
          console.info('testKVManagerCloseKVStore001 closeKVStore twice ');
          expect(err == null).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.info('testKVManagerCloseKVStore001 err ' + err);
          expect().assertFail();
          done();
        });
      });
    })

    /**
     * @tc.name   ArkUIX_testEtsKVManagerDeleteKVStore001
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_0900
     * @tc.desc   Test Js Api KVManager.DeleteKVStore testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_testEtsKVManagerDeleteKVStore001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('testKVManagerDeleteKVStore001');
      await kvManager!.deleteKVStore(TEST_BUNDLE_NAME, TEST_STORE_ID).then(() => {
        console.info('testKVManagerDeleteKVStore001 deleteKVStore success');
        expect(null).assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.info('testKVManagerDeleteKVStore001 deleteKVStore err ' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err != null).assertTrue();
        done();
      });
    })

    /**
     * @tc.name   ArkUIX_testEtsKVStorePut001
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_0200
     * @tc.desc   Test Js Api KVManager.Put testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVStorePut001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testKVStorePut001');
      try {
        await kvStoreNew!.put(TEST_BUNDLE_NAME, TEST_STORE_ID).then(() => {
          console.info(`testKVStorePut001 Succeeded in putting data`);
        }).catch((err: BusinessError) => {
          console.error(`testKVStorePut001 Failed to put err :` + err);
          expect( err != null).assertTrue();
        });
      } catch (e) {
        console.info('testKVStorePut001 e ' + e);
        expect( e != null).assertTrue();
      }
      done();
    })

    /**
     * @tc.name   ArkUIX_testEtsKVStoreDelete001
     * @tc.number SUB_DistributedData_KVStore_SDK_KVStoreEtsApiTest_0300
     * @tc.desc   Test Js Api KVManager.Delete testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsKVStoreDelete001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testKVStoreDelete001');
      try {
        kvStoreNew!.put(STORE_KEY, STORE_VALUE).then((data) => {
          console.info('testKVStoreDelete001 getKVStore success');
          kvStoreNew!.delete(STORE_KEY).then(() => {
            console.info("testKVStoreDelete001 promise delete success");
            done();
          }).catch((err: BusinessError) => {
            console.info('testKVStoreDelete001 promise delete fail err' + err);
            done();
          });
        }).catch((err: BusinessError) => {
          console.info('testKVStoreDelete001 promise delete fail err' + err);
          done();
        });
      }catch (err) {
        console.info('testKVStoreDelete001 promise delete fail err' + err);
        expect( err != null).assertTrue();
        done();
      }
    })
  })
}