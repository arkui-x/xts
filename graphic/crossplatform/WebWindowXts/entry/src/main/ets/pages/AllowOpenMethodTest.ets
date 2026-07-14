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
struct AllowOpenChildDialog {
  controller?: CustomDialogController
  childController: webview.WebviewController = new webview.WebviewController()

  build() {
    Column() {
      Web({ src: $rawfile("newWindow.html"), controller: this.childController })
        .javaScriptAccess(true)
        .multiWindowAccess(false)
        .onPageEnd(() => {
          if (this.controller) { this.controller.close() }
        })
        .onWindowExit(() => {
          if (this.controller) { this.controller.close() }
        })
    }
  }
}

@Entry
@Component
struct AllowOpenMethodTest {
  @State result: string = '等待选择模式...'
  @State allowOpenValue: boolean | null | undefined = true
  router: Router = this.getUIContext().getRouter()
  controller: webview.WebviewController = new webview.WebviewController()
  dialogController: CustomDialogController | null = null

  applyMode(mode: string): void {
    switch (mode) {
      case 'true': this.allowOpenValue = true; break
      case 'false': this.allowOpenValue = false; break
      case 'null': this.allowOpenValue = null; break
      case 'undefined': this.allowOpenValue = undefined; break
    }
    if (mode === 'null' || mode === 'undefined' || mode === 'false') {
      this.result = '网页加载成功'
    } else {
      this.result = `allow=${String(this.allowOpenValue)}, 等待自动触发...`
    }
    try { this.controller.refresh() } catch (e) { /* ignore */ }
  }

  @Builder
  ModeBtn(text: string, btnId: string, mode: string) {
    Button(text).id(btnId).fontSize(12).height(32).layoutWeight(1)
      .onClick(() => { this.applyMode(mode) })
  }

  build() {
    Scroll() {
      Column() {
        Button('返回').id('返回').width('100%').margin(2)
          .onClick(() => { this.router.back() })

        Text('allowWindowOpenMethod 接口测试').fontSize(16).fontWeight(FontWeight.Bold).margin({ top: 4 })

        Text(this.result).id('result-AllowOpen').fontWeight(FontWeight.Bold)
          .fontColor('#1890ff').fontSize(13).margin(2)

        Text('选择 allowWindowOpenMethod 值：').fontSize(12).fontColor('#666')
        Row({ space: 6 }) {
          this.ModeBtn('true', 'mode-true', 'true')
          this.ModeBtn('false', 'mode-false', 'false')
          this.ModeBtn('null', 'mode-null', 'null')
          this.ModeBtn('undefined', 'mode-undefined', 'undefined')
        }.width('100%').padding({ left: 2, right: 2 })

        Web({ src: $rawfile("allowOpen.html"), controller: this.controller })
          .height(180).width('100%')
          .javaScriptAccess(true)
          .multiWindowAccess(true)
          .allowWindowOpenMethod(this.allowOpenValue)
          .onPageBegin((event) => {})
          .onWindowNew((event) => {
            console.info('[AllowOpenMethodTest] onWindowNew! url=' + event.targetUrl)
            this.result = `event.targetUrl:${event.targetUrl}`
            let popCtrl = new webview.WebviewController()
            this.dialogController = new CustomDialogController({
              builder: AllowOpenChildDialog({ childController: popCtrl }),
              autoCancel: true
            })
            this.dialogController.open()
            try { event.handler.setWebController(popCtrl) } catch (e) {
              console.error('[AllowOpenMethodTest] onWindowNew setWebController error: ' + e)
            }
          })

        Button('刷新页面重新触发').id('refreshBtn').width('100%').margin({ top: 4 })
          .onClick(() => {
            this.result = `allow=${String(this.allowOpenValue)}, 等待自动触发...`
            try { this.controller.refresh() } catch (e) {
              console.error('[AllowOpenMethodTest] refresh error: ' + e)
            }
          })
      }
      .padding(8).width('100%')
    }
    .width('100%').height('100%').backgroundColor('#f5f7fa').scrollable(ScrollDirection.Vertical)
  }
}
