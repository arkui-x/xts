export  interface DATASOURCES {
  title:string,
  path:string
}
export const DataSources:Array<DATASOURCES>=[
  {
    title: "WebController_ZoomIn",
    path: "pages/WebController/ZoomIn"
  },
  {
    title: "WebController_ZoomOut",
    path: "pages/WebController/ZoomOut"
  },
  {
    title: "WebController_GetOriginalUrl",
    path: "pages/WebController/GetOriginalUrl"
  },
  {
    title: "WebController_PageUp",
    path: "pages/WebController/PageUp"
  },
  {
    title:"WebController_GetWebId",
    path:"pages/WebController/GetWebId"
  },
  {
    title:"WebController_SetWebDebuggingAccessTrue",
    path:"pages/WebController/SetWebDebuggingAccessTrue"
  },
  {
    title:"WebController_SetWebDebuggingAccessFalse",
    path:"pages/WebController/SetWebDebuggingAccessFalse"
  },
  {
    title:"WebController_SetWebDebuggingAccessError",
    path:"pages/WebController/SetWebDebuggingAccessError"
  },
  {
    title:"WebController_PageDown",
    path:"pages/WebController/PageDown"
  },
  {
    title:"WebController_PostUrl",
    path:"pages/WebController/PostUrl"
  },
  {
    title:"WebAttribute_OnlineImageAccess",
    path:"pages/WebAttribute/onlineImageAccess"
  },
  {
    title:"WebAttribute_ImageAccess",
    path:"pages/WebAttribute/imageAccess"
  },
  {
    title:"WebAttribute_BlockNetwork",
    path:"pages/WebAttribute/blockNetwork"
  },
  {
    title:"WebAttribute_DomStorageAccess",
    path:"pages/WebAttribute/domStorageAccess"
  },
  {
    title:"WebAttribute_MixedMode",
    path:"pages/WebAttribute/mixedMode"
  },
  {
    title:"WebAttribute_CacheMode",
    path:"pages/WebAttribute/cacheMode"
  },
  {
    title:"WebAttribute_GeolocationAccess",
    path:"pages/WebAttribute/geolocationAccess"
  },
  {
    title:"WebAttribute_OnRefreshAccessedHistory",
    path:"pages/WebAttribute/OnRefreshAccessedHistory"
  },
  {
    title:"WebAttribute_OnRefreshAccessedHistoryError",
    path:"pages/WebAttribute/OnRefreshAccessedHistoryError"
  },
  {
    title:"WebAttribute_OnFullScreenEnter",
    path:"pages/WebAttribute/onFullScreenEnter"
  },
  {
    title:"WebAttribute_OnFullScreenExit",
    path:"pages/WebAttribute/onFullScreenExit",
  },
  {
    title:"WebAttribute_OnBeforeUnload",
    path:"pages/WebAttribute/OnBeforeUnload"
  },
]

export const TypeSources:Array<DATASOURCES>=[
  {
    title: "WebController_Index",
    path: "pages/WebController/WebController"
  },
  {
    title: "WebAttribute_Index",
    path: "pages/WebAttribute/WebAttribute"
  },
]