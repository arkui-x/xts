/*
* Copyright (c) 2024 Huawei Device Co., Ltd.
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
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect} from '@ohos/hypium';
import data_Rdb from '@ohos.data.relationalStore';
import common from '@ohos.app.ability.common';
import { BusinessError } from '@ohos.base';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

let context: common.Context;
const TAG = "[RelationalStore_JSKITS_TEST]";
const CREATE_TABLE_TEST = "CREATE TABLE IF NOT EXISTS test (" + "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
  "name TEXT NOT NULL, " + "age INTEGER, " + "salary REAL, " + "blobType BLOB)";

export default function relationalStoreCustomDirTest() {
  describe('relationalStoreCustomDirTest', () => {
    beforeAll(async () => {
      let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator =
        AbilityDelegatorRegistry.getAbilityDelegator();
      context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");
      console.info(TAG + 'beforeAll');
    })

    beforeEach(async () => {
      console.info(TAG + 'beforeEach');
    })

    afterEach(async () => {
      console.info(TAG + 'afterEach');

    })

    afterAll(async () => {
      console.info(TAG + 'afterAll');
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0010
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Single level directory getRdbStore callback test
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0010', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "test"
      }
      data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
        if (err == null) {
          console.info(TAG + "getRdbStore Success: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
          done();
        } else {
          console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
          expect().assertFail();
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0020
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Single level directory getRdbStore promise test
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0020', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "test"
      }
      await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
        console.info(TAG + "getRdbStore done: " + rdbStore);
        expect(rdbStore != null).assertTrue();
      }).catch((err:BusinessError) => {
        console.info(`Get RdbStore failed,code is ${err.code},message is ${err.message}`);
        expect().assertFail();
        done();
      })
      await data_Rdb.deleteRdbStore(context, STORE_CONFIG).then(() => {
        console.info(TAG + "Delete RdbStore successfully");
        done();
      }).catch((err: BusinessError) => {
        console.info(TAG + "Delete RdbStore failed" + err.code + err.message);
        expect().assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0030
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Single level directory insert update delete query test
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0030', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "test"
      }
      let store:data_Rdb.RdbStore | null = null;
      store = await data_Rdb.getRdbStore(context, STORE_CONFIG);
      expect(store != null).assertTrue();
      try {
        store.executeSql(CREATE_TABLE_TEST, null);
      } catch (e) {
        expect().assertFail();
        done();
      }
      let u8 = new Uint8Array([1, 2, 3]);
      const valueBucket: data_Rdb.ValuesBucket = {
        "name": "zhangsan",
        "age": 18,
        "salary": 100.5,
        "blobType": u8,
      }
      await store.insert("test", valueBucket).then(async (ret) => {
        console.info(TAG + "insert  done: " + ret)
        expect(1).assertEqual(ret);
      }).catch((err: BusinessError) => {
        console.info(TAG + "insert with null table" + err);
        expect().assertFail();
        done();
      })
      let predicates = new data_Rdb.RdbPredicates("test");
      predicates.equalTo("name", "zhangsan");
      await store.query(predicates).then(async (resultSet) => {
        console.info(TAG + "resultSet query done");
        expect(true).assertEqual(resultSet.goToFirstRow())
        const id = resultSet.getLong(resultSet.getColumnIndex("id"))
        const name = resultSet.getString(resultSet.getColumnIndex("name"))
        const age = resultSet.getLong(resultSet.getColumnIndex("age"))
        const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"))
        const blobType = resultSet.getBlob(resultSet.getColumnIndex("blobType"))
        console.info(TAG + "id=" + id + ", name=" + name + ", age=" + age + ", salary=" +
          salary + ", blobType=" + blobType);
        expect(1).assertEqual(id);
        expect("zhangsan").assertEqual(name)
        expect(18).assertEqual(age)
        expect(100.5).assertEqual(salary)
        expect(1).assertEqual(blobType[0])
        expect(2).assertEqual(blobType[1])
        expect(3).assertEqual(blobType[2])
        expect(false).assertEqual(resultSet.goToNextRow())
        resultSet.close();
      }).catch((err: BusinessError) => {
        console.info("query error " + err);
        expect().assertFail();
        done();
      })
      const valueBucket1: data_Rdb.ValuesBucket = {
        "name": "lisi",
        "age": 18,
        "salary": 100.5,
        "blobType": u8,
      }
      predicates.equalTo("name", "zhangsan");
      await store.update(valueBucket1, predicates).then(async (rows) => {
        console.info(TAG + "Updated row count:" + rows);
        expect(1).assertEqual(rows);
      }).catch((err: BusinessError) => {
        console.info("update error " + err);
        expect().assertFail();
        done();
      })
      let predicates1 = new data_Rdb.RdbPredicates("test");
      predicates1.equalTo("name", "lisi");
      await store.query(predicates1).then(async (resultSet) => {
        console.info(TAG + "resultSet query done");
        expect(true).assertEqual(resultSet.goToFirstRow())
        const id = resultSet.getLong(resultSet.getColumnIndex("id"))
        const name = resultSet.getString(resultSet.getColumnIndex("name"))
        const age = resultSet.getLong(resultSet.getColumnIndex("age"))
        const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"))
        const blobType = resultSet.getBlob(resultSet.getColumnIndex("blobType"))
        console.info(TAG + "id=" + id + ", name=" + name + ", age=" + age + ", salary=" +
          salary + ", blobType=" + blobType);
        expect(1).assertEqual(id);
        expect("lisi").assertEqual(name)
        expect(18).assertEqual(age)
        expect(100.5).assertEqual(salary)
        expect(1).assertEqual(blobType[0])
        expect(2).assertEqual(blobType[1])
        expect(3).assertEqual(blobType[2])
        expect(false).assertEqual(resultSet.goToNextRow())
        resultSet.close();
      }).catch((err: BusinessError) => {
        console.info("query error " + err);
        expect().assertFail();
        done();
      })
      await store.delete(predicates1).then(async (rows) => {
        console.info(TAG + "delete done:" + rows);
        expect(1).assertEqual(rows);
      }).catch((err: BusinessError) => {
        console.info("delete error " + err)
        expect().assertFail();
        done();
      })
      await store.query(predicates1).then(async (resultSet) => {
        console.info(TAG + "resultSet query done");
        console.info(TAG + "query result:" + resultSet.rowCount);
        expect(0).assertEqual(resultSet.rowCount);
        resultSet.close();
      }).catch((err: BusinessError) => {
        console.info("query error " + err);
        expect().assertFail();
        done();
      })
      await data_Rdb.deleteRdbStore(context, STORE_CONFIG)
      store = null;
      done();
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0040
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Multi-level directory getRdbStore callback
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0040', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/testrdb/test/rdb"
      }
      data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
        if (err == null) {
          console.info(TAG + "getRdbStore Success: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
          done();
        } else {
          console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
          expect().assertFail();
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0050
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Multi-level directory getRdbStore promise
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0050', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/testrdb/test/rdb"
      }
      await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
        console.info(TAG + "getRdbStore done: " + rdbStore);
        expect(rdbStore != null).assertTrue();
        await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
        done();
      }).catch((err:BusinessError) => {
        console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
        expect().assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0060
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Multi-level directory insert update delete query test
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0060', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/testrdb/test/rdb"
      }
      let store:data_Rdb.RdbStore | null = null;
      store = await data_Rdb.getRdbStore(context, STORE_CONFIG);
      expect(store != null).assertTrue();
      try {
        store.executeSql(CREATE_TABLE_TEST, null);
      } catch (e) {
        expect().assertFail();
        done();
      }
      let u8 = new Uint8Array([1, 2, 3]);
      const valueBucket: data_Rdb.ValuesBucket = {
        "name": "zhangsan",
        "age": 18,
        "salary": 100.5,
        "blobType": u8,
      }
      await store.insert("test", valueBucket).then(async (ret) => {
        console.info(TAG + "insert  done: " + ret)
        expect(1).assertEqual(ret);
      }).catch((err: BusinessError) => {
        console.info(TAG + "insert with null table" + err);
        expect().assertFail();
        done();
      })
      let predicates = new data_Rdb.RdbPredicates("test");
      predicates.equalTo("name", "zhangsan");
      await store.query(predicates).then(async (resultSet) => {
        console.info(TAG + "resultSet query done");
        expect(true).assertEqual(resultSet.goToFirstRow())
        const id = resultSet.getLong(resultSet.getColumnIndex("id"))
        const name = resultSet.getString(resultSet.getColumnIndex("name"))
        const age = resultSet.getLong(resultSet.getColumnIndex("age"))
        const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"))
        const blobType = resultSet.getBlob(resultSet.getColumnIndex("blobType"))
        console.info(TAG + "id=" + id + ", name=" + name + ", age=" + age + ", salary=" +
          salary + ", blobType=" + blobType);
        expect(1).assertEqual(id);
        expect("zhangsan").assertEqual(name)
        expect(18).assertEqual(age)
        expect(100.5).assertEqual(salary)
        expect(1).assertEqual(blobType[0])
        expect(2).assertEqual(blobType[1])
        expect(3).assertEqual(blobType[2])
        expect(false).assertEqual(resultSet.goToNextRow())
        resultSet.close();
      }).catch((err: BusinessError) => {
        console.info("query error " + err);
        expect().assertFail();
        done();
      })
      const valueBucket1: data_Rdb.ValuesBucket = {
        "name": "lisi",
        "age": 18,
        "salary": 100.5,
        "blobType": u8,
      }
      predicates.equalTo("name", "zhangsan");
      await store.update(valueBucket1, predicates).then(async (rows) => {
        console.info(TAG + "Updated row count:" + rows);
        expect(1).assertEqual(rows);
      }).catch((err: BusinessError) => {
        console.info("update error " + err);
        expect().assertFail();
        done();
      })
      let predicates1 = new data_Rdb.RdbPredicates("test");
      predicates1.equalTo("name", "lisi");
      await store.query(predicates1).then(async (resultSet) => {
        console.info(TAG + "resultSet query done");
        expect(true).assertEqual(resultSet.goToFirstRow())
        const id = resultSet.getLong(resultSet.getColumnIndex("id"))
        const name = resultSet.getString(resultSet.getColumnIndex("name"))
        const age = resultSet.getLong(resultSet.getColumnIndex("age"))
        const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"))
        const blobType = resultSet.getBlob(resultSet.getColumnIndex("blobType"))
        console.info(TAG + "id=" + id + ", name=" + name + ", age=" + age + ", salary=" +
          salary + ", blobType=" + blobType);
        expect(1).assertEqual(id);
        expect("lisi").assertEqual(name)
        expect(18).assertEqual(age)
        expect(100.5).assertEqual(salary)
        expect(1).assertEqual(blobType[0])
        expect(2).assertEqual(blobType[1])
        expect(3).assertEqual(blobType[2])
        expect(false).assertEqual(resultSet.goToNextRow())
        resultSet.close();
      }).catch((err: BusinessError) => {
        console.info("query error " + err);
        expect().assertFail();
        done();
      })
      await store.delete(predicates1).then(async (rows) => {
        console.info(TAG + "delete done:" + rows);
        expect(1).assertEqual(rows);
      }).catch((err: BusinessError) => {
        console.info("delete error " + err)
        expect().assertFail();
        done();
      })
      await store.query(predicates1).then(async (resultSet) => {
        console.info(TAG + "resultSet query done");
        console.info(TAG + "query result:" + resultSet.rowCount);
        expect(0).assertEqual(resultSet.rowCount);
        resultSet.close();
      }).catch((err: BusinessError) => {
        console.info("query error " + err);
        expect().assertFail();
        done();
      })
      await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
      store = null;
      done();
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0070
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 128 bytes customDir:Multi-level directory getRdbStore test callback
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0070', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/ttst/tee00/11/tee2288000000/#% 0t0" +
          "0/123323vjkdfn/48378498/nvnvnvn/88999/vvbbb/nvjdnvj/8"
      }
      data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
        if (err == null) {
          console.info(TAG + "getRdbStore Success: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
          done();
        } else {
          console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
          expect().assertFail();
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0080
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 128 bytes customDir:Multi-level directory getRdbStore test promise
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0080', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/ttst/tee00/11/tee2288000000/#% 0t0" +
          "0/123323vjkdfn/48378498/nvnvnvn/88999/vvbbb/nvjdnvj/8"
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
          console.info(TAG + "getRdbStore done: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
          done();
        }).catch((err:BusinessError) => {
          console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
          expect().assertFail();
          done();
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0080 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0090
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 128 bytes customDir:Single level directory  getRdbStore test callback
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0090', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "dataappel66teeeeeeeee67eeeehfghfgheeeeeeeee!@#@$$#%%(*  (eeee9988711ssssssssss+_)" +
          "25555555555555hfhfg55gggggghgfhhhfghfghgfhfhfgh"
      }
      try {
        data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
          if (err == null) {
            console.info(TAG + "getRdbStore Success: " + rdbStore);
            expect(rdbStore != null).assertTrue();
            await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
            done();
          } else {
            console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
            expect().assertFail();
            done();
          }
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0090 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0100
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 128 bytes customDir:Single level directory  getRdbStore test promise
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0100', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "dataappel66teeeeeeeee67eeeehfghfgheeeeeeeee!@#@$$#%%(*  (eeee9988711ssssssssss+_)" +
          "25555555555555hfhfg55gggggghgfhhhfghfghgfhfhfgh"
      }
      await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
        console.info(TAG + "getRdbStore done: " + rdbStore);
        expect(rdbStore != null).assertTrue();
        await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
        done();
      }).catch((err:BusinessError) => {
        console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
        expect().assertFail();
        done();
      })
    })


    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0110
     * @tc.name : customDir
     * @tc.desc : RelationalStore getrdbStore-deleteRdbStore-getrdbStore test promise
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0110', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/test1"
      }
      try {
        let store:data_Rdb.RdbStore | null = null;
        store = await data_Rdb.getRdbStore(context, STORE_CONFIG);
        store.executeSql(CREATE_TABLE_TEST, null);
        console.info(TAG + "getRdbStore done: " + store);
      } catch (err) {
        expect().assertFail();
        done();
      }
      await data_Rdb.deleteRdbStore(context, STORE_CONFIG).then(() => {
        console.info(TAG + "Delete RdbStore successfully.");
      }).catch((err: BusinessError) => {
        console.info(`Delete RdbStore failed, code is ${err.code},message is ${err.message}`);
        expect().assertFail();
        done();
      })
      const STORE_CONFIG1: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/test1"
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG1).then(async (rdbStore) => {
          console.info(TAG + "getRdbStore done: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG1);
          done();
        }).catch((err: BusinessError) => {
          console.info(`Get RdbStore failed,code is ${err.code},message is ${err.message}`);
          expect().assertFail();
          done();
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0110 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /*
   * @tc.number : SUB_RelationalStore_customDir_Func_0120
   * @tc.name : customDir
   * @tc.desc : RelationalStore store backup and restore promise test
   * @tc.level : Level 0
   */
    it('SUB_RelationalStore_customDir_Func_0120', 0, async (done: Function) => {
      let backupName = "BackupTest004.db"
      const STORE_CONFIG:data_Rdb.StoreConfig = {
        name: "rdbStore1.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/test/rdbStore1.db"
      }
      let store:data_Rdb.RdbStore | null = null;
      store = await data_Rdb.getRdbStore(context, STORE_CONFIG);
      try {
        expect(store != null).assertTrue();
        await store.executeSql(CREATE_TABLE_TEST);
        let u8 = new Uint8Array([1, 2, 3]);
        const valueBucket:data_Rdb.ValuesBucket = {
          "name": "zhangsan",
          "age": 18,
          "salary": 100.5,
          "blobType": u8,
        }
        await store.insert("test", valueBucket).then(async (ret) => {
          console.info(TAG + "insert  done: " + ret)
          expect(1).assertEqual(ret);
        }).catch((err: BusinessError) => {
          console.info(TAG + "insert with null table" + err);
          expect().assertFail();
          done();
        })
        await store.backup(backupName);
        await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
        await store.restore(backupName);
        let predicates = new data_Rdb.RdbPredicates("test");
        let resultSet = await store.query(predicates);
        expect(true).assertEqual(resultSet.goToFirstRow())
        const id = resultSet.getLong(resultSet.getColumnIndex("id"))
        const name = resultSet.getString(resultSet.getColumnIndex("name"))
        const age = resultSet.getLong(resultSet.getColumnIndex("age"))
        const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"))
        const blobType = resultSet.getBlob(resultSet.getColumnIndex("blobType"))
        console.info(TAG + "id=" + id + ", name=" + name + ", age=" + age + ", salary=" +
          salary + ", blobType=" + blobType);
        expect(1).assertEqual(id);
        expect("zhangsan").assertEqual(name)
        expect(18).assertEqual(age)
        expect(100.5).assertEqual(salary)
        expect(1).assertEqual(blobType[0])
        expect(2).assertEqual(blobType[1])
        expect(3).assertEqual(blobType[2])
        expect(false).assertEqual(resultSet.goToNextRow())
        resultSet.close();
        await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
        done();
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0120 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0150
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir: "" getRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0150', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: ""
      }
      try {
        data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
          if (err == null) {
            console.info(TAG + "getRdbStore Success: " + rdbStore);
            expect(rdbStore != null).assertTrue();
            await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
            done();
          } else {
            console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
            expect().assertFail();
            done();
          }
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0150 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0160
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir: "" getRdbStore test promise
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0160', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: ""
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
          console.info(TAG + "getRdbStore done: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
          done();
        }).catch((err:BusinessError) => {
          console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
          expect().assertFail();
          done();
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0160 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0170
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir: undefined getRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0170', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: undefined
      }
      try {
        data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
          if (err == null) {
            console.info(TAG + "getRdbStore Success: " + rdbStore);
            expect(rdbStore != null).assertTrue();
            await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
            done();
          } else {
            console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
            expect().assertFail();
            done();
          }
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0170 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0180
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir: undefined getRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0180', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: undefined
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
          console.info(TAG + "getRdbStore done: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
          done();
        }).catch((err:BusinessError) => {
          console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
          expect().assertFail();
          done();
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0180 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0190
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir: "*" getRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0190', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "*"
      }
      try {
        data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
          if (err == null) {
            console.info(TAG + "getRdbStore Success: " + rdbStore);
            expect(rdbStore != null).assertTrue();
            await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
            done();
          } else {
            console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
            expect().assertFail();
            done();
          }
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0190 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0200
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir: "*" getRdbStore test promise
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0200', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "*"
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
          console.info(TAG + "getRdbStore done: " + rdbStore);
          expect(rdbStore != null).assertTrue();
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
          done();
        }).catch((err:BusinessError) => {
          console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
          expect().assertFail();
          done();
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0200 failed, error is" + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0210
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 129 bytes customDir:Multi-level directory getRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0210', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/ttst/tee00/11/tee2288000000/#% 0t00/" +
          "123323vjkdfn/48378498/nvnvnvn/88999/vvbbb/nvjdnvj/78"
      }
      try {
        data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
          if (err == null) {
            expect().assertFail();
            done();
          } else {
            console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
            expect().assertFail();
            done();
          }
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0210 failed, error is" + JSON.stringify(err));
        expect("401").assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0220
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 129 bytes customDir:Multi-level directory getRdbStore test promise
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0220', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/ttst/tee00/11/tee2288000000/#% 0t00/" +
          "123323vjkdfn/48378498/nvnvnvn/88999/vvbbb/nvjdnvj/78"
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
          expect().assertFail();
          done();
        }).catch((err:BusinessError) => {
          console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
          expect().assertFail();
          done();
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0220 failed, error is" + JSON.stringify(err));
        expect("401").assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0230
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 129 bytes customDir:Single level directory  getRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0230', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "dataappel66teeeeeeeee67eeeehfghfgheeeeeeeee!@#@$$#%%(*  (eeee9988711ssssssssss+_)" +
          "25555555555555hfhfg55gggggghgfhhhfghfghgfhfhfgh5"
      }
      try {
        data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
          if (err == null) {
            expect().assertFail();
            done();
          } else {
            console.info(TAG + `Get RdbStore failed, code is"+${err.code}+"message is"+${err.message}`)
            expect().assertFail();
            done();
          }
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0230 failed, error is" + JSON.stringify(err));
        expect("401").assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0240
     * @tc.name : customDir
     * @tc.desc : RelationalStore store Sandbox Path 129 bytes customDir:Single level directory  getRdbStore test promise
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0240', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "dataappel66teeeeeeeee67eeeehfghfgheeeeeeeee!@#@$$#%%(*  (eeee9988711ssssssssss+_)" +
          "25555555555555hfhfg55gggggghgfhhhfghfghgfhfhfgh5"
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
          expect().assertFail();
          done();
        }).catch((err:BusinessError) => {
          console.info(`Get RdbStore failed,code is ${err.code}, message is ${err.message}`);
          expect().assertFail();
          done();
        })
      } catch (err) {
        console.info(TAG + "SUB_RelationalStore_customDir_Func_0240 failed, error is" + JSON.stringify(err));
        expect("401").assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0250
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir:"/*"  getRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0250', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "/data/app/el2/100/database/bundleName/rdb/testrdb/test/rdb"
      }
      try {
        data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, store) => {
          if (err) {
            console.error(TAG + "catch err: Get RdbStore failed, err: code=" + err.code + " message=" + err.message)
            done()
            expect().assertFail()
          } else {
            done()
            expect().assertFail()
          }
        })
      } catch (err) {
        console.error(TAG + "catch err:  code=" + err.code + " message=" + err.message);
        expect("401").assertEqual(err.code);
        done()
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0260
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir:"/*"  getRdbStore test promise
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0260', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "/data/app/el2/100/database/bundleName/rdb/testrdb/test/rdb"
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG).then(async (rdbStore) => {
          expect().assertFail();
          done()
        }).catch((err: BusinessError) => {
          console.info(TAG + `Get RdbStore failed, err: code= ${err.code}, message = ${err.message}`);
          expect().assertFail()
          done()
        })
      } catch (err) {
        console.info(TAG, "catch err: Get RdbStore failed, err: code=" + err.code + " message=" + err.message);
        expect("401").assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0270
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir:"/*"  deleteRdbStore test callback
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0270', 0, async (done: Function) => {
      const STORE_CONFIG1: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "/*"
      }
      try {
        data_Rdb.deleteRdbStore(context, STORE_CONFIG1, async (err) => {
          if (err) {
            console.error(TAG + `Delete RdbStore failed, code is ${err.code},message is ${err.message}`);
            expect().assertFail()
            done()
          } else {
            expect().assertFail()
            done()
          }
        })
      } catch (err) {
        console.error(TAG + `Delete RdbStore failed, code is ${err.code},message is ${err.message}`);
        expect("401").assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0280
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir:"/*"  deleteRdbStore test promise
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0280', 0, async (done: Function) => {
      const STORE_CONFIG1: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "/*"
      }
      try {
        await data_Rdb.deleteRdbStore(context, STORE_CONFIG1).then(() => {
          console.info(TAG + "Delete RdbStore successfully");
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.info(TAG + "Delete RdbStore failed" + err.code + err.message);
          expect().assertFail()
          done();
        })
      } catch (err) {
        console.info(TAG + "Delete RdbStore failed" + err.code + err.message);
        expect("401").assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0290
     * @tc.name : customDir
     * @tc.desc : RelationalStore store customDir is not a file getRdbStore test
     * @tc.level : Level 2
     */
    it('SUB_RelationalStore_customDir_Func_0290', 0, async (done: Function) => {
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "abc.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/abc.db"
      }
      try {
        let rdbStore = await data_Rdb.getRdbStore(context, STORE_CONFIG);
        await rdbStore.executeSql(CREATE_TABLE_TEST, null);
        await data_Rdb.deleteRdbStore(context, STORE_CONFIG);
      } catch (e) {
        expect().assertFail();
        done();
      }
      const STORE_CONFIG1: data_Rdb.StoreConfig = {
        name: "abc.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb"
      }
      try {
        let rdbStore = await data_Rdb.getRdbStore(context, STORE_CONFIG1);
        await rdbStore.executeSql(CREATE_TABLE_TEST, null);
        await data_Rdb.deleteRdbStore(context, STORE_CONFIG1);
        expect().assertFail();
        done();
      } catch (err) {
        console.info(TAG + "Delete RdbStore failed" + err.code + err.message);
        expect(14800030).assertEqual(err.code);
        done();
      }
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0300
     * @tc.name : customDir
     * @tc.desc : RelationalStore store backup and restore callback test
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0300', 0, async (done: Function) => {
      let backupName = "BackupTest003.db"
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore4.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/rdb/test/rdbStore1.db"
      }

      let store = await data_Rdb.getRdbStore(context, STORE_CONFIG)
      expect(store != null).assertTrue()
      store.executeSql(CREATE_TABLE_TEST, null)
      let u8 = new Uint8Array([1, 2, 3])
      const valueBucket: data_Rdb.ValuesBucket = {
        "name": "zhangsan",
        "age": 18,
        "salary": 100.5,
        "blobType": u8,
      }
      let ret = await store.insert("test", valueBucket)
      expect(1).assertEqual(ret)
      store.backup(backupName, async (err) => {
        if (err) {
          expect().assertFail()
          done()
        } else {
          console.info('Backup success.')
          await data_Rdb.deleteRdbStore(context, STORE_CONFIG)
          store.restore(backupName, async (err) => {
            if (err) {
              expect().assertFail()
              done()
            } else {
              console.info('restore success.')
              let predicates = new data_Rdb.RdbPredicates("test")
              let resultSet = await store.query(predicates)
              expect(true).assertEqual(resultSet.goToFirstRow())
              const id = resultSet.getLong(resultSet.getColumnIndex("id"))
              const name = resultSet.getString(resultSet.getColumnIndex("name"))
              const age = resultSet.getLong(resultSet.getColumnIndex("age"))
              const salary = resultSet.getDouble(resultSet.getColumnIndex("salary"))
              const blobType = resultSet.getBlob(resultSet.getColumnIndex("blobType"))
              console.info(TAG + "id=" + id + ", name=" + name + ", age=" + age +
               ", salary=" + salary + ", blobType=" + blobType)
              expect(1).assertEqual(id)
              expect("zhangsan").assertEqual(name)
              expect(18).assertEqual(age)
              expect(100.5).assertEqual(salary)
              expect(1).assertEqual(blobType[0])
              expect(2).assertEqual(blobType[1])
              expect(3).assertEqual(blobType[2])
              expect(false).assertEqual(resultSet.goToNextRow())
              resultSet.close()
              data_Rdb.deleteRdbStore(context, STORE_CONFIG)
              done()
            }
          })
        }
      })
    })

    /**
     * @tc.number : SUB_RelationalStore_customDir_Func_0310
     * @tc.name : customDir
     * @tc.desc : RelationalStore getrdbStore-deleteRdbStore-getrdbStore test callback
     * @tc.level : Level 0
     */
    it('SUB_RelationalStore_customDir_Func_0310', 0, async (done: Function) => {
      let Result = false
      const STORE_CONFIG: data_Rdb.StoreConfig = {
        name: "rdbStore.db",
        securityLevel: data_Rdb.SecurityLevel.S1,
        customDir: "data/app/el2/100/database/bundleName/test"
      }
      try {
        await data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
          if (!err) {
            console.info('getRdbStore 1st STORE_CONFIG success.')
            rdbStore.executeSql(CREATE_TABLE_TEST, null)
            Result = true
            data_Rdb.deleteRdbStore(context, STORE_CONFIG, async (err) => {
              if (!err) {
                console.info('deleteRdbStore 1st STORE_CONFIG success.')
                Result = false
                await data_Rdb.getRdbStore(context, STORE_CONFIG, async (err, rdbStore) => {
                  if (!err) {
                    console.info('getRdbStore 2ed STORE_CONFIG success.')
                    Result = true
                    data_Rdb.deleteRdbStore(context, STORE_CONFIG, async (err) => {
                      if (!err) {
                        console.info('deleteRdbStore 2ed STORE_CONFIG success.')
                        Result = false
                        expect(Result).assertFalse()
                        done()
                      } else {
                        console.info(TAG + "deleteRdbStore 2ed catch err:  code=" + err.code +
                         " message=" + err.message)
                        expect().assertFail()
                        done()
                      }
                    })
                  } else {
                    console.info(TAG + "getRdbStore 2ed catch err:  code=" + err.code + " message=" + err.message)
                    expect().assertFail()
                    done()
                  }
                })
              } else {
                console.info(TAG + "deleteRdbStore 1st catch err:  code=" + err.code + " message=" + err.message)
                expect().assertFail()
                done()
              }
            })
          } else {
            console.info(TAG + "getRdbStore 1st catch err:  code=" + err.code + " message=" + err.message)
            expect().assertFail()
            done()
          }
        })
      } catch (err) {
        console.info(TAG + "catch err:  code=" + err.code + " message=" + err.message)
        expect().assertFail()
        done()
      }
    })
  })
}