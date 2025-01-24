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
import { BusinessError } from '@kit.BasicServicesKit';
import router from '@ohos.router';

@Entry
@Component
struct WithoutWebComponent {
  controller: webview.WebviewController = new webview.WebviewController();

  @State runJavaScriptResult: string = "";

  build() {
    Row() {
      Scroll() {
        Column() {
          Text(this.runJavaScriptResult)
            .id("runJavaScriptResult")
            .fontSize(16)

          Button("runJavaScript callback")
            .id("runJavaScript callback")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.controller.runJavaScriptExt("test()", (error, result) => {});
              } catch (Error) {
                this.runJavaScriptResult = `ErrorCode:${(Error as BusinessError).code}`;
              }
            })

          Button("runJavaScript promise")
            .id("runJavaScript promise")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              try {
                this.controller.runJavaScriptExt("test()")
                  .then((result) => {});
              } catch (Error) {
                this.runJavaScriptResult = `ErrorCode:${(Error as BusinessError).code}`;
              }
            })

          Button("Back")
            .id("Back")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#fffbb80d')
            .onClick(() => {
              router.back();
            })

        }
      }
    }
  }
}