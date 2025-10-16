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
import CertFuncEnumTestUnit from './certFuncEnum.test';
import parsingConfigTest from './parsingConfig.test';
import x509CertMatchTest from './x509CertMatch.test';
import x509MethodFunc from './x509Method.test';
import certFrameworkCertChainOfflineValidateJsAPIFunctionTestUnit from './certChainOfflineValidate.test';
import SecurityCryptoFwSignVerifySyncTestUnit from './securityCpfwSignVerify.test';
import SecurityCryptoFwSha3TestUnit from './digestSync.test';
import SecurityCryptoFwKeyGenerateECCTestUnit from './eccKeyUntil.test';
import SecurityCryptoFwKeyGenerateDHTestUnit from './dhKeyUntil.test';
import certFrameworkCertChainJsAPIFunctionTestUnit from './certChain.test';
import SecurityCryptoFwKeyGenerateECCTestUnit2 from './securityCpfw.test';
import securityTest from './securityFunc.test';
import certFrameworkCertChainPolicyJsAPIFunctionTestUnit from './certChainPolicy.test';
import certificateCRLJsunit from './certificateCrl.test';
import certificateFuncTest from './certificateFunc.test';
import asyGetKeySpecBySpecTest from './asyGetKeySpecBySpec.test';
import securityCryptoFwVector from './securityCryptoFwVector.test';
import securityCryptoFwHkdf from './securityCryptoFwHkdf.test';
import securityCryptoFwCipherSmTest from './securityCryptoFwCipherSM2.test';
import securityCryptoFwSignatureTest from './securityCryptoFwSM2Signature.test';

export default function testsuite() {
  CertFuncEnumTestUnit()
  x509CertMatchTest()
  parsingConfigTest()
  x509MethodFunc()
  certFrameworkCertChainOfflineValidateJsAPIFunctionTestUnit()
  SecurityCryptoFwSignVerifySyncTestUnit()
  SecurityCryptoFwSha3TestUnit()
  SecurityCryptoFwKeyGenerateECCTestUnit()
  SecurityCryptoFwKeyGenerateDHTestUnit()
  certFrameworkCertChainJsAPIFunctionTestUnit()
  SecurityCryptoFwKeyGenerateECCTestUnit2()
  securityTest()
  certFrameworkCertChainPolicyJsAPIFunctionTestUnit()
  certificateCRLJsunit()
  certificateFuncTest();
  asyGetKeySpecBySpecTest();
  securityCryptoFwVector();
  securityCryptoFwHkdf();
  securityCryptoFwCipherSmTest();
  securityCryptoFwSignatureTest();
}