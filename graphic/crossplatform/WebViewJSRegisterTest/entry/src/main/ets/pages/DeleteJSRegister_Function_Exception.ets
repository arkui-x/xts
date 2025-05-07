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
import { Router } from '@ohos.arkui.UIContext'

@Entry
@Component
struct Index {
  scroller: Scroller = new Scroller();
  controller: webview.WebviewController = new webview.WebviewController();
  controller1: webview.WebviewController = new webview.WebviewController();
  @State router: Router = this.getUIContext().getRouter();
  @State message: string = "Hello World";

  build() {
      Column() {
        Text(this.message)
          .id("Result")

        Scroll(this.scroller) {
          Column({ space: 5 }) {
            Button('NoBinding')
              .id('NoBinding')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller1.deleteJavaScriptRegister("backToEts");
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('DeleteNameIsNotExist')
              .id('DeleteNameIsNotExist')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.deleteJavaScriptRegister("backToEts");
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('DeleteNameIsEmpty')
              .id('DeleteNameIsEmpty')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.deleteJavaScriptRegister("");
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('DeleteNameIsUndefined')
              .id('DeleteNameIsUndefined')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.deleteJavaScriptRegister(undefined);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('DeleteNameIsNull')
              .id('DeleteNameIsNull')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.deleteJavaScriptRegister(null);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('Back')
              .id('Back')
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.router.back()
              })

            Web({ src: $rawfile('index_Exception.html'), controller: this.controller })
              .javaScriptAccess(true)
          }
        }
     }
  }
}