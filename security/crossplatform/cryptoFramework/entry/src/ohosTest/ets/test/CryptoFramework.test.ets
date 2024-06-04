/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import cryptoFramework from "@ohos.security.cryptoFramework";
import { BusinessError } from '@ohos.base';
import {
  symKeyGenerator,
  asyKeyGenerator,
  KeyPairGenPromise,
  convertKeyGenPromise,
  input1,
  input2,
  rsaGenerator,
  asyKeyPairSpec,
  asyKeyGeneratorBySpec,
  priKeyGenPromise,
  pubKeyGenPromise,
  cipher,
  signer
} from '../utils/common/CommonVariables';

/**
 * Thread sleeps
 */
function sleep(ms: number = 1000): Promise<void> {
  return new Promise((resolve: Function) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}

function stringToUint8Array(str: string) {
  let arr: Uint8Array = new Uint8Array(str.length);
  for (let i: number = 0, j: number = str.length; i < j; ++i) {
    arr[i] = str.charCodeAt(i);
  }
  return arr;
}

function getDataBlob(): cryptoFramework.DataBlob {
  const arr: number[] = [
    0xba, 0x3d, 0xc2, 0x71, 0x21, 0x1e, 0x30, 0x56,
    0xad, 0x47, 0xfc, 0x5a, 0x46, 0x39, 0xee, 0x7c,
    0xba, 0x3b, 0xc2, 0x71, 0xab, 0xa0, 0x30, 0x72]; // keyLen = 192 (24 bytes)
  const keyMaterial: Uint8Array = new Uint8Array(arr);
  const keyMaterialBlob: cryptoFramework.DataBlob = {
    data: keyMaterial
  };
  return keyMaterialBlob;
}

export default function cryptoFrame() {
  describe('CryptoFrame', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    });
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    });
    afterEach(async () => {
      await sleep(200);
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    });
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Result_Enum_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Result_Enum_0100
     * @tc.desc      : An enumeration that represents the result of an execution
     * @tc.size      : MediumTest
     * @tc.type      : Func
     * @tc.level     : Level 0
     */
    it('SUB_Security_Crypto_Framework_Result_Enum_0100', 0, async () => {
      expect(cryptoFramework.Result.INVALID_PARAMS === 401).assertTrue();
      expect(cryptoFramework.Result.NOT_SUPPORT === 801).assertTrue();
      expect(cryptoFramework.Result.ERR_OUT_OF_MEMORY === 17620001).assertTrue();
      expect(cryptoFramework.Result.ERR_RUNTIME_ERROR === 17620002).assertTrue();
      expect(cryptoFramework.Result.ERR_CRYPTO_OPERATION === 17630001).assertTrue();
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Crypto_Mode_Enum_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Crypto_Mode_Enum_0100
     * @tc.desc      : An enumeration that represents the result of an execution
     * @tc.size      : MediumTest
     * @tc.type      : Func
     * @tc.level     : Level 0
     */
    it('SUB_Security_Crypto_Framework_Crypto_Mode_Enum_0100', 0, async () => {
      expect(cryptoFramework.CryptoMode.ENCRYPT_MODE === 0).assertTrue();
      expect(cryptoFramework.CryptoMode.DECRYPT_MODE === 1).assertTrue();
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKey_SpecItem_Enum_0100
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKey_SpecItem_Enum_0100
     * @tc.desc      : An enumeration that represents the result of an execution
     * @tc.size      : MediumTest
     * @tc.type      : Func
     * @tc.level     : Level 0
     */
    it('SUB_Security_Crypto_Framework_AsyKey_SpecItem_Enum_0100', 0, async () => {
      expect(cryptoFramework.AsyKeySpecItem.DSA_P_BN === 101).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.DSA_Q_BN === 102).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.DSA_G_BN === 103).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.DSA_SK_BN === 104).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.DSA_PK_BN === 105).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_FP_P_BN === 201).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_A_BN === 202).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_B_BN === 203).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_G_X_BN === 204).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_G_Y_BN === 205).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_N_BN === 206).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_H_NUM === 207).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_SK_BN === 208).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_PK_X_BN === 209).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_PK_Y_BN === 210).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_FIELD_TYPE_STR === 211).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_FIELD_SIZE_NUM === 212).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.ECC_CURVE_NAME_STR === 213).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.RSA_N_BN === 301).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.RSA_SK_BN === 302).assertTrue();
      expect(cryptoFramework.AsyKeySpecItem.RSA_PK_BN === 303).assertTrue();
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKey_SpecType_Enum_0100
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKey_SpecType_Enum_0100
     * @tc.desc      : An enumeration that represents the result of an execution
     * @tc.size      : MediumTest
     * @tc.type      : Enum
     * @tc.level     : Level 0
     */
    it('SUB_Security_Crypto_Framework_AsyKey_SpecType_Enum_0100', 0, async () => {
      expect(cryptoFramework.AsyKeySpecType.COMMON_PARAMS_SPEC === 0).assertTrue();
      expect(cryptoFramework.AsyKeySpecType.PRIVATE_KEY_SPEC === 1).assertTrue();
      expect(cryptoFramework.AsyKeySpecType.PUBLIC_KEY_SPEC === 2).assertTrue();
      expect(cryptoFramework.AsyKeySpecType.KEY_PAIR_SPEC === 3).assertTrue();
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Cipher_SpecItem_Enum_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Cipher_SpecItem_Enum_0100
     * @tc.desc      : An enumeration that represents the result of an execution
     * @tc.size      : MediumTest
     * @tc.type      : Enum
     * @tc.level     : Level 0
     */
    it('SUB_Security_Crypto_Framework_Cipher_SpecItem_Enum_0100', 0, async () => {
      expect(cryptoFramework.CipherSpecItem.OAEP_MD_NAME_STR === 100).assertTrue();
      expect(cryptoFramework.CipherSpecItem.OAEP_MGF_NAME_STR === 101).assertTrue();
      expect(cryptoFramework.CipherSpecItem.OAEP_MGF1_MD_STR === 102).assertTrue();
      expect(cryptoFramework.CipherSpecItem.OAEP_MGF1_PSRC_UINT8ARR === 103).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_MD_NAME_STR === 100).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_MGF_NAME_STR === 101).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_MGF1_MD_STR === 102).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM === 103).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_TRAILER_FIELD_NUM === 104).assertTrue();
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Sign_SpecItem_Enum_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Sign_SpecItem_Enum_0100
     * @tc.desc      : An enumeration that represents the result of an execution
     * @tc.size      : MediumTest
     * @tc.type      : Enum
     * @tc.level     : Level 0
     */
    it('SUB_Security_Crypto_Framework_Sign_SpecItem_Enum_0100', 0, async () => {
      expect(cryptoFramework.SignSpecItem.PSS_MD_NAME_STR === 100).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_MGF_NAME_STR === 101).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_MGF1_MD_STR === 102).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM === 103).assertTrue();
      expect(cryptoFramework.SignSpecItem.PSS_TRAILER_FIELD_NUM === 104).assertTrue();
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Get_Encoded_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Get_Encoded_Func_0100
     * @tc.desc      : A byte steam that gets the key data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Get_Encoded_Func_0100', 0, async () => {
      symKeyGenerator.generateSymKey((err, key) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_Get_Encoded_Func_0100 failed, ${err.code}, ${err.message}`);
          expect(false).assertTrue();
        } else {
          let encodedKey: cryptoFramework.DataBlob = key.getEncoded();
          console.info(`SUB_Security_Crypto_Framework_Get_Encoded_Func_0100 key blob: ${JSON.stringify(encodedKey.data)}`);
          expect(encodedKey.data instanceof Uint8Array).assertTrue();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_SymKey_ClearMem_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_SymKey_ClearMem_Func_0100
     * @tc.desc      : Zeros out the key content in the underlying memory of the system
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_SymKey_ClearMem_Func_0100', 0, async () => {
      symKeyGenerator.generateSymKey((err: BusinessError, key: cryptoFramework.SymKey) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_SymKey_ClearMem_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          let encodedKey: cryptoFramework.DataBlob = key.getEncoded();
          console.info(`SUB_Security_Crypto_Framework_SymKey_ClearMem_Func_0100 encodedKey before clearMem: ${JSON.stringify(encodedKey.data)}`); // Display key content.
          key.clearMem();
          encodedKey = key.getEncoded();
          console.info(`SUB_Security_Crypto_Framework_SymKey_ClearMem_Func_0100 encodedKey after clearMem: ${JSON.stringify(encodedKey.data)}`); // Display all 0s. 00 0 0 0 0 0 0 000
          expect(encodedKey.data.every((item: number) => item === 0)).assertTrue();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_PubKey_Get_AsyKey_Spec_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_PubKey_Get_AsyKey_Spec_Func_0100
     * @tc.desc      : The public key,which is a subclass of the key
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_PubKey_Get_AsyKey_Spec_Func_0100', 0, async () => {
      asyKeyGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_PubKey_Get_AsyKey_Spec_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          let p: string | number | bigint = keyPair.pubKey.getAsyKeySpec(cryptoFramework.AsyKeySpecItem.ECC_FP_P_BN);
          expect(p).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_PriKey_ClearMem_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_PriKey_ClearMem_Func_0100
     * @tc.desc      : Synchronization method,which clears the key content in the underlying memory of the system
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_PriKey_ClearMem_Func_0100', 0, async () => {
      asyKeyGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_PriKey_ClearMem_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          const priKey: cryptoFramework.PriKey = keyPair.priKey;
          let encodedKey: cryptoFramework.DataBlob = priKey.getEncoded();
          console.info(`SUB_Security_Crypto_Framework_PriKey_ClearMem_Func_0100 encodedKey before clearMem: ${JSON.stringify(encodedKey.data)}`);
          /* For the asymmetric private key, clearMem() releases the internal key struct. After clearMem is executed, getEncoded() is not supported. */
          priKey.clearMem();
          expect(priKey).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_PriKey_Get_AsyKey_Spec_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_PriKey_Get_AsyKey_Spec_Func_0100
     * @tc.desc      : Synchronization method,Obtain the key
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_PriKey_Get_AsyKey_Spec_Func_0100', 0, async () => {
      asyKeyGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_PriKey_Get_AsyKey_Spec_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          let p: string | number | bigint = keyPair.priKey.getAsyKeySpec(cryptoFramework.AsyKeySpecItem.ECC_FP_P_BN);
          expect(p).not().assertNull();
        }
      });

    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_SymKeyGenerator_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_SymKeyGenerator_Func_0100
     * @tc.desc      : Obtain the corresponding cipher instance
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_SymKeyGenerator_Func_0100', 0, async () => {
      try {
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('3DES192');
        expect(symKeyGenerator).not().assertNull();
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Create_SymKeyGenerator_Func_0100 failed, catch error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0100
     * @tc.desc      : get a randomly generated key from the symmetric key generator through callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0100', 0, async () => {
      symKeyGenerator.generateSymKey((err: BusinessError, symKey: cryptoFramework.SymKey) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(symKey.algName).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0200
     * @tc.desc      : Asynchronously obtains the key randomly generated by the symmetric key generator through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0200', 0, async () => {
      symKeyGenerator.generateSymKey()
        .then(symKey => {
          expect(symKey.algName).not().assertNull();
        }, (error: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_SymKeyGenerator_GenerateSymKey_Func_0200 failed, error code: ${error.code}, ,msg: ${error.message}`);
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0100
     * @tc.desc      : Asynchronously generates a symmetric key based on the specified data by callback function
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0100', 0, async () => {
      let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
      symKeyGenerator.convertKey(keyMaterialBlob, (err: BusinessError, symKey: cryptoFramework.SymKey) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(symKey.algName).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0200
     * @tc.desc      : Asynchronously generates a symmetric key base on the specified data through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0200', 0, async () => {
      let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
      symKeyGenerator.convertKey(keyMaterialBlob)
        .then((symKey: cryptoFramework.SymKey) => {
          expect(symKey.algName).not().assertNull();
        }, (error: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_SymKeyGenerator_ConvertKey_Func_0200 failed, error code: ${error.code}, msg: ${error.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_Func_0100
     * @tc.desc      : Specify the algorithm name to obtain the corresponding cipher instance
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_Func_0100', 0, async () => {
      try {
        let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("ECC256");
        expect(asyKeyGenerator).not().assertNull();
      } catch (error) {
        console.error(`SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_Func_0100 failed ,error code: ${error.code}, msg: ${error.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0100
     * @tc.desc      : Asynchronously obtains a randomly generated key from an asymmetric key generator through callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0100', 0, async () => {
      asyKeyGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(keyPair).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0200
     * @tc.desc      : Asynchronously obtains the key generated by the asymmetric key generator through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0200', 0, async () => {
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        expect(keyPair).not().assertNull();
      }).catch((error: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_AsyKeyGenerator_GenerateKeyPair_Func_0200 failed, error code: ${error.code}, msg: ${error.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0100
     * @tc.desc      : Asynchronously obtains the key generated by the asymmetric key generator by callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0100', 0, async () => {
      let pubKeyArray: Uint8Array = new Uint8Array([48, 89, 48, 19, 6, 7, 42, 134, 72, 206, 61, 2, 1, 6, 8, 42, 134, 72, 206, 61, 3, 1, 7, 3, 66, 0, 4, 83, 96, 142, 9, 86, 214, 126, 106, 247, 233, 92, 125, 4, 128, 138, 105, 246, 162, 215, 71, 81, 58, 202, 121, 26, 105, 211, 55, 130, 45, 236, 143, 55, 16, 248, 75, 167, 160, 167, 106, 2, 152, 243, 44, 68, 66, 0, 167, 99, 92, 235, 215, 159, 239, 28, 106, 124, 171, 34, 145, 124, 174, 57, 92]);
      let priKeyArray: Uint8Array = new Uint8Array([48, 49, 2, 1, 1, 4, 32, 115, 56, 137, 35, 207, 0, 60, 191, 90, 61, 136, 105, 210, 16, 27, 4, 171, 57, 10, 61, 123, 40, 189, 28, 34, 207, 236, 22, 45, 223, 10, 189, 160, 10, 6, 8, 42, 134, 72, 206, 61, 3, 1, 7]);
      let pubKeyBlob: cryptoFramework.DataBlob = {
        data: pubKeyArray
      }; // Data of the public key.
      let priKeyBlob: cryptoFramework.DataBlob = {
        data: priKeyArray
      }; // Data of the private key.
      asyKeyGenerator.convertKey(pubKeyBlob, priKeyBlob, (err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(keyPair).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0200
     * @tc.desc      : Asynchronously obtains the key generated by the asymmetric key generator by promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0200', 0, async () => {
      convertKeyGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        expect(keyPair).not().assertNull();
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_AsyKeyGenerator_ConvertKey_Func_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_By_Spec_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_By_Spec_Func_0100
     * @tc.desc      : obtain the corresponding cipher instance
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_By_Spec_Func_0100', 0, async () => {
      try {
        let asyKeyGeneratorBySpec: cryptoFramework.AsyKeyGeneratorBySpec = cryptoFramework.createAsyKeyGeneratorBySpec(asyKeyPairSpec);
        expect(asyKeyGeneratorBySpec).not().assertNull();
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Create_AsyKeyGenerator_By_Spec_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0100
     * @tc.desc      : Asynchronously obtains the key through callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0100', 0, async () => {
      asyKeyGeneratorBySpec.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(keyPair).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0200
     * @tc.desc      : Asynchronous acquisition of the key generated by the asymmetric key generator by promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0200', 0, async () => {
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        expect(keyPair).not().assertNull();
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GenerateKeyPair_Func_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0100
     * @tc.desc      : Asynchronous acquisition of keys generated by asymmetric key generators by callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0100', 0, async () => {
      asyKeyGeneratorBySpec.generatePriKey((err: BusinessError, priKey: cryptoFramework.PriKey) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(priKey).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0200
     * @tc.desc      : Asynchronously obtains the key generated by the asymmetric key generator by promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0200', 0, async () => {
      priKeyGenPromise.then((priKey: cryptoFramework.PriKey) => {
        expect(priKey).not().assertNull();
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePriKey_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0100
     * @tc.desc      : Asynchronously obtains the key generated by the asymmetric key generator by callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0100', 0, async () => {
      asyKeyGeneratorBySpec.generatePubKey((err, pubKey) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(pubKey).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0200
     * @tc.desc      : Asynchronously obtains the key generated by the asymmetric key generator through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0200', 0, async () => {
      pubKeyGenPromise.then((pubKey: cryptoFramework.PubKey) => {
        expect(pubKey).not().assertNull();
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_AsyKeyGeneratorBySpec_GeneratePubKey_Func_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_Cipher_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_Cipher_Func_0100
     * @tc.desc      : You can specify an algorithm name to obtain the Cipher instance.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_Cipher_Func_0100', 0, async () => {
      let cipherAlgName: string = '3DES192|ECB|PKCS7';
      try {
        let cipher: cryptoFramework.Cipher = cryptoFramework.createCipher(cipherAlgName);
        expect(cipher.algName).not().assertNull();
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Create_Cipher_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Cipher_Init_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Cipher_Init_Func_0100
     * @tc.desc      : The cipher object for encryption and decryption is initialized and the result is obtained by registering the callback function.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Cipher_Init_Func_0100', 0, async () => {
      symKeyGenerator.generateSymKey((err: BusinessError, symKey: cryptoFramework.SymKey) => {
        cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, null, (err) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Cipher_Init_Func_0100 Failed, error code: ${err.code}, msg: ${err.message}`);
            expect(err.code == 401).assertTrue();
          } else {
            expect(err).assertUndefined();
          }
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Cipher_Init_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Cipher_Init_Func_0200
     * @tc.desc      : The cipher object for encryption and decryption is initialized and the result is obtained using a Promise.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Cipher_Init_Func_0200', 0, async () => {
      symKeyGenerator.generateSymKey((err: BusinessError, symKey: cryptoFramework.SymKey) => {
        cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, null)
          .then(() => {
            expect(symKey).not().assertNull();
            console.info(`SUB_Security_Crypto_Framework_Cipher_Init_Func_0200 success`);
          }, (error: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Cipher_Init_Func_0200 failed, error code: ${error.code}, msg: ${error.message}`);
            expect(error.code == 401).assertTrue();
          });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Cipher_Update_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Cipher_Update_Func_0100
     * @tc.desc      : Segmenting updates encrypting or decrypting data operations by registering callback functions to obtain add/decrypt data.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Cipher_Update_Func_0100', 0, async () => {
      symKeyGenerator.generateSymKey((err: BusinessError, symKey: cryptoFramework.SymKey) => {
        let str: string = 'this is test!';
        let plainText: cryptoFramework.DataBlob = {
          data: stringToUint8Array(str)
        };
        cipher.update(plainText, (err: BusinessError, output: cryptoFramework.DataBlob) => { // Example of the encryption process.
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Cipher_Update_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
            expect(err.code == 801).assertTrue();
          } else {
            console.info(`Update cipher success`);
            expect(output).not().assertNull();
          }
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Cipher_Update_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Cipher_Update_Func_0200
     * @tc.desc      : Piecewise updates encrypt or decrypt data operations to get add/decrypt data through Promises
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Cipher_Update_Func_0200', 0, async () => {
      symKeyGenerator.generateSymKey((err: BusinessError, symKey: cryptoFramework.SymKey) => {
        let str: string = 'this is test!';
        let plainText: cryptoFramework.DataBlob = {
          data: stringToUint8Array(str)
        };
        cipher.update(plainText)
          .then((output: cryptoFramework.DataBlob) => {
            expect(output).not().assertNull();
          }, (error: BusinessError) => {
            console.info(`SUB_Security_Crypto_Framework_Cipher_Update_Func_0200 failed, error code: ${error.code}, msg: ${error.message}`);
            expect(err.code == 801).assertTrue();
          });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0100
     * @tc.desc      : Piecewise updates encrypt or decrypt data operations to get add/decrypt data through callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0100', 0, async () => {
      let rsaGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      let cipher: cryptoFramework.Cipher = cryptoFramework.createCipher("RSA1024|PKCS1");
      rsaGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        let pubKey: cryptoFramework.PubKey = keyPair.pubKey;
        cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, pubKey, null, (err: BusinessError) => {
          let plainText: string = "this is cipher text";
          let input: cryptoFramework.DataBlob = {
            data: stringToUint8Array(plainText)
          };
          cipher.doFinal(input, (err: BusinessError, data: cryptoFramework.DataBlob) => {
            if (err) {
              console.error(`SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0100 failed, error code: ${err.code}, msg: ${err.message}`);
              expect(false).assertTrue();
            } else {
              expect(data.data).not().assertNull();
            }
          });
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0200
     * @tc.desc      : In symmetric encryption and decryption, doFinal adds/decrypts the remaining data (generated by the grouping mode) and the incoming data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0200', 0, async () => {
      let rsaGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      let cipher: cryptoFramework.Cipher = cryptoFramework.createCipher("RSA1024|PKCS1");
      rsaGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        let pubKey: cryptoFramework.PubKey = keyPair.pubKey;
        cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, pubKey, null, (err: BusinessError) => {
          let plainText: string = "this is cipher text";
          let input: cryptoFramework.DataBlob = {
            data: stringToUint8Array(plainText)
          };
          cipher.doFinal(input).then((data: cryptoFramework.DataBlob) => {
            expect(data.data).not().assertNull();
          }).catch((err: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Cipher_DoFinal_Func_0200 failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          });
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Set_Cipher_Spec_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Set_Cipher_Spec_0100
     * @tc.desc      : Set encryption and decryption parameters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Set_Cipher_Spec_0100', 0, async () => {
      try {
        let cipherAlgName: string = 'RSA2048|PKCS1_OAEP|SHA256|MGF1_SHA256';
        let cipher: cryptoFramework.Cipher = cryptoFramework.createCipher(cipherAlgName);
        let pSource: Uint8Array = new Uint8Array([1, 2, 3, 4]);
        cipher.setCipherSpec(cryptoFramework.CipherSpecItem.OAEP_MGF1_PSRC_UINT8ARR, pSource);
        let mdName: string | Uint8Array = cipher.getCipherSpec(cryptoFramework.CipherSpecItem.OAEP_MGF1_PSRC_UINT8ARR);
        console.log(`test mdName3` + mdName);
        expect(mdName).not().assertNull();
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Set_Cipher_Spec_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Get_Cipher_Spec_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Get_Cipher_Spec_0100
     * @tc.desc      : Get encryption and decryption parameters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Get_Cipher_Spec_0100', 0, async () => {
      try {
        let cipherAlgName: string = 'RSA2048|PKCS1_OAEP|SHA256|MGF1_SHA256';
        let cipher: cryptoFramework.Cipher = cryptoFramework.createCipher(cipherAlgName);
        let pSource: Uint8Array = new Uint8Array([1, 2, 3, 4]);
        cipher.setCipherSpec(cryptoFramework.CipherSpecItem.OAEP_MGF1_PSRC_UINT8ARR, pSource);
        let mdName: string | Uint8Array = cipher.getCipherSpec(cryptoFramework.CipherSpecItem.OAEP_MGF1_PSRC_UINT8ARR);
        console.log('test mdName3' + mdName);
        expect(mdName).not().assertNull();
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Get_Cipher_Spec_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_Sign_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_Sign_0100
     * @tc.desc      : Sign instance generation
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_Sign_0100', 0, async () => {
      try {
        expect(signer).not().assertNull();
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Create_Sign_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Sign_Init_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Sign_Init_0100
     * @tc.desc      : Initialize the Sign object with the private key through callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Sign_Init_0100', 0, async () => {
      rsaGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        let globalKeyPair: cryptoFramework.KeyPair = keyPair;
        let priKey: cryptoFramework.PriKey = globalKeyPair.priKey;
        signer.init(priKey, (err: BusinessError) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Sign_Init_0100 failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          } else {
            expect(err).assertUndefined();
          }
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Sign_Init_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Sign_Init_0200
     * @tc.desc      : Initialize the Sign object with the private key through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Sign_Init_0200', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let signMessageBlob: cryptoFramework.DataBlob;
      let plan1: string = "This is Sign test plan1";
      let plan2: string = "This is Sign test plan2";
      let input1: cryptoFramework.DataBlob = {
        data: stringToUint8Array(plan1)
      };
      let input2: cryptoFramework.DataBlob = {
        data: stringToUint8Array(plan2)
      };
      let rsaGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      let signer: cryptoFramework.Sign = cryptoFramework.createSign("RSA1024|PKCS1|SHA256");
      rsaGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_Sign_Init_0200 failed, error code: ${err.code},msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          globalKeyPair = keyPair;
          let priKey: cryptoFramework.PriKey = globalKeyPair.priKey;
          signer.init(priKey).then(() => {
            signer.update(input1, (e: BusinessError) => {
              signer.sign(input2, (err: BusinessError, data: cryptoFramework.DataBlob) => {
                if (err) {
                  console.error(`SUB_Security_Crypto_Framework_Sign_Init_0200 failed, error code: ${err.code}, msg: ${err.message}`);
                  expect(false).assertTrue();
                } else {
                  signMessageBlob = data;
                  expect(signMessageBlob.data).not().assertNull();
                }
              });
            });
          }).catch((error: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Sign_Init_0200 failed,catch error code: ${error.code},msg: ${error.message}`);
            expect(false).assertTrue();
          });
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Sign_Update_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Sign_Update_0100
     * @tc.desc      : Append data to be signed and update it by registering the callback function
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Sign_Update_0100', 0, async () => {
      rsaGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        let globalKeyPair: cryptoFramework.KeyPair = keyPair;
        let priKey: cryptoFramework.PriKey = globalKeyPair.priKey;
        signer.init(priKey, (err: BusinessError) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Sign_Update_0100 failed, error code: ${err.code}, msg: ${err.message}`);
            expect(err.code == 401).assertTrue();
          } else {
            signer.update(input1, (err: BusinessError) => {
              if (err) {
                console.error(`SUB_Security_Crypto_Framework_Sign_Update_0100 failed, error code: ${err.code}, msg: ${err.message}`);
                expect(false).assertTrue();
              } else {
                expect(err).assertUndefined();
                console.log('signer update success');
              }
            });
          }
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Sign_Update_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Sign_Update_0200
     * @tc.desc      : Initialize the Sign object with the private key through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Sign_Update_0200', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let signMessageBlob: cryptoFramework.DataBlob;
      let plan1: string = "This is Sign test plan1";
      let plan2: string = "This is Sign test plan2";
      let input1: cryptoFramework.DataBlob = {
        data: stringToUint8Array(plan1)
      };
      let input2: cryptoFramework.DataBlob = {
        data: stringToUint8Array(plan2)
      };
      let rsaGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      let signer = cryptoFramework.createSign("RSA1024|PKCS1|SHA256");
      rsaGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        globalKeyPair = keyPair;
        let priKey: cryptoFramework.PriKey = globalKeyPair.priKey;
        signer.init(priKey).then(() => {
          signer.update(input1).then(() => {
            signer.sign(input2, (err: BusinessError, data: cryptoFramework.DataBlob) => {
              if (err) {
                console.error(`SUB_Security_Crypto_Framework_Sign_Init_0200 failed, error code: ${err.code}, msg: ${err.message}`);
                expect(false).assertTrue();
              } else {
                signMessageBlob = data;
                expect(signMessageBlob.data).not().assertNull();
              }
            });
          });
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Sign_Sign_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Sign_Sign_0100
     * @tc.desc      : Sign the data by callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Sign_Sign_0100', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let signer: cryptoFramework.Sign = cryptoFramework.createSign("RSA1024|PKCS1|SHA256");
      rsaGenerator.generateKeyPair((err: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        globalKeyPair = keyPair;
        let priKey: cryptoFramework.PriKey = globalKeyPair.priKey;
        signer.init(priKey, (err: BusinessError) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Sign_Sign_0100 init failed, error code: ${err.code}, msg: ${err.message}`);
            expect(err.code == 401).assertTrue();
          } else {
            signer.update(input1, (err: BusinessError) => {
              if (err) {
                console.error(`SUB_Security_Crypto_Framework_Sign_Sign_0100 update failed, error code: ${err.code}, msg: ${err.message}`);
                expect(false).assertTrue();
              } else {
                signer.sign(input2, (err: BusinessError, dataBlob: cryptoFramework.DataBlob) => {
                  if (err) {
                    console.error(`SUB_Security_Crypto_Framework_Sign_Sign_0100 sign failed, error code: ${err.code}, msg: ${err.message}`);
                    expect(false).assertTrue();
                  } else {
                    expect(dataBlob.data).not().assertNull();
                  }
                });
              }
            });
          }
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Sign_Sign_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Sign_Sign_0200
     * @tc.desc      : Initialize the Sign object with the private key through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Sign_Sign_0200', 0, async () => {
      try {
        const signer: cryptoFramework.Sign = cryptoFramework.createSign("ECC256|SHA256");
        KeyPairGenPromise.then(async (keyPair: cryptoFramework.KeyPair) => {
          let priKey: cryptoFramework.PriKey = keyPair.priKey;
          await signer.init(priKey);
          await signer.update(input1);
          signer.sign(input2).then((dataBlob: cryptoFramework.DataBlob) => {
            expect(dataBlob.data).not().assertNull();
          }).catch((err: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Sign_Sign_0200 sign failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          });
        }).catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Sign_Sign_0200 asyKeyGenerator.generateKeyPair failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Sign_Sign_0200 failed, catch error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Set_Sign_Spec_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Set_Sign_Spec_0100
     * @tc.desc      : Set the signature parameters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Set_Sign_Spec_0100', 0, async () => {
      let setN: number = 20;
      try {
        signer.setSignSpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM, setN);
        let saltLen: string | number = signer.getSignSpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM);
        expect(saltLen).assertEqual(setN);
      } catch (e) {
        console.error(`SUB_Security_Crypto_Framework_Set_Sign_Spec_0100 failed, error code: ${e.code}, msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Get_Sign_Spec_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Get_Sign_Spec_0100
     * @tc.desc      : Set the signature parameters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Get_Sign_Spec_0100', 0, async () => {
      let setN: number = 40;
      try {
        signer.setSignSpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM, setN);
        let saltLen: string | number = signer.getSignSpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM);
        expect(saltLen).assertEqual(setN);
      } catch (e) {
        console.error(`SUB_Security_Crypto_Framework_Get_Sign_Spec_0100 failed, error code: ${e.code}, msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_Verify_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_Verify_0100
     * @tc.desc      : Verify instance generation
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_Verify_0100', 0, async () => {
      try {
        let verify_1: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");
        let verify_2: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PSS|SHA256|MGF1_SHA256");
        expect(verify_1).not().assertNull();
        expect(verify_2).not().assertNull();
      } catch (e) {
        console.error(`SUB_Security_Crypto_Framework_Create_Verify_0100 failed, error code: ${e.code}, msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Verify_Init_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Verify_Init_0100
     * @tc.desc      : Initialize the Verify object by passing in the public key through callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Verify_Init_0100', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      let KeyPairGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.generateKeyPair();
      KeyPairGenPromise.then(keyPair => {
        globalKeyPair = keyPair;
      }).then(() => {
        let verifier: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");
        verifier.init(globalKeyPair.pubKey, (err: BusinessError) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Verify_Init_0100 init failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          } else {
            expect(err).assertUndefined();
          }
        });
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_Verify_Init_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Verify_Init_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Verify_Init_0200
     * @tc.desc      : Initialize the Verify object by passing in the public key through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Verify_Init_0200', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      let KeyPairGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.generateKeyPair();
      KeyPairGenPromise.then(keyPair => {
        globalKeyPair = keyPair;
      }).then(() => {
        let verifier: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");
        verifier.init(globalKeyPair.pubKey).then(() => {
          expect(verifier.algName).not().assertNull();
        }).catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Verify_Init_0200 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_Verify_Init_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Verify_Update_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Verify_Update_0100
     * @tc.desc      : Add pending signature data and update it by registering a callback function
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Verify_Update_0100', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      let KeyPairGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.generateKeyPair();
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        globalKeyPair = keyPair;
      }).then(() => {
        let verify: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");
        verify.init(globalKeyPair.pubKey, (err: BusinessError) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Verify_Update_0100 init failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          } else {
            verify.update(input1, (err: BusinessError) => {
              if (err) {
                console.error(`SUB_Security_Crypto_Framework_Verify_Update_0100 update failed, error code: ${err.code}, msg: ${err.message}`);
                expect(false).assertTrue();
              } else {
                expect(err).assertUndefined();
              }
            });
          }
        });
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_Verify_Update_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Verify_Update_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Verify_Update_0200
     * @tc.desc      : Append the data to be verified through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Verify_Update_0200', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("RSA1024|PSS|SHA256|MGF1_SHA256");
      let KeyPairGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.generateKeyPair();
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        globalKeyPair = keyPair;
        return signer.init(keyPair.priKey);
      }).then(() => {
        let verify: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");
        verify.init(globalKeyPair.pubKey).then(() => {
          verify.update(input1).then(() => {
            expect(verify).not().assertNull();
          }).catch((err: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Verify_Update_0200 update failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          });
        }).catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Verify_Update_0200 init failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_Verify_Update_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Verify_Verify_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Verify_Verify_0100
     * @tc.desc      : Verify the data through callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Verify_Verify_0100', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("RSA1024|PSS|SHA256|MGF1_SHA256");
      let KeyPairGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.generateKeyPair();
      KeyPairGenPromise.then(keyPair => {
        globalKeyPair = keyPair;
        return signer.init(keyPair.priKey);
      })
        .then(() => {
          return signer.update(input1);
        })
        .then(() => {
          return signer.sign(input2);
        })
        .then(dataBlob => {
          let verify: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");
          verify.init(globalKeyPair.pubKey, (err: BusinessError) => {
            if (err) {
              console.error(`SUB_Security_Crypto_Framework_Verify_Verify_0100 init failed, error code: ${err.code}, msg: ${err.message}`);
              expect(false).assertTrue();
            } else {
              verify.update(input1, (err: BusinessError) => {
                if (err) {
                  console.error(`SUB_Security_Crypto_Framework_Verify_Verify_0100 update failed, error code: ${err.code}, msg: ${err.message}`);
                  expect(false).assertTrue();
                } else {
                  verify.verify(input2, dataBlob, (err: BusinessError, data) => {
                    if (err) {
                      console.error(`SUB_Security_Crypto_Framework_Verify_Verify_0100 verify failed, error code: ${err.code}, msg: ${err.message}`);
                      expect(false).assertTrue();
                    } else {
                      console.info("SUB_Security_Crypto_Framework_Verify_Verify_0100 result is " + data);
                      expect(data).not().assertNull();
                    }
                  });
                }
              });
            }
          });
        })
        .catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Verify_Verify_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Verify_Verify_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Verify_Verify_0200
     * @tc.desc      : Verify the data through promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Verify_Verify_0200', 0, async () => {
      let globalKeyPair: cryptoFramework.KeyPair;
      let asyKeyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("RSA1024|PRIMES_2");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("RSA1024|PSS|SHA256|MGF1_SHA256");
      let KeyPairGenPromise: Promise<cryptoFramework.KeyPair> = asyKeyGenerator.generateKeyPair();
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        let priKey: cryptoFramework.PriKey = keyPair.priKey;
        globalKeyPair = keyPair;
        return signer.init(priKey);
      })
        .then(() => {
          return signer.update(input1);
        })
        .then(() => {
          return signer.sign(input2);
        })
        .then((dataBlob: cryptoFramework.DataBlob) => {
          let verifier: cryptoFramework.Verify = cryptoFramework.createVerify("RSA1024|PKCS1|SHA256");
          let verifyInitPromise: Promise<void> = verifier.init(globalKeyPair.pubKey);
          verifyInitPromise.then((): Promise<void> => {
            return verifier.update(input1);
          }).then(() => {
            return verifier.verify(input2, dataBlob);
          }).then((data: boolean) => {
            console.log(`SUB_Security_Crypto_Framework_Verify_Verify_0200 Verify result is ${data}`);
            expect(data).not().assertNull();
          });
        })
        .catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Verify_Verify_0200 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Set_VerifySpec_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Set_VerifySpec_0100
     * @tc.desc      : Set the verification parameters
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Set_VerifySpec_0100', 0, async () => {
      let verifier: cryptoFramework.Verify = cryptoFramework.createVerify("RSA2048|PSS|SHA256|MGF1_SHA256");
      let setN: number = 20;
      try {
        verifier.setVerifySpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM, setN);
        const getN: string | number = verifier.getVerifySpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM);
        expect(getN).assertEqual(setN);
      } catch (error) {
        const e: BusinessError = error as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Set_VerifySpec_0100 failed, error code: ${e.code}, msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Get_VerifySpec_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Get_VerifySpec_0100
     * @tc.desc      : Set the verification parameters
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Get_VerifySpec_0100', 0, async () => {
      let verifier: cryptoFramework.Verify = cryptoFramework.createVerify("RSA2048|PSS|SHA256|MGF1_SHA256");
      let setN: number = 40;
      try {
        verifier.setVerifySpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM, setN);
        const getN: string | number = verifier.getVerifySpec(cryptoFramework.SignSpecItem.PSS_SALT_LEN_NUM);
        expect(getN).assertEqual(setN);
      } catch (error) {
        const e: BusinessError = error as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Get_VerifySpec_0100 failed, error code: ${e.code}, msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_Key_Agreement_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_Key_Agreement_0100
     * @tc.desc      : KeyAgreement instance generation
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_Key_Agreement_0100', 0, async () => {
      try {
        let keyAgreement: cryptoFramework.KeyAgreement = cryptoFramework.createKeyAgreement("ECC256");
        expect(keyAgreement).not().assertNull();
      } catch (error) {
        const e: BusinessError = error as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Create_Key_Agreement_0100 failed, error code: ${e.code}, msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Generate_Secret_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Generate_Secret_0100
     * @tc.desc      : Key negotiation is performed based on the incoming private key and public key by callback
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Generate_Secret_0100', 0, async () => {
      let rsaGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("ECC256");
      rsaGenerator.generateKeyPair((error: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        if (error) {
          console.error(`SUB_Security_Crypto_Framework_Generate_Secret_0100 generateKeyPair failed, error code: ${error.code}, msg: ${error.message}`);
          expect(false).assertTrue();
        } else {
          let globalKeyPair: cryptoFramework.KeyPair = keyPair;
          let keyAgreement: cryptoFramework.KeyAgreement = cryptoFramework.createKeyAgreement("ECC256");
          keyAgreement.generateSecret(globalKeyPair.priKey, globalKeyPair.pubKey, (err: BusinessError, secret: cryptoFramework.DataBlob) => {
            if (err) {
              console.error(`SUB_Security_Crypto_Framework_Generate_Secret_0100 generateSecret failed, error code: ${err.code}, msg: ${err.message}`);
              expect(err.code == 401).assertTrue();
            } else {
              console.info(`SUB_Security_Crypto_Framework_Generate_Secret_0100 generateSecret data: ${secret.data}`);
              expect(secret.data).not().assertNull();
            }
          });
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Generate_Secret_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Generate_Secret_0200
     * @tc.desc      : Key negotiation is performed based on the incoming private key and public key by promise
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Generate_Secret_0200', 0, async () => {
      let rsaGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator("ECC256");
      rsaGenerator.generateKeyPair((error: BusinessError, keyPair: cryptoFramework.KeyPair) => {
        let globalKeyPair: cryptoFramework.KeyPair = keyPair;
        let keyAgreement: cryptoFramework.KeyAgreement = cryptoFramework.createKeyAgreement("ECC256");
        let keyAgreementPromise: Promise<cryptoFramework.DataBlob> = keyAgreement.generateSecret(globalKeyPair.priKey, globalKeyPair.pubKey);
        keyAgreementPromise.then((secret: cryptoFramework.DataBlob) => {
          console.info(`SUB_Security_Crypto_Framework_Generate_Secret_0200 generateSecret data: ${secret.data}`);
          expect(secret.data).not().assertNull();
        }).catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Generate_Secret_0200 generateSecret failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_Md_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_Md_0100
     * @tc.desc      : Generate an Md instance for computation and operation of message digests.
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_Md_0100', 0, async () => {
      try {
        let md: cryptoFramework.Md = cryptoFramework.createMd("SHA256");
        expect(md).not().assertNull();
      } catch (error) {
        let e: BusinessError = error as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Create_Md_0100 failed, error code: ${e.code},msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Md_Update_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Md_Update_0100
     * @tc.desc      : Incoming messages are calculated for Md updates through callback
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Md_Update_0100', 0, async () => {
      let md: cryptoFramework.Md = cryptoFramework.createMd("SHA256");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("ECC256|SHA256");
      console.info(`SUB_Security_Crypto_Framework_Md_Update_0100 Md algName is: ${md.algName}`);
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        let priKey: cryptoFramework.PriKey = keyPair.priKey;
        return signer.init(priKey);
      })
        .then(() => {
          return signer.update(input1);
        })
        .then(() => {
          return signer.sign(input2);
        })
        .then((dataBlob: cryptoFramework.DataBlob) => {
          md.update(dataBlob, (err: BusinessError) => {
            if (err) {
              console.error(`SUB_Security_Crypto_Framework_Create_Md_0100 failed, error code: ${err.code},msg: ${err.message}`);
              expect(false).assertTrue();
            } else {
              expect(err).assertUndefined();
            }
          });
        })
        .catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Create_Md_0100 failed,catch error code: ${err.code},msg: ${err.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Md_Update_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Md_Update_0200
     * @tc.desc      : Incoming messages are calculated for Md updates through promise
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Md_Update_0200', 0, async () => {
      let md: cryptoFramework.Md = cryptoFramework.createMd("SHA256");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("ECC256|SHA256");
      console.info(`SUB_Security_Crypto_Framework_Md_Update_0200 Md algName is: ${md.algName}`);
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        let priKey: cryptoFramework.PriKey = keyPair.priKey;
        return signer.init(priKey);
      })
        .then(() => {
          return signer.update(input1);
        })
        .then(() => {
          return signer.sign(input2);
        })
        .then((dataBlob: cryptoFramework.DataBlob) => {
          let promiseMdUpdate: Promise<void> = md.update(dataBlob);
          promiseMdUpdate.then(() => {
            md.digest((e: BusinessError, dataBlob: cryptoFramework.DataBlob) => {
              if (e) {
                console.error(`SUB_Security_Crypto_Framework_Md_Update_0200 failed, error code: ${e.code},msg: ${e.message}`);
                expect(false).assertTrue();
              } else {
                expect(dataBlob.data).not().assertNull();
              }
            });
          }).catch((error: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Md_Update_0200 failed,catch error code: ${error.code},msg: ${error.message}`);
            expect(false).assertTrue();
          });
        })
        .catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Md_Update_0200 failed,catch error code: ${err.code},msg: ${err.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Md_Digest_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Md_Digest_0100
     * @tc.desc      : The result of the calculation of Md is returned by registering a callback function
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Md_Digest_0100', 0, async () => {
      let md: cryptoFramework.Md = cryptoFramework.createMd("SHA256");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("ECC256|SHA256");
      console.info(`SUB_Security_Crypto_Framework_Md_Digest_0100 Md algName is: ${md.algName}`);
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        let priKey: cryptoFramework.PriKey = keyPair.priKey;
        return signer.init(priKey);
      })
        .then(() => {
          return signer.update(input1);
        })
        .then(() => {
          return signer.sign(input2);
        })
        .then((dataBlob: cryptoFramework.DataBlob) => {
          md.update(dataBlob, (err: BusinessError) => {
            if (err) {
              console.error(`SUB_Security_Crypto_Framework_Md_Digest_0100 failed, error code: ${err.code}, msg: ${err.message}`);
              expect(false).assertTrue();
            } else {
              md.digest((err1: BusinessError, mdOutput: cryptoFramework.DataBlob) => {
                if (err1) {
                  console.error(`SUB_Security_Crypto_Framework_Md_Digest_0100 failed, error code: ${err1.code}, msg: ${err1.message}`);
                  expect(false).assertTrue();
                } else {
                  console.info(`SUB_Security_Crypto_Framework_Md_Digest_0100 MD result: ${mdOutput}`);
                  expect(mdOutput).not().assertNull();
                }
              });
            }
          });
        })
        .catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Md_Digest_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Md_Digest_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Md_Digest_0200
     * @tc.desc      : The result of the calculation of Md is returned by registering a promise function
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Md_Digest_0200', 0, async () => {
      let md: cryptoFramework.Md = cryptoFramework.createMd("SHA256");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("ECC256|SHA256");
      console.info(`SUB_Security_Crypto_Framework_Md_Digest_0200 Md algName is: ${md.algName}`);
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        let priKey: cryptoFramework.PriKey = keyPair.priKey;
        return signer.init(priKey);
      })
        .then(() => {
          return signer.update(input1);
        })
        .then(() => {
          return signer.sign(input2);
        })
        .then((dataBlob: cryptoFramework.DataBlob) => {
          let promiseMdUpdate: Promise<void> = md.update(dataBlob);
          promiseMdUpdate.then(() => {
            let promiseMdDigest: Promise<cryptoFramework.DataBlob> = md.digest();
            return promiseMdDigest;
          }).then((mdOutput: cryptoFramework.DataBlob) => {
            console.info(`SUB_Security_Crypto_Framework_Md_Digest_0200 MD result: ${mdOutput.data}`);
            expect(mdOutput).not().assertNull();
          }).catch((error: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Md_Digest_0200 failed, error code: ${error.code}, msg: ${error.message}`);
            expect(false).assertTrue();
          });
        })
        .catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Md_Digest_0200 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Md_GetMdLength_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Md_GetMdLength_0100
     * @tc.desc      : The result of the calculation of Md is returned by registering a promise function
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Md_GetMdLength_0100', 0, async () => {
      let md: cryptoFramework.Md = cryptoFramework.createMd("SHA256");
      const signer: cryptoFramework.Sign = cryptoFramework.createSign("ECC256|SHA256");
      console.info(`SUB_Security_Crypto_Framework_Md_GetMdLength_0100 Md algName is: ${md.algName}`);
      KeyPairGenPromise.then((keyPair: cryptoFramework.KeyPair) => {
        let priKey: cryptoFramework.PriKey = keyPair.priKey;
        return signer.init(priKey);
      })
        .then(() => {
          return signer.update(input1);
        })
        .then(() => {
          return signer.sign(input2);
        })
        .then((dataBlob: cryptoFramework.DataBlob) => {
          let promiseMdUpdate: Promise<void> = md.update(dataBlob);
          promiseMdUpdate.then(() => {
            let promiseMdDigest: Promise<cryptoFramework.DataBlob> = md.digest();
            return promiseMdDigest;
          }).then((mdOutput: cryptoFramework.DataBlob) => {
            console.info(`SUB_Security_Crypto_Framework_Md_GetMdLength_0100 MD result: ${mdOutput.data}`);
            let mdLen: number = md.getMdLength();
            console.info(`SUB_Security_Crypto_Framework_Md_GetMdLength_0100 MD len: ${mdLen}`);
            expect(mdLen).not().assertNaN();
          }).catch((error: BusinessError) => {
            console.error(`SUB_Security_Crypto_Framework_Md_GetMdLength_0100 failed, error code: ${error.code}, msg: ${error.message}`);
            expect(false).assertTrue();
          });
        })
        .catch((err: BusinessError) => {
          console.error(`SUB_Security_Crypto_Framework_Md_GetMdLength_0100 failed,catch error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_Mac_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_Mac_0100
     * @tc.desc      : Generate a Mac instance
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_Mac_0100', 0, async () => {
      try {
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        expect(mac).not().assertNull();
      } catch (error) {
        let e: BusinessError = error as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Create_Mac_0100 failed, error code: ${e.code}, msg: ${e.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Mac_Init_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Mac_Init_0100
     * @tc.desc      : Initialize Mac computation with a symmetric key through callback
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Mac_Init_0100', 0, async () => {
      try {
        let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('AES192');
        const symKey: cryptoFramework.SymKey = await symKeyGenerator.convertKey(keyMaterialBlob);
        mac.init(symKey, (err: BusinessError) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Mac_Init_0100 init failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          } else {
            expect(err).assertUndefined();
          }
        });
      } catch (e) {
        const err: BusinessError = e as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Mac_Init_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Mac_Init_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Mac_Init_0200
     * @tc.desc      : Initialize Mac computation with a symmetric key through promise
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Mac_Init_0200', 0, async () => {
      try {
        let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('AES192');
        const symKey: cryptoFramework.SymKey = await symKeyGenerator.convertKey(keyMaterialBlob);
        await mac.init(symKey);
        const len: number = mac.getMacLength();
        expect(len).not().assertNull();
      } catch (e) {
        const err: BusinessError = e as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Mac_Init_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Mac_Update_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Mac_Update_0100
     * @tc.desc      : Incoming messages are computed for Mac updates through callback
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Mac_Update_0100', 0, async () => {
      try {
        let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('AES192');
        const symKey: cryptoFramework.SymKey = await symKeyGenerator.convertKey(keyMaterialBlob);
        mac.init(symKey, (err: BusinessError) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Mac_Update_0100 init failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          } else {
            mac.update(keyMaterialBlob, (e: BusinessError) => {
              if (e) {
                console.error(`SUB_Security_Crypto_Framework_Mac_Update_0100 update failed, error code: ${e.code}, msg: ${e.message}`);
                expect(false).assertTrue();
              } else {
                expect(e).assertUndefined();
              }
            });
          }
        });
      } catch (e) {
        const err: BusinessError = e as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Mac_Update_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Mac_Update_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Mac_Update_0200
     * @tc.desc      : Incoming messages are computed for Mac updates through promise
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Mac_Update_0200', 0, async () => {
      try {
        let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('AES192');
        const symKey: cryptoFramework.SymKey = await symKeyGenerator.convertKey(keyMaterialBlob);
        await mac.init(symKey);
        await mac.update(keyMaterialBlob);
        const len: number = mac.getMacLength();
        expect(len).not().assertNull();
      } catch (e) {
        const err: BusinessError = e as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Mac_Update_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Mac_DoFinal_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Mac_DoFinal_0100
     * @tc.desc      : Return the result of the Mac calculation by registering the callback function
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Mac_DoFinal_0100', 0, async () => {
      try {
        let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('AES192');
        const symKey: cryptoFramework.SymKey = await symKeyGenerator.convertKey(keyMaterialBlob);
        await mac.init(symKey);
        await mac.update(keyMaterialBlob);
        mac.doFinal((err: BusinessError, macOutput: cryptoFramework.DataBlob) => {
          if (err) {
            console.error(`SUB_Security_Crypto_Framework_Mac_DoFinal_0100 doFinal failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          } else {
            console.info(`SUB_Security_Crypto_Framework_Mac_DoFinal_0100 result: ${macOutput}`);
            expect(macOutput).not().assertNull();
          }
        });
      } catch (e) {
        const err: BusinessError = e as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Mac_DoFinal_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Mac_DoFinal_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Mac_DoFinal_0200
     * @tc.desc      : get return Mac result through promise
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Mac_DoFinal_0200', 0, async () => {
      try {
        let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('AES192');
        const symKey: cryptoFramework.SymKey = await symKeyGenerator.convertKey(keyMaterialBlob);
        await mac.init(symKey);
        await mac.update(keyMaterialBlob);
        const macOutput: cryptoFramework.DataBlob = await mac.doFinal();
        expect(macOutput).not().assertNull();
      } catch (e) {
        const err: BusinessError = e as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Mac_DoFinal_0200 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Mac_Get_Mac_Length_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Mac_Get_Mac_Length_0100
     * @tc.desc      : get the length Mac message authentication code
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Mac_Get_Mac_Length_0100', 0, async () => {
      try {
        let keyMaterialBlob: cryptoFramework.DataBlob = getDataBlob();
        let mac: cryptoFramework.Mac = cryptoFramework.createMac("SHA256");
        let symKeyGenerator: cryptoFramework.SymKeyGenerator = cryptoFramework.createSymKeyGenerator('AES192');
        const symKey: cryptoFramework.SymKey = await symKeyGenerator.convertKey(keyMaterialBlob);
        await mac.init(symKey);
        const len: number = mac.getMacLength();
        expect(len).not().assertNull();
      } catch (e) {
        const err: BusinessError = e as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Mac_Get_Mac_Length_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Create_Random_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Create_Random_0100
     * @tc.desc      : get random instance
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Create_Random_0100', 0, async () => {
      try {
        let rand: cryptoFramework.Random = cryptoFramework.createRandom();
        expect(rand).not().assertNull();
      } catch (error) {
        let err: BusinessError = error as BusinessError;
        console.error(`SUB_Security_Crypto_Framework_Create_Random_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Generate_Random_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Generate_Random_0100
     * @tc.desc      : Asynchronously generates a random number of a specified length through callback
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Generate_Random_0100', 0, async () => {
      let rand: cryptoFramework.Random = cryptoFramework.createRandom();
      rand.generateRandom(12, (err: BusinessError, randData: cryptoFramework.DataBlob) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_Generate_Random_Sync_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          expect(randData.data).not().assertNull();
        }
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Generate_Random_0200
     * @tc.name      : SUB_Security_Crypto_Framework_Generate_Random_0200
     * @tc.desc      : Asynchronously generates a random number of fixed length through promise
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Generate_Random_0200', 0, async () => {
      let rand: cryptoFramework.Random = cryptoFramework.createRandom();
      rand.generateRandom(12).then((randData: cryptoFramework.DataBlob) => {
        expect(randData.data).not().assertNull();
      }).catch((err: BusinessError) => {
        console.error(`SUB_Security_Crypto_Framework_Generate_Random_Sync_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      });
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Generate_Random_Sync_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Generate_Random_Sync_0100
     * @tc.desc      : Synchronously generates a random number of fixed length
     * * @tc.size    : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Generate_Random_Sync_0100', 0, async () => {
      let rand: cryptoFramework.Random = cryptoFramework.createRandom();
      try {
        let randData: cryptoFramework.DataBlob = rand.generateRandomSync(12);
        console.info(`SUB_Security_Crypto_Framework_Generate_Random_Sync_0100 rand result: ${randData.data}`);
        expect(randData.data).not().assertNull();
      } catch (err) {
        console.error(`SUB_Security_Crypto_Framework_Generate_Random_Sync_0100 failed, error code: ${err.code}, msg: ${err.message}`);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_Security_Crypto_Framework_Set_Seed_0100
     * @tc.name      : SUB_Security_Crypto_Framework_Set_Seed_0100
     * @tc.desc      : set specified seed
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('SUB_Security_Crypto_Framework_Set_Seed_0100', 0, async () => {
      let rand: cryptoFramework.Random = cryptoFramework.createRandom();
      rand.generateRandom(12, (err: BusinessError, randData: cryptoFramework.DataBlob) => {
        if (err) {
          console.error(`SUB_Security_Crypto_Framework_Set_Seed_0100 failed, error code: ${err.code}, msg: ${err.message}`);
          expect(false).assertTrue();
        } else {
          try {
            rand.setSeed(randData);
            expect(randData.data).not().assertNull();
          } catch (err) {
            console.error(`SUB_Security_Crypto_Framework_Set_Seed_0100 failed, error code: ${err.code}, msg: ${err.message}`);
            expect(false).assertTrue();
          }
        }
      });
    });
  });
}