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
import {
  describe,
  beforeAll,
  beforeEach,
  afterEach,
  afterAll,
  it,
  expect,
  Size,
  TestType,
  Level
} from '@ohos/hypium';
import cert from '@ohos.security.cert';
import {
  p12_ecc_cert, p12_rsa_error_format
} from '../config/p12';

export default function parsingConfigTest() {
  describe("certFrameworkParseP12CertTestUnit", () => {
    beforeAll(async () => {
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
    afterAll(async () => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_ParseP12Cert_Func_0100
     * @tc.name   : testParseP12Cert0100
     * @tc.desc   : The X509 Cert Format is PEM
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testParseP12Cert0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let p12_cert: Uint8Array = new Uint8Array(p12_ecc_cert);
          let conf: cert.Pkcs12ParsingConfig = {
            password: "123456",
            needsCert: true,
            needsPrivateKey: false,
            needsOtherCerts: false,
          };
          let p12: cert.Pkcs12Data = cert.parsePkcs12(p12_cert, conf);
          if (p12.cert) {
            expect(null).assertNull();
          } else {
            expect(null).assertFail();
          }
        } catch (error) {
          console.error(`testParseP12Cert0100 ${error}, error code: ${error.code}`);
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_ParseP12Cert_Func_0200
     * @tc.name   : testParseP12Cert0200
     * @tc.desc   : The X509 Cert Format is PEM
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testParseP12Cert0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let p12_cert: Uint8Array = new Uint8Array(p12_rsa_error_format);
          let conf: cert.Pkcs12ParsingConfig = {
            password: "123456",
            needsCert: true,
            needsPrivateKey: true,
            needsOtherCerts: true,
          };
          cert.parsePkcs12(p12_cert, conf);
        } catch (error) {
          console.error(`testParseP12Cert0200 ${error}, error code: ${error.code}`);
          expect(error.code).assertEqual(19030001);
        }
        done();
      });
  });
}