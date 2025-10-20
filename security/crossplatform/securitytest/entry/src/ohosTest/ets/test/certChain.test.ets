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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, TestType, Size, Level, expect } from "@ohos/hypium";
import cert from '@ohos.security.cert';
import * as certChainFunc from "../certChain/certChainFunc";
import { CERT_CHAIN_DATA_PEM_PARAMETERS } from '../common/commonParam';

export default function certFrameworkCertChainJsAPIFunctionTestUnit() {
  describe("certFrameworkCertChainJsAPIFunctionTestUnit", () => {
    let certChain0: cert.X509CertChain = {} as cert.X509CertChain;
    let rootCaCert0: cert.X509Cert = {} as cert.X509Cert;
    let leafCert: cert.X509Cert = {} as cert.X509Cert;
    let parentCert0: cert.X509Cert = {} as cert.X509Cert;
    let otherCert: cert.X509Cert = {} as cert.X509Cert;
    console.info("##########start certFrameworkCertChainJsAPIFunctionTestUnit##########");
    beforeAll(async () => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
      // Create X509 certChain0-certChain2
      try {
        certChain0 = await certChainFunc.createX509CertChainPromise("pem", 0);
        expect(certChain0 != null).assertTrue();
      } catch (err) {
        console.error("createX509CertChain(inStream: EncodingBlob) error", err);
        expect(null).assertFail();
      }
      // Create Root X509 Cert, Leaf X509 Cert, Parent X509 Cert
      try {
        parentCert0 = await certChainFunc.createCustomizedX509CertPromise('pem', 3);
        rootCaCert0 = await certChainFunc.createCustomizedX509CertPromise('pem', 2);
        leafCert = await certChainFunc.createCustomizedX509CertPromise('pem', 0);
        otherCert = await certChainFunc.createCustomizedX509CertPromise('pem', 5);
        expect(parentCert0 != null).assertTrue();
        expect(rootCaCert0 != null).assertTrue();
        expect(leafCert != null).assertTrue();
        expect(otherCert != null).assertTrue();
      } catch (err) {
        console.error("createX509Cert error", err);
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
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0100
     * @tc.name   : testCertChainValidate0100
     * @tc.desc   : Test cert chain validation with null parameter
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await certChain0.validate(null);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0200
     * @tc.name   : testCertChainValidate0200
     * @tc.desc   : Test cert chain validation with undefined parameter
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await certChain0.validate(undefined);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0300
     * @tc.name   : testCertChainValidate0300
     * @tc.desc   : Test cert chain validation with invalid date format
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "abc",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };

      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0400
     * @tc.name   : testCertChainValidate0400
     * @tc.desc   : Test cert chain validation with date before validity period
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "20230101000000Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };

      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CERT_NOT_YET_VALID);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0500
     * @tc.name   : testCertChainValidate0500
     * @tc.desc   : Test cert chain validation with boundary date before validity
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "20231223235959Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };

      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CERT_NOT_YET_VALID);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0600
     * @tc.name   : testCertChainValidate0600
     * @tc.desc   : Test cert chain validation at validity start time
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "20231224000000Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0700
     * @tc.name   : testCertChainValidate0700
     * @tc.desc   : Test cert chain validation within validity period
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "20231224000001Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }

      param = {
        date: "20241223235958Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0800
     * @tc.name   : testCertChainValidate0800
     * @tc.desc   : Test cert chain validation at validity end time
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "20241223235959Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_0900
     * @tc.name   : testCertChainValidate0900
     * @tc.desc   : Test cert chain validation with expired date
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "20241224000000Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };

      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CERT_HAS_EXPIRED);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1000
     * @tc.name   : testCertChainValidate1000
     * @tc.desc   : Test cert chain validation with far future date
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate1000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        date: "20300101000000Z",
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };

      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CERT_HAS_EXPIRED);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1100
     * @tc.name   : testCertChainValidate1100
     * @tc.desc   : Test cert chain validation with empty trust anchor
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate1100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{}]
      };

      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1200
     * @tc.name   : testCertChainValidate1200
     * @tc.desc   : Test cert chain validation with CA subject only
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate1200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject
        }]
      };

      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1300
     * @tc.name   : testCertChainValidate1300
     * @tc.desc   : Test cert chain validation with root CA cert as trust anchor
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate1300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };

      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1400
     * @tc.name   : testCertChainValidate1400
     * @tc.desc   : Test cert chain validation with parent CA cert as trust anchor
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate1400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: parentCert0
        }]
      };
      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == parentCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1500
     * @tc.name   : testCertChainValidate1500
     * @tc.desc   : Test cert chain validation with different cert chain and parent cert
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate1500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let certChain2: cert.X509CertChain = {} as cert.X509CertChain;
      try {
        certChain2 = await certChainFunc.createX509CertChainPromise("pem", 3);
        expect(certChain2 != null).assertTrue();
      } catch (err) {
        console.error("createX509CertChain(inStream: EncodingBlob) error", err);
        expect(null).assertFail();
      }

      let parentCert2: cert.X509Cert = {} as cert.X509Cert;
      try {
        parentCert2 = await certChainFunc.createCustomizedX509CertPromise('pem', 4);
        expect(parentCert2 != null).assertTrue();
      } catch (err) {
        console.error("createX509Cert error", err);
        expect(null).assertFail();
      }

      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: parentCert2
        }]
      };
      try {
        const validRes = await certChain2.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == parentCert2.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1600
     * @tc.name   : testCertChainValidate1600
     * @tc.desc   : Test cert chain validation with unrelated grandparent cert
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate1600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let grandparentCert: cert.X509Cert = {} as cert.X509Cert;
      try {
        grandparentCert = await certChainFunc.createCustomizedX509CertPromise('pem', 4);
        expect(grandparentCert != null).assertTrue();
      } catch (err) {
        console.error("createX509Cert error", err);
        expect(null).assertFail();
      }

      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: grandparentCert
        }]
      };
      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1700
     * @tc.name   : testCertChainValidate1700
     * @tc.desc   : Test cert chain validation with leaf cert as trust anchor
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate1700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: leafCert
        }]
      };
      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1800
     * @tc.name   : testCertChainValidate1800
     * @tc.desc   : Test cert chain validation with unrelated other cert
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate1800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: otherCert
        }]
      };
      try {
        await certChain0.validate(param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_1900
     * @tc.name   : testCertChainValidate1900
     * @tc.desc   : Test cert chain validation with another cert chain and root cert
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate1900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let certChain3: cert.X509CertChain = {} as cert.X509CertChain;
      try {
        certChain3 = await certChainFunc.createX509CertChainPromise("pem", 4);
        expect(certChain3 != null).assertTrue();
      } catch (err) {
        console.error("createX509CertChain(inStream: EncodingBlob) error", err);
        expect(null).assertFail();
      }

      let rootCert3: cert.X509Cert = {} as cert.X509Cert;
      try {
        rootCert3 = await certChainFunc.createCustomizedX509CertPromise('pem', 4);
        expect(rootCert3 != null).assertTrue();
      } catch (err) {
        console.error("createX509Cert error", err);
        expect(null).assertFail();
      }

      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: rootCert3
        }]
      };
      try {
        const validRes = await certChain3.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCert3.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2000
     * @tc.name   : testCertChainValidate2000
     * @tc.desc   : Test cert chain validation with mismatched cert chain and root cert
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate2000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let certChain3: cert.X509CertChain = {} as cert.X509CertChain;
      try {
        certChain3 = await certChainFunc.createX509CertChainPromise("pem", 4);
        expect(certChain3 != null).assertTrue();
      } catch (err) {
        console.error("createX509CertChain(inStream: EncodingBlob) error", err);
        expect(null).assertFail();
      }

      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain3, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2100
     * @tc.name   : testCertChainValidate2100
     * @tc.desc   : Test cert chain validation with single cert chain
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate2100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let oneCert: cert.X509Cert = {} as cert.X509Cert;
      let certChainOne: cert.X509CertChain = {} as cert.X509CertChain;
      try {
        oneCert = await certChainFunc.createCustomizedX509CertPromise('pem', 5);
        expect(oneCert != null).assertTrue();
      } catch (err) {
        console.error("createX509Cert error", err);
        expect(null).assertFail();
      }
      try {
        certChainOne = await certChainFunc.createX509CertChainPromise("pem", 1);
        expect(certChainOne != null).assertTrue();
      } catch (err) {
        console.error("createX509CertChain(inStream: EncodingBlob) error", err);
        expect(null).assertFail();
      }

      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: oneCert
        }]
      };
      try {
        const validRes = await certChainOne.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == oneCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == oneCert.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2200
     * @tc.name   : testCertChainValidate2200
     * @tc.desc   : Test cert chain validation with CA cert and public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate2200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CACert: rootCaCert0,
            CAPubKey: new Uint8Array([0x30, 0x67, 0x31])
          }
        ]
      };
      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CACert != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2300
     * @tc.name   : testCertChainValidate2300
     * @tc.desc   : Test cert chain validation with CA public key only
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate2300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey
        }]
      };
      try {
        const validRes = await certChain0.validate(param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CAPubKey != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CAPubKey?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey?.toString())
          .assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2400
     * @tc.name   : testCertChainValidate2400
     * @tc.desc   : Test cert chain validation with parent CA public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate2400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[1].publicKey
        }]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CAPubKey != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CAPubKey?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[1].publicKey?.toString())
          .assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2500
     * @tc.name   : testCertChainValidate2500
     * @tc.desc   : Test cert chain validation with leaf cert public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate2500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[0].publicKey
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2600
     * @tc.name   : testCertChainValidate2600
     * @tc.desc   : Test cert chain validation with wrong public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate2600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[3].publicKey
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2700
     * @tc.name   : testCertChainValidate2700
     * @tc.desc   : Test cert chain validation with invalid public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate2700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[4].publicKey
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2800
     * @tc.name   : testCertChainValidate2800
     * @tc.desc   : Test cert chain validation with empty public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate2800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CAPubKey: new Uint8Array()
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_2900
     * @tc.name   : testCertChainValidate2900
     * @tc.desc   : Test cert chain validation with CA subject only
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate2900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3000
     * @tc.name   : testCertChainValidate3000
     * @tc.desc   : Test cert chain validation with CA subject and public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate3000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject,
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey,
          }
        ]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CAPubKey != null).assertTrue();
        expect(validRes.trustAnchor.CASubject != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CAPubKey?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey?.toString())
          .assertTrue();
        expect(validRes.trustAnchor.CASubject?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject?.toString())
          .assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3100
     * @tc.name   : testCertChainValidate3100
     * @tc.desc   : Test cert chain validation with mismatched CA subject and public key
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate3100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject,
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[1].publicKey,
          }
        ]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3200
     * @tc.name   : testCertChainValidate3200
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate3200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[1].subject,
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[1].publicKey,
          }
        ]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CAPubKey != null).assertTrue();
        expect(validRes.trustAnchor.CASubject != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CAPubKey?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[1].publicKey?.toString())
          .assertTrue();
        expect(validRes.trustAnchor.CASubject?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[1].subject?.toString())
          .assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3300
     * @tc.name   : testCertChainValidate3300
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate3300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[0].subject,
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey,
          }
        ]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3400
     * @tc.name   : testCertChainValidate3400
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate3400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[3].subject,
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey,
          }
        ]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CRYPTO_OPERATION);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3500
     * @tc.name   : testCertChainValidate3500
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate3500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CASubject: new Uint8Array(),
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey,
          }
        ]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3600
     * @tc.name   : testCertChainValidate3600
     * @tc.desc   : Test cert chain validation with multiple trust anchors
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate3600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CACert: rootCaCert0,
          },
          {
            CACert: otherCert
          }
        ]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CACert != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3700
     * @tc.name   : testCertChainValidate3700
     * @tc.desc   : Test cert chain validation with root and parent CA trust anchors
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate3700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        trustAnchors: [
          {
            CACert: rootCaCert0,
          },
          {
            CACert: parentCert0
          }
        ]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CACert != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3800
     * @tc.name   : testCertChainValidate3800
     * @tc.desc   : Test cert chain validation with CRL revocation check
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate3800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const crl = await certChainFunc.createX509CrlPromise(0);
      let certCrl = cert.createCertCRLCollection([], [crl]);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CRYPTO_OPERATION);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_3900
     * @tc.name   : testCertChainValidate3900
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate3900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const crl = await certChainFunc.createX509CrlPromise(1);
      let certCrl = cert.createCertCRLCollection([], [crl]);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CRYPTO_OPERATION);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4000
     * @tc.name   : testCertChainValidate4000
     * @tc.desc   : Test cert chain validation with valid CRL
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate4000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const crl = await certChainFunc.createX509CrlPromise(2);
      let certCrl = cert.createCertCRLCollection([], [crl]);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4100
     * @tc.name   : testCertChainValidate4100
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate4100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const crl1 = await certChainFunc.createX509CrlPromise(1);
      const crl2 = await certChainFunc.createX509CrlPromise(2);
      let certCrl = cert.createCertCRLCollection([], [crl1, crl2]);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.ERR_CRYPTO_OPERATION);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4200
     * @tc.name   : testCertChainValidate4200
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate4200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let param: cert.CertChainValidationParameters = {
        certCRLs: [],
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4300
     * @tc.name   : testCertChainValidate4300
     * @tc.desc   : Test cert chain validation with certificate collection
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate4300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let certCrl = cert.createCertCRLCollection([rootCaCert0]);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4400
     * @tc.name   : testCertChainValidate4400
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate4400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let certCrl = cert.createCertCRLCollection([rootCaCert0], []);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [{
          CACert: rootCaCert0
        }]
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4500
     * @tc.name   : testCertChainValidate4500
     * @tc.desc   : Test cert chain validation with comprehensive parameters
     * @tc.size   : MediumTest
     * @tc.level  : Level 1
     * @tc.type   : Function
     */
    it("testCertChainValidate4500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let certCrl = cert.createCertCRLCollection([rootCaCert0], []);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [
          {
            CACert: rootCaCert0,
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey,
            CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject,
          }
        ],
        date: '20231231000000Z'
      };
      try {
        const validRes = await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(validRes != null).assertTrue();
        expect(validRes.entityCert != null).assertTrue();
        expect(validRes.trustAnchor != null).assertTrue();
        expect(validRes.trustAnchor.CACert != null).assertTrue();
        expect(validRes.trustAnchor.CAPubKey != null).assertTrue();
        expect(validRes.trustAnchor.CASubject != null).assertTrue();
        expect(validRes.entityCert.getCertSerialNumber() == leafCert.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CACert?.getCertSerialNumber() == rootCaCert0.getCertSerialNumber()).assertTrue();
        expect(validRes.trustAnchor.CAPubKey?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey?.toString())
          .assertTrue();
        expect(validRes.trustAnchor.CASubject?.toString() == CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject?.toString())
          .assertTrue();
      } catch (err) {
        console.error("[Promise]X509CertChain validate error: ", err);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4600
     * @tc.name   : testCertChainValidate4600
     * @tc.desc   : Test cert chain validation functionality
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate4600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let certCrl = cert.createCertCRLCollection([rootCaCert0], []);
      let param: cert.CertChainValidationParameters = {
        certCRLs: [certCrl],
        trustAnchors: [
          {
            CACert: otherCert,
            CAPubKey: CERT_CHAIN_DATA_PEM_PARAMETERS[2].publicKey,
            CASubject: CERT_CHAIN_DATA_PEM_PARAMETERS[2].subject,
          }
        ],
        date: '20231231000000Z'
      };
      try {
        await certChainFunc.certChainValidateCallback(certChain0, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_Certificate_Func_4700
     * @tc.name   : testCertChainValidate4700
     * @tc.desc   : Test cert chain validation with invalid cert chain structure
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     * @tc.type   : Function
     */
    it("testCertChainValidate4700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let certChainInvalid: cert.X509CertChain = {} as cert.X509CertChain;
      try {
        certChainInvalid = await certChainFunc.createX509CertChainPromise("pem", 2);
        expect(certChainInvalid != null).assertTrue();
      } catch (err) {
        console.error("createX509CertChain(inStream: EncodingBlob) error", err);
        expect(null).assertFail();
      }

      let param: cert.CertChainValidationParameters = {
        trustAnchors: [{
          CACert: rootCaCert0
        }],
        date: '20231231000000Z'
      };
      try {
        await certChainFunc.certChainValidateCallback(certChainInvalid, param);
        expect(null).assertFail();
      } catch (err) {
        expect(err.code).assertEqual(cert.CertResult.INVALID_PARAMS);
      }
      done();
    });
  });
}