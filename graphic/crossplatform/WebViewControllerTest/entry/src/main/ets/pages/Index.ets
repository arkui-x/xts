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

import { webview } from '@kit.ArkWeb';
import router from '@ohos.router';

@Entry
@Component
struct IndexPage {
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Row() {
      Scroll() {
        Column() {
          Text('WebViewController Test')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 30, bottom: 30 })

          Button('postMessageEventExt测试')
            .id('postMessageEventExt测试')
            .fontSize(15)
            .margin(5)
            .height(40)
            .width('50%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/PostMessageEventExt'
              })
            })

          Button("onMessageEventExt测试")
            .id('onMessageEventExt测试')
            .fontSize(15)
            .margin(5)
            .height(40)
            .width('50%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/OnMessageEventExt'
              })
            })

          Button("runJavaScriptExt测试")
            .id('runJavaScriptExt测试')
            .fontSize(15)
            .margin(5)
            .height(40)
            .width('50%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/RunJavaScriptExt'
              })
            })

          Button("webDownloadDelegate测试")
            .id('webDownloadDelegate测试')
            .fontSize(15)
            .margin(5)
            .height(40)
            .width('50%')
            .onClick(()=>{
              router.pushUrl({
                url: 'pages/WebDownloadDelegate'
              })
            })

          Web({ src: "https://www.baidu.com/", controller: this.controller })
            .height(1)
        }
        .width('100%')
      }
    }
    .height('100%')
  }
}