/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from "@ohos/hypium";
import relationalStore from "@ohos.data.relationalStore";
import { ValuesBucket } from '@ohos.data.ValuesBucket';
import { BusinessError } from '@ohos.base';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const TAG = "[RDB_JSKITS_TEST]";
const CREATE_TABLE_TEST = "CREATE TABLE IF NOT EXISTS test (" + "id INTEGER PRIMARY KEY AUTOINCREMENT, " + "name TEXT UNIQUE, " + "age INTEGER, " + "salary REAL, " + "blobType BLOB)";
const STORE_CONFIG: relationalStore.StoreConfig = {
  name: "Query.db",
  securityLevel: relationalStore.SecurityLevel.S1,
};

let rdbStore: relationalStore.RdbStore | null = null;

async function createTest1() {
  console.info(TAG + "createTest start");
  {
    const valueBucket: ValuesBucket = {
      name: "zhangsan",
      age: 18,
      salary: 100.5,
      blobType: new Uint8Array([1, 2, 3]),
    };
    await (rdbStore as relationalStore.RdbStore).insert("test", valueBucket);
  }
}

async function createTest2() {
  console.info(TAG + "createTest start");
  {
    const valueBucket: ValuesBucket = {
      name: "lisi",
      age: 28,
      salary: 200.5,
      blobType: new Uint8Array([1, 2, 3]),
    };
    await (rdbStore as relationalStore.RdbStore).insert("test", valueBucket);
  }
}

async function createTest3() {
  console.info(TAG + "createTest start");
  {
    const valueBucket: ValuesBucket = {
      name: "lisi2",
      age: 28,
      salary: 200.5,
      blobType: new Uint8Array([1, 2, 3]),
    };
    await (rdbStore as relationalStore.RdbStore).insert("test", valueBucket);
  }
}

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function rdbStoreQueryTest() {
  describe("rdbStoreQueryTest", () => {
    beforeAll(async () => {
      console.info(TAG + "beforeAll");
      console.info(TAG + 'Get context successful. context=' + context);
    });

    beforeEach(async () => {
      await sleep(300);
      console.info(TAG + "beforeEach");
      rdbStore = await relationalStore.getRdbStore(context, STORE_CONFIG);
      await (rdbStore as relationalStore.RdbStore).executeSql(CREATE_TABLE_TEST, null);
      await createTest1();
      await createTest2();
      await createTest3();
    });

    afterEach(async () => {
      console.info(TAG + "afterEach");
      rdbStore = null;
      await relationalStore.deleteRdbStore(context, "Query.db");
    });

    afterAll(async () => {
      console.info(TAG + "afterAll");
    });

    console.info(TAG + "*************Unit Test Begin*************");

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0930
     * @tc.name   : testRdbStoreQuery001
     * @tc.desc   : RdbStore query callback test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreQuery001", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreQuery001 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      (rdbStore as relationalStore.RdbStore).query(predicates, async (err, resultSet) => {
        if (err) {
          console.error(`Query failed, code is ${err.code},message is ${err.message}`);
          expect(!err).assertTrue();
        }
        console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
        expect(3).assertEqual(resultSet.rowCount);
        resultSet.close();
        done();
      });
      console.info(TAG + "************* testRdbStoreQuery001 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0950
     * @tc.name   : testRdbStoreQuery002
     * @tc.desc   : RdbStore query callback test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreQuery002", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreQuery002 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("age", 18);
      (rdbStore as relationalStore.RdbStore).query(predicates, ["salary"], async (err, resultSet) => {
        if (err) {
          console.error(`Query failed, code is ${err.code},message is ${err.message}`);
          expect(!err).assertTrue();
        }
        console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
        expect(true).assertEqual(resultSet.goToFirstRow());
        const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"));
        expect(100.5).assertEqual(salary);
        resultSet.close();
        done();
      });
      console.info(TAG + "************* testRdbStoreQuery002 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0940
     * @tc.name   : testRdbStoreQuery003
     * @tc.desc   : RdbStore query promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreQuery003", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreQuery003 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      let promise = (rdbStore as relationalStore.RdbStore).query(predicates);
      promise.then((resultSet) => {
        console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
        expect(3).assertEqual(resultSet.rowCount);
        resultSet.close();
        done();
      });
      console.info(TAG + "************* testRdbStoreQuery003 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0960
     * @tc.name   : testRdbStoreQuery004
     * @tc.desc   : RdbStore query promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreQuery004", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreQuery004 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("age", 18);
      let promise = (rdbStore as relationalStore.RdbStore).query(predicates, ["salary"]);
      promise.then((resultSet) => {
        console.info(`ResultSet column names: ${resultSet.columnNames}, column count: ${resultSet.columnCount}`);
        expect(true).assertEqual(resultSet.goToFirstRow());
        const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"));
        expect(100.5).assertEqual(salary);
        resultSet.close();
        done();
      });
      console.info(TAG + "************* testRdbStoreQuery004 end *************");
    });

  });
}
