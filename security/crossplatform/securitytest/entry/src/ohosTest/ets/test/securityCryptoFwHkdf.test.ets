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
import * as commonUtils from './utils/common/commonUtils';
import * as hkdfUtils from './utils/hkdf/hkdfUtils';

export default function SecurityCryptoFwHkdfTestUnit() {
  describe('SecurityCryptoFwHkdfTestUnit', () => {

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_Hkdf_Func_0100
     * @tc.name   : testSecurityCryptoframeworkHkdfFunc0100
     * @tc.desc   : Test HKDF key derivation functionality
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("testSecurityCryptoframeworkHkdfFunc0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          for (let vectors of hkdfUtils.KAT_VECTOR_DATA) {
            let key = vectors.key;
            let salt = vectors.salt;
            let info = vectors.info;
            let keySize = vectors.keySize;
            let expectSecret = vectors.expectSecret;
            let hashName = vectors.hashName;
            let spec: cryptoFramework.HKDFSpec = {
              algName: "HKDF",
              key: new Uint8Array(key),
              salt: new Uint8Array(salt),
              info: new Uint8Array(info),
              keySize: keySize
            };
            let kdfAlgName: string = "HKDF|" + hashName + "|EXTRACT_AND_EXPAND";
            let secret: cryptoFramework.DataBlob = await hkdfUtils.hkdfPromise(kdfAlgName, spec);
            let hexSecret: string = commonUtils.decToHexString(secret);
            let hkdfSecret: number[] = commonUtils.convertToUint8Array(hexSecret);
            let ret: boolean = commonUtils.compareNumber(hkdfSecret, expectSecret);
            expect(ret).assertTrue();
            expect(secret.data.length).assertEqual(keySize);
          }
        } catch (error) {
          console.error(`HKDF “${error}“, error code: ${error.code}`);
          expect(null).assertFail();
        }
        done();
      });
  });
}