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
import distributedKVStore from '@ohos.data.distributedKVStore';
import hilog from '@ohos.hilog'
import common from '@ohos.app.ability.common';
import { BusinessError } from '@ohos.base';
import Utils from './Util.test';

export default function KvStoreEtsTestStatic() {
  let domain: number = 0x0000; //日志标识,0x0000作为测试框架的业务标识
  let tag: string = 'testTag >>>>>> '; //日志标识字符串,作为tag标识当前runner类下的测试行为

  hilog.info(domain, tag, '%{public}s', '================ export kvstoretest start ....');
  const TEST_BUNDLE_NAME = 'com.example.kvstoretest';
  const TEST_SINGLE_STORE_ID = 'single_testId';
  hilog.info(domain, tag, '%{public}s', '================ export kvstoretest 111');
  let kvManager : distributedKVStore.KVManager;
  let context: common.UIAbilityContext;

  describe("KvStoreEtsTestStatic", (): void => {
    hilog.info(domain, tag, '%{public}s', '================ describe kvstoretest start ==========');
    let singleOptions : distributedKVStore.Options = {
      createIfMissing : true,
      kvStoreType : distributedKVStore.KVStoreType.SINGLE_VERSION,
      schema : undefined,
      securityLevel : distributedKVStore.SecurityLevel.S3,
    }
    hilog.info(domain, tag, '%{public}s', '================ describe kvstoretest singleOptions');
    
    beforeAll(async (): Promise<void> => {
      try {
        hilog.info(domain, tag, '%{public}s', '================ beforeAll start==========');
        await Utils.msSleep(2000)
        context = AppStorage.get("TestAbilityContext") as common.UIAbilityContext;
        hilog.info(domain, tag, '%{public}s', 'onAbilityCreate enddatabaseDir:' + context.databaseDir);
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "============beforeAll e: " + e);
        hilog.info(domain, tag, '%{public}s', '================ beforeAll end==========');
      }
    })

    beforeEach(async () => {
      hilog.info(domain, tag, '%{public}s', '================ beforeEach start==========');
      const config : distributedKVStore.KVManagerConfig = {
        bundleName: TEST_BUNDLE_NAME,
        context: context
      }
      hilog.info(domain, tag, '%{public}s', '================ createKVManager start ');
      kvManager = distributedKVStore.createKVManager(config);
      await Utils.msSleep(100)
      hilog.info(domain, tag, '%{public}s', '================ createKVManager end, kvManager=' + kvManager);
      hilog.info(domain, tag, '%{public}s', '================ beforeEach end==========');
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest001
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0010
     * @tc.desc   getKVStore<distributedKVStore.SingleKVStore>
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_KvStoreTest001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest001 start ");
      try {
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest001 start getKvstore");
        let store = await kvManager.getKVStore<distributedKVStore.SingleKVStore>(TEST_SINGLE_STORE_ID, singleOptions);
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest001 getKvstore end");
        expect(store !== null).assertTrue();
        done();
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "============fail on exception: " + e);
        expect(null).assertFail();
        done();
      }
      hilog.info(domain, tag, '%{public}s', "============done  ");
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest003
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0030
     * @tc.desc   SingleKVStore put get string
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_KvStoreTest003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest003 start ");
      const KEY_TEST_STRING_ELEMENT = 'key_test_string';
      const VALUE_TEST_STRING_ELEMENT = 'value-string-001';
      try {
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest003 start getKvstore");
        let store : distributedKVStore.SingleKVStore = await kvManager.getKVStore<distributedKVStore.SingleKVStore>(TEST_SINGLE_STORE_ID, singleOptions);
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest003 start put");
        await store.put(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT);
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest003 put end");
        let value = await store.get(KEY_TEST_STRING_ELEMENT);
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest003 get end");
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest003 key is" + KEY_TEST_STRING_ELEMENT +
          ", value is " + value);
        expect(VALUE_TEST_STRING_ELEMENT === (value as string)).assertTrue();
        done();
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "============fail on exception: " + e);
        expect(null).assertFail();
        done();
      }
      hilog.info(domain, tag, '%{public}s', "============done ");;
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest005
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0050
     * @tc.desc   SingleKVStore put get Boolean
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_KvStoreTest005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest005 start ");
      const KEY_TEST_BOOL_ELEMENT = 'key_test_boolean';
      const VALUE_TEST_BOOL_ELEMENT : boolean = false;
      try {
        let store : distributedKVStore.SingleKVStore = await kvManager.getKVStore<distributedKVStore.SingleKVStore>(TEST_SINGLE_STORE_ID, singleOptions);
        await store.put(KEY_TEST_BOOL_ELEMENT, VALUE_TEST_BOOL_ELEMENT);
        let value = await store.get(KEY_TEST_BOOL_ELEMENT);
        hilog.info(domain, tag, '%{public}s',
          "============KvStoreTest005 VALUE_TEST_BOOL_ELEMENT is " + VALUE_TEST_BOOL_ELEMENT + " value is " + value);
        expect(VALUE_TEST_BOOL_ELEMENT === (value as boolean)).assertTrue();
        done();
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "============fail on exception: " + e);
        expect(null).assertFail();
        done();
      }
      hilog.info(domain, tag, '%{public}s', "============done ");
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest006
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0060
     * @tc.desc   SingleKVStore put get Uint8Array
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_KvStoreTest006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest006 start ");
      const KEY_TEST_UINT8ARRAY_ELEMENT = 'key_test_number_array';
      const buffer = new ArrayBuffer(8);
      const VALUE_TEST_UINT8ARRAY_ELEMENT : Uint8Array = new Uint8Array(buffer);
      try {
        let store : distributedKVStore.SingleKVStore = await kvManager.getKVStore<distributedKVStore.SingleKVStore>(TEST_SINGLE_STORE_ID, singleOptions);
        await store.put(KEY_TEST_UINT8ARRAY_ELEMENT, VALUE_TEST_UINT8ARRAY_ELEMENT);
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest006 put success ");
        done();
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest006 fail on exception: " + e);
        expect(null).assertFail();
        done();
      }
      hilog.info(domain, tag, '%{public}s', "============done ");
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest007
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0070
     * @tc.desc   SingleKVStore backup
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_KvStoreTest007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest007 start ");
      try {
        let store : distributedKVStore.SingleKVStore = await kvManager.getKVStore<distributedKVStore.SingleKVStore>(TEST_SINGLE_STORE_ID, singleOptions);
        let fileName : string = "test";
        await store.backup(fileName);
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest007 success");
        done();
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest007 fail on exception: " + e);
        expect(null).assertFail();
        done();
      }
      hilog.info(domain, tag, '%{public}s', "============done ");
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest009
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0090
     * @tc.desc   SingleKVStore backup  callback
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_KvStoreTest009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest009 start ");
      try {
        kvManager.getKVStore(TEST_SINGLE_STORE_ID, singleOptions, (err: BusinessError|null, store: distributedKVStore.SingleKVStore|undefined) => {
          let fileName : string = "test";
          store?.backup(fileName, (err: BusinessError|null) => {
            hilog.info(domain, tag, '%{public}s', "============KvStoreTest009 done ");
            done();
          });
        });
      }catch (e) {
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest009 fail on exception: " + e);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest018
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0180
     * @tc.desc   SingleKVStore put get  callback string
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_KvStoreTest018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest018 start ");
      const KEY_TEST_STRING_ELEMENT = 'key_test_string';
      const VALUE_TEST_STRING_ELEMENT = 'value-string-001';

      try {
        kvManager.getKVStore(TEST_SINGLE_STORE_ID, singleOptions, (err: BusinessError|null, store: distributedKVStore.SingleKVStore|undefined) => {
          store?.put(KEY_TEST_STRING_ELEMENT, VALUE_TEST_STRING_ELEMENT, (err: BusinessError|null) => {
            store?.get(KEY_TEST_STRING_ELEMENT, (err: BusinessError<void>|null, value:undefined|Boolean|String|Number|Uint8Array) => {
              expect(VALUE_TEST_STRING_ELEMENT == (value as string)).assertTrue();
              hilog.info(domain, tag, '%{public}s', "============done ");
              done();
            });
          });
        });
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "fail on exception: " + e);
        expect(null).assertFail();
        done();
      }
    })

    /**
     * @tc.name   ArkUIX_KvStoreTest021
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0210
     * @tc.desc   Schema.constructor, FieldNode.constructor, Query.constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_KvStoreTest021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "============KvStoreTest021 start ");
      try {
        let schema: distributedKVStore.Schema | null = new distributedKVStore.Schema();
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest021 Schema done ");
        done();
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "============KvStoreTest021 fail. e: " + e);
        expect(null).assertFail();
        done();
      }
    })
    
    /**
     * @tc.name   ArkUIX_KvStoreTest022
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0220
     * @tc.desc   SingleKVStore get(key)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_KvStoreTest022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "=======KvStoreTest022 start ");
      try {
        let store : distributedKVStore.SingleKVStore = await kvManager.getKVStore<distributedKVStore.SingleKVStore>(TEST_SINGLE_STORE_ID, singleOptions);
        hilog.info(domain, tag, '%{public}s', "=======KvStoreTest022 getKVStore ");
        store.get('keyno').then((data: boolean | string | number | Uint8Array) => {
          hilog.info(domain, tag, '%{public}s', "=======KvStoreTest022 get success");
          expect(null).assertFail();
          done();
        }).catch((err:Error) => {
          let error = err as BusinessError;
          hilog.info(domain, tag, '%{public}s', `=======KvStoreTest022 fail err=${error.code},ms=${error.message}`);
          expect(error.code).assertEqual(15100004);
          done();
        });
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "=======KvStoreTest022 catch e=" + e);
        expect(null).assertFail();
        done();
      }
    })
    
    /**
     * @tc.name   ArkUIX_KvStoreTest023
     * @tc.number SUB_DistributedData_KvStore_SDK_APITest_STATIC_0230
     * @tc.desc   SingleKVStore get(key)  callback
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_KvStoreTest023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:()=>void) : Promise<void> => {
      hilog.info(domain, tag, '%{public}s', "=======KvStoreTest023 start ");
      try {
        kvManager.getKVStore(TEST_SINGLE_STORE_ID, singleOptions, (err: BusinessError|null, store: distributedKVStore.SingleKVStore|undefined) => {
          store?.get('keyno', (err: BusinessError<void>|null, value: undefined|Boolean|String|Number|Uint8Array) => {
            if (err != undefined) {
              hilog.info(domain, tag, '%{public}s', `=======KvStoreTest023 fail err=${err.code},ms=${err.message}`);
              expect(err.code).assertEqual(15100004);
              done();
            } else {
              hilog.info(domain, tag, '%{public}s', "=======KvStoreTest023 get success");
              expect(null).assertFail();
              done();
            }
          });
        });
      } catch (e) {
        hilog.info(domain, tag, '%{public}s', "=======KvStoreTest023 catch e=" + e);
        expect(null).assertFail();
        done();
      }
    })

  })
}