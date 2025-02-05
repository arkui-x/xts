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

import GetWebIdTest from './WebController_GetWebId.test';
import WebController_PostUrl from './WebController_PostUrl.test';
import WebController_ZoomIn from './WebController_ZoomIn.test';
import WebController_ZoomOut from './WebController_ZoomOut.test';
import WebController_GetOriginUrl from './WebController_GetOriginUrl.test';
import WebController_PageUp from './WebController_PageUp.test';
import WebController_PageDown from './WebController_PageDown.test';

import WebController_SetWebDebuggingAccessError from './WebController_SetWebDebuggingAccessError.test';
import WebController_SetWebDebuggingAccessFalse from './WebController_SetWebDebuggingAccessFalse.test';
import WebController_SetWebDebuggingAccessTrue from './WebController_SetWebDebuggingAccessTrue.test';
import WebAttribute_OnlineImageAccess from './WebAttribute_OnlineImageAccess.test';
import WebAttribute_ImageAccess from './WebAttribute_ImageAccess.test';
import WebAttribute_DomStorageAccess from './WebAttribute_DomStorageAccess.test';
import WebAttribute_CacheMode from './WebAttribute_CacheMode.test';
import WebAttribute_MixedMode from './WebAttribute_MixedMode.test';
import WebAttribute_BlockNetwork from './WebAttribute_BlockNetwork.test';
import AceWebAttribute_OnBeforeUnload from './WebAttribute_OnBeforeUnload.test';
import AceWebAttribute_onFullScreenExit from './WebAttribute_OnFullScreenExit.test';
import AceWebAttributeFun_OnRefreshAccessedHistory from './WebAttributeFun_OnRefreshAccessedHistory.test';
import WebAttributeFun_OnFullScreenEnter from './WebAttributeFun_OnFullScreenEnter.test';


export default function testsuite() {
  WebController_ZoomIn();
  WebController_ZoomOut();
  WebController_GetOriginUrl();
  WebController_PageUp();
  WebController_PageDown();
  WebController_PostUrl();
  GetWebIdTest();
  WebAttribute_OnlineImageAccess();
  WebAttribute_ImageAccess();
  WebAttribute_DomStorageAccess();
  WebAttribute_CacheMode();
  WebAttribute_MixedMode();
  WebAttribute_BlockNetwork();
  AceWebAttribute_OnBeforeUnload();
  AceWebAttribute_onFullScreenExit();
  AceWebAttributeFun_OnRefreshAccessedHistory();
  WebAttributeFun_OnFullScreenEnter();
  WebController_SetWebDebuggingAccessError();
  WebController_SetWebDebuggingAccessFalse();
  WebController_SetWebDebuggingAccessTrue();
}