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
  @State result: string = 'fileAccess Test'
  router: Router = this.getUIContext().getRouter()
  sandboxFile: string = '/sandbox_webPage.html'
  rawfile: Resource = $rawfile("rawfile_webPage.html")

  controller: webview.WebviewController = new webview.WebviewController()
  sandboxPath: string | undefined = this.getUIContext().getHostContext()?.filesDir

  build() {
    Row() {
      Column({ space: 16 }) {
        Text(this.result)
          .id('result')
          .fontWeight(FontWeight.Bold)

        Row() {
          Button("加载沙箱网页")
            .id("加载沙箱网页")
            .width("30%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.controller.loadUrl("file://" + this.sandboxPath + '/sandbox_webPage.html')
            })

          Button("加载沙箱图片")
            .id("加载沙箱图片")
            .width("30%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.controller.loadUrl("file://" + this.sandboxPath + '/picture.png')
            })

          Button("加载沙箱视频")
            .id("加载沙箱视频")
            .width("30%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.controller.loadUrl("file://" + this.sandboxPath + '/video.mp4')
            })
        }
        .justifyContent(FlexAlign.Center)

        Row() {
          Button("加载rawfile网页")
            .id("加载rawfile网页")
            .width("30%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.controller.loadUrl($rawfile("rawfile_webPage.html"))
            })

          Button("加载rawfile图片")
            .id("加载rawfile图片")
            .width("30%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.controller.loadUrl($rawfile("picture.png"))
            })

          Button("加载rawfile视频")
            .id("加载rawfile视频")
            .width("30%")
            .onClick(() => {
              this.result = "网页加载成功"
              this.controller.loadUrl($rawfile("video.mp4"))
            })
        }
        .justifyContent(FlexAlign.Center)

        Button('返回')
          .id('返回')
          .backgroundColor(Color.Orange)
          .onClick(() => {
            this.router.back()
          })

        Web({ src: "about:blank", controller: this.controller })
          .height(200)
          .javaScriptAccess(true)
          .onErrorReceive((e) => {
            this.result = "网页加载失败"
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}