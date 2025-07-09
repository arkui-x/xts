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
import data_Rdb from '@ohos.data.relationalStore';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const TAG = "[RelationalStore_KITS _TEST]"
const CREATE_TABLE_ALL_DATA_TYPE_SQL = "CREATE TABLE IF NOT EXISTS AllDataType "
  + "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
  + "integerValue INTEGER , longValue INTEGER , shortValue INTEGER , booleanValue INTEGER , "
  + "doubleValue REAL , floatValue REAL , stringValue TEXT , blobValue BLOB , clobValue TEXT , "
  + "byteValue INTEGER , dateValue INTEGER , timeValue INTEGER , timestampValue INTEGER , "
  + "calendarValue INTEGER , characterValue TEXT , primIntValue INTEGER , primLongValue INTEGER , "
  + "primShortValue INTEGER , primFloatValue REAL , primDoubleValue REAL , "
  + "primBooleanValue INTEGER , primByteValue INTEGER , primCharValue TEXT, `order` INTEGER);";

const STORE_CONFIG: data_Rdb.StoreConfig = {
  name: "Predicates.db",
  securityLevel: data_Rdb.SecurityLevel.S1
}

let rdbStore: data_Rdb.RdbStore | null = null;
let DOUBLE_MAX = 9223372036854775807;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function buildAllDataType1() {
  console.info(TAG + "buildAllDataType1 start");
  {
    let u8 = new Uint8Array([1, 2, 3])
    const valueBucket: Record<string, data_Rdb.ValueType> = {
      "integerValue": 2147483647,
      "doubleValue": DOUBLE_MAX,
      "booleanValue": true,
      "floatValue": -0.123,
      "longValue": 9223372036854775807,
      "shortValue": 32767,
      "characterValue": ' ',
      "stringValue": "ABCDEFGHIJKLMN",
      "blobValue": u8,
      "byteValue": 127,
    }
    if (rdbStore) {
      await rdbStore.insert("AllDataType", valueBucket)
    }
  }
}

async function buildAllDataType2() {
  console.info(TAG + "buildAllDataType2 start");
  {
    let u8 = new Uint8Array([1, 2, 3])
    const valueBucket: Record<string, data_Rdb.ValueType> = {
      "integerValue": 1,
      "doubleValue": 1.0,
      "booleanValue": false,
      "floatValue": 1.0,
      "longValue": 1,
      "shortValue": 1,
      "characterValue": '中',
      "stringValue": "ABCDEFGHIJKLMN",
      "blobValue": u8,
      "byteValue": 1,
    }
    if (rdbStore) {
      await rdbStore.insert("AllDataType", valueBucket)
    }
  }
}

async function buildAllDataType3() {
  console.info(TAG + "buildAllDataType3 start");
  {
    let u8 = new Uint8Array([1, 2, 3])
    const valueBucket: Record<string, data_Rdb.ValueType> = {
      "integerValue": -2147483648,
      "doubleValue": Number.MIN_VALUE,
      "booleanValue": false,
      "floatValue": 0.1234567,
      "longValue": -9223372036854775808,
      "shortValue": -32768,
      "characterValue": '#',
      "stringValue": "ABCDEFGHIJKLMN",
      "blobValue": u8,
      "byteValue": -128,
    }
    if (rdbStore) {
      await rdbStore.insert("AllDataType", valueBucket)
    }
  }
}

export default function relationalStorePredicatesTest() {
  describe('relationalStorePredicatesTest', () => {
    beforeAll(async () => {
      await sleep(3000);
      console.info(TAG + 'beforeAll')
    })

    beforeEach(async () => {
      await sleep(300);
      console.info(TAG + 'beforeEach')
      rdbStore = await data_Rdb.getRdbStore(context, STORE_CONFIG);
      await rdbStore.executeSql(CREATE_TABLE_ALL_DATA_TYPE_SQL, null);
      await buildAllDataType1();
      await buildAllDataType2();
      await buildAllDataType3();
      await rdbStore.executeSql("CREATE INDEX index_name ON AllDataType (characterValue);", null);
    })

    afterEach(async () => {
      await sleep(300);
      console.info(TAG + 'afterEach')
      rdbStore = null;
      await data_Rdb.deleteRdbStore(context, "Predicates.db");
    })

    afterAll(async () => {
      await sleep(3000);
      console.info(TAG + 'afterAll')
    })
    console.info(TAG + "*************Unit Test Begin*************");

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotContains_0001
     * @tc.name Normal test case of predicates, test "notContains" for string value
     * @tc.desc 1.Execute notContains ("stringValue", "ABC")
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotContains0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testNotContains0001 start *************");
      if (rdbStore) {
        let predicates = new data_Rdb.RdbPredicates("AllDataType");
        predicates.notContains("stringValue", "ABC");
        let result: data_Rdb.ResultSet = await rdbStore.query(predicates);
        expect(0).assertEqual(result.rowCount);
        result.close()
        console.log(TAG + "************* testNotContains0001 end *************");
      }
    })

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotContains_0002
     * @tc.name Normal test case of predicates, test "notContains" for  Chinese character value
     * @tc.desc 1.Execute notContains ("characterValue", "中")
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotContains0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testNotContains0002 start *************");
      if (rdbStore) {
        let predicates = new data_Rdb.RdbPredicates("AllDataType");
        predicates.notContains("characterValue", "中");
        let result: data_Rdb.ResultSet = await rdbStore.query(predicates);
        expect(2).assertEqual(result.rowCount);
        result.close()
        console.log(TAG + "************* testNotContains0002 end *************");
      }
    })

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotContains_0003
     * @tc.name Normal test case of predicates, test "notContains" for character value
     * @tc.desc 1.Execute notContains ("characterValue", "#")
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotContains0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testNotContains0003 start *************");
      let predicates = new data_Rdb.RdbPredicates("AllDataType");
      predicates.notContains("characterValue", "#");
      if (rdbStore == null) {
        return;
      }
      let result = await rdbStore.query(predicates);
      expect(2).assertEqual(result.rowCount);
      result.close()
      console.log(TAG + "************* testNotContains0003 end *************");
    })

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotContains_0004
     * @tc.name Abnormal test case of predicates, test "notContains" for character value
     * @tc.desc 1.Execute notContains ("characterValue", null)
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotContains0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info(TAG, "************* testNotContains0004 start *************");
      try {
        let predicates = new data_Rdb.RdbPredicates("AllDataType");
        predicates.notContains("characterValue", null);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG,
          `testNotContains0012 predicates.notContains failed: err code=${err.code}, message=${err.message}`);
        expect("401").assertEqual(err.code);
      }
      console.info(TAG, "************* testNotContains0004 end *************");
    })

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotLike_0001
     * @tc.name Normal test case of predicates, test "notLike" for string value
     * @tc.desc 1.Execute notLike ("stringValue", "ABCDEFGHIJKLMN")
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotLike0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testNotLike0001 start *************");
      if (rdbStore) {
        let predicates = new data_Rdb.RdbPredicates("AllDataType");
        predicates.notLike("stringValue", "ABCDEFGHIJKLMN");
        let result = await rdbStore.query(predicates);
        expect(0).assertEqual(result.rowCount);
        result.close()
        console.log(TAG + "************* testNotLike0001 end *************");
      }
    })

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotLike_0002
     * @tc.name Normal test case of predicates, test "notLike" for Chinese character value
     * @tc.desc 1.Execute notLike ("characterValue", "中")
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotLike0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testNotLike0002 start *************");
      if (rdbStore) {
        let predicates = new data_Rdb.RdbPredicates("AllDataType");
        predicates.notLike("characterValue", "中");
        let result = await rdbStore.query(predicates);
        expect(2).assertEqual(result.rowCount);
        result.close()
        console.log(TAG + "************* testNotLike0002 end *************");
      }
    })

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotLike_0003
     * @tc.name Normal test case of predicates, test "notLike" for character value
     * @tc.desc 1.Execute notLike ("characterValue", "#")
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotLike0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log(TAG + "************* testNotLike0003 start *************");
      if (rdbStore) {
        let predicates = new data_Rdb.RdbPredicates("AllDataType");
        predicates.notLike("characterValue", "#");
        let result = await rdbStore.query(predicates);
        expect(2).assertEqual(result.rowCount);
        result.close()
        console.log(TAG + "************* testNotLike0003 end *************");
      }
    })

    /**
     * @tc.number SUB_DistributedData_RelationalStore_SDK_PredicatesEtsAPITest_NotLike_0004
     * @tc.name Abnormal test case of predicates, test "notLike" for character value
     * @tc.desc 1.Execute notLike ("characterValue", null)
     *          2.Query data
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testNotLike0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      console.info(TAG + "************* testNotLike0004 start *************");
      try {
        let predicates = new data_Rdb.RdbPredicates("AllDataType");
        predicates.notLike("characterValue", null);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG, `testNotLike0012 predicates.notLike failed: err code=${err.code}, message=${err.message}`);
        expect("401").assertEqual(err.code);
      }
      console.info(TAG + "************* testNotLike0004 end *************");
    })
  });
}