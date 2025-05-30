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
  name: "Delete.db",
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

export default function rdbStoreDeleteTest() {
  describe("rdbStoreDeleteTest", () => {
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
      await relationalStore.deleteRdbStore(context, "Delete.db");
    });

    afterAll(async () => {
      console.info(TAG + "afterAll");
    });

    console.info(TAG + "*************Unit Test Begin*************");

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0450
     * @tc.name   : testRdbStoreDelete001
     * @tc.desc   : RdbStore delete callback test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDelete001", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDelete001 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("age", 18);
      let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
      expect(1).assertEqual(resultSet.rowCount);
      resultSet.close();
      (rdbStore as relationalStore.RdbStore).delete(predicates, async (err, rows) => {
        if (err) {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          expect(!err).assertTrue();
        }
        console.info(`Delete rows: ${rows}`);
        expect(1).assertEqual(rows);
        let predicates = new relationalStore.RdbPredicates("test");
        predicates.equalTo("age", 18);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        expect(0).assertEqual(resultSet.rowCount);
        resultSet.close();
        done();
      });
      console.info(TAG + "************* testRdbStoreDelete001 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0440
     * @tc.name   : testRdbStoreDelete002
     * @tc.desc   : RdbStore delete callback test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDelete002", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDelete002 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("aaa id", 1);
      (rdbStore as relationalStore.RdbStore).delete(predicates, async (err, rows) => {
        if (err) {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          expect(err.code === 14800021).assertTrue();
          console.info(TAG + "delete with wrong conditions");
          let predicates = new relationalStore.RdbPredicates("test");
          predicates.equalTo("age", 18);
          let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
          expect(1).assertEqual(resultSet.rowCount);
          resultSet.close();
          done();
          return;
        }
        expect(!err).assertFail();
      });
      console.info(TAG + "************* testRdbStoreDelete002 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0480
     * @tc.name   : testRdbStoreDelete003
     * @tc.desc   : RdbStore delete callback test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDelete003", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDelete003 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("age", 28);
      (rdbStore as relationalStore.RdbStore).delete(predicates, async (err, rows) => {
        if (err) {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          expect(!err).assertTrue();
          done();
        }
        console.info(`Delete rows: ${rows}`);
        expect(2).assertEqual(rows);
        let predicates = new relationalStore.RdbPredicates("test");
        predicates.equalTo("age", 28);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        expect(0).assertEqual(resultSet.rowCount);
        resultSet.close();
        done();
      });
      console.info(TAG + "************* testRdbStoreDelete003 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0460
     * @tc.name   : testRdbStoreDelete004
     * @tc.desc   : RdbStore delete promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDelete004", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDelete004 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("age", 18);
      let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
      expect(1).assertEqual(resultSet.rowCount);
      resultSet.close();
      (rdbStore as relationalStore.RdbStore)
        .delete(predicates)
        .then(async (ret) => {
          expect(1).assertEqual(ret);
          let predicates = new relationalStore.RdbPredicates("test");
          predicates.equalTo("age", 18);
          let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
          expect(0).assertEqual(resultSet.rowCount);
          console.info(TAG + "Delete done: " + ret);
          resultSet.close();
          done();
        })
        .catch((err: BusinessError) => {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          expect(!err).assertTrue();
        });
      console.info(TAG + "************* testRdbStoreDelete004 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0500
     * @tc.name   : testRdbStoreDelete005
     * @tc.desc   : RdbStore delete promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDelete005", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDelete005 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("aaa id", 1);
      (rdbStore as relationalStore.RdbStore)
        .delete(predicates)
        .then(async (ret) => {
          console.info(TAG + "Delete done: " + ret);
          expect(ret !== null).assertFail();
        })
        .catch(async (err: BusinessError) => {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          expect(err.code === 14800021).assertTrue();
          console.info(TAG + "delete with wrong conditions");
          let predicates = new relationalStore.RdbPredicates("test");
          predicates.equalTo("age", 18);
          let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
          expect(1).assertEqual(resultSet.rowCount);
          resultSet.close();
          done();
        });
      console.info(TAG + "************* testRdbStoreDelete005 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0490
     * @tc.name   : testRdbStoreDelete006
     * @tc.desc   : RdbStore delete promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDelete006", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDelete006 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("age", "28");
      (rdbStore as relationalStore.RdbStore)
        .delete(predicates)
        .then(async (ret) => {
          expect(2).assertEqual(ret);
          console.info(TAG + "Delete done: " + ret);
          let predicates = new relationalStore.RdbPredicates("test");
          predicates.equalTo("age", 28);
          let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
          expect(0).assertEqual(resultSet.rowCount);
          resultSet.close();
          done();
        })
        .catch((err: BusinessError) => {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          expect(!err).assertTrue();
        });
      console.info(TAG + "************* testRdbStoreDelete006 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0470
     * @tc.name   : testRdbStoreDelete008
     * @tc.desc   : RdbStore delete callback test: predicate nonexistence
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDelete008", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDelete008 start *************");
      let predicates = new relationalStore.RdbPredicates("test");
      predicates.equalTo("age", 88);
      let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
      expect(0).assertEqual(resultSet.rowCount);
      resultSet.close();
      (rdbStore as relationalStore.RdbStore).delete(predicates, async (err, rows) => {
        if (err) {
          console.error(`Delete failed, code is ${err.code},message is ${err.message}`);
          expect(!err).assertTrue();
        }
        console.info(`Delete rows: ${rows}`);
        expect(0).assertEqual(rows);
        let predicates = new relationalStore.RdbPredicates("test");
        predicates.equalTo("age", 18);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        expect(0).assertEqual(resultSet.rowCount);
        resultSet.close();
      });
      done();
      console.info(TAG + "************* testRdbStoreDelete008 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0510
     * @tc.name   : testRdbStoreDeleteError001
     * @tc.desc   : RdbStore delete callback test: undefined
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDeleteError001", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDeleteError001 start *************");
      try {
        (rdbStore as relationalStore.RdbStore).delete(undefined, async (err, rows) => {
          console.info(`testRdbStoreDeleteError001 Delete failed`);
          expect(err).assertFail();
          done();
        });
      } catch (err) {
        console.info(TAG + "testRdbStoreDeleteError001 catch error: " + err);
        expect(err.code).assertEqual('401');
        let predicates = new relationalStore.RdbPredicates("test");
        predicates.equalTo("age", 18);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        expect(1).assertEqual(resultSet.rowCount);
        resultSet.close();
        done();
      }
      console.info(TAG + "************* testRdbStoreDeleteError001 end *************");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_RelationStore_RdbStoreJsAPITest_0520
     * @tc.name   : testRdbStoreDeleteError005
     * @tc.desc   : RdbStore delete promise test: undefined
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testRdbStoreDeleteError005", 0, async (done: Function) => {
      console.info(TAG + "************* testRdbStoreDeleteError005 start *************");
      try {
        (rdbStore as relationalStore.RdbStore)
          .delete(undefined)
          .then(async (ret) => {
            console.info(TAG + "Delete done: " + ret);
            expect().assertFail();
          })
          .catch(async (err: BusinessError) => {
            console.error('testRdbStoreDeleteError005');
            done();
          });
      } catch (err) {
        console.info(TAG + "testRdbStoreDeleteError005 catch error: " + err);
        expect(err.code).assertEqual('401');
        let predicates = new relationalStore.RdbPredicates("test");
        predicates.equalTo("age", 18);
        let resultSet = await (rdbStore as relationalStore.RdbStore).query(predicates);
        expect(1).assertEqual(resultSet.rowCount);
        resultSet.close();
        done();
      }
      console.info(TAG + "************* testRdbStoreDeleteError005 end *************");
    });
  });
}
