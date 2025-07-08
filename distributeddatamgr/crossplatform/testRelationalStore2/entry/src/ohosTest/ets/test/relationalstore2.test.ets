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
import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common';
import { BusinessError } from '@kit.BasicServicesKit';

let context: common.UIAbilityContext;
const TAG = "[VALUE_TYPE_TEST]"

const CREATE_TABLE_TEST = "CREATE TABLE IF NOT EXISTS bigint_table(id INTEGER PRIMARY KEY AUTOINCREMENT, value1 UNLIMITED INT NOT NULL, value2 UNLIMITED INT, name TEXT)";
const DROP_TABLE_TEST = "DROP TABLE IF EXISTS bigint_table";

const STORE_CONFIG : relationalStore.StoreConfig= {
  name: 'value_type.db',
  securityLevel: relationalStore.SecurityLevel.S1,
}
let store :relationalStore.RdbStore| null= null;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function RdbStoreValueTypeTest() {
  describe('RdbStoreValueTypeTest', () => {
    beforeAll(async () => {
      await sleep(3000);
      console.info(TAG + 'beforeAll');
      context = AppStorage.get<common.UIAbilityContext>("TestAbilityContext") as common.UIAbilityContext
      store = await relationalStore.getRdbStore(context, STORE_CONFIG);
    })

    beforeEach(async () => {
      await sleep(300);
      console.info(TAG + 'beforeEach');
      if(store) {
        store.executeSync(CREATE_TABLE_TEST);
      }
    })

    afterEach(async () => {
      await sleep(300);
      console.info(TAG + 'afterEach')
      if(store) {
        store.executeSync(DROP_TABLE_TEST);
      }
    })

    afterAll(async () => {
      console.info(TAG + 'afterAll');
      store = null;
      await relationalStore.deleteRdbStore(context, "value_type.db");
      await sleep(3000);
    })

    console.log(TAG + "*************Unit Test Begin*************");

    /**
     * @tc.name the value type BigInt(45)
     * @tc.number SUB_DistributedData_RelationalStore_SDK_BigIntAPITest_0100
     * @tc.desc the value type BigInt(45)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testValueType0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testValueType0001 start *************");
      let bucket :relationalStore.ValuesBucket= {
        "value1":BigInt(45),
        "value2":BigInt(-45),
        "name":"zhangsan",
      };
      if(store) {
        try {
          console.log(TAG + "insert(bigint_table," + bucket + ")");
          let rowid = await store.insert("bigint_table", bucket);
          console.log(TAG + "insert():=>" + rowid);
          let resultSet = await store.querySql("select value1, value2 from bigint_table");
          console.log(TAG + "query" + resultSet);
          let status = resultSet.goToNextRow();
          expect(status).assertTrue();
          console.log(TAG + "goToNextRow():=>" + status);
          let value1 = resultSet.getValue(0);
          let type = typeof value1;
          console.log(TAG + "getValue(0):=>" + value1 + " type:" + type);
          expect(type).assertEqual("bigint");
          expect(value1).assertEqual(bucket["value1"]);
          let value2 = resultSet.getValue(1);
          type = typeof value2;
          console.log(TAG + "getValue(1):=>" + value2 + " type:" + type);
          expect(type).assertEqual("bigint");
          expect(value2).assertEqual(bucket["value2"]);

        } catch (err) {
          expect(false).assertFail();
          console.error(TAG + `failed, code:${err.code}, message: ${err.message}`);

        }
      }
      console.log(TAG + "************* testValueType0001 end *************");
    })

    /**
     * @tc.name the value BigInt "15822401018187971961171"
     * @tc.number SUB_DistributedData_RelationalStore_SDK_BigIntAPITest_0200
     * @tc.desc the value BigInt "15822401018187971961171"
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testValueType0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testValueType0002 start *************");
      let bucket :relationalStore.ValuesBucket= {
        "value1":BigInt("15822401018187971961171"),
        "value2":BigInt("-15822401018187971961171"),
        "name":"zhangsan",
      };
      if(store) {
        try {
          console.log(TAG + "insert(bigint_table," + bucket + ")");
          let rowid = await store.insert("bigint_table", bucket);
          console.log(TAG + "insert():=>" + rowid);
          let resultSet = await store.querySql("select value1, value2 from bigint_table");
          console.log(TAG + "query" + resultSet);
          let status = resultSet.goToNextRow();
          expect(status).assertTrue();
          console.log(TAG + "goToNextRow():=>" + status);
          let value1 = resultSet.getValue(0);
          let type = typeof value1;
          console.log(TAG + "getValue(0):=>" + value1 + " type:" + type);
          expect(type).assertEqual("bigint");
          expect(value1).assertEqual(bucket["value1"]);
          let value2 = resultSet.getValue(1);
          type = typeof value2;
          console.log(TAG + "getValue(1):=>" + value2 + " type:" + type);
          expect(type).assertEqual("bigint");
          expect(value2).assertEqual(bucket["value2"]);

        } catch (err) {
          expect(false).assertFail();
          console.error(TAG + `failed, code:${err.code}, message: ${err.message}`);

        }
      }
      console.log(TAG + "************* testValueType0002 end *************");
    })
    /**
     * @tc.name the value update
     * @tc.number SUB_DistributedData_RelationalStore_SDK_BigIntAPITest_0300
     * @tc.desc the value update
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testValueType0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testValueType0003 start *************");
      let bucket :relationalStore.ValuesBucket= {
        "value1":BigInt("15822401018187971961171"),
        "value2":BigInt("-15822401018187971961171"),
        "name":"zhangsan",
      };
      let bucket1 :relationalStore.ValuesBucket= {
        "value1":BigInt("15322401018187971961171"),
        "value2":BigInt("-15822401018187971961171"),
        "name":"lisi",
      };
      if(store) {
        try {
          console.log(TAG + "insert (bigint_table," + bucket + ")");
          let rowid = await store.insert("bigint_table", bucket);
          console.log(TAG + "insert success,rowid is:" + rowid);
          let predicates = new relationalStore.RdbPredicates("bigint_table");
          predicates.equalTo("value1", bucket["value1"]);
          await store.update(bucket1, predicates).then(async (rows) => {
            console.info(TAG + "update start");
            console.info(TAG + "Updated row count:" + rows);
            expect(1).assertEqual(rows);
            console.info(TAG + "update end");
          }).catch((err:BusinessError) => {
            console.info("update error " + err.code);
            expect(null).assertFail();
          })
          let resultSet = await store.querySql("select value1, value2 from bigint_table");
          console.log(TAG + "query" + resultSet);
          let status = resultSet.goToNextRow();
          expect(status).assertTrue();
          console.log(TAG + "goToNextRow():=>" + status);
          let value1 = resultSet.getValue(0);
          let type = typeof value1;
          console.log(TAG + "getValue(0):=>" + value1 + " type:" + type);
          expect(type).assertEqual("bigint");
          expect(value1).assertEqual(bucket1["value1"]);
          let value2 = resultSet.getValue(1);
          type = typeof value2;
          console.log(TAG + "getValue(1):=>" + value2 + " type:" + type);
          expect(type).assertEqual("bigint");
          expect(value2).assertEqual(bucket1["value2"]);

        } catch (err) {
          expect(false).assertFail();
          console.error(TAG + `failed, code:${err.code}, message: ${err.message}`);

        }
      }
      console.log(TAG + "************* testValueType0003 end *************");
    })
  })
}