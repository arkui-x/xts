/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from "@ohos/hypium";
import relationalStore from '@ohos.data.relationalStore';
import { ValuesBucket } from '@ohos.data.ValuesBucket';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

let rdbStore: relationalStore.RdbStore | undefined;
const STORE_NAME = "statistics.db"
const CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS test (" +
  "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
  "name TEXT NOT NULL, " + "age INTEGER, " + "salary REAL, " + "blobType BLOB)";
const config: relationalStore.StoreConfig = {
  'name': STORE_NAME,
  securityLevel: relationalStore.SecurityLevel.S1,
};
const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function SqlExecutionTimeTest() {
  describe('SqlExecutionTimeTest', () => {
    let TAG = "ttt ";
    beforeAll(async () => {
      await sleep(3000);
      console.info(TAG + 'beforeAll');
      rdbStore = await relationalStore.getRdbStore(context, config);
    })

    beforeEach(async () => {
      await sleep(300);
      console.info(TAG + 'beforeEach');
      if (rdbStore == undefined) {
        return;
      }

      await rdbStore.executeSql(CREATE_TABLE_SQL);
      try {
        const valueBucket1: ValuesBucket = {
          'name': 'zhangSan',
          'age': 18,
          'salary': 25000,
          'blobType': new Uint8Array([1, 2, 3]),
        };
        let rowId = await rdbStore.insert('test', valueBucket1);
        expect(1).assertEqual(rowId);
      } catch (err) {
        console.error(TAG + `failed, code:${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
    })

    afterEach(async () => {
      await sleep(300);
      console.info(TAG + 'afterEach');
      if (rdbStore == undefined) {
        return;
      }
      try {
        rdbStore.off('statistics');
      } catch (err) {
        console.error(TAG + `unRegister fail3, code:${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      await rdbStore.executeSql("drop table test");
    })

    afterAll(async () => {
      rdbStore = undefined;
      await relationalStore.deleteRdbStore(context, STORE_NAME);
      console.info(TAG + 'afterAll');
      await sleep(3000);
    })


    /**
     * @tc.name testRdbStoreStatistics0001
     * @tc.number SUB_DistributedData_RelationalStore_SDK_SqlExeInfoJsAPITest_0110
     * @tc.desc 1. Register callback for statistics
     *          2. Insert data
     *          3. UnRegister callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testRdbStoreStatistics0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreStatistics0001 start *************");
      if (rdbStore == undefined) {
        return;
      }
      try {
        rdbStore.on('statistics', (SqlExeInfo: relationalStore.SqlExecutionInfo) => {
          console.info(TAG + "totalTime is : " + SqlExeInfo.totalTime);
          console.info(TAG + "prepareTime is : " + SqlExeInfo.prepareTime);
          console.info(TAG + "waitTime is : " + SqlExeInfo.waitTime);
          console.info(TAG + "executeTime is : " + SqlExeInfo.executeTime);
          expect('INSERT INTO test(age,blobType,name,salary) VALUES (?,?,?,?)').assertEqual(SqlExeInfo.sql[0]);
          done();
        });
      } catch (err) {
        console.error(TAG + `on statistics fail, code:${err.code}, message: ${err.message}`);
        expect().assertFail();
        done();
      }

      try {
        const valueBucket1: ValuesBucket = {
          'name': 'LiSi',
          'age': 18,
          'salary': 25000,
          'blobType': new Uint8Array([1, 2, 3]),
        };
        let rowId = await rdbStore.insert('test', valueBucket1);
        console.log(TAG + "rowId = " + rowId);
        expect(2).assertEqual(rowId);
      } catch (error) {
        console.error(TAG + `insert fail, code:${error.code}, message: ${error.message}`);
        expect().assertFail();
        done();
      }
      console.info(TAG + "************* testRdbStoreStatistics0001 end *************");
    })


    /**
     * @tc.name testRdbStoreStatistics0003
     * @tc.number SUB_DistributedData_RelationalStore_SDK_SqlExeInfoJsAPITest_0130
     * @tc.desc 1. Register callback for statistics
     *          2. update data
     *          3. UnRegister callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testRdbStoreStatistics0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreStatistics0003 start *************");
      if (rdbStore == undefined) {
        return;
      }
      try {
        rdbStore.on('statistics', (SqlExeInfo) => {
          console.info(TAG + "totalTime is : " + SqlExeInfo.totalTime);
          console.info(TAG + "prepareTime is : " + SqlExeInfo.prepareTime);
          console.info(TAG + "waitTime is : " + SqlExeInfo.waitTime);
          console.info(TAG + "executeTime is : " + SqlExeInfo.executeTime);
          expect('UPDATE test SET age=?,blobType=?,name=?,salary=? WHERE id = ? ').assertEqual(SqlExeInfo.sql[0]);
          done();
        });
      } catch (err) {
        console.error(TAG + `on statistics fail, code:${err.code}, message: ${err.message}`);
        expect().assertFail();
        done();
      }
      try {
        const valueBucket1: ValuesBucket = {
          'name': 'wangWu',
          'age': 18,
          'salary': 25000,
          'blobType': new Uint8Array([1, 2, 3]),
        };
        let predicates = new relationalStore.RdbPredicates('test');
        predicates.equalTo('id', 1);
        let rowId = await rdbStore.update(valueBucket1, predicates);
        expect(1).assertEqual(rowId);
      } catch (error) {
        console.error(TAG + `update fail, code:${error.code}, message: ${error.message}`);
        expect().assertFail();
        done();
      }
      console.info(TAG + "************* testRdbStoreStatistics0003 end *************");
    })


    /**
     * @tc.name testRdbStoreStatistics0005
     * @tc.number SUB_DistributedData_RelationalStore_SDK_SqlExeInfoJsAPITest_0150
     * @tc.desc 1. Register callback for statistics
     *          2. query data
     *          3. UnRegister callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testRdbStoreStatistics0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreStatistics0005 start *************");
      if (rdbStore == undefined) {
        return;
      }
      try {
        rdbStore.on('statistics', (SqlExeInfo) => {
          console.info(TAG + "totalTime is : " + SqlExeInfo.totalTime);
          console.info(TAG + "prepareTime is : " + SqlExeInfo.prepareTime);
          console.info(TAG + "waitTime is : " + SqlExeInfo.waitTime);
          console.info(TAG + "executeTime is : " + SqlExeInfo.executeTime);
          expect('SELECT * FROM test').assertEqual(SqlExeInfo.sql[0]);
          done();
        });
      } catch (err) {
        console.error(TAG + `on statistics fail, code:${err.code}, message: ${err.message}`);
        expect().assertFail();
        done();
      }
      try {
        let predicates = new relationalStore.RdbPredicates('test');
        let result: relationalStore.ResultSet = await rdbStore.query(predicates);
        expect(1).assertEqual(result.rowCount);
      } catch (error) {
        console.error(TAG + `query fail, code:${error.code}, message: ${error.message}`);
        expect().assertFail();
        done();
      }
      console.info(TAG + "************* testRdbStoreStatistics0005 end *************");
    })


    /**
     * @tc.name testRdbStoreStatistics0007
     * @tc.number SUB_DistributedData_RelationalStore_SDK_SqlExeInfoJsAPITest_0170
     * @tc.desc 1. Register callback for statistics
     *          2. delete data
     *          3. UnRegister callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testRdbStoreStatistics0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreStatistics0007 start *************");
      if (rdbStore == undefined) {
        return;
      }
      try {
        rdbStore.on('statistics', (SqlExeInfo) => {
          console.info(TAG + "totalTime is : " + SqlExeInfo.totalTime);
          console.info(TAG + "prepareTime is : " + SqlExeInfo.prepareTime);
          console.info(TAG + "waitTime is : " + SqlExeInfo.waitTime);
          console.info(TAG + "executeTime is : " + SqlExeInfo.executeTime);
          expect('DELETE FROM test').assertEqual(SqlExeInfo.sql[0]);
          done();
        });
      } catch (err) {
        console.error(TAG + `on statistics fail, code:${err.code}, message: ${err.message}`);
        expect().assertFail();
        done();
      }
      try {
        let predicates = new relationalStore.RdbPredicates('test');
        let rowId = await rdbStore.delete(predicates);
        expect(1).assertEqual(rowId);
      } catch (error) {
        console.error(TAG + `delete fail, code:${error.code}, message: ${error.message}`);
        expect().assertFail();
        done();
      }
      console.info(TAG + "************* testRdbStoreStatistics0007 end *************");
    })


    /**
     * @tc.name testRdbStoreStatistics0010
     * @tc.number SUB_DistributedData_RelationalStore_SDK_SqlExeInfoJsAPITest_0200
     * @tc.desc 1. Register callback for statistics
     *          2. querySql data
     *          3. UnRegister callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testRdbStoreStatistics0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreStatistics0010 start *************");
      if (rdbStore == undefined) {
        return;
      }
      try {
        rdbStore.on('statistics', (SqlExeInfo) => {
          console.info(TAG + "totalTime is : " + SqlExeInfo.totalTime);
          console.info(TAG + "prepareTime is : " + SqlExeInfo.prepareTime);
          console.info(TAG + "waitTime is : " + SqlExeInfo.waitTime);
          console.info(TAG + "executeTime is : " + SqlExeInfo.executeTime);
          expect('select * from test').assertEqual(SqlExeInfo.sql[0]);
          done();
        })
      } catch (err) {
        console.error(TAG + `on statistics fail, code:${err.code}, message: ${err.message}`);
        expect().assertFail();
        done();
      }

      await rdbStore.querySql("select * from test");
      console.info(TAG + "************* testRdbStoreStatistics0010 end *************");
    })
  })
}
