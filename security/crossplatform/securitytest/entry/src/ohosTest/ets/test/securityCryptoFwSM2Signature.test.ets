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
import { describe, it, expect, TestType, Size, Level } from '@ohos/hypium';
import cryptoFramework from '@ohos.security.cryptoFramework';
import { doSignSync, doVerifySync, generateSignKey } from './utils/signVerify/signVerifySyncUtils';
import { compareDataBlob, compareString, createData } from './utils/common/commonUtils';

export default function SecurityCryptoFwSM2TestUnit() {
  describe('SecurityCryptoFwSM2TestUnit', () => {

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_SM2_ASN1ToRS_Func_0100
     * @tc.name   : testSecurityCryptoframeworkSM2ASN1ToRSFunc0100
     * @tc.desc   : Test SM2 signature and verification functionality
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testSecurityCryptoframeworkSM2ASN1ToRSFunc0100",
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        try {
          let msgLen: number = 64;
          let msg: cryptoFramework.DataBlob = await createData(msgLen);
          let algName: string = "SM2_256";
          let digest: string = "SM3";
          let keyPair = await generateSignKey(algName);
          let signAlgName: string = algName + "|" + digest;
          let dataSign = doSignSync(signAlgName, keyPair.priKey, msg);
          let RS: cryptoFramework.EccSignatureSpec = cryptoFramework.SignatureUtils.genEccSignatureSpec(dataSign.data);
          let asn1: Uint8Array = cryptoFramework.SignatureUtils.genEccSignature(RS);
          let ret: boolean = compareDataBlob({ data: asn1 }, dataSign);
          ret = ret && doVerifySync(signAlgName, keyPair.pubKey, msg, { data: asn1 });
          expect(ret).assertTrue();
        } catch (error) {
          console.error(` “${error}“, error code: ${error.code}`);
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_SM2_ASN1ToRS_Func_0200
     * @tc.name   : testSecurityCryptoframeworkSM2ASN1ToRSFunc0200
     * @tc.desc   : Test SM2 ASN.1 to RS conversion functionality
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testSecurityCryptoframeworkSM2ASN1ToRSFunc0200",
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
        try {
          // Big endian
          let expect_r: string = "eade4f43ef29faba54e2276cd2fb250b9cfe381912e4cb7b4d98ca527fa544fe"
          let expect_s: string = "3507f67f76de9422349f57fe3603c6c254ccef76267438d730bcb4b1f159e8"
          let asn1ToRS: Uint8Array = new Uint8Array([
            0x30, 0x44, 0x02, 0x21, 0x00, 0xEA, 0xDE, 0x4F, 0x43, 0xEF, 0x29, 0xFA, 0xBA, 0x54, 0xE2, 0x27,
            0x6C, 0xD2, 0xFB, 0x25, 0x0B, 0x9C, 0xFE, 0x38, 0x19, 0x12, 0xE4, 0xCB, 0x7B, 0x4D, 0x98, 0xCA,
            0x52, 0x7F, 0xA5, 0x44, 0xFE, 0x02, 0x1F, 0x35, 0x07, 0xF6, 0x7F, 0x76, 0xDE, 0x94, 0x22, 0x34,
            0x9F, 0x57, 0xFE, 0x36, 0x03, 0xC6, 0xC2, 0x54, 0xCC, 0xEF, 0x76, 0x26, 0x74, 0x38, 0xD7, 0x30,
            0xBC, 0xB4, 0xB1, 0xF1, 0x59, 0xE8
          ]);
          let RS: cryptoFramework.EccSignatureSpec = cryptoFramework.SignatureUtils.genEccSignatureSpec(asn1ToRS);
          let r = RS.r.toString(16);
          let s = RS.s.toString(16);
          let ret = compareString(expect_r, r);
          ret = ret && compareString(expect_s, s);
          expect(ret).assertTrue();
        } catch (error) {
          console.error(` “${error}“, error code: ${error.code}`);
          expect(null).assertFail();
        }
      });
  })
}