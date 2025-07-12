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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import data_relationalStore from '@ohos.data.relationalStore'
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@kit.BasicServicesKit';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();

const TAG = "[RDB_ENCRYPT_TEST]";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function rdbstoreEncryptTest() {
  describe('rdbstoreEncryptTest', () => {
    beforeAll(async () => {
      await sleep(3000);
      console.info(TAG + 'beforeAll');
      console.info(TAG + 'Get context successful. context=' + context);
    });

    beforeEach(async () => {
      await sleep(300);
      console.info(TAG + 'beforeEach');
    });

    afterEach(async () => {
      console.info(TAG + 'afterEach');
      await data_relationalStore.deleteRdbStore(context, "nondefault.db");
      await sleep(300);
    });

    afterAll(async () => {
      console.info(TAG + 'afterAll');
      await sleep(3000);
    });
    console.log(TAG + "*************Unit Test Begin*************");

    /**
     * @tc.name RdbEncryptTest_0010
     * @tc.number SUB_DDM_RDB_RdbEncryptTest_0010
     * @tc.desc RDB create encrypt db test
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('RdbEncryptTest_0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      console.log(TAG + "************* RdbEncryptTest_0010 start *************")
      let STORE_CONFIG_NON_DEFAULT: data_relationalStore.StoreConfig = {
        name: "nondefault.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
        encrypt: true,
        cryptoParam: {
          encryptionKey: new Uint8Array('testkey'.split('').map(it => it.charCodeAt(0))),
          iterationCount: 25000,
          encryptionAlgo: data_relationalStore.EncryptionAlgo.AES_256_CBC,
          hmacAlgo: data_relationalStore.HmacAlgo.SHA512,
          kdfAlgo: data_relationalStore.KdfAlgo.KDF_SHA512,
          cryptoPageSize: 2048
        }
      }
      let storePromise = data_relationalStore.getRdbStore(context, STORE_CONFIG_NON_DEFAULT);
      storePromise.then(async (store) => {
        try {
          console.log(TAG + "getRdbStore done: " + store);
        } catch (err) {
          expect(null).assertFail();
        }
      }).catch((err: BusinessError<null>) => {
        expect(null).assertFail();
      })
      await storePromise
      console.log(TAG + "************* RdbEncryptTest_0010 end *************")
    })

    /**
     * @tc.name RdbEncryptTest_0020
     * @tc.number SUB_DDM_RDB_RdbEncryptTest_0020
     * @tc.desc RDB create unencrypted db test
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('RdbEncryptTest_0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      console.log(TAG + "************* RdbEncryptTest_0020 start *************")
      let STORE_CONFIG_NON_DEFAULT: data_relationalStore.StoreConfig = {
        name: "nondefault.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
        encrypt: true,
        cryptoParam: {
          encryptionKey: new Uint8Array('testkey'.split('').map(it => it.charCodeAt(0))),
          iterationCount: 10000,
          encryptionAlgo: data_relationalStore.EncryptionAlgo.AES_256_CBC,
          hmacAlgo: data_relationalStore.HmacAlgo.SHA512,
          kdfAlgo: data_relationalStore.KdfAlgo.KDF_SHA512,
          cryptoPageSize: 1024
        }
      }
      let storePromise = data_relationalStore.getRdbStore(context, STORE_CONFIG_NON_DEFAULT);
      storePromise.then(async (store) => {
        try {
          console.log(TAG + "getRdbStore done: " + store);
        } catch (err) {
          expect(null).assertFail();
        }
      }).catch((err: BusinessError<null>) => {
        expect(null).assertFail();
      })
      await storePromise;
      console.log(TAG + "************* RdbEncryptTest_0020 end *************")
    })

    /**
     * @tc.name RdbDecryptTest_0030
     * @tc.number SUB_DDM_RDB_RdbDecryptTest_0030
     * @tc.desc RDB decrypt function invalid iteration config test
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('RdbDecryptTest_0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      console.info(TAG + "************* RdbDecryptTest_0030 start *************")
      let invalid_iter_config: data_relationalStore.StoreConfig = {
        name: "nondefault.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
        encrypt: true,
        cryptoParam: {
          encryptionKey: new Uint8Array('testkey'.split('').map(it => it.charCodeAt(0))),
          iterationCount: -1,
          encryptionAlgo: data_relationalStore.EncryptionAlgo.AES_256_CBC,
          hmacAlgo: data_relationalStore.HmacAlgo.SHA512,
          kdfAlgo: data_relationalStore.KdfAlgo.KDF_SHA512,
          cryptoPageSize: 2048
        }
      }
      try {
        let rdbStore = await data_relationalStore.getRdbStore(context, invalid_iter_config)
        expect().assertFail()
      } catch (err) {
        console.error(`Invalid iter config, error code: ${err.code}, err message: ${err.message}`);
        expect("401").assertEqual(err.code)
      }
      console.info(TAG + "************* RdbDecryptTest_0030 end *************")
    })

    /**
     * @tc.name RdbDecryptTest_0040
     * @tc.number SUB_DDM_RDB_RdbDecryptTest_0040
     * @tc.desc RDB decrypt function invalid algorithm config test
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('RdbDecryptTest_0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      console.info(TAG + "************* RdbDecryptTest_0040 start *************")
      let invalid_algo_config: data_relationalStore.StoreConfig = {
        name: "nondefault.db",
        securityLevel: data_relationalStore.SecurityLevel.S1,
        encrypt: true,
        cryptoParam: {
          encryptionKey: new Uint8Array('testkey'.split('').map(it => it.charCodeAt(0))),
          iterationCount: 25000,
          encryptionAlgo: data_relationalStore.EncryptionAlgo.AES_256_CBC + 1,
          hmacAlgo: data_relationalStore.HmacAlgo.SHA512,
          kdfAlgo: data_relationalStore.KdfAlgo.KDF_SHA512,
          cryptoPageSize: 2048
        }
      }
      try {
        let rdbStore = await data_relationalStore.getRdbStore(context, invalid_algo_config)
        expect().assertFail()
      } catch (err) {
        console.error(`Invalid algorithm config, error code: ${err.code}, err message: ${err.message}`);
        expect("401").assertEqual(err.code)
      }
      console.info(TAG + "************* RdbDecryptTest_0040 end *************")
    })
    
    console.log(TAG + "*************Unit Test End*************");
  })
}