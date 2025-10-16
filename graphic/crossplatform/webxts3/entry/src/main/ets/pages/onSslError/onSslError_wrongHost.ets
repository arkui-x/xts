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
  @State result: string = '这是测试onSslErrorEvent与onSslErrorEventReceive接口域名不匹配网址的界面'
  @State onSslErrorEvent_url: string = ""
  @State onSslErrorEvent_error: string = ""
  @State onSslErrorEvent_originalUrl: string = ""
  @State onSslErrorEvent_referrer: string = " "
  @State onSslErrorEvent_isMainFrame: string = ""
  @State onSslErrorEvent_certChainData_length: string = ""
  @State onSslErrorEventReceive_error: string = ""
  @State onSslErrorEventReceive_certChainData_length: string = ""

  controller: webview.WebviewController = new webview.WebviewController()
  router: Router = this.getUIContext().getRouter()
  uiContext: UIContext = this.getUIContext()

  build() {
    Row() {
      Column() {
        Text(this.result)
          .id('result')
          .fontWeight(FontWeight.Bold)

        Text(this.onSslErrorEvent_url)
          .id('onSslErrorEvent_url')

        Text(this.onSslErrorEvent_error)
          .id('onSslErrorEvent_error')

        Text(this.onSslErrorEvent_originalUrl)
          .id('onSslErrorEvent_originalUrl')

        Text(this.onSslErrorEvent_referrer)
          .id('onSslErrorEvent_referrer')

        Text(this.onSslErrorEvent_isMainFrame)
          .id('onSslErrorEvent_isMainFrame')

        Text(this.onSslErrorEvent_certChainData_length)
          .id('onSslErrorEvent_certChainData_length')

        Text(this.onSslErrorEventReceive_error)
          .id('onSslErrorEventReceive_error')

        Text(this.onSslErrorEventReceive_certChainData_length)
          .id('onSslErrorEventReceive_certChainData_length')

        Button('返回主页')
          .id('返回主页')
          .backgroundColor(Color.Orange)
          .onClick(() => {
            this.router.back({
              url: 'pages/Index'
            })
          })

        Web({ src: 'https://wrong.host.badssl.com/', controller: this.controller })
          .height(200)
          .onSslErrorEvent((event: SslErrorEvent) => {
            this.onSslErrorEvent_url = event.url
            this.onSslErrorEvent_error = "" + event.error
            this.onSslErrorEvent_originalUrl = event.originalUrl
            this.onSslErrorEvent_referrer = " " + event.referrer
            this.onSslErrorEvent_isMainFrame = "" + event.isMainFrame
            this.onSslErrorEvent_certChainData_length = "" + event.certChainData?.length

            const errorDetails = `onSslErrorEvent信息:
              URL: ${event.url},
              Error Code: ${event.error},
              Original URL: ${event.originalUrl},
              Referrer: ${event.referrer},
              Main Frame: ${event.isMainFrame},
              CertChainData count: ${event.certChainData?.length},`

            this.uiContext.showAlertDialog({
              title: 'onSslErrorEvent弹窗',
              message: errorDetails,
              primaryButton: {
                value: '确认连接',
                action: () => {
                  try {
                    event.handler.handleConfirm()
                    this.result = "未产生异常"
                  } catch (error) {
                    this.result = "产生异常"
                  }
                }
              },
              secondaryButton: {
                value: '取消连接',
                action: () => {
                  try {
                    event.handler.handleCancel()
                    event.handler.handleCancel(false)
                    event.handler.handleCancel(true)
                    this.result = "未产生异常"
                  } catch (error) {
                    this.result = "产生异常"
                  }
                }
              }
            })
          })
          .onSslErrorEventReceive((event: OnSslErrorEventReceiveEvent) => {
            this.onSslErrorEventReceive_error = "" + event.error
            this.onSslErrorEventReceive_certChainData_length = "" + event.certChainData?.length

            const errorDetails = `onSslErrorEventReceive信息:
              Error Code: ${event.error},
              CertChainData count: ${event.certChainData?.length},`

            this.getUIContext().showAlertDialog({
              title: 'onSslErrorEventReceive弹窗',
              message: errorDetails,
              primaryButton: {
                value: '确认连接',
                action: () => {
                  try {
                    event.handler.handleConfirm()
                    this.result = "未产生异常"
                  } catch (error) {
                    this.result = "产生异常"
                  }
                }
              },
              secondaryButton: {
                value: '取消连接',
                action: () => {
                  try {
                    event.handler.handleCancel()
                    event.handler.handleCancel(false)
                    event.handler.handleCancel(true)
                    this.result = "未产生异常"
                  } catch (error) {
                    this.result = "产生异常"
                  }
                }
              }
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}