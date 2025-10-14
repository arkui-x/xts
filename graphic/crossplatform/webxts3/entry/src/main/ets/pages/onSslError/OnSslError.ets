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

@Entry
@Component
struct Index {
  @State message: string = 'onSslErrorEvent and onSslErrorEventReceive Test'
  router: Router = this.getUIContext().getRouter()

  build() {
    Row() {
      Column({ space: 12 }) {
        Text(this.message)
          .fontWeight(FontWeight.Bold)

        Button('证书过期网址测试')
          .id('证书过期网址测试')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/onSslError/onSslError_expired'
            })
          })

        Button('域名不匹配网址测试')
          .id('域名不匹配网址测试')
          .onClick(() => {
            this.router.pushUrl({
              url: "pages/onSslError/onSslError_wrongHost"
            })
          })

        Button('自签名证书网址测试')
          .id('自签名证书网址测试')
          .onClick(() => {
            this.router.pushUrl({
              url: "pages/onSslError/onSslError_selfSigned"
            })
          })

        Button('不受信任的根证书网址测试')
          .id('不受信任的根证书网址测试')
          .onClick(() => {
            this.router.pushUrl({
              url: "pages/onSslError/onSslError_untrustedRoot"
            })
          })

        Button('子资源错误网址测试')
          .id('子资源错误网址测试')
          .onClick(() => {
            this.router.pushUrl({
              url: "pages/onSslError/onSslError_SubRes"
            })
          })

        Button('callback为null测试')
          .id('callback为null测试')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/onSslError/onSslError_callback_null'
            })
          })

        Button('callback为undefined测试')
          .id('callback为undefined测试')
          .onClick(()=>{
            this.router.pushUrl({
              url: 'pages/onSslError/onSslError_callback_undefined'
            })
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}