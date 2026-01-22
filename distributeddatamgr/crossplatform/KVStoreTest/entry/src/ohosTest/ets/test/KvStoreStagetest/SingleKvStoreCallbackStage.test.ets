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
let kvManager: factory.KVManager | null = null;
let kvStore: factory.SingleKVStore | null = null;
let context: common.UIAbilityContext;

export default function singleKvStoreCallbackStageTest(){
  describe('singleKvStoreCallbackStageTest', () => {
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
      console.info('beforeAll config:' + JSON.stringify(config));
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
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetResultSet102
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_1230
     * @tc.desc   Test Js Api SingleKvStore.GetResultSet() testcase 102
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetResultSet102', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetResultSet102');
      try {
        let resultSet: factory.KVStoreResultSet;
        await kvStore!.getResultSet('batch_test_string_key', async (err, result) => {
          console.info('testSingleKvStoreGetResultSet102 getResultSet success');
          resultSet = result;
          expect(resultSet.getCount() == 0).assertTrue();
          await kvStore!.closeResultSet(resultSet, (err, data) => {
            console.info('testSingleKvStoreGetResultSet102 closeResultSet success');
            expect(err == undefined).assertTrue();
            done();
          })
        });
      }catch(e) {
        console.info('testSingleKvStoreGetResultSet102 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetResultSet105
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_1260
     * @tc.desc   Test Js Api SingleKvStore.GetResultSet() testcase 105
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetResultSet105', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetResultSet105');
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
          console.info('testSingleKvStoreGetResultSet105 putBatch success');
          expect(err == undefined).assertTrue();
          let query = new factory.Query();
          query.prefixKey("batch_test");
          await kvStore!.getResultSet(query, async (err, result) => {
            console.info('testSingleKvStoreGetResultSet105 getResultSet success');
            resultSet = result;
            expect(resultSet.getCount() == 10).assertTrue();
            await kvStore!.closeResultSet(resultSet, (err, data) => {
              console.info('testSingleKvStoreGetResultSet105 closeResultSet success');
              expect(err != undefined).assertFalse();
              done();
            })
          });
        });
      } catch(e) {
        console.info('testSingleKvStoreGetResultSet105 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetResultSet106
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_1270
     * @tc.desc   Test Js Api SingleKvStore.GetResultSet() testcase 106
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetResultSet106', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetResultSet106');
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
          console.info('testSingleKvStoreGetResultSet106 putBatch success');
          let query = new factory.Query();
          query.prefixKey("batch_test");
          await kvStore!.getResultSet(query, async (err, result) => {
            console.info('testSingleKvStoreGetResultSet106 getResultSet success');
            resultSet = result;
            expect(resultSet.getCount() == 10).assertTrue();
            await kvStore!.closeResultSet(resultSet, (err, data) => {
              console.info('testSingleKvStoreGetResultSet106 closeResultSet success');
              expect(err != undefined).assertFalse();
              done();
            })
          });
        });
      } catch(e) {
        console.info('testSingleKvStoreGetResultSet106 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetResultSize101
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_1280
     * @tc.desc   Test Js Api SingleKvStore.GetResultSize() testcase 101
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetResultSize101', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetResultSize101');
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
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('testSingleKvStoreGetResultSize101 putBatch success');
          let query = new factory.Query();
          query.prefixKey("batch_test");
          await kvStore!.getResultSize(query, async (err, resultSize) => {
            console.info('testSingleKvStoreGetResultSize101 getResultSet success');
            expect(resultSize == 10).assertTrue();
            done();
          });
        });
      } catch(e) {
        console.info('testSingleKvStoreGetResultSize101 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetResultSize102
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_1290
     * @tc.desc   Test Js Api SingleKvStore.GetResultSize() testcase 102
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetResultSize102', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetResultSize102');
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
        await kvStore!.putBatch(entries, async (err, data) => {
          console.info('testSingleKvStoreGetResultSize102 putBatch success');
          let query = new factory.Query();
          query.prefixKey("batch_test");
          await kvStore!.getResultSize(query, async (err, resultSize) => {
            console.info('testSingleKvStoreGetResultSize102 getResultSet success');
            expect(resultSize == 10).assertTrue();
            done();
          });

        });
      } catch(e) {
        console.info('testSingleKvStoreGetResultSize102 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_testEtsSingleKvStoreGetEntries102
     * @tc.number SUB_DistributedData_KVStore_SDK_SingleKvStoreEtsApiTest_1180
     * @tc.desc   Test Js Api SingleKvStore.GetEntries() testcase 102
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_testEtsSingleKvStoreGetEntries102', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('testSingleKvStoreGetEntries102');
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
        console.info('testSingleKvStoreGetEntries102 entries: ' + JSON.stringify(entries));
        await kvStore!.putBatch(entries, async (err,data) => {
          console.info('testSingleKvStoreGetEntries102 putBatch success');
          let query = new factory.Query();
          query.prefixKey("batch_test");
          await kvStore!.getEntries(query, (err,entrys) => {
            console.info('testSingleKvStoreGetEntries102 getEntries success');
            console.info('testSingleKvStoreGetEntries102 entrys.length: ' + entrys.length);
            console.info('testSingleKvStoreGetEntries102 entrys[0]: ' + JSON.stringify(entrys[0]));
            expect(entrys.length == 10).assertTrue();
            expect(entrys[0].value.value.toString() == arr.toString()).assertTrue();
            done();
          });
        });
      }catch(e) {
        console.info('testSingleKvStoreGetEntries102 e ' + e);
        expect(e != null).assertTrue();
        done();
      }
    })
  })
}