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

export default function relationalStoreErrorCodeTest() {
  describe('relationalStoreErrorCodeTest', () => {
    beforeAll(async () => {
      console.info(TAG + "*************Unit Test Begin*************");
      console.info(TAG + 'beforeAll');
    })

    beforeEach(async () => {
      console.info(TAG + 'beforeEach');
      rdbStore = await relationalStore.getRdbStore(context, STORE_CONFIG);
      console.info(TAG + "create rdb store success")
      await rdbStore.executeSql(CREATE_TABLE_EMPLOYEE, null);
    })

    afterEach(async () => {
      console.info(TAG + 'afterEach');
      await relationalStore.deleteRdbStore(context, "rdbStore.db");
    })

    afterAll(async () => {
      console.info(TAG + 'afterAll');
      console.info(TAG + "*************Unit Test end*************");
    })

    /**
     * @tc.name transaction.querySql errcode is 401
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0100
     * @tc.desc transaction.querySql errcode is 401
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode001 start *************");
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.querySql(undefined, undefined)
        await transaction.commit();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 401).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode001 end *************");
    })

    /**
     * @tc.name transaction.querySqlSync errcode is 401
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0200
     * @tc.desc transaction.querySqlSync errcode is 401
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode002 start *************");
      try {
        let transaction: relationalStore.Transaction;
        transaction = await (rdbStore as relationalStore.RdbStore).createTransaction()
        await transaction.querySqlSync(undefined, undefined)
        await transaction.commit();
        expect().assertFail();
        done()
      } catch (err) {
        console.log(TAG + "err.code" + err.code + "err.message" + err.message)
        expect(err.code == 401).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode002 end *************");
    })

    /**
     * @tc.name transaction.executeSync errcode is 401
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0300
     * @tc.desc transaction.executeSync errcode is 401
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode003 start *************");
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
        expect(err.code == 401).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode003 end *************");
    })

    /**
     * @tc.name transaction.executeSync errcode is 801
     * @tc.number SUB_DistributedData_RelationalStore_SDK_RDBAPIErrcodeTest_0400
     * @tc.desc transaction.executeSync errcode is 801
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('errcode004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info(TAG + "************* errcode004 start *************");
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
        expect(err.code == 801).assertTrue()
        done()
      }
      console.info(TAG + "************* errcode004 end *************");
    })
  })
}