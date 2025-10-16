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

import { webview } from '@kit.ArkWeb'
import { Router } from '@ohos.arkui.UIContext'

@Entry
@Component
struct WebComponent {
  @State result: string = '这是测试onSslErrorEvent与onSslErrorEventReceive接口callback为null的界面'
  controller: webview.WebviewController = new webview.WebviewController()
  router: Router = this.getUIContext().getRouter()

  build() {
    Row() {
      Column() {
        Text(this.result)
          .id('result')
          .fontWeight(FontWeight.Bold)

        Button('返回主页')
          .id('返回主页')
          .backgroundColor(Color.Orange)
          .onClick(() => {
            this.router.back({
              url: 'pages/Index'
            })
          })

        Web({ src: 'https://expired.badssl.com', controller: this.controller })
          .height(200)
          .onSslErrorEvent(null)
          .onSslErrorEventReceive(null)
      }
      .width('100%')
    }
    .height('100%')
  }
}