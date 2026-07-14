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

@Entry
@Component
struct MultiAccessTest {
  @State result: string = '等待选择模式...'
  @State multiAccessValue: boolean | null | undefined = true
  router: Router = this.getUIContext().getRouter()
  controller: webview.WebviewController = new webview.WebviewController()

  applyMode(mode: string): void {
    switch (mode) {
      case 'null': this.multiAccessValue = null; break
      case 'undefined': this.multiAccessValue = undefined; break
    }
    this.result = `multi=${String(this.multiAccessValue)}, 等待触发...`
    try { this.controller.refresh() } catch (e) { /* ignore */ }
  }

  @Builder
  ModeBtn(text: string, btnId: string, mode: string) {
    Button(text).id(btnId).fontSize(13).height(34).layoutWeight(1)
      .onClick(() => { this.applyMode(mode) })
  }

  build() {
    Scroll() {
      Column() {
        Button('返回').id('返回').width('100%').margin(2)
          .onClick(() => { this.router.back() })

        Text('multiWindowAccess 接口测试').fontSize(16).fontWeight(FontWeight.Bold).margin({ top: 4 })

        Text(this.result).id('result-MultiAccess').fontWeight(FontWeight.Bold)
          .fontColor('#1890ff').fontSize(13).margin(2)

        Text('选择 multiWindowAccess 值：').fontSize(12).fontColor('#666')
        Row({ space: 8 }) {
          this.ModeBtn('null', 'mode-null', 'null')
          this.ModeBtn('undefined', 'mode-undefined', 'undefined')
        }.width('100%').padding({ left: 2, right: 2 })

        Web({ src: $rawfile("window.html"), controller: this.controller })
          .height(200).width('100%')
          .javaScriptAccess(true)
          .multiWindowAccess(this.multiAccessValue as boolean)
          .allowWindowOpenMethod(true)
          .onPageEnd((event) => {
            if (this.multiAccessValue !== true && event.url && event.url.includes('baidu.com')) {
              this.result = '网页加载成功'
            }
          })
          .onWindowNew((event) => {
            console.info('[MultiAccessTest] onWindowNew! (should not happen when null/undef)')
            this.result = `event.targetUrl:${event.targetUrl}`
          })

        Button('触发打开链接').id('triggerOpen').width('100%').margin({ top: 4 })
          .onClick(() => {
            try {
              this.controller.runJavaScript("openNewWindow('https://www.baidu.com')")
            } catch (e) { console.error('execute js failed', e) }
          })
      }
      .padding(8).width('100%')
    }
    .width('100%').height('100%').backgroundColor('#f5f7fa').scrollable(ScrollDirection.Vertical)
  }
}
