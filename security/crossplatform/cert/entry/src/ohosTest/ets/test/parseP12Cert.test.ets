/*
 * Copyright (C) 2024 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from "@ohos/hypium";
import cert from '@ohos.security.cert';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import {
  p12_ecc_cert,
  p12_expired_cert,
  p12_max_other,
  p12_priKey_usage_ex,
  p12_rsa_cert,
  p12_rsa_error_format,
  vectorP12Data } from './utils/certificate/p12';
import { BusinessError } from '@kit.BasicServicesKit';
import { taskpool, util } from '@kit.ArkTS';


function sleep(ms: number = 1000): Promise<void> {
  return new Promise((resolve: Function) => {
    setTimeout(() => {
      resolve();
    }, ms);
  });
}

@Concurrent
async function doPkcs12Stub(p12: number[]): Promise<boolean> {
  let timeFlag: boolean = false;
  let timeoutId:number = 0;
  let intervalTime = 10000;
  let ret: boolean = true;
  setInterval(() => {
    timeFlag = true;
  }, 3600000 * 6 * 3);
  while (!timeFlag) {
    try {
      let p12_cert: Uint8Array = new Uint8Array(p12_max_other);
      let conf: cert.Pkcs12ParsingConfig = {
        password: "123456",
        needsOtherCerts: true
      };
      let p12: cert.Pkcs12Data = cert.parsePkcs12(p12_cert, conf);
      if (p12.privateKey) {
        console.info("#################### pri:" + p12.privateKey.toString())
      }
      if (p12.cert) {
        console.info("#################### cert:" + p12.cert.toString())
      }
      if (p12.otherCerts) {
        console.info("#################### other:" + p12.otherCerts.length)
      }
      await new Promise<void>((resolve, reject) => {
        timeoutId = setTimeout(() => {
          resolve()
        }, intervalTime)
      }).then(undefined, (error: Object) =>{});
      clearTimeout(timeoutId);
    } catch (error) {
      console.error(`doPkcs12Stub “${error}“, error code: ${error.code}`);
      return false;
    }
  }

  return ret;
}

export default function certFrameworkParseP12CertTestUnit() {
  describe("certFrameworkParseP12CertTestUnit", () => {
    beforeAll(async () => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
      sleep(5000);
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
    afterAll(async () => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });

    /**
     * @tc.number SUB_Security_Cert_Framework_ParseP12Cert_Func_0100
     * @tc.name parse pkcs12 cert
     * @tc.desc The X509 Cert Format is PEM
     * @tc.size SmallTest
     * @tc.level Level1
     * @tc.type Function
     */
    it("SUB_Security_Cert_Framework_ParseP12Cert_Func_0100", 0, async (done: Function) => {
      try {
        let p12Cert: vectorP12Data = p12_rsa_cert;
        let p12_cert: Uint8Array = new Uint8Array(p12Cert.p12Cert);
        let conf: cert.Pkcs12ParsingConfig = {
          password: "123456",
        };
        let p12: cert.Pkcs12Data = cert.parsePkcs12(p12_cert, conf);
        let priKey = p12.privateKey;
        expect(priKey).assertEqual(p12Cert.priKey);
        if (p12.cert) {
          let pub: cryptoFramework.PubKey = p12.cert.getPublicKey();
          await p12.cert.verify(pub).then(() => {
            expect(null).assertNull();
          }).catch((error: BusinessError) => {
            console.error('verify failed, errCode: ' + error.code + ', errMsg: ' + error.message);
            expect(null).assertTrue();
          });
        }
        expect(p12.otherCerts).assertEqual(undefined);
      } catch (error) {
        console.error(`ParseP12Cert_Func_0100 ${error}, error code: ${error.code}`);
        expect(null).assertFail();
      }
      done();
    });

  });
}
