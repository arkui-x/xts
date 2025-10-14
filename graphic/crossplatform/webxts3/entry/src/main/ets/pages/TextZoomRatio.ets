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
struct Setting {
  @State result: string = 'textZoomRatio Test'
  @State textZoomRatio: number | null | undefined = 1
  router: Router = this.getUIContext().getRouter()
  controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Row() {
      Column({ space: 16 }) {
        Text(this.result)
          .id('result')
          .fontWeight(FontWeight.Bold)

        Row() {
          Button("设置1")
            .id("设置1")
            .width("18%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 1
              this.controller.refresh()
            })

          Button("设置50")
            .id("设置50")
            .width("18%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 50
              this.controller.refresh()
            })

          Button("设置100")
            .id("设置100")
            .width("18%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 100
              this.controller.refresh()
            })

          Button("设置150")
            .id("设置150")
            .width("18%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 150
              this.controller.refresh()
            })

          Button("设置2147483647")
            .id("设置2147483647")
            .width("18%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 2147483647
              this.controller.refresh()
            })
        }
        .justifyContent(FlexAlign.Center)

        Row() {
          Button("设置-100")
            .id("设置-100")
            .width("15%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = -100
              this.controller.refresh()
            })

          Button("设置0")
            .id("设置0")
            .width("15%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 0
              this.controller.refresh()
            })

          Button("设置150.5")
            .id("设置150.5")
            .width("15%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 150.5
              this.controller.refresh()
            })

          Button("设置9999999999")
            .id("设置9999999999")
            .width("15%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = 9999999999
              this.controller.refresh()
            })

          Button("设置null")
            .id("设置null")
            .width("15%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = null
              this.controller.refresh()
            })

          Button("设置undefined")
            .id("设置undefined")
            .width("18%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.textZoomRatio = undefined
              this.controller.refresh()
            })
        }
        .justifyContent(FlexAlign.Center)

        Button('返回')
          .id('返回')
          .backgroundColor(Color.Orange)
          .onClick(() => {
            this.router.back()
          })

        Web({ src: $rawfile("rawfile_webPage.html"), controller: this.controller })
          .height(200)
          .javaScriptAccess(true)
          .textZoomRatio(this.textZoomRatio)
          .onErrorReceive((e) => {
            this.result = "网页加载失败"
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}