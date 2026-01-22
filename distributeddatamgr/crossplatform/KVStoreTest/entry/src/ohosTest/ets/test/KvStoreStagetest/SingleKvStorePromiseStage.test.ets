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
let context: common.UIAbilityContext;

export default function singleKvStorePromiseStageTest(){
  describe('singleKvStorePromiseStageTest', () => {
    const options: factory.Options = {
      createIfMissing : true,
      kvStoreType : factory.KVStoreType.SINGLE_VERSION,
      securityLevel : factory.SecurityLevel.S3,
    }

    beforeAll(async (done: Function) => {
      context = AppStorage.get<common.UIAbilityContext>("TestAbilityContext") as common.UIAbilityContext;
      const config: factory.KVManagerConfig = {
        bundleName: TEST_BUNDLE_NAME,
        context: context
      }
      console.info('beforeAll config:'+ JSON.stringify(config));
      kvManager = factory.createKVManager(config);
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
        console.info('beforeEach getKVStore err ' + err);
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
          console.info('afterEach deleteKVStore err ' + err);
          done();
        });
      }).catch((err: BusinessError) => {
        console.info('afterEach closeKVStore err ' + err);
        done();
      });
    })

    /**
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetResultSize002
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_0350
     * @tc.desc   Test Js Api SingleKvStoreGetResultSize testcase 002
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetResultSize002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetResultSize001');
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
          console.info('testSingleKvStoreGetResultSize001 putBatch success');
          expect(err == undefined).assertTrue();
        }).catch((err: BusinessError) => {
          console.info('testSingleKvStorePutBatch001 putBatch fail ' + err);
          expect(err != null).assertTrue();
        });
        let query = new factory.Query();
        query.prefixKey("batch_test");
        await kvStore!.getResultSize(query).then((resultSize) => {
          console.info('testSingleKvStoreGetResultSize001 getResultSet success');
          expect(resultSize == 10).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.info('testSingleKvStoreGetResultSize001 getResultSet fail ' + err);
          expect(err != null).assertTrue();
          done();
        });
      }catch(e) {
        console.info('testSingleKvStoreGetResultSize001 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetEntries001
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_0220
     * @tc.desc   Test Js Api SingleKvStoreGetEntries testcase 001
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetEntries001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetEntries001');
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
        console.info('testSingleKvStoreGetEntries001 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries).then(async (err) => {
          console.info('testSingleKvStoreGetEntries001 putBatch success');
          expect(err == undefined).assertTrue();
          await kvStore!.getEntries('batch_test_bool_key').then((entrys) => {
            console.info('testSingleKvStoreGetEntries001 getEntries success');
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value.toString() == arr.toString()).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error('testSingleKvStoreGetEntries001 getEntries fail ' + `, error code is ${err.code}, message is ${err.message}`);
            expect(null).assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error('testSingleKvStoreGetEntries001 putBatch fail ' + `, error code is ${err.code}, message is ${err.message}`);
          expect(null).assertFail();
          done();
        });
      }catch(e) {
        console.error('testSingleKvStoreGetEntries001 e ' + `, error code is ${e.code}, message is ${e.message}`);
        expect(null).assertFail();
        done();
      }
    })
  })
}