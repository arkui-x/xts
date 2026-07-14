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

interface WindowNewHandler {
  setWebController: (controller: webview.WebviewController | null | undefined) => void
}

interface WindowNewEvent {
  targetUrl: string
  handler: WindowNewHandler
}

@CustomDialog
struct ChildWebViewDialog {
  controller?: CustomDialogController
  childController: webview.WebviewController = new webview.WebviewController()

  build() {
    Column() {
      Web({ src: $rawfile("newWindow.html"), controller: this.childController })
        .javaScriptAccess(true)
        .multiWindowAccess(false)
        .onPageEnd(() => {
          if (this.controller) {
            this.controller.close()
          }
        })
        .onWindowExit(() => {
          if (this.controller) {
            this.controller.close()
          }
        })
    }
  }
}

@Entry
@Component
struct OnWindowNewTest {
  @State result: string = '等待选择模式...'
  @State multiWinAccess: boolean = true
  @State allowWinOpenMethod: boolean = true
  @State cbMode: string = 'normal'
  @State cbRegistered: string = 'registered'

  router: Router = this.getUIContext().getRouter()
  controller: webview.WebviewController = new webview.WebviewController()
  dialogController: CustomDialogController | null = null

  applyMode(mode: string): void {
    switch (mode) {
      case 'm01':
        this.multiWinAccess = true; this.allowWinOpenMethod = true
        this.cbMode = 'normal'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm02':
        this.multiWinAccess = true; this.allowWinOpenMethod = true
        this.cbMode = 'noHandler'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm03':
        this.multiWinAccess = true; this.allowWinOpenMethod = true
        this.cbMode = 'handlerNull'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm04':
        this.multiWinAccess = true; this.allowWinOpenMethod = true
        this.cbMode = 'handlerUndef'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm05':
        this.multiWinAccess = true; this.allowWinOpenMethod = false
        this.cbMode = 'normal'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm06':
        this.multiWinAccess = true; this.allowWinOpenMethod = false
        this.cbMode = 'noHandler'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm07':
        this.multiWinAccess = true; this.allowWinOpenMethod = false
        this.cbMode = 'handlerNull'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm08':
        this.multiWinAccess = true; this.allowWinOpenMethod = false
        this.cbMode = 'handlerUndef'; this.cbRegistered = 'registered'
        this.result = '窗口未弹出'
        break
      case 'm09':
        this.multiWinAccess = false; this.allowWinOpenMethod = false
        this.cbMode = 'normal'; this.cbRegistered = 'registered'
        this.result = '网页未加载'
        break
      case 'm10':
        this.multiWinAccess = false; this.allowWinOpenMethod = true
        this.cbMode = 'normal'; this.cbRegistered = 'registered'
        this.result = '网页未加载'
        break
      case 'm11':
        this.multiWinAccess = true; this.allowWinOpenMethod = true
        this.cbMode = 'normal'; this.cbRegistered = 'asNull'
        this.result = '网页未加载'
        break
      case 'm12':
        this.multiWinAccess = true; this.allowWinOpenMethod = true
        this.cbMode = 'normal'; this.cbRegistered = 'asUndefined'
        this.result = '网页未加载'
        break
    }

    try { this.controller.refresh() } catch (e) {
      console.error('[OnWindowNewTest] refresh error: ' + e)
    }
  }

  handleOnWindowNew(event: WindowNewEvent): void {
    console.info('[OnWindowNewTest] onWindowNew 触发! mode=' + this.cbMode + ', url=' + event.targetUrl)
    if (this.cbRegistered !== 'registered') {
      this.result = '网页加载成功'
      return
    }
    if (this.cbMode === 'normal') {
      this.result = `event.targetUrl:${event.targetUrl}`
      let popCtrl = new webview.WebviewController()
      this.dialogController = new CustomDialogController({
        builder: ChildWebViewDialog({ childController: popCtrl }),
        autoCancel: true
      })
      this.dialogController.open()
      event.handler.setWebController(popCtrl)
    } else if (this.cbMode === 'noHandler') {
      this.result = `event.targetUrl:${event.targetUrl}`
    } else if (this.cbMode === 'handlerNull') {
      this.result = `event.targetUrl:${event.targetUrl}`
      event.handler.setWebController(null)
    } else if (this.cbMode === 'handlerUndef') {
      this.result = `event.targetUrl:${event.targetUrl}`
      event.handler.setWebController(undefined)
    }
  }

  // 辅助：创建模式按钮（统一样式）
  @Builder
  ModeBtn(text: string, btnId: string, mode: string) {
    Button(text).id(btnId).fontSize(11).height(30).padding({ left: 6, right: 6 }).margin(2)
      .onClick(() => { this.applyMode(mode) })
  }

  build() {
    Scroll() {
      Column() {
        Button('返回').id('返回').width('100%').margin(2)
          .onClick(() => { this.router.back() })

        Text('onWindowNew 接口测试').fontSize(16).fontWeight(FontWeight.Bold).margin({ top: 4 })

        Text(this.result).id('result-WinNew').fontWeight(FontWeight.Bold).fontColor('#1890ff')
          .fontSize(13).margin(2)

        // ===== 分组标题 =====
        Text('【multi=T, allow=T】handler 变体').fontSize(11).fontColor('#1890ff')
          .margin({ top: 6 }).width('100%')
        Flex({ wrap: FlexWrap.Wrap }) {
          this.ModeBtn('M01-弹窗', 'mode-m01', 'm01')
          this.ModeBtn('M02-不调hnd', 'mode-m02', 'm02')
          this.ModeBtn('M03-h(null)', 'mode-m03', 'm03')
          this.ModeBtn('M04-h(undef)', 'mode-m04', 'm04')
        }.width('100%')

        Text('【multi=T, allow=F】handler 变体').fontSize(11).fontColor('#fa8c16')
          .margin({ top: 4 }).width('100%')
        Flex({ wrap: FlexWrap.Wrap }) {
          this.ModeBtn('M05-弹窗', 'mode-m05', 'm05')
          this.ModeBtn('M06-不调hnd', 'mode-m06', 'm06')
          this.ModeBtn('M07-h(null)', 'mode-m07', 'm07')
          this.ModeBtn('M08-h(undef)', 'mode-m08', 'm08')
        }.width('100%')

        Text('【multi=F / cb特殊值】').fontSize(11).fontColor('#722ed1')
          .margin({ top: 4 }).width('100%')
        Flex({ wrap: FlexWrap.Wrap }) {
          this.ModeBtn('M09-multiF,allowF', 'mode-m09', 'm09')
          this.ModeBtn('M10-multiF,allowT', 'mode-m10', 'm10')
          this.ModeBtn('M11-cb=null', 'mode-m11', 'm11')
          this.ModeBtn('M12-cb=undef', 'mode-m12', 'm12')
        }.width('100%')

        // ===== WebView =====
        Web({ src: $rawfile("window.html"), controller: this.controller })
          .height(180).width('100%')
          .javaScriptAccess(true)
          .multiWindowAccess(this.multiWinAccess)
          .allowWindowOpenMethod(this.allowWinOpenMethod)
          .onPageBegin((event) => {
            if (!this.multiWinAccess && event.url && event.url.includes('baidu.com')) {
              console.info('[OnWindowNewTest] 主WebView已导航到: ' + event.url)
            }
          })
          .onPageEnd((event) => {
            if (!this.multiWinAccess && event.url && event.url.includes('baidu.com')) {
              this.result = '网页加载成功'
            }
          })
          .onWindowNew(this.cbRegistered === 'asNull'
            ? null
            : this.cbRegistered === 'asUndefined'
              ? undefined
              : (event: WindowNewEvent) => { this.handleOnWindowNew(event); })

        // ===== 触发按钮 =====
        Button('触发打开链接').id('triggerOpen').width('100%').margin({ top: 4 })
          .onClick(() => {
            try {
              this.controller.runJavaScript("startTimerToOpen('https://www.baidu.com', 2)")
            } catch (e) {
              console.error('execute js failed', e)
            }
            if (this.cbRegistered !== 'registered') {
              this.result = '网页加载成功'
            }
          })
      }
      .padding(8)
      .width('100%')
    }
    .width('100%').height('100%').backgroundColor('#f5f7fa').scrollable(ScrollDirection.Vertical)
  }
}
