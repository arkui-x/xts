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
import data_relationalStore from '@ohos.data.relationalStore';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const TAG = "[+]";
const CREATE_TABLE_TEST = "CREATE TABLE IF NOT EXISTS test (" + "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
  "data1 text," + "data2 long, " + "data3 double," + "data4 blob," + "data5 ASSET," + "data6 ASSETS," +
  "data7 floatvector(128)," + "data8 UNLIMITED INT" + ")";

const STORE_CONFIG: data_relationalStore.StoreConfig = {
  name: "Resultset.db",
  securityLevel: data_relationalStore.SecurityLevel.S1,
};

let rdbStore: data_relationalStore.RdbStore | undefined | null;

async function createTest() {
  console.log(TAG + "createTest data start");
  {
    let u8 = new Uint8Array([1, 2, 3]);
    const valueBucket: data_relationalStore.ValuesBucket = {
      "data1": "hello",
      "data2": 10,
      "data3": 1.0,
      "data4": u8,
    };
    await (rdbStore as data_relationalStore.RdbStore).insert("test", valueBucket);
  }
  {
    let u8 = new Uint8Array([3, 4, 5]);
    const valueBucket: data_relationalStore.ValuesBucket = {
      "data1": "2",
      "data2": -5,
      "data3": 100000.5,
      "data4": u8,
    };
    await (rdbStore as data_relationalStore.RdbStore).insert("test", valueBucket);
  }
  {
    let u8 = new Uint8Array(0);
    const valueBucket: data_relationalStore.ValuesBucket = {
      "data1": "hello world",
      "data2": 3,
      "data3": 100000,
      "data4": u8,
    };
    await (rdbStore as data_relationalStore.RdbStore).insert("test", valueBucket);
  }
  console.log(TAG + "createTest data end");
}

export default function rdbResultSetSJsTest() {
  describe('rdbResultSetSJsTest', () => {
    beforeAll(async () => {
      console.info(TAG + 'beforeAll');
      rdbStore = await data_relationalStore.getRdbStore(context, STORE_CONFIG);
      await rdbStore.executeSql(CREATE_TABLE_TEST, null);
      await createTest();
    });
    beforeEach(async () => {
      console.info(TAG + 'beforeEach');
    });
    afterEach(() => {
      console.info(TAG + 'afterEach');
    });
    afterAll(async () => {
      console.info(TAG + 'afterAll');
      rdbStore = null;
      await data_relationalStore.deleteRdbStore(context, "Resultset.db");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0100
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0001 start *************");
      try {
        let asset: data_relationalStore.Asset = {
          name: "name4",
          uri: "uri4",
          createTime: "createTime4",
          modifyTime: "modifyTime4",
          size: "size4",
          path: "path4"
        };
        let assets = [asset];
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": "hello world",
          "data2": 3,
          "data3": 10.5,
          "data4": new Uint8Array([1, 2, 3]),
          "data5": asset,
          "data6": assets,
          "data7": new Float32Array([1.5, 2.5]),
          "data8": 100n
        };
        await (rdbStore as data_relationalStore.RdbStore).insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0001 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("id"));
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data1"));
        expect(type).assertEqual(data_relationalStore.ColumnType.TEXT);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data2"));
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data3"));
        expect(type).assertEqual(data_relationalStore.ColumnType.REAL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data4"));
        expect(type).assertEqual(data_relationalStore.ColumnType.BLOB);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data5"));
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSET);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data6"));
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSETS);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data7"));
        expect(type).assertEqual(data_relationalStore.ColumnType.FLOAT_VECTOR);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data8"));
        expect(type).assertEqual(data_relationalStore.ColumnType.UNLIMITED_INT);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0001 getColumnType failed " + err);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0001 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0002
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0200
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0002 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
          "data2": null,
          "data3": null,
          "data4": null,
          "data5": null,
          "data6": null,
          "data7": null,
          "data8": null
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0002 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("id"));
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data1"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data2"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data3"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data4"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data5"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data6"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data7"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType(resultSet?.getColumnIndex("data8"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0002 getColumnType failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0002 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0003
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0300
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0003 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0003 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        resultSet?.close();
        await resultSet?.getColumnType(resultSet?.getColumnIndex("id"));
        console.error(TAG + "testGetColumnTypeJsTest0003 getColumnType success ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0003 getColumnType failed. " + err);
        expect('14800014').assertEqual(err.code);
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0003 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0004
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0400
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0004 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0004 insert failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        await resultSet?.getColumnType(0);
        console.error(TAG + "testGetColumnTypeJsTest0004 getColumnType success ");
        expect(true).assertFail();
        done();
      } catch (err) {
        expect(14800012).assertEqual(err.code);
        resultSet.close();
        done();
        console.error(TAG + "testGetColumnTypeJsTest0004 getColumnType failed " + err);
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0004 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0005
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0500
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0005 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0005 insert failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let columnCount = resultSet?.columnCount;
        expect(9).assertEqual(columnCount);
        await resultSet?.getColumnType(columnCount);
        console.error(TAG + "testGetColumnTypeJsTest0005 getColumnType success ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0005 getColumnType failed " + err.code + err.message);
        expect(14800013).assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0005 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0006
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0600
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0006 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0006 insert failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        await resultSet?.getColumnType(-1);
        console.error(TAG + "testGetColumnTypeJsTest0006 getColumnType success ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0006 getColumnType failed. " + err.code + err.message);
        expect('401').assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0006 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0007
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0700
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0007 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0007 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = await resultSet.getColumnType(Number.MAX_SAFE_INTEGER);
        console.error(TAG + "testGetColumnTypeJsTest0007 failed type " + type);
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0007 success " + err.code + err.message);
        expect('401').assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0007 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0008
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0800
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0008 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0008 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = await resultSet?.getColumnType(Number.MAX_VALUE);
        console.error(TAG + "testGetColumnTypeJsTest0008 success type " + type);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0008 failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0008 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0009
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0900
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0009 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0009 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet.goToRow(count - 1));
        let type = await resultSet?.getColumnType(Number.MIN_VALUE);
        console.error(TAG + "testGetColumnTypeJsTest0009 success type " + type);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0009 failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0009 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0010
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1000
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0010 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0010 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = await resultSet?.getColumnType(Number.MIN_SAFE_INTEGER);
        console.error(TAG + "testGetColumnTypeJsTest0010 success type " + type);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0010 failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0010 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0011
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPITEST_1100
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0011 start *************");
      try {
        let asset: data_relationalStore.Asset = {
          name: "name4",
          uri: "uri4",
          createTime: "createTime4",
          modifyTime: "modifyTime4",
          size: "size4",
          path: "path4",
        };
        let assets = [asset];
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": "hello world",
          "data2": 3,
          "data3": 100000,
          "data4": new Uint8Array([1, 2, 3]),
          "data5": asset,
          "data6": assets,
          "data7": new Float32Array([1.5, 2.5]),
          "data8": 100n
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0011 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = await resultSet?.getColumnType("id");
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = await resultSet?.getColumnType("data1");
        expect(type).assertEqual(data_relationalStore.ColumnType.TEXT);
        type = await resultSet?.getColumnType("data2");
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = await resultSet?.getColumnType("data3");
        expect(type).assertEqual(data_relationalStore.ColumnType.REAL);
        type = await resultSet?.getColumnType("data4");
        expect(type).assertEqual(data_relationalStore.ColumnType.BLOB);
        type = await resultSet?.getColumnType("data5");
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSET);
        type = await resultSet?.getColumnType("data6");
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSETS);
        type = await resultSet?.getColumnType("data7");
        expect(type).assertEqual(data_relationalStore.ColumnType.FLOAT_VECTOR);
        type = await resultSet?.getColumnType("data8");
        resultSet?.close();
        expect(type).assertEqual(data_relationalStore.ColumnType.UNLIMITED_INT);
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0011 querySql failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0011 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0012
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPITEST_1200
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0012 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
          "data2": null,
          "data3": null,
          "data4": null,
          "data5": null,
          "data6": null,
          "data7": null,
          "data8": null
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0012 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = await resultSet?.getColumnType("id");
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = await resultSet?.getColumnType("data1");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType("data2");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType("data3");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType("data4");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType("data5");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType("data6");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType("data7");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = await resultSet?.getColumnType("data8");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0012 failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0012 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0013
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPITEST_1300
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0013 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0013 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let columnCount = resultSet?.columnCount;
        expect(9).assertEqual(columnCount);
        await resultSet?.getColumnType("");
        console.error(TAG + "testGetColumnTypeJsTest0013 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0013 success " + err.code + err.message);
        expect('401').assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0013 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0014
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPITEST_1400
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0014 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0014 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let columnCount = resultSet?.columnCount;
        expect(9).assertEqual(columnCount);
        await resultSet?.getColumnType("columnName");
        console.error(TAG + "testGetColumnTypeJsTest0014 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0014 success " + err.code + err.message);
        expect(401).assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0014 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0015
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPITEST_1500
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0015 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0015 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        resultSet?.close();
        await resultSet?.getColumnType("id");
        console.error(TAG + "testGetColumnTypeJsTest0015 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0015 success " + err.code + err.message);
        expect('14800014').assertEqual(err.code);
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0015 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeJsTest0016
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPITEST_1600
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0016 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0016 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        await resultSet?.getColumnType("id");
        console.error(TAG + "testGetColumnTypeJsTest0016 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0016 success " + err.code + err.message);
        expect(14800012).assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0016 end *************");
    });

    /**
     * @tc.name   : testgetColumnTypeJsTest0017
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPITEST_1700
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeJsTest0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeJsTest0017 start *************");
      try {
        let predicates = new data_relationalStore.RdbPredicates("test");
        await rdbStore?.delete(predicates);
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0017 insert failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT data1 FROM test");
      try {
        for (let i = 0; i < 500; ++i) {
          let count = resultSet.rowCount;
          expect(true).assertEqual(resultSet?.goToRow(count - 1));
          resultSet?.getColumnType(0);
          done();
        }
      } catch (err) {
        console.error(TAG + "testGetColumnTypeJsTest0017 success " + err.code + err.message);
        expect('14800014').assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeJsTest0017 end *************");
    });
    console.log(TAG + "*************Unit Test End*************");
  });
}