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
import GeolocationPermissions_GetAccessibleGeolocation_Promise
  from "./GeolocationPermissions_GetAccessibleGeolocation_Promise.test";
import GeolocationPermissions_GetStoredGeolocation_Callback
  from "./GeolocationPermissions_GetStoredGeolocation_Callback.test";
import GeolocationPermissions_GetStoredGeolocation_Promise
  from "./GeolocationPermissions_GetStoredGeolocation_Promise.test";
import GeolocationPermissions_AllowGeolocation from './GeolocationPermissions_AllowGeolocation.test';
import GeolocationPermissions_DeleteAllGeolocation from './GeolocationPermissions_DeleteAllGeolocation.test';
import GeolocationPermissions_DeleteGeolocation from './GeolocationPermissions_DeleteGeolocation.test';
import GeolocationPermissions_GetAccessibleGeolocation_Callback
  from './GeolocationPermissions_GetAccessibleGeolocation_Callback.test';
import WebStorage_DeleteAllData from "./WebStorage_DeleteAllData.test";
import WebStorage_DeleteOrigin from "./WebStorage_DeleteOrigin.test";
import WebStorage_GetOriginQuota_Callback from "./WebStorage_GetOriginQuota_Callback.test";
import WebStorage_GetOriginQuota_Promise from "./WebStorage_GetOriginQuota_Promise.test";
import WebStorage_GetOrigins_Callback from "./WebStorage_GetOrigins_Callback.test";
import WebStorage_GetOrigins_Callback_error from "./WebStorage_GetOrigins_Callback_error.test";
import WebStorage_GetOrigins_Promise from "./WebStorage_GetOrigins_Promise.test";
import WebStorage_GetOrigins_Promise_error from "./WebStorage_GetOrigins_Promise_error.test";
import WebStorage_GetOriginUsage_Callback from "./WebStorage_GetOriginUsage_Callback.test";
import WebStorage_GetOriginUsage_Promise from "./WebStorage_GetOriginUsage_Promise.test";
import CookieManage_ClearSessionCookie from './CookieManage_ClearSessionCookie.test';
import CookieManage_ExistCookie_False from './CookieManage_ExistCookie_False.test';
import CookieManage_ExistCookie_True from './CookieManage_ExistCookie_True.test';
import incognitoModeFalse from './incognitoModeFalse.test';
import incognitoModeTrue from './incognitoModeTrue.test';
import JsGeolocation_invoke_true from "./JsGeolocation_invoke_true.test";
import JsGeolocation_invoke_false from "./JsGeolocation_invoke_false.test";

export default function testsuite() {
  CookieManage_ExistCookie_False();
  CookieManage_ExistCookie_True();
  CookieManage_ClearSessionCookie();
  GeolocationPermissions_AllowGeolocation();
  GeolocationPermissions_GetAccessibleGeolocation_Callback();
  GeolocationPermissions_GetAccessibleGeolocation_Promise();
  GeolocationPermissions_GetStoredGeolocation_Callback();
  GeolocationPermissions_GetStoredGeolocation_Promise();
  GeolocationPermissions_DeleteGeolocation();
  GeolocationPermissions_DeleteAllGeolocation();
  JsGeolocation_invoke_true();
  JsGeolocation_invoke_false();
  WebStorage_GetOrigins_Callback_error();
  WebStorage_GetOrigins_Promise_error();
  WebStorage_DeleteAllData();
  WebStorage_DeleteOrigin();
  WebStorage_GetOriginQuota_Callback();
  WebStorage_GetOriginQuota_Promise();
  WebStorage_GetOrigins_Callback();
  WebStorage_GetOrigins_Promise();
  WebStorage_GetOriginUsage_Callback();
  WebStorage_GetOriginUsage_Promise();
  incognitoModeFalse();
  incognitoModeTrue();
}