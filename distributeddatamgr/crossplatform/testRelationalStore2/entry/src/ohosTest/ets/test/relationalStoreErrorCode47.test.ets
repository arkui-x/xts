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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium'
import relationalStore from '@ohos.data.relationalStore';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const TAG = "[RelationalStore_JSKITS_TEST]";
const CREATE_TABLE_EMPLOYEE =
  "CREATE TABLE IF NOT EXISTS employee (" + "id INTEGER PRIMARY KEY AUTOINCREMENT, " + "name TEXT NOT NULL, " +
    "age INTEGER)";

const STORE_CONFIG: relationalStore.StoreConfig = {
  name: "rdbStore.db",
  securityLevel: relationalStore.SecurityLevel.S1,
}

let rdbStore: relationalStore.RdbStore;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function relationalStoreErrorCode47Test() {
  describe('relationalStoreErrorCode47Test', () => {
    beforeAll(async () => {
      await sleep(3000);
      console.info(TAG + "*************Unit Test Begin*************");
      console.info(TAG + 'beforeAll');
    })

    beforeEach(async () => {
      await sleep(300);
      console.info(TAG + 'beforeEach');
      rdbStore = await relationalStore.getRdbStore(context, STORE_CONFIG);
      console.info(TAG + "create rdb store success")
      await rdbStore.executeSql(CREATE_TABLE_EMPLOYEE, null);
    })

    afterEach(async () => {
      await sleep(300);
      console.info(TAG + 'afterEach');
      await relationalStore.deleteRdbStore(context, "rdbStore.db");
    })

    afterAll(async () => {
      console.info(TAG + 'afterAll');
      await sleep(3000);
      console.info(TAG + "*************Unit Test end*************");
    })

    /**
     * @tc.name errcode001
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0100
     * @tc.desc transaction.insert errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.info(TAG + "************* errcode001 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insert("employee", record, relationalStore.ConflictResolution.ON_CONFLICT_REPLACE);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue();
        resultSet.close();
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue();
      }
      console.info(TAG + "************* errcode001 end *************");
    })

    /**
     * @tc.name errcode002
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0200
     * @tc.desc transaction.insertSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.info(TAG + "************* errcode002 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insertSync("employee", record, relationalStore.ConflictResolution.ON_CONFLICT_REPLACE);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue();
        resultSet.close();
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue();
      }
      console.info(TAG + "************* errcode002 end *************");
    })

    /**
     * @tc.name errcode003
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0300
     * @tc.desc transaction.batchInsert errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode003 start *************");
      const record1: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record2: relationalStore.ValuesBucket = {
        "name": "Jim1",
        "age": 30,
      };
      let valuebackets = new Array(record1, record2);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.batchInsert("employee", valuebackets);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 2).assertTrue();
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue();
        done()
      }
      console.info(TAG + "************* errcode003 end *************");
    })

    /**
     * @tc.name errcode004
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0400
     * @tc.desc transaction.batchInsertSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode004 start *************");
      const record1: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record2: relationalStore.ValuesBucket = {
        "name": "Jim1",
        "age": 30,
      };
      let valuebackets = new Array(record1, record2);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.batchInsertSync("employee", valuebackets);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 2).assertTrue();
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue();
        done()
      }
      console.info(TAG + "************* errcode004 end *************");
    })

    /**
     * @tc.name errcode005
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0500
     * @tc.desc transaction.update errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode005 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record1: relationalStore.ValuesBucket = {
        "name": "zhangsan",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows = await transaction.update(record1, predicates, relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        console.log(TAG + "rows" + rows);
        expect(rows == 1).assertTrue()
        transaction.commit();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode005 end *************");
    })

    /**
     * @tc.name errcode006
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0600
     * @tc.desc transaction.updateSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode044 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record1: relationalStore.ValuesBucket = {
        "name": "zhangsan",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows =
          await transaction.updateSync(record1, predicates, relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        console.log(TAG + "rows" + rows);
        expect(rows == 1).assertTrue()
        await transaction.commit();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode006 end *************");
    })

    /**
     * @tc.name errcode007
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0700
     * @tc.desc delete errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode007 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows = await transaction.delete(predicates)
        console.log(TAG + "rows" + rows);
        expect(rows == 1).assertTrue()
        await transaction.commit()
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode007 end *************");
    })

    /**
     * @tc.name errcode008
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0800
     * @tc.desc transaction.delete errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode008 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows = await transaction.deleteSync(predicates)
        console.log(TAG + "rows" + rows);
        expect(rows == 1).assertTrue()
        await transaction.commit()
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode008 end *************");
    })

    /**
     * @tc.name errcode009
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0900
     * @tc.desc transaction.query errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode009 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        await transaction.insertSync("employee", record, relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await transaction.query(predicates, ["name", "age"]);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue()
        await transaction.commit();
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
      }
      console.info(TAG + "************* errcode009end *************");
    })

    /**
     * @tc.name errcode010
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1000
     * @tc.desc transaction.querySync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode010 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insert("employee", record, relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = transaction.querySync(predicates, ["name", "age"]);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue();
        await transaction.commit();
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode010 end *************");
    })

    /**
     * @tc.name errcode011
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1100
     * @tc.desc transaction.querySql errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode011 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let resultSet = await transaction.querySql("SELECT * FROM employee WHERE age = ?", ["30"]);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue()
        transaction.commit()
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode011 end *************");
    })

    /**
     * @tc.name errcode012
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1200
     * @tc.desc transaction.querySqlSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode033 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insertSync("employee", record, relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        let resultSet = await transaction.querySqlSync("SELECT * FROM employee WHERE age = ?", ["30"]);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue()
        await transaction.commit();
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode012 end *************");
    })

    /**
     * @tc.name errcode013
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1300
     * @tc.desc transaction.execute errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode013 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        await transaction.execute("DELETE FROM EMPLOYEE WHERE age = ?", ["30"]);
        await transaction.commit();
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 0).assertTrue()
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode013 end *************");
    })

    /**
     * @tc.name errcode014
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1400
     * @tc.desc transaction.executeSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode014 start *************");
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.executeSync("DELETE FROM EMPLOYEE WHERE age = ?", ["30"])
        await transaction.commit()
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        expect(resultSet.rowCount == 0).assertTrue()
        resultSet.close();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode014 end *************");
    })

    /**
     * @tc.name errcode015
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1500
     * @tc.desc errcode is 14800013
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode015 start *************");
      const CREATE_TABLE_TEST1 = "CREATE TABLE IF NOT EXISTS test1 (" + "id INTEGER PRIMARY KEY, " +
        "name TEXT NOT NULL, " + "age INTEGER, " + "blobType BLOB)";
      await rdbStore.executeSync(CREATE_TABLE_TEST1, null);
      let u8 = new Uint8Array([1, 2, 3]);
      const record: relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
        "blobType": u8,
      };
      await (rdbStore as relationalStore.RdbStore).insert("test1", record)
      let predicates = new relationalStore.RdbPredicates("test1");
      predicates.equalTo("age", 30);
      try {
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG + "resultSet.rowCount" + resultSet.rowCount);
        resultSet.goToFirstRow();
        resultSet.getRow();
        expect(resultSet.rowCount == 1).assertTrue();
        resultSet.close()
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 14800013).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode015 end *************");
    })
  })
}
