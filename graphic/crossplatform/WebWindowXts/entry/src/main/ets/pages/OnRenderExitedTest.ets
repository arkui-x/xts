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
import deviceInfo from '@ohos.deviceInfo'

@Entry
@Component
struct OnRenderExitedTest {
  @State result: string = '等待选择模式...'
  @State cbMode: string = 'registered'
  router: Router = this.getUIContext().getRouter()
  controller: webview.WebviewController = new webview.WebviewController()
  @State webSrc: string = ''

  isIOSPlatform(): boolean {
    const osFullName = deviceInfo.osFullName ?? ''
    return osFullName.split(' ')[0] === 'iOS'
  }

  applyMode(mode: string): void {
    switch (mode) {
      case 'normal': this.cbMode = 'registered'; break
      case 'null': this.cbMode = 'asNull'; break
      case 'undefined': this.cbMode = 'asUndefined'; break
    }
    this.result = `callback=${mode}, 点击"触发渲染退出"`
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

        Text('onRenderExited 接口测试').fontSize(16).fontWeight(FontWeight.Bold).margin({ top: 4 })

        Text(this.result).id('result-RenderExit').fontWeight(FontWeight.Bold)
          .fontColor('#1890ff').fontSize(13).margin(2)

        Text('选择 callback 模式：').fontSize(12).fontColor('#666')
        Row({ space: 6 }) {
          this.ModeBtn('正常', 'mode-normal', 'normal')
          this.ModeBtn('cb=null', 'mode-null', 'null')
          this.ModeBtn('cb=undef', 'mode-undefined', 'undefined')
        }.width('100%').padding({ left: 2, right: 2 })

        Button('触发渲染退出').id('triggerRenderExit').width('100%').margin({ top: 8 })
          .onClick(() => {
            // callback=null/undefined 时不会触发事件，无需加载崩溃URL
            if (this.cbMode !== 'registered') {
              this.result = '网页加载成功'
              return
            }
            if (this.isIOSPlatform()) {
              try { this.controller.loadUrl($rawfile('crash_oom.html')); this.webSrc = '' }
              catch (e) { console.error('load crash page failed', e) }
            } else {
              try { this.controller.loadUrl('chrome://crash/'); this.webSrc = 'chrome://crash/' }
              catch (e) { console.error('load crash url failed', e) }
            }
            this.result = '已触发，等待回调...'
          })

        Web({ src: this.webSrc, controller: this.controller })
          .javaScriptAccess(true)
          .layoutWeight(1).width('100%')
          .onRenderExited(this.cbMode === 'asNull'
            ? null
            : this.cbMode === 'asUndefined'
              ? undefined
              : (event) => {
                  const reason = event ? event.renderExitReason : 'event为null'
                  this.result = 'renderExitReason:' + reason
                  console.info('[OnRenderExitedTest] renderExitReason=' + reason)
                })

        Blank().height(8)
      }
      .padding(8).width('100%')
    }
    .width('100%').height('100%').backgroundColor('#f5f7fa').scrollable(ScrollDirection.Vertical)
  }
}
