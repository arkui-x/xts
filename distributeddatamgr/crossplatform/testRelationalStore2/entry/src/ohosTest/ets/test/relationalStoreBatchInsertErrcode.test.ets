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
import { relationalStore } from '@kit.ArkData';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'

const TAG = "[ttt]"
const STORE_CONFIG: relationalStore.StoreConfig = {
  name: "RdbTest.db",
  securityLevel: relationalStore.SecurityLevel.S1
};

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();

const CREATE_TABLE_TEST =
  "CREATE TABLE IF NOT EXISTS test  (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL, age INTEGER, salary REAL, blobType BLOB)";

let rdbStore: relationalStore.RdbStore | undefined | null;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function relationalStoreBatchInsertErrcodeTest() {
  describe('relationalStoreBatchInsertErrcodeTest', () => {
    beforeAll(async () => {
      await sleep(3000);
      console.info(TAG + 'beforeAll')
    })

    beforeEach(async () => {
      console.info(TAG + 'beforeEach');
      rdbStore = await relationalStore.getRdbStore(context, STORE_CONFIG);
      (rdbStore as relationalStore.RdbStore).executeSql(CREATE_TABLE_TEST);
    })
    afterEach(async () => {
      await sleep(300);
      console.info(TAG + 'afterEach')
      rdbStore = null;
      await relationalStore.deleteRdbStore(context, "RdbTest.db");
    })
    afterAll(async () => {
      await sleep(3000);
      console.info(TAG + 'afterAll')
    })

    /**
     * @tc.name testRdbStoreBatchInsertWithConflictResolutionErrcode0100
     * @tc.number SUB_DistributedData_RelationalStore_SDK_BatchInsertWithConflictResolutionEtsAPI16Test_0100
     * @tc.desc rdbstore.batchInsertWithConflictResolution errcode is 14800014
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testRdbStoreBatchInsertWithConflictResolutionErrcode0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbStoreBatchInsertWithConflictResolutionErrcode0100 start *************");
        let u8 = new Uint8Array([1, 2, 3])
        const valueBucket: relationalStore.ValuesBucket = {
          "name": "zhangsan",
          "age": 18,
          "salary": 100.5,
          "blobType": u8,
        }
        let valueBucketArray: relationalStore.ValuesBucket[] = new Array();
        for (let i = 0; i < 2; i++) {
          valueBucketArray.push(valueBucket);
        }
        await (rdbStore as relationalStore.RdbStore).close();
        try {
          await (rdbStore as relationalStore.RdbStore).batchInsertWithConflictResolution("test", valueBucketArray,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE);
          expect(null).assertFail()
          done();
        } catch (err) {
          console.log(TAG + err + "batchInsertWithConflictResolution failed" + err.code);
          expect(err.code == 14800014).assertTrue()
          done();
        }
        console.log(TAG + "************* testRdbStoreBatchInsertWithConflictResolutionErrcode0100 end *************");
      })

    /**
     * @tc.name testRdbStoreBatchInsertWithConflictResolutionSyncErrcode0200
     * @tc.number SUB_DistributedData_RelationalStore_SDK_BatchInsertWithConflictResolutionEtsAPI16Test_0200
     * @tc.desc rdbstore.batchInsertWithConflictResolutionSync errcode is 14800014
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testRdbStoreBatchInsertWithConflictResolutionSyncErrcode0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        console.log(TAG +
          "************* testRdbStoreBatchInsertWithConflictResolutionSyncErrcode0200 start *************");
        let u8 = new Uint8Array([1, 2, 3])
        const valueBucket: relationalStore.ValuesBucket = {
          "name": "zhangsan",
          "age": 18,
          "salary": 100.5,
          "blobType": u8,
        }
        let valueBucketArray: relationalStore.ValuesBucket[] = new Array();
        for (let i = 0; i < 2; i++) {
          valueBucketArray.push(valueBucket);
        }
        await (rdbStore as relationalStore.RdbStore).close();
        try {
          await (rdbStore as relationalStore.RdbStore).batchInsertWithConflictResolutionSync("test", valueBucketArray,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE);
          expect(null).assertFail()
          done();
        } catch (err) {
          console.log(TAG + err + "batchInsertWithConflictResolutionSync failed" + err.code);
          expect(err.code == 14800014).assertTrue()
          done();
        }
        console.log(TAG +
          "************* testRdbStoreBatchInsertWithConflictResolutionSyncErrcode0200 end *************");
      })
  })
}