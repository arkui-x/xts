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
import { describe, it, TestType, Size, Level, expect } from '@ohos/hypium';
import cryptoFramework from '@ohos.security.cryptoFramework';
import * as specUtil from './utils/common/keyGenSpecUtil';

export default function SecurityCryptoFwGenerateECCBrainPoolTestUnit() {
  describe('SecurityCryptoFwCipherSM2TestUnit', () => {

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_Cipher_SM2_Func_0100
     * @tc.name   : testSecurityCryptoframeworkCipherSM2Func0100
     * @tc.desc   : Verify C1C3C2 encode/decode returns original ASN.1 and fields
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("testSecurityCryptoframeworkCipherSM2Func0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async () => {
        let testNumber: string = "testSecurityCryptoframeworkCipherSM2Func0100";
        let preCipherSpec = specUtil.genSM2CipherTextFunc();
        let preAsn1Data = specUtil.genAsn1DataFunc();
        try {
          let postAsn1Data = cryptoFramework.SM2CryptoUtil.genCipherTextBySpec(preCipherSpec, "C1C3C2");
          expect(postAsn1Data.data.toString()).assertEqual(preAsn1Data.data.toString());
          let postCipherSpec = cryptoFramework.SM2CryptoUtil.getCipherTextSpec(postAsn1Data, "C1C3C2");
          expect(postCipherSpec.xCoordinate).assertEqual(preCipherSpec.xCoordinate);
          expect(postCipherSpec.yCoordinate).assertEqual(preCipherSpec.yCoordinate);
          expect(postCipherSpec.cipherTextData.toString()).assertEqual(preCipherSpec.cipherTextData.toString());
          expect(postCipherSpec.hashData.toString()).assertEqual(preCipherSpec.hashData.toString());
          console.log(testNumber + `: getCipherTextSpec succeed`);
        } catch (err) {
          console.error(testNumber + ` catch error: “${err}“, error code: ${err.code}`);
          expect(null).assertFail();
        }
        console.log(testNumber + `: success`);
      });

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_Cipher_SM2_Func_0200
     * @tc.name   : testSecurityCryptoframeworkCipherSM2Func0200
     * @tc.desc   : Expect error for invalid mode C1C2C2
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testSecurityCryptoframeworkCipherSM2Func0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        let testNumber: string = "testSecurityCryptoframeworkCipherSM2Func0200";
        let preCipherSpec = specUtil.genSM2CipherTextFunc();
        try {
          cryptoFramework.SM2CryptoUtil.genCipherTextBySpec(preCipherSpec, "C1C2C2");
          expect(null).assertFail();
        } catch (err) {
          console.error(testNumber + `: catch error: “${err}“, error code: ${err.code}`);
          expect(401).assertEqual(err.code);
        }
        console.log(testNumber + ": success");
      });

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_Cipher_SM2_Func_0300
     * @tc.name   : testSecurityCryptoframeworkCipherSM2Func0300
     * @tc.desc   : Expect error when hashData is truncated
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("testSecurityCryptoframeworkCipherSM2Func0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        let testNumber: string = "testSecurityCryptoframeworkCipherSM2Func0300";
        let preCipherSpec: cryptoFramework.SM2CipherTextSpec = specUtil.genSM2CipherTextFunc();
        preCipherSpec.hashData = preCipherSpec.hashData.subarray(1);
        try {
          cryptoFramework.SM2CryptoUtil.genCipherTextBySpec(preCipherSpec, "C1C3C2");
          expect(null).assertFail();
        } catch (err) {
          expect(401).assertEqual(err.code);
          console.error(testNumber + `: catch error: “${err}“, error code: ${err.code}`);
        }
        console.log(testNumber + ": success");
      });

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_Cipher_SM2_Func_0400
     * @tc.name   : testSecurityCryptoframeworkCipherSM2Func0400
     * @tc.desc   : Parse ASN.1 to cipher spec and verify all fields
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("testSecurityCryptoframeworkCipherSM2Func0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        let testNumber: string = "testSecurityCryptoframeworkCipherSM2Func0400";
        let preAsn1Data = specUtil.genAsn1DataFunc();
        let preCipherSpec = specUtil.genSM2CipherTextFunc();
        try {
          let postCipherSpec = cryptoFramework.SM2CryptoUtil.getCipherTextSpec(preAsn1Data);
          expect(postCipherSpec.xCoordinate).assertEqual(preCipherSpec.xCoordinate);
          expect(postCipherSpec.yCoordinate).assertEqual(preCipherSpec.yCoordinate);
          expect(postCipherSpec.cipherTextData.toString()).assertEqual(preCipherSpec.cipherTextData.toString());
          expect(postCipherSpec.hashData.toString()).assertEqual(preCipherSpec.hashData.toString());
        } catch (err) {
          console.error(testNumber + `: catch error: “${err}“, error code: ${err.code}`);
          expect(null).assertFail();
        }
        console.log(testNumber + ": success");
      });

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_Cipher_SM2_Func_0500
     * @tc.name   : testSecurityCryptoframeworkCipherSM2Func0500
     * @tc.desc   : Generate ASN.1 from spec and verify bytes match
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("testSecurityCryptoframeworkCipherSM2Func0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        let testNumber: string = "testSecurityCryptoframeworkCipherSM2Func0500";
        let preCipherSpec = specUtil.genSM2CipherTextFunc();
        let preAsn1Data = specUtil.genAsn1DataFunc();
        try {
          let asn1Data = cryptoFramework.SM2CryptoUtil.genCipherTextBySpec(preCipherSpec);
          expect(asn1Data.data.toString()).assertEqual(preAsn1Data.data.toString());
        } catch (err) {
          console.error(testNumber + `: catch error: “${err}“, error code: ${err.code}`);
          expect(null).assertFail();
        }
        console.log(testNumber + ": success");
      });
  })
}