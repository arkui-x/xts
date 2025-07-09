/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
import data_relationalStore from '@ohos.data.relationalStore'
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const TAG = "[RELATIONAL_STORE_JSKITS_TEST]"
const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function rdbrootDirTest() {
  describe('rdbrootDirTest', () => {
    beforeAll(async () => {
      await sleep(3000);
      console.log(TAG + "*************Unit Test Start*************");
      console.info(TAG + 'beforeAll');
    });

    beforeEach(async () => {
      console.info(TAG + 'beforeEach');
    });

    afterEach(async () => {
      await sleep(300);
      console.info(TAG + 'afterEach');
    });

    afterAll(async () => {
      await sleep(3000);
      console.info(TAG + 'afterAll');
      console.log(TAG + "*************Unit Test End*************");
    });

    /**
     * @tc.name invalid rootDir path promise test
     * @tc.number SUB_DistributedData_RelationalStore_SDK_rootDirJsAPITest_0100
     * @tc.desc invalid rootDir path promise test
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 3
     */
    it('rdbrootDirTest0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      console.log(TAG + "************* rdbrootDirTest0100 start *************");
      const STORE_CONFIG: data_relationalStore.StoreConfig = {
        name: "rootDirTest.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
      }
      await data_relationalStore.getRdbStore(context, STORE_CONFIG)
      const STORE_CONFIG1: data_relationalStore.StoreConfig = {
        name: "rootDirTest.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
        customDir: "rdb",
        rootDir: "invalidPath"
      }
      try {
        await data_relationalStore.getRdbStore(context, STORE_CONFIG1);
        expect().assertFail();
        done()
      } catch (err) {
        await data_relationalStore.deleteRdbStore(context, "rootDirTest.db");
        console.log(TAG + "delete rdbstore success");
        expect(err.code).assertEqual("14800010");
        console.log(TAG + "failed, error code: " + err.code, "err message:" + err.message);
        done();
      }
      console.log(TAG + "************* rdbrootDirTest0100 end *************");
    })

    /**
     * @tc.name invalid rootDir path callback test
     * @tc.number SUB_DistributedData_RelationalStore_SDK_rootDirJsAPITest_0200
     * @tc.desc invalid rootDir path callback test
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 3
     */
    it('rdbrootDirTest0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      console.log(TAG + "************* rdbrootDirTest0200 start *************");
      const STORE_CONFIG: data_relationalStore.StoreConfig = {
        name: "rootDirTest.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
      }
      await data_relationalStore.getRdbStore(context, STORE_CONFIG)
      const STORE_CONFIG1: data_relationalStore.StoreConfig = {
        name: "rootDirTest.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
        customDir: "rdb",
        rootDir: "invalidPath"
      }
      try {
        data_relationalStore.getRdbStore(context, STORE_CONFIG1, async (err, rdbStore) => {
          expect().assertFail();
          done()
        })
      } catch (err) {
        await data_relationalStore.deleteRdbStore(context, "rootDirTest.db");
        console.log(TAG + "delete rdbstore success");
        expect(err.code).assertEqual("14800010");
        console.log(TAG + "failed, error code: " + err.code, "err message:" + err.message);
        done();
      }
      ;
      console.log(TAG + "************* rdbrootDirTest0200 end *************");
    })

    /**
     * @tc.name db not exist promise test
     * @tc.number SUB_DistributedData_RelationalStore_SDK_rootDirJsAPITest_0300
     * @tc.desc db not exist promise test
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 3
     */
    it('rdbrootDirTest0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      console.log(TAG + "************* rdbrootDirTest0300 start *************");
      const STORE_CONFIG: data_relationalStore.StoreConfig = {
        name: "rootDirTest.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
      }
      await data_relationalStore.getRdbStore(context, STORE_CONFIG)
      const STORE_CONFIG1: data_relationalStore.StoreConfig = {
        name: "rootDirTest1.db",
        securityLevel: data_relationalStore.SecurityLevel.S3,
        rootDir: "/data/storage/el2/database",
        customDir: "relationalstore/rdb"
      }
      try {
        await data_relationalStore.getRdbStore(context, STORE_CONFIG1);
        expect().assertFail();
        done()
      } catch (err) {
        await data_relationalStore.deleteRdbStore(context, "rootDirTest.db");
        console.log(TAG + "delete rdbstore success");
        expect(err.code).assertEqual("14800010");
        console.log(TAG + "failed, error code: " + err.code, "err message:" + err.message);
        done();
      }
      console.log(TAG + "************* rdbrootDirTest0300 end *************");
    })
  })
}