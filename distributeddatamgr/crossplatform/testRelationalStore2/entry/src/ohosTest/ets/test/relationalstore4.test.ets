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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size,TestType } from '@ohos/hypium'
import relationalStore from '@ohos.data.relationalStore';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();

const TAG = "[RelationalStore_JSKITS_TEST]";
const CREATE_TABLE_EMPLOYEE = "CREATE TABLE IF NOT EXISTS employee (" + "id INTEGER PRIMARY KEY AUTOINCREMENT, " + "name TEXT NOT NULL, " + "age INTEGER)";

const STORE_CONFIG : relationalStore.StoreConfig= {
  name: "rdbStore.db",
  securityLevel: relationalStore.SecurityLevel.S1,
}

let rdbStore:relationalStore.RdbStore;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function relationalStoreErrorCode47Test() {
  describe('relationalStoreErrorCode47Test', ()=> {
    beforeAll(async ()=> {
      await sleep(3000);
      console.info(TAG + "*************Unit Test Begin*************");
      console.info(TAG + 'beforeAll');
    })

    beforeEach(async ()=> {
      await sleep(300);
      console.info(TAG + 'beforeEach');
      rdbStore = await relationalStore.getRdbStore(context, STORE_CONFIG);
      console.info(TAG + "create rdb store success")
      await rdbStore.executeSql(CREATE_TABLE_EMPLOYEE, null);
    })

    afterEach(async ()=> {
      await sleep(300);
      console.info(TAG + 'afterEach');
      await relationalStore.deleteRdbStore(context,"rdbStore.db");
    })

    afterAll(async ()=> {
      console.info(TAG + 'afterAll');
      await sleep(3000);
      console.info(TAG + "*************Unit Test end*************");
    })



    /**
     * @tc.name transaction.insert errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_3500
     * @tc.desc transaction.insert errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.info(TAG + "************* errcode036 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insert("employee", record,relationalStore.ConflictResolution.ON_CONFLICT_REPLACE);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue();
        resultSet.close();
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue();
      }
      console.info(TAG + "************* errcode036 end *************");
    })

    /**
     * @tc.name transaction.insertSync errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_3500
     * @tc.desc transaction.insertSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.info(TAG + "************* errcode037 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insertSync("employee", record,relationalStore.ConflictResolution.ON_CONFLICT_REPLACE);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue();
        resultSet.close();
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue();
      }
      console.info(TAG + "************* errcode037 end *************");
    })

    /**
     * @tc.name transaction.batchInsert errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_3500
     * @tc.desc transaction.batchInsert errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode038 start *************");
      const record1:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record2:relationalStore.ValuesBucket = {
        "name": "Jim1",
        "age": 30,
      };
      let valuebackets = new Array(record1, record2);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.batchInsert("employee", valuebackets);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 2).assertTrue();
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue();
        done()
      }
      console.info(TAG + "************* errcode038 end *************");
    })

    /**
     * @tc.name transaction.batchInsertSync errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_3500
     * @tc.desc transaction.batchInsertSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode039 start *************");
      const record1:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record2:relationalStore.ValuesBucket = {
        "name": "Jim1",
        "age": 30,
      };
      let valuebackets = new Array(record1, record2);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.batchInsertSync("employee", valuebackets);
        await transaction.commit();
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 2).assertTrue();
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue();
        done()
      }
      console.info(TAG + "************* errcode039 end *************");
    })

    /**
     * @tc.name transaction.update errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1700
     * @tc.desc transaction.update errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode043 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record1:relationalStore.ValuesBucket = {
        "name": "zhangsan",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows = await transaction.update(record1,predicates,relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        console.log(TAG+"rows"+rows);
        expect(rows == 1).assertTrue()
        transaction.commit();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode043 end *************");
    })

    /**
     * @tc.name transaction.updateSync errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1700
     * @tc.desc transaction.updateSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode044 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      const record1:relationalStore.ValuesBucket = {
        "name": "zhangsan",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows = await transaction.updateSync(record1,predicates,relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        console.log(TAG+"rows"+rows);
        expect(rows == 1).assertTrue()
        await transaction.commit();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode044 end *************");
    })
  /**
     * @tc.name delete errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1900
     * @tc.desc delete errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode045 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows = await transaction.delete(predicates)
        console.log(TAG+"rows"+rows);
        expect(rows == 1).assertTrue()
        await transaction.commit()
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode045 end *************");
    })
    /**
     * @tc.name transaction.delete errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_1900
     * @tc.desc transaction.delete errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode046 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let rows = await transaction.deleteSync(predicates)
        console.log(TAG+"rows"+rows);
        expect(rows == 1).assertTrue()
        await transaction.commit()
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode046 end *************");
    })

        /**
     * @tc.name transaction.query errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_2700
     * @tc.desc transaction.query errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode042 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        await transaction.insertSync("employee", record,relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = await transaction.query(predicates,["name","age"]);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue()
        await transaction.commit();
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
      }
      console.info(TAG + "************* errcode042end *************");
    })


    /**
     * @tc.name transaction.querySync rrcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_3100
     * @tc.desc transaction.querySync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode031 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insert("employee", record,relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        let predicates = new relationalStore.RdbPredicates("employee");
        predicates.equalTo("age", 30);
        let resultSet = transaction.querySync(predicates,["name","age"]);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue();
        await transaction.commit();
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode031 end *************");
    })


    /**
     * @tc.name transaction.querySql errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_3200
     * @tc.desc transaction.querySql errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode032 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        let resultSet = await transaction.querySql("SELECT * FROM employee WHERE age = ?",["30"]);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue()
        transaction.commit()
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode032 end *************");
    })

        /**
     * @tc.name transaction.querySqlSync errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_3300
     * @tc.desc transaction.querySqlSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode033 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.insertSync("employee", record,relationalStore.ConflictResolution.ON_CONFLICT_REPLACE)
        let resultSet = await transaction.querySqlSync("SELECT * FROM employee WHERE age = ?",["30"]);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 1).assertTrue()
        await transaction.commit();
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode033 end *************");
    })

    /**
     * @tc.name transaction.execute errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_2700
     * @tc.desc transaction.execute errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode041 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction();
        await  transaction.execute("DELETE FROM EMPLOYEE WHERE age = ?",["30"]);
        await  transaction.commit();
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 0).assertTrue()
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode041 end *************");
    })

    /**
     * @tc.name transaction.executeSync errcode is 14800047
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_2600
     * @tc.desc transaction.executeSync errcode is 14800047
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode040 start *************");
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
      };
      await (rdbStore as relationalStore.RdbStore).insert("employee", record)
      let predicates = new relationalStore.RdbPredicates("employee");
      predicates.equalTo("age", 30);
      try{
        let transaction:relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.executeSync("DELETE FROM EMPLOYEE WHERE age = ?",["30"])
        await transaction.commit()
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG+"resultSet.rowCount"+ resultSet.rowCount);
        expect(resultSet.rowCount == 0).assertTrue()
        resultSet.close();
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800047).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode040 end *************");
    })

    /**
     * @tc.name errcode is 14800013
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0600
     * @tc.desc errcode is 14800013
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      console.info(TAG + "************* errcode006 start *************");
      const CREATE_TABLE_TEST1 = "CREATE TABLE IF NOT EXISTS test1 (" + "id INTEGER PRIMARY KEY, " +
        "name TEXT NOT NULL, " + "age INTEGER, "  + "blobType BLOB)";
      await rdbStore.executeSync(CREATE_TABLE_TEST1, null);
      let u8 = new Uint8Array([1,2,3]);
      const record:relationalStore.ValuesBucket = {
        "name": "Jim",
        "age": 30,
        "blobType":u8,
      };
      await (rdbStore as relationalStore.RdbStore).insert("test1", record)
      let predicates = new relationalStore.RdbPredicates("test1");
      predicates.equalTo("age", 30);

      try{
        let resultSet =  await (rdbStore as relationalStore.RdbStore).query(predicates);
        console.log(TAG+"resultSet.rowCount"+resultSet.rowCount);
        resultSet.goToFirstRow();
        resultSet.getRow();
        expect(resultSet.rowCount == 1).assertTrue();
        resultSet.close()
        done()
      }catch(err){
        console.log(TAG+"err.code"+err.code + "err.message"+err.message)
        expect(err.code == 14800013).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode006 end *************");
    })
  })
}
