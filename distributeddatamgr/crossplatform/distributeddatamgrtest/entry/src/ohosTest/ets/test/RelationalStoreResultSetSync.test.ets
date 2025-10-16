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

const TAG = "[RELATIONAL_STORE_JSKITS_RESULTSET_TEST]";
const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
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
      "data4": u8
    };
    await (rdbStore as data_relationalStore.RdbStore).insert("test", valueBucket);
  }
  {
    let u8 = new Uint8Array([3, 4, 5]);
    const valueBucket: data_relationalStore.ValuesBucket = {
      "data1": "2",
      "data2": -5,
      "data3": 2.5,
      "data4": u8
    };
    await (rdbStore as data_relationalStore.RdbStore).insert("test", valueBucket);
  }
  {
    let u8 = new Uint8Array(0);
    const valueBucket: data_relationalStore.ValuesBucket = {
      "data1": "hello world",
      "data2": 3,
      "data3": 1.8,
      "data4": u8
    };
    await (rdbStore as data_relationalStore.RdbStore).insert("test", valueBucket);
  }
  console.log(TAG + "createTest data end");
}

export default function rdbResultSetSyncTest() {
  describe('rdbResultSetSyncTest', () => {
    beforeAll(async () => {
      console.info(TAG + 'beforeAll');
      try {
        rdbStore = await data_relationalStore.getRdbStore(context, STORE_CONFIG);
        await rdbStore.executeSql(CREATE_TABLE_TEST, null);
        await createTest();
      } catch (error) {
        console.log('error: ' + error.message);
      }
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
      try {
        await data_relationalStore.deleteRdbStore(context, "Resultset.db");
      } catch (error) {
        console.log('error: ' + error.message);
      }
    });

    /**
     * @tc.name   : testGetColumnTypeSync0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0100
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0001 start *************");
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
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0001 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("id"));
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data1"));
        expect(type).assertEqual(data_relationalStore.ColumnType.TEXT);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data2"));
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data3"));
        expect(type).assertEqual(data_relationalStore.ColumnType.REAL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data4"));
        expect(type).assertEqual(data_relationalStore.ColumnType.BLOB);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data5"));
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSET);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data6"));
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSETS);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data7"));
        expect(type).assertEqual(data_relationalStore.ColumnType.FLOAT_VECTOR);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data8"));
        expect(type).assertEqual(data_relationalStore.ColumnType.UNLIMITED_INT);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0001  failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0001 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0002
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0200
     * @tc.desc   : querySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0002 start *************");
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
        console.error(TAG + "testGetColumnTypeSync0002 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("id"));
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data1"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data2"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data3"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data4"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data5"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data6"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data7"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("data8"));
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0002  failed " + err.code + err.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0002 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0003
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0300
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0003 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0003 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        resultSet?.close();
        resultSet?.getColumnTypeSync(resultSet?.getColumnIndex("id"));
        console.error(TAG + "testGetColumnTypeSync0003 getColumnTypeSync success");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0003 getColumnTypeSync failed. " + err);
        expect('14800014').assertEqual(err.code);
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0003 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0004
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0400
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0004 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0004 insert failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        resultSet?.getColumnTypeSync(0);
        console.error(TAG + "testGetColumnTypeSync0004 getColumnType success ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0004 getColumnType failed " + err);
        expect(14800012).assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0004 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0005
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0500
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0005 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0005 insert failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let columnCount = resultSet?.columnCount;
        expect(9).assertEqual(columnCount);
        resultSet?.getColumnTypeSync(columnCount);
        console.error(TAG + "testGetColumnTypeSync0005 getColumnType success ");
        expect(true).assertFail();
        done();
      } catch (err) {
        expect(14800013).assertEqual(err.code);
        resultSet?.close();
        done();
        console.error(TAG + "testGetColumnTypeSync0005 getColumnType failed " + err);
      }
      console.log(TAG + "************* testGetColumnTypeSync0005 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0006
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0600
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0006 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0006 insert failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        resultSet?.getColumnTypeSync(-1);
        console.error(TAG + "testGetColumnTypeSync0006 getColumnType success ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0006 getColumnType failed. " + err);
        expect('401').assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0006 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0007
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0700
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0007 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0007 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = resultSet.getColumnTypeSync(Number.MAX_SAFE_INTEGER);
        console.error(TAG + "testGetColumnTypeSync0007 failed type " + type);
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0007 success " + err);
        expect('401').assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0007 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0008
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0800
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0008 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0008 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = resultSet?.getColumnTypeSync(Number.MAX_VALUE);
        console.error(TAG + "testGetColumnTypeSync0008 success type " + type);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0008 failed " + err);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0008 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0009
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_0900
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0009 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null,
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0009 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = resultSet?.getColumnTypeSync(Number.MIN_VALUE);
        console.error(TAG + "testGetColumnTypeSync0009 success type " + type);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0009 failed " + err);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0009 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0010
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1000
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0010 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0010 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = resultSet?.getColumnTypeSync(Number.MIN_SAFE_INTEGER);
        console.error(TAG + "testGetColumnTypeSync0010 success type " + type);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0010 failed " + err);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0010 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0011
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1100
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0011 start *************");
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
          "data3": 100000,
          "data4": new Uint8Array([1, 2, 3]),
          "data5": asset,
          "data6": assets,
          "data7": new Float32Array([1.5, 2.5]),
          "data8": 100n
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0011 insert failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = resultSet?.getColumnTypeSync("id");
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = resultSet?.getColumnTypeSync("data1");
        expect(type).assertEqual(data_relationalStore.ColumnType.TEXT);
        type = resultSet?.getColumnTypeSync("data2");
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = resultSet?.getColumnTypeSync("data3");
        expect(type).assertEqual(data_relationalStore.ColumnType.REAL);
        type = resultSet?.getColumnTypeSync("data4");
        expect(type).assertEqual(data_relationalStore.ColumnType.BLOB);
        type = resultSet?.getColumnTypeSync("data5");
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSET);
        type = resultSet?.getColumnTypeSync("data6");
        expect(type).assertEqual(data_relationalStore.ColumnType.ASSETS);
        type = resultSet?.getColumnTypeSync("data7");
        expect(type).assertEqual(data_relationalStore.ColumnType.FLOAT_VECTOR);
        type = resultSet?.getColumnTypeSync("data8");
        resultSet?.close();
        expect(type).assertEqual(data_relationalStore.ColumnType.UNLIMITED_INT);
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0011 querySql failed " + err);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0011 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0012
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1200
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0012 start *************");
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
        console.error(TAG + "testGetColumnTypeSync0012 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet.goToRow(count - 1));
        let type = data_relationalStore.ColumnType.NULL;
        type = resultSet?.getColumnTypeSync("id");
        expect(type).assertEqual(data_relationalStore.ColumnType.INTEGER);
        type = resultSet?.getColumnTypeSync("data1");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync("data2");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync("data3");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync("data4");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync("data5");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync("data6");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync("data7");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        type = resultSet?.getColumnTypeSync("data8");
        expect(type).assertEqual(data_relationalStore.ColumnType.NULL);
        resultSet?.close();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0012 failed " + err);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0012 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0013
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1300
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0013 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0013 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet.goToRow(count - 1));
        let columnCount = resultSet.columnCount;
        expect(9).assertEqual(columnCount);
        resultSet?.getColumnTypeSync("");
        console.error(TAG + "testGetColumnTypeSync0013 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0013 success " + err);
        expect('401').assertEqual(err.code);
        resultSet.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0013 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0014
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1400
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0014 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0014 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        let count = resultSet?.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        let columnCount = resultSet?.columnCount;
        expect(9).assertEqual(columnCount);
        resultSet?.getColumnTypeSync("columnName");
        console.error(TAG + "testGetColumnTypeSync0014 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0014 success " + err.code);
        expect(401).assertEqual(err.code);
        resultSet?.close();
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0014 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0015
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1500
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0015 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0015 failed " + err);
      }
      try {
        let resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
        let count = resultSet.rowCount;
        expect(true).assertEqual(resultSet?.goToRow(count - 1));
        resultSet?.close();
        resultSet?.getColumnTypeSync("id");
        console.error(TAG + "testGetColumnTypeSync0015 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0015 success " + err);
        expect('14800014').assertEqual(err.code);
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0015 end *************");
    });

    /**
     * @tc.name   : testGetColumnTypeSync0016
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RESULTSET_ETSAPI20TEST_1600
     * @tc.desc   : uerySharingResource test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testGetColumnTypeSync0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testGetColumnTypeSync0016 start *************");
      try {
        let valueBucket: data_relationalStore.ValuesBucket = {
          "data1": null
        };
        await rdbStore?.insert("test", valueBucket);
      } catch (err) {
        console.error(TAG + "testGetColumnTypeSync0016 failed " + err);
      }
      let resultSet: data_relationalStore.ResultSet;
      resultSet = await (rdbStore as data_relationalStore.RdbStore).querySql("SELECT * FROM test");
      try {
        resultSet?.getColumnTypeSync("id");
        console.error(TAG + "testGetColumnTypeSync0016 failed ");
        expect(true).assertFail();
        done();
      } catch (err) {
        expect(14800012).assertEqual(err.code);
        resultSet.close();
        console.error(TAG + "testGetColumnTypeSync0016 success " + err);
        done();
      }
      console.log(TAG + "************* testGetColumnTypeSync0016 end *************");
    });
    console.log(TAG + "*************Unit Test End*************");
  });
}