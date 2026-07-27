/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import WebAttributeTest from './WebAttribute.test'
import WebviewControllerTest from './WebviewController.test'
import JavaScriptOnDocumentStartTest from './JavaScriptOnDocumentStart.test'
import ClearCookiesTest from './ClearCookies.test'
import CookieManagerTest from './CookieManager.test'
import CookieManagerTest2 from './CookieManager2.test'
import PutAcceptCookieEnabledTest from './PutAcceptCookieEnabled.test'
import ThirdPartyCookieNetworkTest from './ThirdPartyCookieNetwork.test'
import SslErrorInvalidTest from './SslErrorInvalid.test'
import JavaScriptOnDocumentEndTest from './JavaScriptOnDocumentEnd.test'

export default function testsuite() {
  CookieManagerTest()
  CookieManagerTest2()
  ClearCookiesTest()
  PutAcceptCookieEnabledTest()
  ThirdPartyCookieNetworkTest()
  WebAttributeTest()
  WebviewControllerTest()
  JavaScriptOnDocumentStartTest()
  JavaScriptOnDocumentEndTest()
  SslErrorInvalidTest()
}
