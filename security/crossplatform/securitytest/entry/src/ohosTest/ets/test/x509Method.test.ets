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
import * as certChainFunc from "../certChain/certChainFunc";
import * as certChainFunc3 from "../certChain/certChainFunc3";

export default function x509MethodFunc() {
  describe("x509MethodFuncTestUnit", () => {
    let certChain0: cert.X509CertChain = {} as cert.X509CertChain;
    let rootCaCert0: cert.X509Cert = {} as cert.X509Cert;
    let leafCert: cert.X509Cert = {} as cert.X509Cert;
    let parentCert0: cert.X509Cert = {} as cert.X509Cert;
    let otherCert: cert.X509Cert = {} as cert.X509Cert;
    console.info("##########start certFrameworkCertNameJsAPIFunctionTestUnit##########");
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
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0100
     * @tc.name   : testX509Method0100
     * @tc.desc   : Verify issuer X500 DN equals expected string
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0100';
      let nameString = '/C=BE/O=GlobalSign nv-sa/CN=GlobalSign Extended Validation CA - G2';
      const x509Cert: cert.X509Cert = await certChainFunc3.createX509Cert();
      try {
        let x500DistinguishedName = await x509Cert.getIssuerX500DistinguishedName();
        console.log(`${caseName} getIssuerX500DistinguishedName sucess: ${JSON.stringify(x500DistinguishedName.getName())}`);
        expect(x500DistinguishedName.getName() == nameString).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0200
     * @tc.name   : testX509Method0200
     * @tc.desc   : Verify subject X500 DN equals expected string
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0200';
      const x509Cert: cert.X509Cert = await certChainFunc3.createX509Cert();
      let nameString = certChainFunc3.nameString;
      try {
        let x500DistinguishedName = await x509Cert.getSubjectX500DistinguishedName();
        console.log(`${caseName} getIssuerX500DistinguishedName sucess: ${JSON.stringify(x500DistinguishedName.getName())}`);
        expect(x500DistinguishedName.getName() == nameString).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0300
     * @tc.name   : testX509Method0300
     * @tc.desc   : check X509Cert.toString result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0300';
      const x509Cert: cert.X509Cert = await certChainFunc3.createX509Cert();
      try {
        let toStringData = await x509Cert.toString();
        console.log(`${caseName} toString sucess: ${JSON.stringify(toStringData)}`);
        expect(toStringData != null).assertTrue();
        expect(toStringData.length == 4365).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0400
     * @tc.name   : testX509Method0400
     * @tc.desc   : Verify X509Cert.hashCode returns 32-byte array
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0400';
      const x509Cert: cert.X509Cert = await certChainFunc3.createX509Cert();
      try {
        let hashCodeData = await x509Cert.hashCode();
        console.log(`${caseName} hashCode sucess: ${JSON.stringify(hashCodeData)}`);
        expect(hashCodeData != null).assertTrue();
        expect(hashCodeData.length == 32).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0500
     * @tc.name   : testX509Method0500
     * @tc.desc   : Verify X509Cert extensions object fields and length
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0500';
      const x509Cert: cert.X509Cert = await certChainFunc3.createX509Cert();
      try {
        let certExtension = await x509Cert.getExtensionsObject();
        console.log(`${caseName} getExtensionsObject sucess: ${JSON.stringify(certExtension.getEncoded())}`);
        expect(certExtension != null).assertTrue();
        expect(certExtension.getEncoded().data.length == 711).assertTrue();
        expect(certExtension.checkCA() == -1).assertTrue();
        expect(certExtension.hasUnsupportedCriticalExtension() == false).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0600
     * @tc.name   : testX509Method0600
     * @tc.desc   : check X509CRLEntry.getCertIssuerX500DistinguishedName result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0600';
      const x509CRL: cert.X509CRL = await certChainFunc3.createX509CrlEntryTest1();
      try {
        let x500DistinguishedName = await x509CRL.getRevokedCert(BigInt(1000)).getCertIssuerX500DistinguishedName();
        console.log(`${caseName} getIssuerX500DistinguishedName sucess: ${JSON.stringify(x500DistinguishedName.getName())}`);
        expect(x500DistinguishedName.getName() == '/CN=CRL issuer').assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0700
     * @tc.name   : testX509Method0700
     * @tc.desc   : Verify CRL entry issuer X500 DN equals expected string
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0700';
      const x509CRL: cert.X509CRL = await certChainFunc3.createX509CrlEntryTest1();
      try {
        let x500DistinguishedName = await x509CRL.getRevokedCert(BigInt(1000)).getCertIssuerX500DistinguishedName();
        console.log(`${caseName} getIssuerX500DistinguishedName sucess: ${JSON.stringify(x500DistinguishedName.getName())}`);
        expect(x500DistinguishedName.getName() == '/CN=CRL issuer').assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0800
     * @tc.name   : testX509Method0800
     * @tc.desc   : Verify CRL entry hashCode returns 32-byte array
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0800';
      const x509CRL: cert.X509CRL = await certChainFunc3.createX509CrlEntryTest1();
      try {
        let hashCodeData = await x509CRL.getRevokedCert(BigInt(1000)).hashCode();
        console.log(`${caseName} hashCode sucess: ${JSON.stringify(hashCodeData)}`);
        expect(hashCodeData != null).assertTrue();
        expect(hashCodeData.length == 32).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_0900
     * @tc.name   : testX509Method0900
     * @tc.desc   : Verify CRL entry extensions fields and encoded length
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method0900';
      const x509CRLEntry: cert.X509CRL = await certChainFunc3.createX509CrlEntryTest3();
      let serialNumber = BigInt('14091103387070223745671018446433705560');
      try {
        let certExtension = await x509CRLEntry.getRevokedCert(serialNumber).getExtensionsObject();
        console.log(`${caseName} getExtensionsObject sucess: ${JSON.stringify(certExtension.getEncoded())}`);
        expect(certExtension != null).assertTrue();
        expect(certExtension.getEncoded().data.length == 14).assertTrue();
        expect(certExtension.hasUnsupportedCriticalExtension() == false).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1000
     * @tc.name   : testX509Method1000
     * @tc.desc   : check X509CRL.getIssuerX500DistinguishedName result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1000';
      const x509CRL: cert.X509CRL = await certChainFunc3.createX509Crl();
      try {
        let x500DistinguishedName = await x509CRL.getIssuerX500DistinguishedName();
        console.log(`${caseName} getIssuerX500DistinguishedName sucess: ${JSON.stringify(x500DistinguishedName.getName())}`);
        expect(x500DistinguishedName.getName() == '/C=CN/ST=Jiangsu/L=Nanjing/O=ts/OU=ts/CN=ts').assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1100
     * @tc.name   : testX509Method1100
     * @tc.desc   : Verify X509CRL.toString returns expected length
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1100';
      const x509CRL: cert.X509CRL = await certChainFunc3.createX509Crl();
      try {
        let toStringData = await x509CRL.toString();
        console.log(`${caseName} toString sucess: ${JSON.stringify(toStringData)}`);
        expect(toStringData != null).assertTrue();
        expect(toStringData.length == 2086).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1200
     * @tc.name   : testX509Method1200
     * @tc.desc   : check X509CRL.hashCode result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1200';
      const x509CRL: cert.X509CRL = await certChainFunc3.createX509Crl();
      try {
        let hashCodeData = await x509CRL.hashCode();
        console.log(`${caseName} hashCode sucess: ${JSON.stringify(hashCodeData)}`);
        expect(hashCodeData != null).assertTrue();
        expect(hashCodeData.length == 32).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1300
     * @tc.name   : testX509Method1300
     * @tc.desc   : Verify X509Cert extensions fields and encoded length
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1300';
      const x509Cert: cert.X509Cert = await certChainFunc3.createX509Cert();
      try {
        let certExtension = await x509Cert.getExtensionsObject();
        console.log(`${caseName} getExtensionsObject sucess: ${JSON.stringify(certExtension.getEncoded())}`);
        expect(certExtension != null).assertTrue();
        expect(certExtension.getEncoded().data.length == 711).assertTrue();
        expect(certExtension.checkCA() == -1).assertTrue();
        expect(certExtension.hasUnsupportedCriticalExtension() == false).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1400  
     * @tc.name   : testX509Method1400
     * @tc.desc   : check X509CertChain.toString result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1400';
      const x509CertChain: cert.X509CertChain = await certChainFunc3.createX509CertChain1();
      try {
        let toStringData = await x509CertChain.toString();
        console.log(`${caseName} toString sucess: ${JSON.stringify(toStringData)}`);
        expect(toStringData != null).assertTrue();
        expect(toStringData.length == 10133).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1500
     * @tc.name   : testX509Method1500
     * @tc.desc   : check X509CertChain.hashCode result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1500';
      const x509CertChain: cert.X509CertChain = await certChainFunc3.createX509CertChain1();
      try {
        let hashCodeData = await x509CertChain.hashCode();
        console.log(`${caseName} hashCode sucess: ${JSON.stringify(hashCodeData)}`);
        expect(hashCodeData != null).assertTrue();
        expect(hashCodeData.length == 32).assertTrue();
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1600
     * @tc.name   : testX509Method1600
     * @tc.desc   : check X500DistinguishedName.getName() result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1600';
      let nameStr = '/CN=John Doe/OU=IT Department/O=ACME Inc./L=San Francisco/ST=California/C=US/CN=ALN C/CN=XTS';
      try {
        cert.createX500DistinguishedName(nameStr)
          .then((data) => {
            console.log(`${caseName} createX500DistinguishedName sucess: ${JSON.stringify(data.getName())}`);
            expect(data.getName() == nameStr).assertTrue();
            done();
          })
          .catch((err: BusinessError<number>) => {
            console.error(`${caseName} createX500DistinguishedName failed,err: ${JSON.stringify(err)}`);
            expect(null).assertFail();
            done();
          })
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1700
     * @tc.name   : testX509Method1700
     * @tc.desc   : check X500DistinguishedName.getName(type) result
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1700';
      let nameStr = '/CN=John Doe/OU=IT Department/O=ACME Inc./L=San Francisco/ST=California/C=US/CN=ALN C/CN=XTS';
      let nameType = 'CN';
      try {
        cert.createX500DistinguishedName(nameStr)
          .then((data) => {
            console.log(`${caseName} createX500DistinguishedName sucess: ${JSON.stringify(data.getName(nameType))}`);
            expect(data.getName(nameType)[0] == 'John Doe').assertTrue();
            expect(data.getName(nameType)[1] == 'ALN C').assertTrue();
            expect(data.getName(nameType)[2] == 'XTS').assertTrue();
            done();
          })
          .catch((err: BusinessError<number>) => {
            console.error(`${caseName} createX500DistinguishedName failed,err: ${JSON.stringify(err)}`);
            expect(null).assertFail();
            done();
          })
      } catch (error) {
        console.error(`${caseName} catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1800
     * @tc.name   : testX509Method1800
     * @tc.desc   : check X500DistinguishedName.getName(type)result,param type abnormal
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1800';
      let nameStr = '/CN=John Doe/OU=IT Department/O=ACME Inc./L=San Francisco/ST=California/C=US/CN=ALN C/CN=XTS';
      let nameType = 'abc';
      try {
        cert.createX500DistinguishedName(nameStr)
          .then((data) => {
            console.log(`${caseName} createX500DistinguishedName sucess: ${JSON.stringify(data.getName(nameType))}`);
            expect(data.getName(nameType) == undefined).assertTrue();
            done();
          })
          .catch((err: BusinessError<number>) => {
            console.error(`${caseName} createX500DistinguishedName failed,err: ${JSON.stringify(err)}`);
            expect(null).assertFail();
            done();
          })
      } catch (error) {
        console.error(`${caseName} createX500DistinguishedName catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });

    /**
     * @tc.number : SUB_SECURITY_CERT_Framework_CertName_Func_1900
     * @tc.name   : testX509Method1900
     * @tc.desc   : check X500DistinguishedName.getName(type)result,param type empty
     * @tc.size   : MediumTest
     * @tc.level  : Level1
     * @tc.type   : Function
     */
    it("testX509Method1900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName = 'testX509Method1900';
      let nameStr = '/CN=John Doe/OU=IT Department/O=ACME Inc./L=San Francisco/ST=California/C=US/CN=ALN C/CN=XTS';
      let nameType = '';
      try {
        cert.createX500DistinguishedName(nameStr)
          .then((data) => {
            console.log(`${caseName} createX500DistinguishedName sucess: ${JSON.stringify(data.getName())}`);
            try {
              data.getName(nameType);
            } catch (err) {
              console.error(`${caseName} getName catch error: ${JSON.stringify(err)}`);
              expect(err.code == cert.CertResult.INVALID_PARAMS).assertTrue();
              done();
            }
          })
          .catch((err: BusinessError<number>) => {
            console.error(`${caseName} createX500DistinguishedName failed,err: ${JSON.stringify(err)}`);
            expect(null).assertFail();
            done();
          })
      } catch (error) {
        console.error(`${caseName} createX500DistinguishedName catch error: ${JSON.stringify(error)}`);
        expect(null).assertFail();
        done();
      }
    });
  });
}
