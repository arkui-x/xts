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
import * as certFunc from "../cert/certFunc";
import {
  CERT_DATA_PEM, CERT_DATA_PEM_PARAMETERS, PEM
} from '../common/commonParam';

export default function x509CertMatchTest() {
  describe("CertTestMatchTestUnit", () => {

    let pemCert0: cert.X509Cert = {} as cert.X509Cert;
    let pemCert1: cert.X509Cert = {} as cert.X509Cert;
    let pemCert7: cert.X509Cert = {} as cert.X509Cert;
    console.info("##########start certFrameworkCertMatchJsAPIFunctionTestUnit##########");
    beforeAll(async () => {
      try {
        pemCert0 = await certFunc.createCustomizedX509CertPromise(PEM, 0);
        pemCert1 = await certFunc.createCustomizedX509CertPromise(PEM, 1);
        pemCert7 = await certFunc.createCustomizedX509CertPromise(PEM, 7);
      } catch (err) {
        console.error("createCustomizedX509CertPromise error");
        expect(null).assertFail();
      }
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
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0100
     * @tc.name   : testX509MatchParameter0100
     * @tc.desc   : Null parameter should throw INVALID_PARAMS
     * @tc.size   : SmallTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509MatchParameter0100", TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, async () => {
      let x509Cert: cert.X509Cert = {} as cert.X509Cert;
      try {
        x509Cert = await certFunc.createCustomizedX509CertPromise(PEM, 1);
        expect(x509Cert != null).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
      try {
        x509Cert.match(null);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
    })

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0200
     * @tc.name   : testX509MatchParameter0200
     * @tc.desc   : Undefined parameter should throw INVALID_PARAMS
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509MatchParameter0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let x509Cert: cert.X509Cert = {} as cert.X509Cert;
      try {
        x509Cert = await certFunc.createCustomizedX509CertPromise(PEM, 1);
        expect(x509Cert != null).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
      try {
        x509Cert.match(undefined);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0300
     * @tc.name   : testX509MatchParameter0300
     * @tc.desc   : Match with exact x509Cert should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509MatchParameter0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let x509Cert: cert.X509Cert = {} as cert.X509Cert;
      try {
        x509Cert = await certFunc.createPEMCustomizedX509CertPromise(CERT_DATA_PEM[0]);
        expect(x509Cert != null).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
      const param: cert.X509CertMatchParameters = {
        x509Cert: x509Cert
      };
      try {
        const result = await certFunc.checkCertMatchParam(PEM, 0, param);
        expect(result).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0400
     * @tc.name   : testX509MatchParameter0400
     * @tc.desc   : Match with different x509Cert should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509MatchParameter0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let x509Cert: cert.X509Cert = {} as cert.X509Cert;
      try {
        x509Cert = await certFunc.createPEMCustomizedX509CertPromise(CERT_DATA_PEM[1]);
        expect(x509Cert != null).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
      const param: cert.X509CertMatchParameters = {
        x509Cert: x509Cert
      };
      try {
        const result = await certFunc.checkCertMatchParam(PEM, 0, param);
        expect(result).assertFalse();
      } catch (err) {
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0500
     * @tc.name   : testX509MatchParameter0500
     * @tc.desc   : Match with full parameters should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509MatchParameter0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let x509Cert: cert.X509Cert = {} as cert.X509Cert;
      try {
        x509Cert = await certFunc.createCustomizedX509CertPromise(PEM, 1);
        expect(x509Cert != null).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
      const param: cert.X509CertMatchParameters = {
        x509Cert,
        validDate: CERT_DATA_PEM_PARAMETERS[1].notAfterDate,
        issuer: CERT_DATA_PEM_PARAMETERS[1].issuer,
        keyUsage: [false, false, false, false, false, false, true, true, true],
        serialNumber: CERT_DATA_PEM_PARAMETERS[1].serialNumber,
        subject: CERT_DATA_PEM_PARAMETERS[1].subject,
        publicKey: CERT_DATA_PEM_PARAMETERS[1].publicKey,
        publicKeyAlgID: CERT_DATA_PEM_PARAMETERS[1].publicKeyAlgID
      };
      try {
        const result = await certFunc.checkCertMatchParam(PEM, 1, param);
        expect(result).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0600
     * @tc.name   : testX509MatchParameter0600
     * @tc.desc   : Match with all keyUsage=true should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509MatchParameter0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let x509Cert: cert.X509Cert = {} as cert.X509Cert;
      try {
        x509Cert = await certFunc.createCustomizedX509CertPromise(PEM, 1);
        expect(x509Cert != null).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
      const param: cert.X509CertMatchParameters = {
        x509Cert,
        validDate: CERT_DATA_PEM_PARAMETERS[1].notAfterDate,
        issuer: CERT_DATA_PEM_PARAMETERS[1].issuer,
        keyUsage: [true, true, true, true, true, true, true, true, true],
        serialNumber: CERT_DATA_PEM_PARAMETERS[1].serialNumber,
        subject: CERT_DATA_PEM_PARAMETERS[1].subject,
        publicKey: CERT_DATA_PEM_PARAMETERS[1].publicKey,
        publicKeyAlgID: CERT_DATA_PEM_PARAMETERS[1].publicKeyAlgID
      };
      try {
        const result = await certFunc.checkCertMatchParam(PEM, 1, param);
        expect(result).assertFalse();
      } catch (err) {
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0700
     * @tc.name   : testX509IssuerMatchParameter0700
     * @tc.desc   : Issuer matches should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509IssuerMatchParameter0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      const param: cert.X509CertMatchParameters = {
        issuer: CERT_DATA_PEM_PARAMETERS[0].issuer
      };
      try {
        const result = await certFunc.checkCertMatchParam(PEM, 0, param);
        expect(result).assertTrue();
      } catch (err) {
        expect(null).assertFail();
      }
    });
    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0800
     * @tc.name   : testX509IssuerMatchParameter0800
     * @tc.desc   : Issuer mismatch should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509IssuerMatchParameter0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      const param: cert.X509CertMatchParameters = {
        issuer: CERT_DATA_PEM_PARAMETERS[2].issuer
      };
      try {
        const result = await certFunc.checkCertMatchParam(PEM, 0, param);
        expect(result).assertFalse();
      } catch (err) {
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_0900
     * @tc.name   : testX509IssuerMatchParameter0900
     * @tc.desc   : Issuer as DER bytes (case 1) should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509IssuerMatchParameter0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          issuer: new Uint8Array([0x30, 0x64, 0x31, 0x10, 0x30, 0x0e, 0x06, 0x03, 0x55, 0x04, 0x08, 0x13, 0x07, 0x4a,
            0x69,
            0x61, 0x6e, 0x67, 0x73, 0x75, 0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02, 0x43, 0x4e,
            0x31, 0x10, 0x30, 0x0e, 0x06, 0x03, 0x55, 0x04, 0x07, 0x13, 0x07, 0x4e, 0x61, 0x6e, 0x6a, 0x69, 0x6e, 0x67,
            0x31, 0x0f, 0x30, 0x0d, 0x06, 0x03, 0x55, 0x04, 0x0a, 0x13, 0x06, 0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x31,
            0x0f, 0x30, 0x0d, 0x06, 0x03, 0x55, 0x04, 0x0b, 0x13, 0x06, 0x74, 0x65, 0x73, 0x74, 0x43, 0x61, 0x31, 0x0f,
            0x30, 0x0d, 0x06, 0x03, 0x55, 0x04, 0x03, 0x13, 0x06, 0x74, 0x65, 0x73, 0x74, 0x43, 0x61])
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 0, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1000
     * @tc.name   : testX509IssuerMatchParameter1000
     * @tc.desc   : Issuer as DER bytes (case 2) should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509IssuerMatchParameter1000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          issuer: new Uint8Array([0x30, 0x74, 0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02, 0x43,
            0x4e,
            0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02, 0x55, 0x53, 0x31, 0x13, 0x30, 0x11, 0x06,
            0x03, 0x55, 0x04, 0x08, 0x13, 0x0a, 0x57, 0x61, 0x73, 0x68, 0x69, 0x6e, 0x67, 0x74, 0x6f, 0x6e, 0x31, 0x13,
            0x30, 0x11, 0x06, 0x03, 0x55, 0x04, 0x07, 0x13, 0x0a, 0x57, 0x61, 0x73, 0x68, 0x69, 0x6e, 0x67, 0x74, 0x6f,
            0x6e, 0x31, 0x0e, 0x30, 0x0c, 0x06, 0x03, 0x55, 0x04, 0x0a, 0x13, 0x05, 0x74, 0x73, 0x31, 0x31, 0x30, 0x31,
            0x0e, 0x30, 0x0c, 0x06, 0x03, 0x55, 0x04, 0x0b, 0x13, 0x05, 0x74, 0x73, 0x31, 0x31, 0x30, 0x31, 0x0e, 0x30,
            0x0c, 0x06, 0x03, 0x55, 0x04, 0x03, 0x13, 0x05, 0x74, 0x73, 0x31, 0x31, 0x30])
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 9, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1100
     * @tc.name   : testX509IssuerMatchParameter1100
     * @tc.desc   : Invalid issuer DER should throw ERR_CRYPTO_OPERATION
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509IssuerMatchParameter1100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          issuer: new Uint8Array([0x30, 0x64, 0x31])
        };
        try {
          pemCert0.match(param);
          expect(null).assertFail();
        } catch (err) {
          expect(err.code).assertEqual(cert.CertResult.ERR_CRYPTO_OPERATION);
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1200
     * @tc.name   : testX509IssuerMatchParameter1200
     * @tc.desc   : Empty issuer DER should throw INVALID_PARAMS
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509IssuerMatchParameter1200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          issuer: new Uint8Array()
        };
        try {
          pemCert0.match(param);
          expect(null).assertFail();
        } catch (err) {
          expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1300
     * @tc.name   : testX509KeyUsageMatchParameter1300
     * @tc.desc   : keyUsage exact match should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter1300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [true, true, true, true, true, true, true, true, true]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 7, param);
          expect(result).assertTrue();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1400
     * @tc.name   : testX509KeyUsageMatchParameter1400
     * @tc.desc   : keyUsage partial mismatch should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter1400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [true, true, false, true, true, false, true, true, true]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 7, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1500
     * @tc.name   : testX509KeyUsageMatchParameter1500
     * @tc.desc   : keyUsage all false should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter1500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [false, false, false, false, false, false, false, false, false]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 7, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1600
     * @tc.name   : testX509KeyUsageMatchParameter1600
     * @tc.desc   : keyUsage length 8 should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter1600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [true, true, true, true, true, true, true, true]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 7, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1700
     * @tc.name   : testX509KeyUsageMatchParameter1700
     * @tc.desc   : keyUsage length 8 for another cert should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter1700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [true, true, true, true, true, true, true, true]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 8, param);
          expect(result).assertTrue();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });
      
    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1800
     * @tc.name   : testX509KeyUsageMatchParameter1800
     * @tc.desc   : keyUsage too many flags should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter1800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [true, true, true, true, true, true, true, true, true, true]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 7, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_1900
     * @tc.name   : testX509KeyUsageMatchParameter1900
     * @tc.desc   : keyUsage with last flag false should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter1900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [true, true, true, true, true, true, true, true, true, false]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 7, param);
          expect(result).assertTrue();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2000
     * @tc.name   : testX509KeyUsageMatchParameter2000
     * @tc.desc   : Empty keyUsage array should throw INVALID_PARAMS
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter2000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: []
        };
        try {
          pemCert7.match(param);
          expect(null).assertFail();
        } catch (err) {
          expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2100
     * @tc.name   : testX509KeyUsageMatchParameter2100
     * @tc.desc   : keyUsage all true does not match cert 0
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509KeyUsageMatchParameter2100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          keyUsage: [true, true, true, true, true, true, true, true, true]
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 0, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2200
     * @tc.name   : testX509SerialNumberMatchParameter2200
     * @tc.desc   : Serial number matches should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509SerialNumberMatchParameter2200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          serialNumber: CERT_DATA_PEM_PARAMETERS[1].serialNumber
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertTrue();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2300
     * @tc.name   : testX509SerialNumberMatchParameter2300
     * @tc.desc   : Serial number mismatch should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509SerialNumberMatchParameter2300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          serialNumber: BigInt(1234567)
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2400
     * @tc.name   : testX509SubjectMatchParameter2400
     * @tc.desc   : Subject matches should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509SubjectMatchParameter2400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          subject: CERT_DATA_PEM_PARAMETERS[1].subject
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertTrue();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2500
     * @tc.name   : testX509SubjectMatchParameter2500
     * @tc.desc   : Subject mismatch should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509SubjectMatchParameter2500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          subject: CERT_DATA_PEM_PARAMETERS[3].subject
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2600
     * @tc.name   : testX509SubjectMatchParameter2600
     * @tc.desc   : Subject as DER bytes (case 1) should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509SubjectMatchParameter2600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          subject: new Uint8Array([0x30, 0x6c, 0x31, 0x0e, 0x30, 0x0c, 0x06, 0x03, 0x55, 0x04, 0x08, 0x13, 0x05, 0x74,
            0x65, 0x73, 0x74, 0x31, 0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02, 0x43, 0x4e, 0x31,
            0x0e, 0x30, 0x0c, 0x06, 0x03, 0x55, 0x04, 0x07, 0x13, 0x05, 0x74, 0x65, 0x73, 0x74, 0x32, 0x31, 0x13, 0x30,
            0x11, 0x06, 0x03, 0x55, 0x04, 0x0a, 0x13, 0x0a, 0x74, 0x65, 0x73, 0x74, 0x45, 0x6e, 0x74, 0x69, 0x74, 0x79,
            0x31, 0x13, 0x30, 0x11, 0x06, 0x03, 0x55, 0x04, 0x0b, 0x13, 0x0a, 0x74, 0x65, 0x73, 0x74, 0x45, 0x6e, 0x74,
            0x69, 0x74, 0x79, 0x31, 0x13, 0x30, 0x11, 0x06, 0x03, 0x55, 0x04, 0x03, 0x13, 0x0a, 0x74, 0x65, 0x73, 0x74,
            0x45, 0x6e, 0x74, 0x69, 0x74, 0x79])
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 0, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2700
     * @tc.name   : testX509SubjectMatchParameter2700
     * @tc.desc   : Subject as DER bytes (case 2) should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509SubjectMatchParameter2700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          subject: new Uint8Array([0x30, 0x6c, 0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02, 0x45,
            0x4e,
            0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x06, 0x13, 0x02, 0x43, 0x4e, 0x31, 0x10, 0x30, 0x0e, 0x06,
            0x03, 0x55, 0x04, 0x08, 0x13, 0x07, 0x4a, 0x69, 0x61, 0x6e, 0x67, 0x73, 0x75, 0x31, 0x10, 0x30, 0x0e, 0x06,
            0x03, 0x55, 0x04, 0x07, 0x13, 0x07, 0x4e, 0x61, 0x6e, 0x6a, 0x69, 0x6e, 0x67, 0x31, 0x0b, 0x30, 0x09, 0x06,
            0x03, 0x55, 0x04, 0x0a, 0x13, 0x02, 0x74, 0x73, 0x31, 0x0b, 0x30, 0x09, 0x06, 0x03, 0x55, 0x04, 0x0b, 0x13,
            0x02, 0x74, 0x73, 0x31, 0x12, 0x30, 0x10, 0x06, 0x03, 0x55, 0x04, 0x03, 0x13, 0x09, 0x31, 0x32, 0x37, 0x2e,
            0x30, 0x2e, 0x30, 0x2e, 0x31])
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 9, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2800
     * @tc.name   : testX509SubjectMatchParameter2800
     * @tc.desc   : Short subject DER should throw ERR_CRYPTO_OPERATION
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509SubjectMatchParameter2800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          subject: new Uint8Array([0x30, 0x6c, 0x31])
        };
        try {
          pemCert1.match(param);
          expect(null).assertFail();
        } catch (err) {
          expect(err.code).assertEqual(cert.CertResult.ERR_CRYPTO_OPERATION);
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_2900
     * @tc.name   : testX509SubjectMatchParameter2900
     * @tc.desc   : Empty subject DER should throw INVALID_PARAMS
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509SubjectMatchParameter2900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          subject: new Uint8Array()
        };
        try {
          pemCert1.match(param);
          expect(null).assertFail();
        } catch (err) {
          expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_3000
     * @tc.name   : testX509PublicKeyMatchParameter3000
     * @tc.desc   : Public key matches should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509PublicKeyMatchParameter3000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          publicKey: CERT_DATA_PEM_PARAMETERS[1].publicKey
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertTrue();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_3100
     * @tc.name   : testX509PublicKeyMatchParameter3100
     * @tc.desc   : Public key structure mismatch should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509PublicKeyMatchParameter3100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          publicKey: {
            data: new Uint8Array([0x30, 0x82, 0x01])
          }
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_3200
     * @tc.name   : testX509PublicKeyMatchParameter3200
     * @tc.desc   : Empty public key data should throw INVALID_PARAMS
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509PublicKeyMatchParameter3200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          publicKey: {
            data: new Uint8Array()
          }
        };
        try {
          pemCert1.match(param);
          expect(null).assertFail();
        } catch (err) {
          expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_3300
     * @tc.name   : testX509PublicKeyAlgIDMatchParameter3300
     * @tc.desc   : Public key AlgID matches should return true
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509PublicKeyAlgIDMatchParameter3300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          publicKeyAlgID: CERT_DATA_PEM_PARAMETERS[1].publicKeyAlgID
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertTrue();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_3400
     * @tc.name   : testX509PublicKeyAlgIDMatchParameter3400
     * @tc.desc   : Public key AlgID mismatch should return false
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509PublicKeyAlgIDMatchParameter3400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          publicKeyAlgID: '1.2.3.4'
        };
        try {
          const result = await certFunc.checkCertMatchParam(PEM, 1, param);
          expect(result).assertFalse();
        } catch (err) {
          expect(null).assertFail();
        }
        done();
      });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Cert_Match_Func_3500
     * @tc.name   : testX509PublicKeyAlgIDMatchParameter3500
     * @tc.desc   : Empty public key AlgID should throw INVALID_PARAMS
     * @tc.size   : MediumTest
     * @tc.level  : Level2
     * @tc.type   : Function
     */
    it("testX509PublicKeyAlgIDMatchParameter3500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const param: cert.X509CertMatchParameters = {
          publicKeyAlgID: ''
        };
        try {
          pemCert1.match(param);
          expect(null).assertFail();
        } catch (err) {
          expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
        }
        done();
      });
  });
}