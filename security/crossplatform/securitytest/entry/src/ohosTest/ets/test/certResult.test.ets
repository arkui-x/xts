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
import { expect } from "@ohos/hypium";
import cryptoFramework from '@ohos.security.cryptoFramework';
import cert from "@ohos.security.cert";
import cpFw from '@ohos.security.cryptoFramework';

function certificateEnumTypeTest() {
  expect(cert.CertResult.NOT_SUPPORT).assertEqual(801);
  expect(cert.CertResult.ERR_OUT_OF_MEMORY).assertEqual(19020001);
  expect(cert.CertResult.ERR_CERT_SIGNATURE_FAILURE).assertEqual(19030002);
  expect(cert.CertResult.ERR_CERT_HAS_EXPIRED).assertEqual(19030004);
  expect(cert.CertResult.ERR_UNABLE_TO_GET_ISSUER_CERT_LOCALLY).assertEqual(19030005);
  expect(cert.CertResult.ERR_KEYUSAGE_NO_CERTSIGN).assertEqual(19030006);
  expect(cert.CertResult.ERR_KEYUSAGE_NO_DIGITAL_SIGNATURE).assertEqual(19030007);
  expect(cert.ValidationPolicyType.VALIDATION_POLICY_TYPE_SSL).assertEqual(1);
  expect(cert.KeyUsageType.KEYUSAGE_DIGITAL_SIGNATURE).assertEqual(0);
  expect(cert.KeyUsageType.KEYUSAGE_NON_REPUDIATION).assertEqual(1);
  expect(cert.KeyUsageType.KEYUSAGE_KEY_ENCIPHERMENT).assertEqual(2);
  expect(cert.KeyUsageType.KEYUSAGE_CRL_SIGN).assertEqual(6);
  expect(cert.EncodingType.ENCODING_UTF8).assertEqual(0);
  expect(cert.RevocationCheckOptions.REVOCATION_CHECK_OPTION_PREFER_OCSP).assertEqual(0);
  expect(cert.RevocationCheckOptions.REVOCATION_CHECK_OPTION_ACCESS_NETWORK).assertEqual(1);
  expect(cert.RevocationCheckOptions.REVOCATION_CHECK_OPTION_FALLBACK_NO_PREFER).assertEqual(2);
  expect(cert.RevocationCheckOptions.REVOCATION_CHECK_OPTION_FALLBACK_LOCAL).assertEqual(3);
  expect(cert.KeyUsageType.KEYUSAGE_DATA_ENCIPHERMENT).assertEqual(3);
  expect(cert.KeyUsageType.KEYUSAGE_KEY_AGREEMENT).assertEqual(4);
  expect(cert.KeyUsageType.KEYUSAGE_KEY_CERT_SIGN).assertEqual(5);
  expect(cert.KeyUsageType.KEYUSAGE_ENCIPHER_ONLY).assertEqual(7);
  expect(cert.KeyUsageType.KEYUSAGE_DECIPHER_ONLY).assertEqual(8);
  expect(cert.ValidationPolicyType.VALIDATION_POLICY_TYPE_X509).assertEqual(0);
  expect(cert.ValidationPolicyType.VALIDATION_POLICY_TYPE_SSL).assertEqual(1);
}

function certificateEnumTypeTest2() {
  expect(cryptoFramework.CipherSpecItem.SM2_MD_NAME_STR).assertEqual(104);
  expect(cpFw.SignSpecItem.SM2_USER_ID_UINT8ARR).assertEqual(105);
  expect(cryptoFramework.AsyKeySpecItem.DH_P_BN).assertEqual(401);
  expect(cryptoFramework.AsyKeySpecItem.DH_G_BN).assertEqual(402);
  expect(cryptoFramework.AsyKeySpecItem.DH_L_NUM).assertEqual(403);
  expect(cryptoFramework.AsyKeySpecItem.DH_SK_BN).assertEqual(404);
  expect(cryptoFramework.AsyKeySpecItem.DH_PK_BN).assertEqual(405);
  expect(cpFw.AsyKeySpecItem.ED25519_SK_BN).assertEqual(501);
  expect(cpFw.AsyKeySpecItem.ED25519_PK_BN).assertEqual(502);
  expect(cpFw.AsyKeySpecItem.X25519_SK_BN).assertEqual(601);
  expect(cpFw.AsyKeySpecItem.X25519_PK_BN).assertEqual(602);
}

export { certificateEnumTypeTest, certificateEnumTypeTest2 };
