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
import { describe, it, expect, TestType, Size, Level } from "@ohos/hypium";
import hilog from '@ohos.hilog';
import cryptoFramework from '@ohos.security.cryptoFramework';
import * as commonUtils from './utils/common/commonUtils';
import * as v from './utils/vectors/vectors';

let domain = 0x0000; // 日志标识,0x0000作为测试框架的业务标识
let tag: string = 'testTag'; // 日志标识字符串,作为tag标识当前runner类下的测试行为

export default function SecurityCryptoFwVectorTestUnit() {
  describe("SecurityCryptoFwVectorTestUnit", (): void => {
    hilog.info(domain, tag, '%{public}s', 'describe start');

    /**
     * @tc.number : SUB_SECURITY_Cryptoframework_VectorTest_Func_0100
     * @tc.name   : testSecurityCryptoframeworkVectorTestFunc0100
     * @tc.desc   : Test PBKDF2 key derivation functionality
     * @tc.size   : Medium
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("testSecurityCryptoframeworkVectorTestFunc0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (): Promise<void> => {
        try {
          let pbkdf2Vectors: v.pbkdf2VectorData[] = v.pbkdf2Vectors;
          for (let vector of pbkdf2Vectors) {
            let digestAlgName: string = vector.algName;
            let kdfAlgName: string = vector.kdfAlgName;
            for (let data of vector.kdfVectorSpec) {
              let password: number[] = data.password;
              let salt: number[] = data.salt;
              let iterations: number = data.iterations;
              let keySize: number = data.keySize;
              let kdfSpec: cryptoFramework.PBKDF2Spec = v.getKdfSpec(password, salt, iterations, keySize);
              let kdf: cryptoFramework.Kdf = cryptoFramework.createKdf(kdfAlgName + "|" + digestAlgName);
              let secret: cryptoFramework.DataBlob = await kdf.generateSecret(kdfSpec);
              let expectKdf: cryptoFramework.DataBlob = v.numberArrayToDataBlob(data.expectKdf);
              let ret: boolean = commonUtils.compareDataBlob(secret, expectKdf);
              expect(ret).assertTrue();
            }
          }
        } catch (error) {
          console.error(`“${error}“, error code: ${error.code}`);
          expect(null).assertFail();
        }
      });
  });
}