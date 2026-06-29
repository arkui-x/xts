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

import { webview } from '@kit.ArkWeb'
import { Router } from '@ohos.arkui.UIContext'

@CustomDialog
struct ExitChildWebView {
  controller?: CustomDialogController
  childController: webview.WebviewController = new webview.WebviewController()
  onExitCallback?: () => void

  build() {
    Column() {
      Web({ src: $rawfile("newWindow.html"), controller: this.childController })
        .javaScriptAccess(true)
        .multiWindowAccess(false)
        .layoutWeight(1).width('100%')
        .onPageEnd(() => {
          // 子页面加载完成后自动调用 window.close() 触发 onWindowExit
          try { this.childController.runJavaScript("closeThisWindow()") } catch (e) {
            console.error('[ExitChildWebView] runJavaScript closeThisWindow error: ' + e)
          }
        })
        .onWindowExit(() => {
          console.info('[ExitChildWebView] onWindowExit 回调触发!')
          if (this.onExitCallback) {
            this.onExitCallback()
          }
          if (this.controller) {
            this.controller.close()
          }
        })
    }.width('100%').padding(8)
  }
}

@Entry
@Component
struct OnWindowExitTest {
  @State result: string = '等待触发...'
  router: Router = this.getUIContext().getRouter()
  controller: webview.WebviewController = new webview.WebviewController()
  dialogController: CustomDialogController | null = null
  popController: webview.WebviewController | null = null

  build() {
    Column() {
      Button('返回').id('返回').width('100%').margin(2)
        .onClick(() => { this.router.back() })

      Text('onWindowExit 接口测试').fontSize(18).fontWeight(FontWeight.Bold).margin(4)

      Text(this.result).id('result-WinExit').fontWeight(FontWeight.Bold)
        .fontColor('#1890ff').fontSize(14).margin(4).width('100%')

      Button('触发打开链接（创建子窗口）').id('triggerOpen').width('100%').margin(2)
        .onClick(() => {
          this.result = '已点击，等待子窗口创建并关闭...'
          try {
            this.controller.runJavaScript("openNewWindow()")
          } catch (e) {
            console.error('execute js failed', e)
          }
        })

      Web({ src: $rawfile("main.html"), controller: this.controller })
        .javaScriptAccess(true)
        .multiWindowAccess(true)
        .allowWindowOpenMethod(true)
        .layoutWeight(1).width('100%')
        .onWindowNew((event) => {
          console.info('[OnWindowExitTest] onWindowNew! targetUrl=' + event.targetUrl)
          // 创建子窗口 WebView 弹窗
          let popCtrl = new webview.WebviewController()
          this.popController = popCtrl
          if (this.dialogController) {
            this.dialogController.close()
          }
          this.dialogController = new CustomDialogController({
            builder: ExitChildWebView({
              childController: popCtrl,
              onExitCallback: () => {
                this.result = 'onWindowExit回调触发'
              }
            }),
            autoCancel: true
          })
          this.dialogController.open()
          try {
            event.handler.setWebController(popCtrl)
          } catch (e) {
            console.error('[OnWindowExitTest] setWebController failed', e)
            if (this.dialogController) { this.dialogController.close() }
          }
        })
    }
    .width('100%').height('100%').backgroundColor('#f5f7fa')
  }
}
