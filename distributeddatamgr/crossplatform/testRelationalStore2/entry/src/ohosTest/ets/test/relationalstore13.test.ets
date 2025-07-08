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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level} from '@ohos/hypium'
import data_relationalStore from '@ohos.data.relationalStore'
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@kit.BasicServicesKit';
import { sendableRelationalStore } from '@kit.ArkData';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context =  delegator.getAppContext().getApplicationContext();

const CREATE_TABLE_TEST1 = "CREATE TABLE IF NOT EXISTS test1 (" + "id INTEGER PRIMARY KEY, " +
  "name TEXT NOT NULL, " + "age INTEGER, " + "salary REAL, " + "blobType BLOB)";

const STORE_CONFIG1:data_relationalStore.StoreConfig = {
  name: "TransactionTest.db",
  securityLevel: data_relationalStore.SecurityLevel.S1,
}

export default function error14800030Test() {
  describe('error14800030Test', () => {

        /**
     * @tc.name      : testSUBDistributedDataRDBSDKErrorCode14800030_1200
     * @tc.number    : SUB_DistributedData_RDB_SDK_ErrorCode14800030Test_1200
     * @tc.desc      : Verify the properties of the text type
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('SUB_DistributedData_RDB_SDK_ErrorCode14800030Test_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done:Function) => {
      let rdbStore = await data_relationalStore.getRdbStore(context, STORE_CONFIG1);
      await rdbStore.executeSql(CREATE_TABLE_TEST1, null);
      let u8 = new Uint8Array(Array(2).fill(1));
      const valueBucket:data_relationalStore.ValuesBucket = {
        "name": "zhangsan",
        "age": 16,
        "salary": 100.5,
        "blobType": u8,
      };
      await rdbStore.insert("test1", valueBucket);
      let predicates = new data_relationalStore.RdbPredicates("test1");
      predicates.equalTo("NAME", "zhangsan");

      try {
        rdbStore.createTransaction().then((transaction: data_relationalStore.Transaction) => {
          transaction.execute("DELETE FROM test WHERE age = ? OR age = ?", [21, 20]).then(() => {
            transaction.commit();
          }).catch((e: BusinessError) => {
            transaction.rollback();
            console.error(`execute sql failed, code is ${e.code},message is ${e.message}`);
          });
        }).catch((err: BusinessError) => {
          console.error(`createTransaction faided, code is ${err.code},message is ${err.message}`);
        });
      } catch (err) {
        expect(err.code).assertEqual(14800030);
      }
      await data_relationalStore.deleteRdbStore(context, "TransactionTest.db");
      done();
    })
  })
}