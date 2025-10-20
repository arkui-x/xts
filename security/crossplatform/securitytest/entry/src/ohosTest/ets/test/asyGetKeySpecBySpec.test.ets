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
import { describe, it, expect, TestType, Size, Level, beforeAll } from "@ohos/hypium";
import cryptoFramework from '@ohos.security.cryptoFramework';
import * as asyCommon from "./utils/common/publicDoSpec";

function genRsa2048KeyPairSpec(): cryptoFramework.RSAKeyPairSpec {
  return asyCommon.genRsa2048KeyPairSpec();
}

function genDsa2048KeyPairSpec(): cryptoFramework.DSAKeyPairSpec {
  return asyCommon.genDsa2048KeyPairSpecBigE();
}

export default function AsyGetKeySpecBySpecJsunit() {
  describe("AsyGetKeySpecBySpecJsunit", () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    });

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_AsyKeySpec_Func_0100
     * @tc.name   : testSecurityCryptoframeworkAsyKeySpecFunc0100
     * @tc.desc   : use keyPair.pubkey to get AsyKeySpecItem
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it(
      "testSecurityCryptoframeworkAsyKeySpecFunc0100",
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (): Promise<void> => {
        let rsaKeyPairSpec: cryptoFramework.RSAKeyPairSpec = genRsa2048KeyPairSpec();
        let asyKeyGeneratorSpec: cryptoFramework.AsyKeyGeneratorBySpec =
          cryptoFramework.createAsyKeyGeneratorBySpec(rsaKeyPairSpec);
        await asyKeyGeneratorSpec
          .generateKeyPair()
          .then((keyPair: cryptoFramework.KeyPair) => {
            let pk: bigint | string | number = keyPair.pubKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.RSA_PK_BN
            );
            expect(pk == rsaKeyPairSpec.pk).assertTrue();
            let n: bigint | string | number = keyPair.pubKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.RSA_N_BN
            );
            expect(n == rsaKeyPairSpec.params.n).assertTrue();
          })
          .catch((err: Error) => {
            console.error(
              "Security_CryptoFramework_AsyKeySpec_Func_0100 failed. error is " +
                err
            );
            expect(null).assertFail();
          });
      }
    );

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_AsyKeySpec_Func_0200
     * @tc.name   : testSecurityCryptoframeworkAsyKeySpecFunc0200
     * @tc.desc   : use keyPair.pubkey to get AsyKeySpecItem
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it(
      "testSecurityCryptoframeworkAsyKeySpecFunc0200",
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (): Promise<void> => {
        let dsaKeyPairSpec: cryptoFramework.DSAKeyPairSpec = genDsa2048KeyPairSpec();
        let asyKeyPairSpec: cryptoFramework.AsyKeyGeneratorBySpec =
          cryptoFramework.createAsyKeyGeneratorBySpec(dsaKeyPairSpec);
        await asyKeyPairSpec
          .generateKeyPair()
          .then((keyPair: cryptoFramework.KeyPair) => {
            let p: bigint | string | number = keyPair.pubKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.DSA_P_BN
            );
            expect(p == dsaKeyPairSpec.params.p).assertTrue();
            let q: bigint | string | number = keyPair.pubKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.DSA_Q_BN
            );
            expect(q == dsaKeyPairSpec.params.q).assertTrue();
            let g: bigint | string | number = keyPair.pubKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.DSA_G_BN
            );
            expect(g == dsaKeyPairSpec.params.g).assertTrue();
            let pk: bigint | string | number = keyPair.pubKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.DSA_PK_BN
            );
            expect(pk == dsaKeyPairSpec.pk).assertTrue();
          })
          .catch((err: Error) => {
            console.error(
              "Security_CryptoFramework_AsyKeySpec_Func_0200 failed. error is " +
                err
            );
            expect(null).assertFail();
          });
      }
    );

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_AsyKeySpec_Func_0300
     * @tc.name   : testSecurityCryptoframeworkAsyKeySpecFunc0300
     * @tc.desc   : the asyKeySpec is genRsa2048KeyPairSpec, Use the promise Style of Interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it(
      "testSecurityCryptoframeworkAsyKeySpecFunc0300",
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (): Promise<void> => {
        let rsaKeyPairSpec: cryptoFramework.RSAKeyPairSpec = genRsa2048KeyPairSpec();
        let asyKeyPairSpec: cryptoFramework.AsyKeyGeneratorBySpec =
          cryptoFramework.createAsyKeyGeneratorBySpec(rsaKeyPairSpec);
        await asyKeyPairSpec
          .generateKeyPair()
          .then((keyPair: cryptoFramework.KeyPair) => {
            let n: bigint | string | number = keyPair.priKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.RSA_N_BN
            );
            expect(n == rsaKeyPairSpec.params.n).assertTrue();
            let sk: bigint | string | number = keyPair.priKey.getAsyKeySpec(
              cryptoFramework.AsyKeySpecItem.RSA_SK_BN
            );
            expect(sk == rsaKeyPairSpec.sk).assertTrue();
          })
          .catch((err: Error) => {
            console.error(
              "Security_CryptoFramework_AsyKeySpec_Func_0300 failed. error: " +
                err
            );
            expect(null).assertFail();
          });
      }
    );
  });
}
