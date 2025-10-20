/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { relationalStore } from '@kit.ArkData';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const TAG = "[ttt]";
const bucket1000: relationalStore.ValuesBucket = {};
for (let i = 0; i < 1001; i++) {
  bucket1000["test" + i] = i;
}
const STORE_CONFIG: relationalStore.StoreConfig = {
  name: "RdbTest.db",
  securityLevel: relationalStore.SecurityLevel.S3
};
const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const CREATE_TABLE_TEST =
  "CREATE TABLE IF NOT EXISTS test  (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL, age INTEGER, salary REAL, blobType BLOB)";

let rdbStore: relationalStore.RdbStore | undefined | null;

export default function relationalStoreBatchInsertTest() {
  describe('relationalStoreBatchInsertTest', () => {
    beforeAll(async () => {
      console.info(TAG + 'beforeAll');
    });
    beforeEach(async () => {
      console.info(TAG + 'beforeEach');
      try {
        rdbStore = await relationalStore.getRdbStore(context, STORE_CONFIG);
        console.info(TAG + 'Get RdbStore successfully.');
        await (rdbStore as relationalStore.RdbStore).executeSql(CREATE_TABLE_TEST);
      } catch (err) {
        console.error(TAG + `Get RdbStore failed, code is ${err.code},message is ${err.message}`);
      }
    });
    afterEach(async () => {
      console.info(TAG + 'afterEach');
      rdbStore = undefined;
      await relationalStore.deleteRdbStore(context, "RdbTest.db");
    });
    afterAll(async () => {
      console.info(TAG + 'afterAll');
    });

    /**
     * @tc.name   : testRdbGetInsertSqlInfo0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0100
     * @tc.desc   : Get Insert SQL Info
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetInsertSqlInfo0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testRdbGetInsertSqlInfo0001 start *************");
      let bucket: relationalStore.ValuesBucket = {
        name: "Logitech",
        age: "18",
        sex: "man",
        desc: "asserter"
      };
      try {
        let info: relationalStore.SqlInfo = relationalStore.getInsertSqlInfo(
          "USER",
          bucket,
          relationalStore.ConflictResolution.ON_CONFLICT_NONE
        );
        expect(info.sql).assertEqual("INSERT INTO USER(age,desc,name,sex) VALUES (?,?,?,?)");
        expect(info.args[0]).assertContain("18");
        expect(info.args[1]).assertContain("asserter");
        expect(info.args[2]).assertContain("Logitech");
        expect(info.args[3]).assertContain("man");
      } catch (error) {
        console.log('error: ' + error.message);
        expect(false).assertTrue();
      }
      done();
      console.log(TAG + "************* testRdbGetInsertSqlInfo0001 end *************");
    });

    /**
     * @tc.name   :  testRdbGetInsertSqlInfoTabkleNameTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0200
     * @tc.desc   : Get Insert SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  :  Level 2
     */
    it('testRdbGetInsertSqlInfoTabkleNameTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetInsertSqlInfoTabkleNameTooLength0001 start *************");
        let bucket: relationalStore.ValuesBucket = {
          name: "Logitech",
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        let tableName: string = "x".repeat(257);
        try {
          relationalStore.getInsertSqlInfo(
            tableName,
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetInsertSqlInfoTabkleNameTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetInsertSqlInfoBucketTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0300
     * @tc.desc   : Get Insert SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetInsertSqlInfoBucketTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketTooLength0001 start *************");
        try {
          relationalStore.getInsertSqlInfo(
            "user",
            bucket1000,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetInsertSqlInfoBucketColumTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0400
     * @tc.desc   : Get Insert SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetInsertSqlInfoBucketColumTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketColumTooLength0001 start *************");
        let tableName: string = "a".repeat(257);
        let bucket: relationalStore.ValuesBucket = {
          name: tableName,
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        bucket[tableName] = "tableName";
        try {
          relationalStore.getInsertSqlInfo(
            "user",
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketColumTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetInsertSqlInfoTableNameIsEmpty0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0500
     * @tc.desc   : Get Insert SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetInsertSqlInfoTableNameIsEmpty0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetInsertSqlInfoTableNameIsEmpty0001 start *************");
        let bucket: relationalStore.ValuesBucket = {
          name: "tableName",
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        try {
          relationalStore.getInsertSqlInfo(
            "",
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetInsertSqlInfoTableNameIsEmpty0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetInsertSqlInfoConflictResolutionIsEmpty0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0600
     * @tc.desc   : Get Insert SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetInsertSqlInfoConflictResolutionIsEmpty0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetInsertSqlInfoConflictResolutionIsEmpty0001 start *************");
        let bucket: relationalStore.ValuesBucket = {
          name: "tableName",
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        try {
          let info: relationalStore.SqlInfo = relationalStore.getInsertSqlInfo(
            "tableName",
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect(info.sql).assertEqual("INSERT INTO tableName(age,desc,name,sex) VALUES (?,?,?,?)");
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect().assertFail();
          done();
        }
        console.log(TAG + "************* testRdbGetInsertSqlInfoConflictResolutionIsEmpty0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetInsertSqlInfoBucketIsNull0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0700
     * @tc.desc   : Get Insert SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetInsertSqlInfoBucketIsNull0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketIsNull0001 start *************");
        let bucket: relationalStore.ValuesBucket = {};
        try {
          relationalStore.getInsertSqlInfo(
            "USER",
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketIsNull0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetInsertSqlInfoBucketIsAssets0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_GETINSERTSQLINFOETSAPI20TEST_0800
     * @tc.desc   : Get Insert SQL Info Bucket Is Assets
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetInsertSqlInfoBucketIsAssets0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketIsAssets0001 start *************");
        let values: relationalStore.Assets = [
          {
            name: "a",
            uri: "b",
            path: "c",
            createTime: "d",
            modifyTime: "e",
            size: "f",
            status: relationalStore.AssetStatus.ASSET_NORMAL
          }
        ];
        let bucket: relationalStore.ValuesBucket = {
          value: values
        };
        try {
          relationalStore.getInsertSqlInfo(
            "ASSETS",
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_REPLACE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetInsertSqlInfoBucketIsAssets0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetUpdateSqlInfo0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETUPDATESQLINFOETSAPI20TEST_0900
     * @tc.desc   : Get Update SQL Info
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetUpdateSqlInfo0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testRdbGetUpdateSqlInfo0001 start *************");
      let bucket: relationalStore.ValuesBucket = {
        name: "Logitech",
        age: "18",
        sex: "man",
        desc: "asserter"
      };
      let predicates = new relationalStore.RdbPredicates("users");
      let info: relationalStore.SqlInfo = relationalStore.getUpdateSqlInfo(
        predicates,
        bucket,
        relationalStore.ConflictResolution.ON_CONFLICT_NONE
      );
      expect(info.sql).assertEqual("UPDATE users SET age=?,desc=?,name=?,sex=?");
      expect(info.args[0]).assertContain("18");
      expect(info.args[1]).assertContain("asserter");
      expect(info.args[2]).assertContain("Logitech");
      expect(info.args[3]).assertContain("man");
      done();
      console.log(TAG + "************* testRdbGetUpdateSqlInfo0001 end *************");
    });

    /**
     * @tc.name   : testRdbGetUpdateSqlInfoBucketIsNull0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETUPDATESQLINFOETSAPI20TEST_1000
     * @tc.desc   : Get Update SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetUpdateSqlInfoBucketIsNull0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetUpdateSqlInfoBucketIsNull0001 start *************");
        let predicates = new relationalStore.RdbPredicates("users");
        let bucket: relationalStore.ValuesBucket = {};
        try {
          relationalStore.getUpdateSqlInfo(
            predicates,
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetUpdateSqlInfoBucketIsNull0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetUpdateSqlInfoBucketTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETUPDATESQLINFOETSAPI20TEST_1100
     * @tc.desc   : Get Update SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetUpdateSqlInfoBucketTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetUpdateSqlInfoBucketTooLength0001 start *************");
        let predicates = new relationalStore.RdbPredicates("users");
        try {
          relationalStore.getUpdateSqlInfo(
            predicates,
            bucket1000,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getUpdateSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetUpdateSqlInfoBucketTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetUpdateSqlInfoBucketCloumTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETUPDATESQLINFOETSAPI20TEST_1200
     * @tc.desc   : Get Update SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetUpdateSqlInfoBucketCloumTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetUpdateSqlInfoBucketCloumTooLength0001 start *************");
        let predicates = new relationalStore.RdbPredicates("users");
        let tableName: string = "a".repeat(257);
        let bucket: relationalStore.ValuesBucket = {
          name: "tableName",
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        bucket[tableName] = "tableName";
        try {
          relationalStore.getUpdateSqlInfo(
            predicates,
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetUpdateSqlInfoBucketCloumTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetUpdateSqlInfoTableTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETUPDATESQLINFOETSAPI20TEST_1300
     * @tc.desc   : Get Update SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetUpdateSqlInfoTableTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetUpdateSqlInfoTableTooLength0001 start *************");
        let tableName: string = "a".repeat(257);
        for (let i = 0; i < 256; i++) {
          tableName = tableName + "a";
        }
        let predicates = new relationalStore.RdbPredicates(tableName);
        let bucket: relationalStore.ValuesBucket = {
          name: "tableName",
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        try {
          relationalStore.getUpdateSqlInfo(
            predicates,
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetUpdateSqlInfoTableTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetUpdateSqlInfoWhereClauseTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETUPDATESQLINFOETSAPI20TEST_1400
     * @tc.desc   : Get Update SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetUpdateSqlInfoWhereClauseTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetUpdateSqlInfoWhereClauseTooLength0001 start *************");
        let tableName: string = "";
        for (let i = 0; i < 256; i++) {
          tableName = tableName + "a";
        }
        let predicates = new relationalStore.RdbPredicates("tableName");
        predicates.equalTo(tableName, "user");
        let bucket: relationalStore.ValuesBucket = {
          name: "tableName",
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        try {
          relationalStore.getUpdateSqlInfo(
            predicates,
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetUpdateSqlInfoWhereClauseTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetUpdateSqlInfoConflictResolutionIsEmpty0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETUPDATESQLINFOETSAPI20TEST_1500
     * @tc.desc   : Get Update SQL Info Bucket Is Null
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetUpdateSqlInfoConflictResolutionIsEmpty0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetUpdateSqlInfoConflictResolutionIsEmpty0001 start *************");
        let predicates = new relationalStore.RdbPredicates("tableName");
        predicates.equalTo("tableName", "user");
        let bucket: relationalStore.ValuesBucket = {
          name: "tableName",
          age: "18",
          sex: "man",
          desc: "asserter"
        };
        try {
          let info: relationalStore.SqlInfo = relationalStore.getUpdateSqlInfo(
            predicates,
            bucket,
            relationalStore.ConflictResolution.ON_CONFLICT_NONE
          );
          expect(info.sql).assertEqual("UPDATE tableName SET age=?,desc=?,name=?,sex=? WHERE tableName = ? ");
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect().assertFail();
          done();
        }
        console.log(TAG + "************* testRdbGetUpdateSqlInfoConflictResolutionIsEmpty0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetDeleteSqlInfo0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETDELETESQLINFOETSAPI20TEST_1600
     * @tc.desc   : Get Delete SQL Info
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetDeleteSqlInfo0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testRdbGetDeleteSqlInfo0001 start *************");
      try {
        let predicates = new relationalStore.RdbPredicates("users");
        let info: relationalStore.SqlInfo = relationalStore.getDeleteSqlInfo(predicates);
        expect(info.sql).assertEqual("DELETE FROM users");
        done();
      } catch (e) {
        console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testRdbGetDeleteSqlInfo0001 end *************");
    });

    /**
     * @tc.name   : testRdbGetDeleteSqlInfoTableNameTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETDELETESQLINFOETSAPI20TEST_1700
     * @tc.desc   : Get Delete SQL Info Table Name Must Be Not Empty
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetDeleteSqlInfoTableNameTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetDeleteSqlInfoTableNameTooLength0001 start *************");
        try {
          let tableName: string = "a".repeat(257);
          let predicates = new relationalStore.RdbPredicates(tableName);
          relationalStore.getDeleteSqlInfo(predicates);
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetDeleteSqlInfoTableNameTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetDeleteSqlInfoTableNameTooLength0002
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETDELETESQLINFOETSAPI20TEST_1800
     * @tc.desc   : Get Delete SQL Info Table Name Must Be Not Empty
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetDeleteSqlInfoTableNameTooLength0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetDeleteSqlInfoTableNameTooLength0002 start *************");
        try {
          let tableName: string = "";
          for (let i = 0; i < 256; i++) {
            tableName = tableName + "a";
          }
          let predicates = new relationalStore.RdbPredicates("tableName");
          predicates.equalTo(tableName, "a");
          relationalStore.getDeleteSqlInfo(predicates);
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getDeleteSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetDeleteSqlInfoTableNameTooLength0002 end *************");
      });

    /**
     * @tc.name   : testRdbGetQuerySqlInfo0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETQUERYSQLINFOETSAPI20TEST_1900
     * @tc.desc   : Get Query SQL Info
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetQuerySqlInfo0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testRdbGetQuerySqlInfo0001 start *************");
      try {
        let predicates = new relationalStore.RdbPredicates("users");
        let info: relationalStore.SqlInfo = relationalStore.getQuerySqlInfo(predicates);
        expect(info.sql).assertEqual("SELECT * FROM users");
        done();
      } catch (e) {
        console.error(TAG + 'getInsertSqlInfo' + e.code + e.message);
        expect().assertFail();
        done();
      }
      console.log(TAG + "************* testRdbGetQuerySqlInfo0001 end *************");
    });

    /**
     * @tc.name   : testRdbGetQuerySqlInfoColumnsIsNullList0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETQUERYSQLINFOETSAPI20TEST_2000
     * @tc.desc   : Get Query SQL Info Columns Is Null List
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetQuerySqlInfoColumnsIsNullList0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetQuerySqlInfoColumnsIsNullList0001 start *************");
        try {
          let predicates = new relationalStore.RdbPredicates("users");
          let info: relationalStore.SqlInfo = relationalStore.getQuerySqlInfo(predicates, []);
          expect(info.sql).assertEqual("SELECT * FROM users");
          done();
        } catch (e) {
          console.error(TAG + 'getQuerySqlInfo' + e.code + e.message);
          expect().assertFail();
          done();
        }
        console.log(TAG + "************* testRdbGetQuerySqlInfoColumnsIsNullList0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetQuerySqlInfoByColumns0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETQUERYSQLINFOETSAPI20TEST_2100
     * @tc.desc   : Get Query SQL Info By Columns
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetQuerySqlInfoByColumns0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetQuerySqlInfoByColumns0001 start *************");
        try {
          let predicates = new relationalStore.RdbPredicates("users");
          let info: relationalStore.SqlInfo = relationalStore.getQuerySqlInfo(predicates, ["name", "age"]);
          expect(info.sql).assertEqual("SELECT name, age  FROM users");
          done();
        } catch (e) {
          console.error(TAG + 'getQuerySqlInfo' + e.code + e.message);
          expect().assertFail();
          done();
        }
        console.log(TAG + "************* testRdbGetQuerySqlInfoByColumns0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetQuerySqlInfoTableNameTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETQUERYSQLINFOETSAPI20TEST_2200
     * @tc.desc   : Get Query SQL Info Table Name Must Be Not Empty
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetQuerySqlInfoTableNameTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetQuerySqlInfoTableNameTooLength0001 start *************");
        try {
          let tableName: string = "a".repeat(257);
          let predicates = new relationalStore.RdbPredicates(tableName);
          relationalStore.getQuerySqlInfo(predicates);
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getDeleteSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetQuerySqlInfoTableNameTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetQuerySqlInfoWhereClauseTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETQUERYSQLINFOETSAPI20TEST_2300
     * @tc.desc   : Get Query SQL Info Table Name Must Be Not Empty
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetQuerySqlInfoWhereClauseTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetQuerySqlInfoWhereClauseTooLength0001 start *************");
        try {
          let tableName: string = "";
          for (let i = 0; i < 256; i++) {
            tableName = tableName + "a";
          }
          let predicates = new relationalStore.RdbPredicates("tableName");
          predicates.equalTo(tableName, "a");
          relationalStore.getQuerySqlInfo(predicates);
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getDeleteSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetQuerySqlInfoWhereClauseTooLength0001 end *************");
      });

    /**
     * @tc.name   : testRdbGetQuerySqlInfoTableNameTooLength0002
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETQUERYSQLINFOETSAPI20TEST_2400
     * @tc.desc   : Get Query SQL Info Table Name Must Be Not Empty
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetQuerySqlInfoTableNameTooLength0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetQuerySqlInfoTableNameTooLength0002 start *************");
        try {
          let predicates = new relationalStore.RdbPredicates("tableName");
          predicates.equalTo("tableName", "a");
          let info: relationalStore.SqlInfo = relationalStore.getQuerySqlInfo(predicates, ["3", "4"]);
          expect(info.args[0]).assertEqual('a');
          done();
        } catch (e) {
          console.error(TAG + 'getDeleteSqlInfo' + e.code + e.message);
          expect().assertFail();
          done();
        }
        console.log(TAG + "************* testRdbGetQuerySqlInfoTableNameTooLength0002 end *************");
      });

    /**
     * @tc.name   : testRdbGetQuerySqlInfoColumnsTooLength0001
     * @tc.number : SUB_DISTRIBUTEDDATA_RELATIONALSTORE_SDK_RDBGETQUERYSQLINFOETSAPI20TEST_2500
     * @tc.desc   : Get Query SQL Info Table Name Must Be Not Empty
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testRdbGetQuerySqlInfoColumnsTooLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        console.log(TAG + "************* testRdbGetQuerySqlInfoColumnsTooLength0001 start *************");
        try {
          let colums: string[] = new Array(1003);
          for (let i = 0; i < colums.length; i++) {
            colums[i] = "a";
          }
          let predicates = new relationalStore.RdbPredicates("tableName");
          predicates.equalTo("tableName", "a");
          relationalStore.getQuerySqlInfo(predicates, colums);
          expect().assertFail();
          done();
        } catch (e) {
          console.error(TAG + 'getDeleteSqlInfo' + e.code + e.message);
          expect(e.code).assertEqual("14800001");
          done();
        }
        console.log(TAG + "************* testRdbGetQuerySqlInfoColumnsTooLength0001 end *************");
      });
  });
}