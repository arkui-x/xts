/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import { Router } from '@ohos.arkui.UIContext'
import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State message: string = 'Web Test'
  router: Router = this.getUIContext().getRouter()
  routerMode: router.RouterMode = router.RouterMode.Standard

  build() {
    Row() {
      Column({ space: 12 }) {
        Text(this.message)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)

        Button('设置fileAccess')
          .id('设置fileAccess')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/SettingFileAccess'
            })
          })

        Button('不设置fileAccess')
          .id('不设置fileAccess')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/WithoutSettingFileAccess'
            })
          })

        Button('设置textZoomRatio')
          .id('设置textZoomRatio')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/TextZoomRatio'
            })
          })

        Button('调用OnSslErrorEvent与onSslErrorEventReceive')
          .id('调用OnSslErrorEvent与onSslErrorEventReceive')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/onSslError/OnSslError'
            })
          })

        Button('onInterceptRequest')
          .id('onInterceptRequest')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/onInterceptRequest/onInterceptRequest'
            })
          })

        Button('onOverrideUrlLoading')
          .id('onOverrideUrlLoading')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/onOverrideUrlLoading/Index'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}