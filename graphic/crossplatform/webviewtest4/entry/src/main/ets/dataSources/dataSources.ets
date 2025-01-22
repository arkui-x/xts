export interface DATASOURCES {
  title: string,
  path: string
}

export const DataSources: Array<DATASOURCES> = [
  {
    title: "GeolocationPermissions_allowGeolocation",
    path: "pages/GeolocationPermissions/allowGeolocation"
  },
  {
    title: "GeolocationPermissions_getAccessibleGeolocation_callback",
    path: "pages/GeolocationPermissions/getAccessibleGeolocation_callback"
  },
  {
    title: "GeolocationPermissions_getAccessibleGeolocation_promise",
    path: "pages/GeolocationPermissions/getAccessibleGeolocation_promise"
  },
  {
    title: "GeolocationPermissions_getStoredGeolocation_callback",
    path: "pages/GeolocationPermissions/getStoredGeolocation_callback"
  },
  {
    title: "GeolocationPermissions_getStoredGeolocation_promise",
    path: "pages/GeolocationPermissions/getStoredGeolocation_promise"
  },
  {
    title: "GeolocationPermissions_deleteGeolocation",
    path: "pages/GeolocationPermissions/deleteGeolocation"
  },
  {
    title: "GeolocationPermissions_deleteAllGeolocation",
    path: "pages/GeolocationPermissions/deleteAllGeolocation"
  },
  {
    title: "JsGeolocationTrue",
    path: "pages/GeolocationPermissions/jsGeolocation_invoke_true"
  },
  {
    title: "JsGeolocationFalse",
    path: "pages/GeolocationPermissions/jsGeolocation_invoke_false"
  },
  {
    title: "WebStorage_deleteAllData",
    path: "pages/WebStorage/deleteAllData"
  },
  {
    title: "WebStorage_DeleteOrigin",
    path: "pages/WebStorage/DeleteOrigin"
  },
  {
    title: "WebStorage_GetOriginQuota_Callback",
    path: "pages/WebStorage/WebStorage_GetOriginQuota_Callback"
  },
  {
    title: "WebStorage_GetOriginQuota_Promise",
    path: "pages/WebStorage/WebStorage_GetOriginQuota_Promise"
  },
  {
    title: "WebStorage_GetOrigins_Callback",
    path: "pages/WebStorage/WebStorage_GetOrigins_Callback"
  },
  {
    title: "WebStorage_GetOrigins_Callback_error",
    path: "pages/WebStorage/WebStorage_GetOrigins_Callback_error"
  },
  {
    title: "WebStorage_GetOrigins_Promise",
    path: "pages/WebStorage/WebStorage_GetOrigins_Promise"
  },
  {
    title: "WebStorage_GetOrigins_Promise_error",
    path: "pages/WebStorage/WebStorage_GetOrigins_Promise_error"
  },
  {
    title: "WebStorage_GetOriginUsage_Callback",
    path: "pages/WebStorage/WebStorage_GetOriginUsage_Callback"
  },
  {
    title: "WebStorage_GetOriginUsage_Promise",
    path: "pages/WebStorage/WebStorage_GetOriginUsage_Promise"
  },
  {
    title: "CookieManage_ClearSessionCookie",
    path: "pages/CookieManage/clearSessionCookie"
  },
  {
    title: "CookieManage_ExistCookieTrue",
    path: "pages/CookieManage/existCookieTrue"
  },
  {
    title: "CookieManage_ExistCookieFalse",
    path: "pages/CookieManage/existCookieFalse"
  },
  {
    title: "incognitoModeFalse",
    path: "pages/CookieManage/incognitoModeFalse"
  },
  {
    title: "incognitoModeTrue",
    path: "pages/CookieManage/incognitoModeTrue"
  },
]

export const TypeSources: Array<DATASOURCES> = [
  {
    title: "GeolocationPermissions_Index",
    path: "pages/GeolocationPermissions/GeolocationPermissionsIndex"
  },
  {
    title: "WebStorage_Index",
    path: "pages/WebStorage/WebStorageIndex"
  },
  {
    title: "Cookie_Index",
    path: "pages/CookieManage/WebCookieManage"
  },
]