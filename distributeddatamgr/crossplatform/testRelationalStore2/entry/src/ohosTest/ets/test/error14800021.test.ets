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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium'
import data_relationalStore from '@ohos.data.relationalStore'
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@kit.BasicServicesKit';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();

const CREATE_TABLE_TEST1 = "CREATE TABLE IF NOT EXISTS test1 (" + "id INTEGER PRIMARY KEY, " +
  "name TEXT NOT NULL, " + "age INTEGER, " + "salary REAL, " + "blobType BLOB)";

const STORE_CONFIG1: data_relationalStore.StoreConfig = {
  name: "TransactionTest.db",
  securityLevel: data_relationalStore.SecurityLevel.S1,
}

let rdbStore: data_relationalStore.RdbStore | undefined = undefined;

export default function error14800021Test() {
  describe('error14800021Test', () => {

    /**
     * @tc.name      : testSUBDistributedDataRDBSDKErrorCode14800021_0100
     * @tc.number    : SUB_DistributedData_RDB_SDK_ErrorCode14800021Test_0100
     * @tc.desc      : Verify the properties of the text type
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSUBDistributedDataRDBSDKErrorCode14800021_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        rdbStore = await data_relationalStore.getRdbStore(context, STORE_CONFIG1);
        const SQL_DELETE_TABLE = 'DELETE FROM test1';

        await rdbStore.executeSql(CREATE_TABLE_TEST1, null);
        (rdbStore as data_relationalStore.RdbStore).createTransaction()
          .then((transaction: data_relationalStore.Transaction) => {

            try {
              let data = (transaction as data_relationalStore.Transaction).executeSync(SQL_DELETE_TABLE);
              transaction.commit();
              console.info(`delete result: ${data}`);
            } catch (err) {
              transaction.rollback();
              console.error(`delete failed, code is ${err.code}, message is ${err.message}`);
              expect(err.code).assertEqual(14800021)
            }
            ;
          })
          .catch((err: BusinessError) => {
            console.error(`createTransaction failed, code is ${err.code},message is ${err.message}`);
          })

        await rdbStore.executeSql(CREATE_TABLE_TEST1, null);
        (rdbStore as data_relationalStore.RdbStore).createTransaction()
          .then((transaction: data_relationalStore.Transaction) => {
            try {
              transaction.execute(SQL_DELETE_TABLE).then((data) => {
                transaction.commit();
                console.info(`delete result: ${data}`);
              }).catch((e: BusinessError) => {
                transaction.rollback();
                console.error(`delete failed, code is ${e.code}, message is ${e.message}`);
              });
            } catch (err) {
              transaction.rollback();
              console.error(`delete failed, code is ${err.code}, message is ${err.message}`);
              expect(err.code).assertEqual(14800021)
            }
            ;
          })
          .catch((err: BusinessError) => {
            console.error(`createTransaction failed, code is ${err.code},message is ${err.message}`);
          });

        await rdbStore.executeSql("DROP TABLE IF EXISTS test1", null);
        rdbStore = undefined;
        await data_relationalStore.deleteRdbStore(context, "TransactionTest.db");
        done();
      })
  })
}