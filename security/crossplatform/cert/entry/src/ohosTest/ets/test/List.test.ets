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

import abilityTest from './Ability.test';
import certTest from './Cert.test';
import certFrameworkSelectCertsJsAPIFunctionTestUnit from './selectCerts.test';
import certFrameworkSelectCRLsJsAPIFunctionTestUnit from './selectCRLs.test';
import certFrameworkCertMatchJsAPIFunctionTestUnit from './certMatch.test';
import certFrameworkCRLMatchJsAPIFunctionTestUnit from './crlMatch.test';
import certFrameworkCertChainExtJsAPIFunctionTestUnit from './certChainExt.test';
import certFrameworkCreateTrustAnchorJsAPIFunctionTestUnit from './createTrustAnchor.test';
import certFrameworkCertCsrTestUnit from './certCsr.test';
import certFrameworkParseP12CertTestUnit from './parseP12Cert.test';
import certFrameworkCertPkcs7ExtCMSFunctionTestUnit from './certP7.test';

export default function testsuite() {
  abilityTest();
  certTest();
  certFrameworkSelectCertsJsAPIFunctionTestUnit();
  certFrameworkSelectCRLsJsAPIFunctionTestUnit();
  certFrameworkCertMatchJsAPIFunctionTestUnit();
  certFrameworkCRLMatchJsAPIFunctionTestUnit();
  certFrameworkCertChainExtJsAPIFunctionTestUnit();
  certFrameworkCreateTrustAnchorJsAPIFunctionTestUnit();
  certFrameworkCertCsrTestUnit();
  certFrameworkParseP12CertTestUnit();
  certFrameworkCertPkcs7ExtCMSFunctionTestUnit();
}