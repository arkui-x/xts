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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, TestType, Size, Level, expect } from '@ohos/hypium';
import cryptoFramework from '@ohos.security.cryptoFramework';
import { AsyAlgName } from '../config/keyGenSpecUtil';

export default function SecurityCryptoFwKeyGenerateECCTestUnit2() {
  describe('SecurityCryptoFwKeyGenerateECCTestUnit', () => {
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
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    });
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0100
     * @tc.name   : testGetEncodedDer0100
     * @tc.desc   : generateKeyPair by sm2
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level3
     */
    it("testGetEncodedDer0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testGetEncodedDer0100";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.SM2;
      let format: string = "X509|UNCOMPRESSED";
      try {
        let generator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName);
        let keyPair: cryptoFramework.KeyPair = await generator.generateKeyPair();
        keyPair.pubKey.getEncodedDer(format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0200
     * @tc.name   : testGetEncodedDer0200
     * @tc.desc   : generateKeyPair by rsa
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level3
     */
    it("testGetEncodedDer0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testGetEncodedDer0200";
      console.log(testNumber + ": started");
      let algName: string = "RSA512";
      let format: string = "X509|COMPRESSED";
      try {
        let generator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName);
        let keyPair: cryptoFramework.KeyPair = await generator.generateKeyPair();
        keyPair.pubKey.getEncodedDer(format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0300
     * @tc.name   : testGetEncodedDer0300
     * @tc.desc   : generateKeyPair by brainPoolP256r1
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level3
     */
    it("testGetEncodedDer0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testGetEncodedDer0300";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let format: string = "COMPRESSED";
      try {
        let generator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName);
        let keyPair: cryptoFramework.KeyPair = await generator.generateKeyPair();
        keyPair.pubKey.getEncodedDer(format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_AsyKeyGenerator_Ecc_Func_0400
     * @tc.name   : testGetEncodedDer0400
     * @tc.desc   : generateKeyPair by brainPoolP256r1
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level3
     */
    it("testGetEncodedDer0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let testNumber: string = "testGetEncodedDer0400";
      console.log(testNumber + ": started");
      let algName: AsyAlgName = AsyAlgName.P256r1;
      let format: string = "";
      try {
        let generator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator(algName);
        let keyPair: cryptoFramework.KeyPair = await generator.generateKeyPair();
        keyPair.pubKey.getEncodedDer(format);
        expect(null).assertFail();
      } catch (err) {
        expect(cryptoFramework.Result.INVALID_PARAMS).assertEqual(err.code);
        console.error(testNumber + `: catch error ${JSON.stringify(err)}`);
      }
      console.log(testNumber + ": success");
    });
  });
}