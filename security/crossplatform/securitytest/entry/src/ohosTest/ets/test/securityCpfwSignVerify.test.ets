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
import * as signVerifySyncUtils from '../config/signVerifySyncUtils';

export default function SecurityCryptoFwSignVerifySyncTestUnit() {
  describe('SecurityCryptoFwSignVerifySyncTestUnit', () => {
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
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_SignAndVerify_Func_0100
     * @tc.name   : testSignAndVerify0100
     * @tc.desc   : Test RSA1024 signature and verification functionality
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level3
     */
    it("testSignAndVerify0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let algName: string = "RSA1024";
        let signAlgName: string = "RSA1024|PSS|SHA384|MGF1_SHA256";
        let keyPair = await signVerifySyncUtils.generateSignKey(algName);
        let sign: cryptoFramework.Sign = cryptoFramework.createSign(signAlgName);
        sign.initSync(keyPair.priKey);
        let dataSign = sign.signSync(null);
        let verify: cryptoFramework.Verify = cryptoFramework.createVerify(signAlgName);
        verify.initSync(keyPair.pubKey);
        let ret = verify.verifySync(null, dataSign);
        expect(ret).assertTrue();
      } catch (error) {
        console.error(`SignVerify “${error}“, error code: ${error.code}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CRYPTOFRAMEWORK_SignAndVerify_Func_0200
     * @tc.name   : testSignAndVerify0200
     * @tc.desc   : Test DSA1024 signature and verification functionality
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level3
     */
    it("testSignAndVerify0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      try {
        let algName: string = "DSA1024";
        let signAlgName: string = "DSA1024|SHA512";
        let keyPair = await signVerifySyncUtils.generateSignKey(algName);
        let sign: cryptoFramework.Sign = cryptoFramework.createSign(signAlgName);
        sign.initSync(keyPair.priKey);
        sign.signSync(null);
        expect(null).assertFail();
      } catch (error) {
        console.error(`SignVerify “${error}“, error code: ${error.code}`);
        expect(error.code).assertEqual(401);
      }
      done();
    });
  });
}
