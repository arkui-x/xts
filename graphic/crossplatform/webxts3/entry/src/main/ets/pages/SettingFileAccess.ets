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
import { fileIo } from '@kit.CoreFileKit'
import { Router } from '@ohos.arkui.UIContext'

const htmlContent = `
<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>沙箱网页</title>
  <style>
    body {
      background-color: lavender;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    h1 { font-size: 32px; color: #333; }
  </style>
</head>
<body>
  <h1>这是一个应用沙箱中的网页文件</h1>
</body>
</html>
`

@Entry
@Component
struct Setting {
  @State result: string = 'fileAccess Test'
  @State isFileAccess: boolean | null | undefined = false
  @State fileAccess: string = 'fileAccess: false'
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

        Button("写文件到沙箱")
          .id("写文件到沙箱")
          .onClick(async () => {
            try {
              let html_fd = fileIo.openSync(this.sandboxPath + '/sandbox_webPage.html', fileIo.OpenMode.CREATE |
              fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
              fileIo.writeSync(html_fd.fd, htmlContent)
              fileIo.closeSync(html_fd)

              let picture_data = this.getUIContext().getHostContext()?.resourceManager.getRawFileContentSync("picture.png")
              let picture_fd = fileIo.openSync(this.sandboxPath + '/picture.png', fileIo.OpenMode.CREATE |
              fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
              fileIo.writeSync(picture_fd.fd, picture_data?.buffer)
              fileIo.closeSync(picture_fd)

              let video_data = await this.getUIContext().getHostContext()?.resourceManager.getRawFileContent("video.mp4")
              let video_fd = fileIo.openSync(this.sandboxPath + '/video.mp4', fileIo.OpenMode.CREATE |
              fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.TRUNC)
              fileIo.writeSync(video_fd.fd, video_data?.buffer)
              fileIo.closeSync(video_fd)

              this.result = "写入完成"
            } catch (error) {
              this.result = "写入异常: " + JSON.stringify(error)
            }
          })

        Select([{ value: '选择false' }, { value: '选择true' }, { value: '选择null' }, { value: '选择undefined' }])
          .id('切换fileAccess属性')
          .value('切换fileAccess属性')
          .onSelect((index: number) => {
            switch (index) {
              case 0:
                this.isFileAccess = false
                break
              case 1:
                this.isFileAccess = true
                break
              case 2:
                this.isFileAccess = null
                break
              case 3:
                this.isFileAccess = undefined
                break
              default:
                break
            }
          })

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
          .fileAccess(this.isFileAccess)
          .onErrorReceive((e) => {
            this.result = "网页加载失败"
          })

      }
      .width('100%')
    }
    .height('100%')
  }
}