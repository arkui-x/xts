/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { describe, beforeAll, afterAll, it, expect, beforeEach } from '@ohos/hypium';
import certFramework from '@ohos.security.cert';
import { BusinessError } from '@ohos.base';
import cryptoFramework from '@ohos.security.cryptoFramework';
import { certDataDer, pubKeyData, priKeyData, extData } from "./utils/publicParam";
import { getEncodingBlob, getEncodingBlobCrl, getEncodingBlobForCrlTest, dataArray, sleep } from "./utils/index";

let x509CertPem: certFramework.X509Cert;
let x509CertDer: certFramework.X509Cert;


let encodingBlobExtDer: certFramework.EncodingBlob = {
  data: extData,
  encodingFormat: certFramework.EncodingFormat.FORMAT_DER
};

let certExt: certFramework.CertExtension;

let x509CrlPem: certFramework.X509CRL;
let x509CrlPemRevoked: certFramework.X509CRL;


let X509CertForCrlTest_normal: certFramework.X509Cert;
let X509CertForCrlTest_error: certFramework.X509Cert;

// Generate the public key by AsyKeyGenerator.
let keyGenerator: cryptoFramework.AsyKeyGenerator = cryptoFramework.createAsyKeyGenerator('RSA1024|PRIMES_3');
let priEncodingBlob: cryptoFramework.DataBlob = {
  data: priKeyData,
};
let pubEncodingBlob: cryptoFramework.DataBlob = {
  data: pubKeyData,
};
let keyPair: cryptoFramework.KeyPair;

let serialNumber: bigint = BigInt(1000);
let crlEntryPem: certFramework.X509CRLEntry;

export default function certTest() {
  describe('certTest', async () => {
    beforeAll(async () => {
      console.log('************* start certificateTest *************');
      x509CertPem = await certFramework.createX509Cert(getEncodingBlob('pem'));
      x509CertDer = await certFramework.createX509Cert({
        data: certDataDer,
        encodingFormat: certFramework.EncodingFormat.FORMAT_DER,
      });
      x509CrlPem = await certFramework.createX509CRL(getEncodingBlobCrl('pem'));
      x509CrlPemRevoked = await certFramework.createX509CRL(getEncodingBlobCrl('pem', true));

      certExt = await certFramework.createCertExtension(encodingBlobExtDer)

      X509CertForCrlTest_normal = await certFramework.createX509Cert(getEncodingBlobForCrlTest('normal'));
      X509CertForCrlTest_error = await certFramework.createX509Cert(getEncodingBlobForCrlTest('error'));

      keyPair = await keyGenerator.convertKey(pubEncodingBlob, priEncodingBlob)

      crlEntryPem = x509CrlPem.getRevokedCert(serialNumber);
    })
    beforeEach(async () => {
      await sleep(200)
    })
    afterAll(() => {
      console.log('************* end certificateTest *************');
    })
    /* *
    * @tc.number:  SUB_Security_Cert_Framework_createX509Cert_Func_0100
    * @tc.name:    test createX509Cert method in callback mode
    * @tc.desc:    create X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_createX509Cert_Func_0100', 0, async (done: Function) => {
      certFramework.createX509Cert(getEncodingBlob('pem'), (err, x509Cert) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0100 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
        } else {
          console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0100 ${JSON.stringify(x509Cert)}}`);
          expect(x509Cert != null).assertTrue();
        }
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Security_Cert_Framework_createX509Cert_Func_0200
    * @tc.name:    test createX509Cert method in callback mode
    * @tc.desc:    create X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_createX509Cert_Func_0200', 0, async (done: Function) => {
      certFramework.createX509Cert(getEncodingBlob('der'), (err, x509Cert) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0200 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
        } else {
          console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0200 ${JSON.stringify(x509Cert)}`);
          expect(x509Cert != null).assertTrue();
        }
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Security_Cert_Framework_createX509Cert_Func_0300
    * @tc.name:    test createX509Cert method in promise mode
    * @tc.desc:    create X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_createX509Cert_Func_0300', 0, async (done: Function) => {
      certFramework.createX509Cert(getEncodingBlob('pem')).then(x509Cert => {
        console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0300 ${JSON.stringify(x509Cert)}`);
        expect(x509Cert != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0300 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0300 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Security_Cert_Framework_createX509Cert_Func_0400
    * @tc.name:    test createX509Cert method in promise mode
    * @tc.desc:    create X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_createX509Cert_Func_0400', 0, async (done: Function) => {
      certFramework.createX509Cert(getEncodingBlob('der')).then(x509Cert => {
        console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0400 ${JSON.stringify(x509Cert)}`);
        expect(x509Cert != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0400 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_createX509Cert_Func_0400 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Security_Cert_Framework_verify_Func_0500
    * @tc.name:    test Verify method in callback mode
    * @tc.desc:    Verify X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_verify_Func_0500', 0, async (done: Function) => {
      let pubKey: cryptoFramework.PubKey = x509CertPem.getPublicKey();
      console.log(`SUB_Security_Cert_Framework_verify_Func_0500 pub ${pubKey}`);
      x509CertPem.verify(pubKey, (err) => {
        console.log(`SUB_Security_Cert_Framework_verify_Func_0500 ${err}`)
        expect(err == null).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Security_Cert_Framework_verify_Func_0600
    * @tc.name:    test Verify method in promise mode
    * @tc.desc:    Verify X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_verify_Func_0600', 0, async (done: Function) => {
      let pubKey: cryptoFramework.PubKey = x509CertPem.getPublicKey();
      x509CertPem.verify(pubKey).then(err => {
        console.log(`SUB_Security_Cert_Framework_verify_Func_0600 ${JSON.stringify(err)}`);
        expect(err == null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_verify_Func_0600 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_verify_Func_0600 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Security_Cert_Framework_getEncoded_Func_0700
    * @tc.name:    test getEncoded method in callback mode
    * @tc.desc:    get Encoded X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_getEncoded_Func_0700', 0, async (done: Function) => {
      x509CertPem.getEncoded((err, data) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_getEncoded_Func_0700 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Security_Cert_Framework_getEncoded_Func_0700 ${data}`);
          expect(data != null).assertTrue();
          done();
        }
      });
    })

    /* *
    * @tc.number:  SUB_Security_Cert_Framework_getEncoded_Func_0800
    * @tc.name:    test getEncoded method in promise mode
    * @tc.desc:    get Encoded X509Cert
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Security_Cert_Framework_getEncoded_Func_0800', 0, async (done: Function) => {
      x509CertPem.getEncoded().then(data => {
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_0800 ${data}`);
        expect(data != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_0800 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getPublicKey_Func_0900
     * @tc.name:    test getPublicKey method
     * @tc.desc:    get the public key of X509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getPublicKey_Func_0900', 0, async (done: Function) => {
      try {
        let pubKey: cryptoFramework.PubKey = x509CertPem.getPublicKey();
        console.log(`SUB_Security_Cert_Framework_getPublicKey_Func_0900 ${pubKey}`);
        expect(pubKey != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getPublicKey_Func_0900 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_checkValidityWithDate_Func_1000
     * @tc.name:    test checkValidityWithDate method
     * @tc.desc:    Verify the certificate validity period
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_checkValidityWithDate_Func_1000', 0, async (done: Function) => {
      let date: string = '20220830000001Z';
      // Verify the certificate validity period.
      try {
        x509CertPem.checkValidityWithDate(date);
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_checkValidityWithDate_Func_1000 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_checkValidityWithDate_Func_1000 errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_checkValidityWithDate_Func_1100
     * @tc.name:    test checkValidityWithDate method
     * @tc.desc:    Verify the certificate validity period
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_checkValidityWithDate_Func_1100', 0, async (done: Function) => {
      let date: string = '29990830000000Z';
      // Verify the certificate validity period.
      try {
        x509CertPem.checkValidityWithDate(date);
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_checkValidityWithDate_Func_1100 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_checkValidityWithDate_Func_1100 errMsg: ${err.message}`);
        expect(err.code).assertEqual(19030004);
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getVersion_Func_1200
     * @tc.name:    test getVersion method
     * @tc.desc:    get Version of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getVersion_Func_1200', 0, async (done: Function) => {
      try {
        let version: number = x509CertPem.getVersion();
        console.log(`SUB_Security_Cert_Framework_getVersion_Func_1200 ${version}`);
        expect(version).assertInstanceOf('Number');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getVersion_Func_1200 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getVersion_Func_1200 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getCertSerialNumber_Func_1300
     * @tc.name:    test getCertSerialNumber method
     * @tc.desc:    get SerialNumber of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getCertSerialNumber_Func_1300', 0, async (done: Function) => {
      try {
        let serialNumber: bigint = x509CertPem.getCertSerialNumber();
        console.log(`SUB_Security_Cert_Framework_getCertSerialNumber_Func_1300 ${serialNumber}`);
        expect(serialNumber).assertInstanceOf('BigInt');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getCertSerialNumber_Func_1300 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getCertSerialNumber_Func_1300 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getIssuerName_Func_1400
     * @tc.name:    test getIssuerName method
     * @tc.desc:    get the IssuerName of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getIssuerName_Func_1400', 0, async (done: Function) => {
      try {
        let issuerName: certFramework.DataBlob = x509CertPem.getIssuerName();
        console.log(`SUB_Security_Cert_Framework_getIssuerName_Func_1400: ${issuerName}`);
        expect(issuerName != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getIssuerName_Func_1400 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getIssuerName_Func_1400 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSubjectName_Func_1500
     * @tc.name:    test getSubjectName method
     * @tc.desc:    get the SubjectName of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSubjectName_Func_1500', 0, async (done: Function) => {
      try {
        let subjectName: certFramework.DataBlob = x509CertPem.getSubjectName();
        console.log(`SUB_Security_Cert_Framework_getSubjectName_Func_1500'${subjectName}`);
        expect(subjectName != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSubjectName_Func_1500 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getSubjectName_Func_1500 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getNotBeforeTime_Func_1600
     * @tc.name:    test getNotBeforeTime method
     * @tc.desc:    get the NotBeforeTime of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getNotBeforeTime_Func_1600', 0, async (done: Function) => {
      try {
        let notBefore: string = x509CertPem.getNotBeforeTime();
        console.log(`SUB_Security_Cert_Framework_getNotBeforeTime_Func_1600 ${notBefore}`);
        expect(notBefore).assertInstanceOf('String');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getNotBeforeTime_Func_1600 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getNotBeforeTime_Func_1600 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getNotAfterTime_Func_1700
     * @tc.name:    test getNotAfterTime method
     * @tc.desc:    get the NotAfterTime of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getNotAfterTime_Func_1700', 0, async (done: Function) => {
      try {
        let notAfter: string = x509CertPem.getNotAfterTime();
        console.log(`SUB_Security_Cert_Framework_getNotAfterTime_Func_1700 ${notAfter}`);
        expect(notAfter).assertInstanceOf('String');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getNotAfterTime_Func_1700 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getNotAfterTime_Func_1700 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignature_Func_1800
     * @tc.name:    test getSignature method
     * @tc.desc:    get the Signature of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignature_Func_1800', 0, async (done: Function) => {
      try {
        let signature: certFramework.DataBlob = x509CertPem.getSignature();
        console.log(`SUB_Security_Cert_Framework_getSignature_Func_1800 ${signature}`);
        expect(signature != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignature_Func_1800 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getSignature_Func_1800 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignatureAlgName_Func_1900
     * @tc.name:    test getSignatureAlgName method
     * @tc.desc:    get the SignatureAlgName of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignatureAlgName_Func_1900', 0, async (done: Function) => {
      try {
        let sigAlgName: string = x509CertPem.getSignatureAlgName();
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgName_Func_1900 ${sigAlgName}`);
        expect(sigAlgName).assertInstanceOf('String');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgName_Func_1900 errCode: ${err.code}`);
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgName_Func_1900 errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignatureAlgOid_Func_2000
     * @tc.name:    test getSignatureAlgOid method
     * @tc.desc:    get the SignatureAlgOid of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignatureAlgOid_Func_2000', 0, async (done: Function) => {
      try {
        let sigAlgOid: string = x509CertPem.getSignatureAlgOid();
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgOid_Func_2000 ${sigAlgOid}`);
        expect(sigAlgOid).assertInstanceOf('String');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgOid_Func_2000 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignatureAlgParams_Func_2100
     * @tc.name:    test getSignatureAlgParams method
     * @tc.desc:    get the SignatureAlgParams of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignatureAlgParams_Func_2100', 0, async (done: Function) => {
      try {
        let sigAlgParams: certFramework.DataBlob = x509CertPem.getSignatureAlgParams();
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgParams_Func_2100 ${sigAlgParams}`);
        expect(sigAlgParams != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgParams_Func_2100 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getKeyUsage_Func_2200
     * @tc.name:    test getKeyUsage method
     * @tc.desc:    get the KeyUsage of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getKeyUsage_Func_2200', 0, async (done: Function) => {
      try {
        let keyUsage: certFramework.DataBlob = x509CertPem.getKeyUsage();
        console.log(`SUB_Security_Cert_Framework_getKeyUsage_Func_2200 ${keyUsage}`);
        expect(keyUsage != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getKeyUsage_Func_2200 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getExtKeyUsage_Func_2300
     * @tc.name:    test getExtKeyUsage method
     * @tc.desc:    get the ExtKeyUsage of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getExtKeyUsage_Func_2300', 0, async (done: Function) => {
      try {
        let extKeyUsage: certFramework.DataArray = x509CertPem.getExtKeyUsage();
        console.log(`SUB_Security_Cert_Framework_getExtKeyUsage_Func_2300 ${extKeyUsage}`);
        expect(extKeyUsage != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getExtKeyUsage_Func_2300 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getBasicConstraints_Func_2400
     * @tc.name:    test getBasicConstraints method
     * @tc.desc:    get the BasicConstraints of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getBasicConstraints_Func_2400', 0, async (done: Function) => {
      let basicConstraints: number = x509CertPem.getBasicConstraints();
      console.log(`SUB_Security_Cert_Framework_getBasicConstraints_Func_2400 ${basicConstraints}`);
      expect(basicConstraints).assertInstanceOf('Number');
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSubjectAltNames_Func_2500
     * @tc.name:    test getSubjectAltNames method
     * @tc.desc:    get the SubjectAltNames of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSubjectAltNames_Func_2500', 0, async (done: Function) => {
      try {
        let subjectAltNames: certFramework.DataArray = x509CertPem.getSubjectAltNames();
        console.log(`SUB_Security_Cert_Framework_getSubjectAltNames_Func_2500 ${subjectAltNames}`);
        expect(subjectAltNames != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSubjectAltNames_Func_2500 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getIssuerAltNames_Func_2600
     * @tc.name:    test getIssuerAltNames method
     * @tc.desc:    get the IssuerAltNames of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getIssuerAltNames_Func_2600', 0, async (done: Function) => {
      try {
        let issuerAltNames: certFramework.DataArray = x509CertPem.getIssuerAltNames();
        console.log(`SUB_Security_Cert_Framework_getIssuerAltNames_Func_2600 ${issuerAltNames}`);
        expect(issuerAltNames != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getIssuerAltNames_Func_2600 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getItem_Func_2700
     * @tc.name:    test getItem method
     * @tc.desc:    get the Item of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getItem_Func_2700', 0, async (done: Function) => {
      try {
        let tbs: certFramework.DataBlob = x509CertDer.getItem(certFramework.CertItemType.CERT_ITEM_TYPE_TBS);
        console.log(`SUB_Security_Cert_Framework_getItem_Func_2700 ${tbs}`);
        expect(tbs != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getItem_Func_2700 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getItem_Func_2800
     * @tc.name:    test getItem method
     * @tc.desc:    get the Item of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getItem_Func_2800', 0, async (done: Function) => {
      try {
        let pubKey: certFramework.DataBlob = x509CertDer.getItem(certFramework.CertItemType.CERT_ITEM_TYPE_PUBLIC_KEY);
        console.log(`SUB_Security_Cert_Framework_getItem_Func_2800 ${pubKey}`);
        expect(pubKey != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getItem_Func_2800 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getItem_Func_2900
     * @tc.name:    test getItem method
     * @tc.desc:    get the Item of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getItem_Func_2900', 0, async (done: Function) => {
      try {
        let issuerId: certFramework.DataBlob = x509CertDer.getItem(certFramework.CertItemType.CERT_ITEM_TYPE_ISSUER_UNIQUE_ID);
        console.log(`SUB_Security_Cert_Framework_getItem_Func_2900 ${issuerId}`);
        expect(issuerId != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getItem_Func_2900 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getItem_Func_3000
     * @tc.name:    test getItem method
     * @tc.desc:    get the Item of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getItem_Func_3000', 0, async (done: Function) => {
      try {
        let subjectId: certFramework.DataBlob = x509CertDer.getItem(certFramework.CertItemType.CERT_ITEM_TYPE_SUBJECT_UNIQUE_ID);
        console.log(`SUB_Security_Cert_Framework_getItem_Func_3000 ${subjectId}`);
        expect(subjectId != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getItem_Func_3000 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getItem_Func_3100
     * @tc.name:    test getItem method
     * @tc.desc:    get the Item of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getItem_Func_3100', 0, async (done: Function) => {
      try {
        let extensions: certFramework.DataBlob = x509CertDer.getItem(certFramework.CertItemType.CERT_ITEM_TYPE_EXTENSIONS);
        console.log(`SUB_Security_Cert_Framework_getItem_Func_3100 ${extensions}`);
        expect(extensions != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getItem_Func_3100 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getItem_Func_3200
     * @tc.name:    test getItem method
     * @tc.desc:    get the Item of x509Cert
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getItem_Func_3200', 0, async (done: Function) => {
      try {
        let extensions: certFramework.DataBlob = x509CertDer.getItem(-1);
        console.log(`SUB_Security_Cert_Framework_getItem_Func_3200 ${extensions}`);
        expect(extensions != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getItem_Func_3200 errCode: ${err.code} errMsg: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createCertExtension_Func_3300
     * @tc.name:    test createCertExtension method in callback mode
     * @tc.desc:    create CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createCertExtension_Func_3300', 0, async (done: Function) => {
      certFramework.createCertExtension(encodingBlobExtDer, (err, certExt) => {
        console.log(`SUB_Security_Cert_Framework_createCertExtension_Func_3300 ${certExt}`);
        expect(certExt != null).assertTrue();
        done();
      })
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createCertExtension_Func_3400
     * @tc.name:    test createCertExtension method in promise mode
     * @tc.desc:    create CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createCertExtension_Func_3400', 0, async (done: Function) => {
      certFramework.createCertExtension(encodingBlobExtDer).then(certExt => {
        console.log(`SUB_Security_Cert_Framework_createCertExtension_Func_3400 ${certExt}`);
        expect(certExt != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_createCertExtension_Func_3400 errCode ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEncoded_Func_3500
     * @tc.name:    test getEncoded method
     * @tc.desc:    get the Encoded of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEncoded_Func_3500', 0, async (done: Function) => {
      try {
        let extEncodedBlob: certFramework.EncodingBlob = certExt.getEncoded();
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_3500 ${extEncodedBlob}`);
        expect(extEncodedBlob != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_3500 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getOidList_Func_3600
     * @tc.name:    test getOidList method
     * @tc.desc:    get the OidList of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getOidList_Func_3600', 0, async (done: Function) => {
      try {
        let oidList: certFramework.DataArray = certExt.getOidList(certFramework.ExtensionOidType.EXTENSION_OID_TYPE_ALL);
        console.log(`SUB_Security_Cert_Framework_getOidList_Func_3600 ${oidList}`);
        expect(oidList != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getOidList_Func_3600 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getOidList_Func_3700
     * @tc.name:    test getOidList method
     * @tc.desc:    get the OidList of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getOidList_Func_3700', 0, async (done: Function) => {
      try {
        let oidList: certFramework.DataArray = certExt.getOidList(certFramework.ExtensionOidType.EXTENSION_OID_TYPE_CRITICAL);
        console.log(`SUB_Security_Cert_Framework_getOidList_Func_3700 ${oidList}`);
        expect(oidList != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getOidList_Func_3700 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getOidList_Func_3800
     * @tc.name:    test getOidList method
     * @tc.desc:    get the OidList of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getOidList_Func_3800', 0, async (done: Function) => {
      try {
        let oidList: certFramework.DataArray = certExt.getOidList(certFramework.ExtensionOidType.EXTENSION_OID_TYPE_UNCRITICAL);
        console.log(`SUB_Security_Cert_Framework_getOidList_Func_3800 ${oidList}`);
        expect(oidList != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getOidList_Func_3800 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEntry_Func_3900
     * @tc.name:    test getEntry method
     * @tc.desc:    get the Entry of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEntry_Func_3900', 0, async (done: Function) => {
      let oid: Uint8Array = new Uint8Array([0x32, 0x2e, 0x35, 0x2e, 0x32, 0x39, 0x2e, 0x31, 0x35]);
      let oidBlob: certFramework.DataBlob = {
        data: oid
      }
      try {
        let entry: certFramework.DataBlob = certExt.getEntry(certFramework.ExtensionEntryType.EXTENSION_ENTRY_TYPE_ENTRY, oidBlob);
        console.log(`SUB_Security_Cert_Framework_getEntry_Func_3900 ${entry}`);
        expect(entry != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getEntry_Func_3900 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEntry_Func_4000
     * @tc.name:    test getEntry method
     * @tc.desc:    get the Entry of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEntry_Func_4000', 0, async (done: Function) => {
      let oid: Uint8Array = new Uint8Array([0x32, 0x2e, 0x35, 0x2e, 0x32, 0x39, 0x2e, 0x31, 0x35]);
      let oidBlob: certFramework.DataBlob = {
        data: oid
      }
      try {
        let entry: certFramework.DataBlob = certExt.getEntry(certFramework.ExtensionEntryType.EXTENSION_ENTRY_TYPE_ENTRY_CRITICAL, oidBlob);
        console.log(`SUB_Security_Cert_Framework_getEntry_Func_4000 ${entry}`);
        expect(entry != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getEntry_Func_4000 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEntry_Func_4100
     * @tc.name:    test getEntry method
     * @tc.desc:    get the Entry of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEntry_Func_4100', 0, async (done: Function) => {
      let oid: Uint8Array = new Uint8Array([0x32, 0x2e, 0x35, 0x2e, 0x32, 0x39, 0x2e, 0x31, 0x35]);
      let oidBlob: certFramework.DataBlob = {
        data: oid
      }
      try {
        let entry: certFramework.DataBlob = certExt.getEntry(certFramework.ExtensionEntryType.EXTENSION_ENTRY_TYPE_ENTRY_VALUE, oidBlob);
        console.log(`SUB_Security_Cert_Framework_getEntry_Func_4100 ${entry}`);
        expect(entry != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getEntry_Func_4100 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_checkCA_Func_4200
     * @tc.name:    test checkCA method
     * @tc.desc:    check the CA of CertExtension
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_checkCA_Func_4200', 0, async (done: Function) => {
      try {
        let res: number = certExt.checkCA();
        console.log(`SUB_Security_Cert_Framework_checkCA_Func_4200 ${res}`)
        expect(res).assertInstanceOf('Number');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_checkCA_Func_4200 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createX509CRL_Func_4300
     * @tc.name:    test createX509CRL method in callback mode
     * @tc.desc:    create X509CRL
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createX509CRL_Func_4300', 0, async (done: Function) => {
      certFramework.createX509CRL(getEncodingBlobCrl('pem'), (err, x509Crl) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4300 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
        } else {
          console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4300 ${x509Crl}`);
          expect(x509Crl != null).assertTrue();
        }
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createX509CRL_Func_4400
     * @tc.name:    test createX509CRL method in callback mode
     * @tc.desc:    create X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createX509CRL_Func_4400', 0, async (done: Function) => {
      certFramework.createX509CRL(getEncodingBlobCrl('der'), (err, x509Crl) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4400 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
        } else {
          console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4400 ${x509Crl}`);
          expect(x509Crl != null).assertTrue();
        }
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createX509CRL_Func_4500
     * @tc.name:    test createX509CRL method in promise mode
     * @tc.desc:    create X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createX509CRL_Func_4500', 0, async (done: Function) => {
      certFramework.createX509CRL(getEncodingBlobCrl('pem')).then(x509Crl => {
        console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4500 ${x509Crl}`);
        expect(x509Crl != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4500 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      })
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createX509CRL_Func_4600
     * @tc.name:    test createX509CRL method in promise mode
     * @tc.desc:    create X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createX509CRL_Func_4600', 0, async (done: Function) => {
      certFramework.createX509CRL(getEncodingBlobCrl('der')).then(x509Crl => {
        console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4600 ${x509Crl}`);
        expect(x509Crl != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_createX509CRL_Func_4600 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      })
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_isRevoked_Func_4700
     * @tc.name:    test isRevoked method
     * @tc.desc:    get the isRevoked of x509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_isRevoked_Func_4700', 0, async (done: Function) => {
      try {
        let revokedFlag: Boolean = x509CrlPemRevoked.isRevoked(X509CertForCrlTest_normal);
        console.log(`SUB_Security_Cert_Framework_isRevoked_Func_4700 ${revokedFlag}`);
        expect(revokedFlag).assertInstanceOf('Boolean');
        expect(revokedFlag).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_isRevoked_Func_4700 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_isRevoked_Func_4800
     * @tc.name:    test isRevoked method
     * @tc.desc:    get the isRevoked of x509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_isRevoked_Func_4800', 0, async (done: Function) => {
      try {
        let revokedFlag: Boolean = x509CrlPemRevoked.isRevoked(X509CertForCrlTest_error);
        console.log(`SUB_Security_Cert_Framework_isRevoked_Func_4800 ${revokedFlag}`);
        expect(revokedFlag).assertInstanceOf('Boolean');
        expect(revokedFlag).assertFalse();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_isRevoked_Func_4800 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getType_Func_4900
     * @tc.name:    test getType method
     * @tc.desc:    get the Type of x509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getType_Func_4900', 0, async (done: Function) => {
      let type: string = x509CrlPem.getType();
      console.log(`SUB_Security_Cert_Framework_getType_Func_4900 ${type}`);
      expect(type).assertInstanceOf('String');
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEncoded_Func_5000
     * @tc.name:    test getEncoded method in callback mode
     * @tc.desc:    get the Encoded of x509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEncoded_Func_5000', 0, async (done: Function) => {
      x509CrlPem.getEncoded((err, data) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_getEncoded_Func_5000 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
        } else {
          console.log(`SUB_Security_Cert_Framework_getEncoded_Func_5000 ${data}`)
          expect(data != null).assertTrue();
        }
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEncoded_Func_5100
     * @tc.name:    test getEncoded method in Promise mode
     * @tc.desc:    get the Encoded of x509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEncoded_Func_5100', 0, async (done: Function) => {
      x509CrlPem.getEncoded().then(result => {
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_5100 ${result}`)
        expect(result != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_5100 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_verify_Func_5200
     * @tc.name:    test verify method in callback mode
     * @tc.desc:    verify the X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_verify_Func_5200', 0, async (done: Function) => {
      try {
        x509CrlPem.verify(keyPair.pubKey, (err) => {
          console.log(`SUB_Security_Cert_Framework_verify_Func_5200 ${err}`)
          expect(err == null).assertTrue();
          done();
        });
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_verify_Func_5200 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_verify_Func_5300
     * @tc.name:    test verify method in promise mode
     * @tc.desc:    verify the X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_verify_Func_5300', 0, async (done: Function) => {
      x509CrlPem.verify(keyPair.pubKey).then(result => {
        console.log(`testX509CrlVerifyPromise001 ${result}`);
        expect(result == null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_verify_Func_5300 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getVersion_Func_5400
     * @tc.name:    test getVersion method
     * @tc.desc:    get the Version of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getVersion_Func_5400', 0, async (done: Function) => {
      let version: number = x509CrlPem.getVersion();
      console.log(`SUB_Security_Cert_Framework_getVersion_Func_5400 ${version}`);
      expect(version).assertInstanceOf('Number');
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getIssuerName_Func_5500
     * @tc.name:    test getIssuerName method
     * @tc.desc:    get the IssuerName of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getIssuerName_Func_5500', 0, async (done: Function) => {
      try {
        let issuerName: certFramework.DataBlob = x509CrlPem.getIssuerName();
        console.log(`SUB_Security_Cert_Framework_getIssuerName_Func_5500 ${issuerName}`);
        expect(issuerName != null).assertTrue();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getIssuerName_Func_5500 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getLastUpdate_Func_5600
     * @tc.name:    test getLastUpdate method
     * @tc.desc:    get the LastUpdate of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getLastUpdate_Func_5600', 0, async (done: Function) => {
      try {
        let lastUpdate: string = x509CrlPem.getLastUpdate();
        console.log(`SUB_Security_Cert_Framework_getLastUpdate_Func_5600 ${lastUpdate}`);
        expect(lastUpdate).assertInstanceOf('String');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getLastUpdate_Func_5600 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getNextUpdate_Func_5700
     * @tc.name:    test getNextUpdate method
     * @tc.desc:    get the NextUpdate of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getNextUpdate_Func_5700', 0, async (done: Function) => {
      try {
        let nextUpdate: string = x509CrlPem.getNextUpdate();
        console.log(`SUB_Security_Cert_Framework_getNextUpdate_Func_5700 ${nextUpdate}`);
        expect(nextUpdate).assertInstanceOf('String');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getNextUpdate_Func_5700 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getRevokedCert_Func_5800
     * @tc.name:    test getRevokedCert method
     * @tc.desc:    get the RevokedCert of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getRevokedCert_Func_5800', 0, async (done: Function) => {
      let serialNumber: bigint = BigInt(1000);
      try {
        let entry: certFramework.X509CRLEntry = x509CrlPem.getRevokedCert(serialNumber);
        console.log(`SUB_Security_Cert_Framework_getRevokedCert_Func_5800 ${entry}`);
        expect(entry != null).assertTrue();
        let revocation: string = entry.getRevocationDate();
        console.log(`SUB_Security_Cert_Framework_getRevokedCert_Func_5800 ${revocation}`);
        expect(revocation != null).assertTrue();
        let certIssuer: certFramework.DataBlob = entry.getCertIssuer();
        console.log(`SUB_Security_Cert_Framework_getRevokedCert_Func_5800 ${certIssuer}`);
        expect(certIssuer != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getRevokedCert_Func_5800 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getRevokedCertWithCert_Func_5900
     * @tc.name:    test getRevokedCertWithCert method
     * @tc.desc:    get the RevokedCertWithCert of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getRevokedCertWithCert_Func_5900', 0, async (done: Function) => {
      try {
        let entry: certFramework.X509CRLEntry = x509CrlPemRevoked.getRevokedCertWithCert(X509CertForCrlTest_normal);
        console.log(`SUB_Security_Cert_Framework_getRevokedCertWithCert_Func_5900 ${entry}`);
        expect(entry != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getRevokedCertWithCert_Func_5900 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getRevokedCerts_Func_6000
     * @tc.name:    test getRevokedCerts method in callback mode
     * @tc.desc:    get the RevokedCerts of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getRevokedCerts_Func_6000', 0, async (done: Function) => {
      x509CrlPem.getRevokedCerts((err, array) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_getRevokedCerts_Func_6000 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
        } else {
          console.log(`SUB_Security_Cert_Framework_getRevokedCerts_Func_6000 ${array}`);
          expect(array != null).assertTrue();
          expect(array.length > 0).assertTrue();
        }
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getRevokedCerts_Func_6100
     * @tc.name:    test getRevokedCerts method in promise mode
     * @tc.desc:    get the RevokedCerts of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getRevokedCerts_Func_6100', 0, async (done: Function) => {
      x509CrlPem.getRevokedCerts().then(array => {
        console.log(`SUB_Security_Cert_Framework_getRevokedCerts_Func_6100 ${array}`);
        expect(array != null).assertTrue();
        expect(array.length > 0).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_getRevokedCerts_Func_6100 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getTBSInfo_Func_6200
     * @tc.name:    test getTBSInfo method
     * @tc.desc:    get the TbsInfo of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getTBSInfo_Func_6200', 0, async (done: Function) => {
      try {
        let tbsInfo: certFramework.DataBlob = x509CrlPem.getTBSInfo();
        console.log(`SUB_Security_Cert_Framework_getTBSInfo_Func_6200 ${tbsInfo}`);
        expect(tbsInfo != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getTBSInfo_Func_6200 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignature_Func_6300
     * @tc.name:    test getSignature method
     * @tc.desc:    get the Signature of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignature_Func_6300', 0, async (done: Function) => {
      try {
        let signature: certFramework.DataBlob = x509CrlPem.getSignature();
        console.log(`SUB_Security_Cert_Framework_getSignature_Func_6300 ${signature}`);
        expect(signature != null).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignature_Func_6300 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignatureAlgName_Func_6400
     * @tc.name:    test getSignatureAlgName method
     * @tc.desc:    get the SignatureAlgName of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignatureAlgName_Func_6400', 0, async (done: Function) => {
      try {
        let sigAlgName: string = x509CrlPem.getSignatureAlgName();
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgName_Func_6400 ${sigAlgName}`);
        expect(sigAlgName).assertInstanceOf('String');
        done();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgName_Func_6400 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignatureAlgOid_Func_6500
     * @tc.name:    test getSignatureAlgOid method
     * @tc.desc:    get the SignatureAlgOid of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignatureAlgOid_Func_6500', 0, async (done: Function) => {
      try {
        let sigAlgOid: string = x509CrlPem.getSignatureAlgOid();
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgOid_Func_6500 ${sigAlgOid}`);
        expect(sigAlgOid).assertInstanceOf('String');
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgOid_Func_6500 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSignatureAlgParams_Func_6600
     * @tc.name:    test getSignatureAlgParams method
     * @tc.desc:    get the SignatureAlgParams of X509Crl
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSignatureAlgParams_Func_6600', 0, async (done: Function) => {
      try {
        let sigAlgParams: certFramework.DataBlob = x509CrlPem.getSignatureAlgParams();
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgParams_Func_6600 ${sigAlgParams}`);
        expect(sigAlgParams != null).assertTrue();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSignatureAlgParams_Func_6600 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createCertChainValidator_Func_6700
     * @tc.name:    test createCertChainValidator method
     * @tc.desc:    create CertChainValidator
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createCertChainValidator_Func_6700', 0, async (done: Function) => {
      try {
        let validator: certFramework.CertChainValidator = certFramework.createCertChainValidator('PKIX');
        console.log(`SUB_Security_Cert_Framework_createCertChainValidator_Func_6700 ${validator}`);
        expect(validator != null).assertTrue();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_createCertChainValidator_Func_6700 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_createCertChainValidator_Func_6800
     * @tc.name:    test createCertChainValidator method
     * @tc.desc:    create CertChainValidator
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_createCertChainValidator_Func_6800', 0, async (done: Function) => {
      try {
        let validator: certFramework.CertChainValidator = certFramework.createCertChainValidator('PKI111');
        console.log(`SUB_Security_Cert_Framework_createCertChainValidator_Func_6800 ${validator}`);
        expect(validator != null).assertTrue();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_createCertChainValidator_Func_6800 errCode: ${err.code} errMsg: ${err.message}`);
        expect(err.code).assertEqual(801);
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_validate_Func_6900
     * @tc.name:    test validate method in callback mode
     * @tc.desc:    validate certChainData
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_validate_Func_6900', 0, async (done: Function) => {
      let certChainData: certFramework.CertChainData = {
        data: dataArray,
        count: 2,
        encodingFormat: certFramework.EncodingFormat.FORMAT_PEM
      };
      try {
        let validator: certFramework.CertChainValidator = certFramework.createCertChainValidator('PKIX');
        validator.validate(certChainData, (err) => {
          console.log(`SUB_Security_Cert_Framework_validate_Func_6900 ${err}`)
          expect(err == null).assertTrue();
          done();
        });
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_validate_Func_6900 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }

    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_validate_Func_7000
     * @tc.name:    test validate method in promise mode
     * @tc.desc:    validate certChainData
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_validate_Func_7000', 0, async (done: Function) => {
      let certChainData: certFramework.CertChainData = {
        data: dataArray,
        count: 2,
        encodingFormat: certFramework.EncodingFormat.FORMAT_PEM
      };
      try {
        let validator: certFramework.CertChainValidator = certFramework.createCertChainValidator('PKIX');
        validator.validate(certChainData).then(result => {
          console.log(`SUB_Security_Cert_Framework_validate_Func_7000 ${result}`);
          expect(result == null).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.log(`SUB_Security_Cert_Framework_validate_Func_7000 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
          done();
        });
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_validate_Func_7000 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      }

    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_algorithm_Func_7100
     * @tc.name:    test Algorithm value
     * @tc.desc:    get Algorithm value of CertChainValidator
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_algorithm_Func_7100', 0, async (done: Function) => {

      try {
        let validator: certFramework.CertChainValidator = certFramework.createCertChainValidator('PKIX');
        let algorithm: string = validator.algorithm;
        console.log(`SUB_Security_Cert_Framework_algorithm_Func_7100 ${algorithm}`);
        expect(algorithm).assertEqual('PKIX');
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_algorithm_Func_7100 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEncoded_Func_7200
     * @tc.name:    test getEncoded method in callback
     * @tc.desc:    get the Encoded of X509CrlEntry
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEncoded_Func_7200', 0, async (done: Function) => {
      crlEntryPem.getEncoded((err, data) => {
        if (err != null) {
          console.log(`SUB_Security_Cert_Framework_getEncoded_Func_7200 errCode: ${err.code} errMsg: ${err.message}`);
          expect().assertFail();
        } else {
          console.log(`SUB_Security_Cert_Framework_getEncoded_Func_7200 ${data}`);
          expect(data != null).assertTrue();
        }
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getEncoded_Func_7300
     * @tc.name:    test getEncoded method in promise mode
     * @tc.desc:    get the Encoded of X509CrlEntry
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getEncoded_Func_7300', 0, async (done: Function) => {
      crlEntryPem.getEncoded().then(result => {
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_7300 ${result}`);
        expect(result != null).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Security_Cert_Framework_getEncoded_Func_7300 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getSerialNumber_Func_7400
     * @tc.name:    test getSerialNumber method
     * @tc.desc:    get the SerialNumber of X509CrlEntry
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getSerialNumber_Func_7400', 0, async (done: Function) => {
      try {
        let serialNumber: BigInt = crlEntryPem.getSerialNumber();
        let expectNumber: BigInt = BigInt(1000)
        console.log(`SUB_Security_Cert_Framework_getSerialNumber_Func_7400 ${serialNumber}`);
        expect(serialNumber).assertEqual(expectNumber)
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getSerialNumber_Func_7400 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getCertIssuer_Func_7500
     * @tc.name:    test getCertIssuer method
     * @tc.desc:    get the SerialNumber of X509CrlEntry
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getCertIssuer_Func_7500', 0, async (done: Function) => {
      try {
        let issuer: cryptoFramework.DataBlob = crlEntryPem.getCertIssuer();
        console.log(`SUB_Security_Cert_Framework_getCertIssuer_Func_7500 ${issuer}`);
        expect(issuer != null).assertTrue();
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getCertIssuer_Func_7500 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number:  SUB_Security_Cert_Framework_getRevocationDate_Func_7600
     * @tc.name:    test getRevocationDate method
     * @tc.desc:    get the SerialNumber of X509CrlEntry
     * @tc.size:    MediumTest
     * @tc.type:    method
     * @tc.level:   Level 2
     */
    it('SUB_Security_Cert_Framework_getRevocationDate_Func_7600', 0, async (done: Function) => {
      try {
        let date: string = crlEntryPem.getRevocationDate();
        console.log(`SUB_Security_Cert_Framework_getRevocationDate_Func_7600 ${date}`);
        expect(date).assertInstanceOf('String');
      } catch (err) {
        console.log(`SUB_Security_Cert_Framework_getRevocationDate_Func_7600 errCode: ${err.code} errMsg: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
  })
}