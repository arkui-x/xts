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
import relationalStore from '@ohos.data.relationalStore';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG = "[RELATIONAL_STORE_JS_READ_ONLY_TEST]";

let STORE_CONFIG: relationalStore.StoreConfig = {
  name: "store.db",
  securityLevel: relationalStore.SecurityLevel.S1,
};
let STORE_CONFIG1: relationalStore.StoreConfig = {
  name: "test.db",
  securityLevel: relationalStore.SecurityLevel.S1,
  isReadOnly: true,
};

let STORE_CONFIG2: relationalStore.StoreConfig = {
  name: "readOnly.db",
  securityLevel: relationalStore.SecurityLevel.S1,
  isReadOnly: true,
};

let STORE_CONFIG3: relationalStore.StoreConfig = {
  name: "readOnly3.db",
  securityLevel: relationalStore.SecurityLevel.S1,
  isReadOnly: true,
};

const valueBucket: relationalStore.ValuesBucket = {
  'name': 'zhangsan',
  'age': 18,
  'salary': 25000,
  'blobType': new Uint8Array([1, 2, 3]),
};

const valueBucket2: relationalStore.ValuesBucket = {
  'name': 'lisi',
  'age': 19,
  'salary': 30000,
  'blobType': new Uint8Array([1, 2, 3]),
};

let rdbStore: relationalStore.RdbStore | undefined;
let readOnlyStore3: relationalStore.RdbStore | undefined;
const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function RdbStoreReadOnlyTest() {
  describe('RdbStoreReadOnlyTest', () => {
    beforeAll(async () => {
      await sleep(3000);
      console.log(TAG + 'beforeAll');
      try {
        await relationalStore.deleteRdbStore(context, STORE_CONFIG);
        await relationalStore.deleteRdbStore(context, STORE_CONFIG3);

        rdbStore = await relationalStore.getRdbStore(context, STORE_CONFIG);
        expect(rdbStore === null).assertFalse();

        const CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS test (id INTEGER PRIMARY KEY AUTOINCREMENT, " +
          "name TEXT, age INTEGER, salary REAL, blobType BLOB)";
        await rdbStore.executeSql(CREATE_TABLE_SQL);
        await rdbStore.insert('test', valueBucket);
        await rdbStore.insert('test', valueBucket2);
        await rdbStore.backup(STORE_CONFIG3.name);
        if (rdbStore) {
          rdbStore.close();
          rdbStore = undefined;
        }

      } catch (err) {
        console.error(TAG,
          `init database failed, errCode:${(err as BusinessError).code}, message:${(err as BusinessError).message}`);
      }
    });

    beforeEach(async (done: Function) => {
      console.info(TAG + 'beforeEach');
      await sleep(300);
    });

    afterEach(async (done: Function) => {
      console.info(TAG + 'afterEach');
      if (readOnlyStore3) {
        readOnlyStore3.close();
        readOnlyStore3 = undefined;
      }
      await sleep(300);
    });

    afterAll(async (done: Function) => {
      console.info(TAG + 'afterAll');
      try {
        await relationalStore.deleteRdbStore(context, STORE_CONFIG);
        await relationalStore.deleteRdbStore(context, STORE_CONFIG1);
        await relationalStore.deleteRdbStore(context, STORE_CONFIG2);
        await relationalStore.deleteRdbStore(context, STORE_CONFIG3);
      } catch (err) {
        console.error(TAG,
          `delete database failed, errCode:${(err as BusinessError).code}, message:${(err as BusinessError).message}`);
      }
      await sleep(3000);
    });

    console.info(TAG + "*************JS Test Begin*************");

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_ReadOnlyAPITest_0100
     * @tc.name testReadOnly0100
     * @tc.desc 1. set isReadOnly as true
     *          2. delete read-only database
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testReadOnly0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      console.info(TAG + "************* testReadOnly0100 start *************");
      try {
        readOnlyStore3 = await relationalStore.getRdbStore(context, STORE_CONFIG3);
        console.info(TAG + 'getRdbStore successfully.');
        expect(readOnlyStore3 === undefined).assertFalse();

        if (readOnlyStore3) {
          readOnlyStore3.close();
          readOnlyStore3 = undefined;
        }

        await relationalStore.deleteRdbStore(context, STORE_CONFIG3).then(() => {
          console.info('Delete RdbStore successfully.');
          done();
        }).catch((err: BusinessError) => {
          console.error(`Delete RdbStore failed, code is ${err.code},message is ${err.message}`);
          expect().assertFail();
          done();
        });
      } catch (err) {
        console.error(TAG,
          `open read-only database failed, errCode:${(err as BusinessError).code}, message:${(err as BusinessError).message}`);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testReadOnly0100 end *************");
    });

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_ReadOnlyAPITest_0200
     * @tc.name testReadOnly0200
     * @tc.desc 1. set isReadOnly as true
     *          2. open read-only database if the database is not exist
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testReadOnly0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      console.info(TAG + "************* testReadOnly0200 start *************");
      try {
        await relationalStore.deleteRdbStore(context, STORE_CONFIG1);

        await relationalStore.getRdbStore(context, STORE_CONFIG1);
        expect().assertFail();
        done();
      } catch (err) {
        console.error(TAG,
          `open read-only database failed, errCode:${(err as BusinessError).code}, message:${(err as BusinessError).message}`);
        expect((err as BusinessError).code).assertEqual(14800030);
        done();
      }
      console.log(TAG + "************* testReadOnly0200 end *************");
    });
  });
}