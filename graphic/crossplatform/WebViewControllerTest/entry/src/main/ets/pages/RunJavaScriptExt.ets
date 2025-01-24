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
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();

  @State runJavaScriptFunc: string | null | undefined = "";
  @State runJavaScriptResult: string = "";
  @State usePromise: boolean = false;

  build() {
    Row() {
      Scroll() {
        Column() {
          Text(this.runJavaScriptResult)
            .id("runJavaScriptResult")
            .fontSize(16)

          Button("runJavaScript getString_withString")
            .id("runJavaScript getString_withString")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.refresh();
              this.runJavaScriptFunc = 'getString()';
            })

          Button("runJavaScript getNumber_withString")
            .id("runJavaScript getNumber_withString")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.refresh();
              this.runJavaScriptFunc = 'getNumber()';
            })

          Button("runJavaScript getBoolean_withString")
            .id("runJavaScript getBoolean_withString")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.refresh();
              this.runJavaScriptFunc = 'getBoolean()';
            })

          Button("runJavaScript getArray_number_withString")
            .id("runJavaScript getArray_number_withString")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.refresh();
              this.runJavaScriptFunc = 'getArray_number()';
            })

          Button("runJavaScript getArray_string_withString")
            .id("runJavaScript getArray_string_withString")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.refresh();
              this.runJavaScriptFunc = 'getArray_string()';
            })

          Button("runJavaScript getArray_boolean_withString")
            .id("runJavaScript getArray_boolean_withString")
            .width('70%')
            .height(28)
            .fontSize(12)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.refresh();
              this.runJavaScriptFunc = 'getArray_boolean()';
            })

          Button('runJavaScript Null')
            .id('runJavaScript Null')
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.runJavaScriptFunc = null;
              this.controller.refresh();
            })

          Button('runJavaScript Undefined')
            .id('runJavaScript Undefined')
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.runJavaScriptFunc = undefined;
              this.controller.refresh();
            })

          Button('runJavaScript NullCallback')
            .id('runJavaScript NullCallback')
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.runJavaScriptFunc = "test()";
              try {
                this.controller.runJavaScriptExt(this.runJavaScriptFunc, null);
              } catch (resError) {
                this.runJavaScriptResult = `ErrorCode:${(resError as BusinessError).code}`;
              }
            })

          Button('runJavaScript UndefinedCallback')
            .id('runJavaScript UndefinedCallback')
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.runJavaScriptFunc = "test()";
              try {
                this.controller.runJavaScriptExt(this.runJavaScriptFunc, undefined);
              } catch (resError) {
                this.runJavaScriptResult = `ErrorCode:${(resError as BusinessError).code}`;
              }
            })

          Button("switch promise")
            .id("switch promise")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.usePromise = true;
              this.controller.refresh();
            })

          Button("runJavaScriptExt withoutWeb")
            .id("runJavaScriptExt withoutWeb")
            .width('70%')
            .height(28)
            .fontSize(15)
            .margin({ top: 5 })
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/RunJavaScriptExt_withoutWeb'
              })
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

          Web({ src: $rawfile('index_runJavaScriptExt.html'), controller: this.controller })
            .javaScriptAccess(true)
            .onPageEnd(() => {
              try {
                if (this.usePromise) {
                  this.controller.runJavaScriptExt(this.runJavaScriptFunc)
                    .then((result) => {
                      try {
                        let type = result.getType();
                        switch (type) {
                          case webview.JsMessageType.STRING: {
                            this.runJavaScriptResult = `String:${result.getString()}`;
                            break;
                          }
                          case webview.JsMessageType.NUMBER: {
                            this.runJavaScriptResult = `Number:${result.getNumber()}`;
                            break;
                          }
                          case webview.JsMessageType.BOOLEAN: {
                            this.runJavaScriptResult = `Boolean:${result.getBoolean()}`;
                            break;
                          }
                          case webview.JsMessageType.ARRAY: {
                            this.runJavaScriptResult = "Array:" + result.getArray();
                            break;
                          }
                          default: {
                            this.runJavaScriptResult = "default break" + type;
                            break;
                          }
                        }
                      } catch (resError) {
                        this.runJavaScriptResult = `ErrorCode:${(resError as BusinessError).code}`;
                      }
                    }).catch((error: BusinessError) => {
                    this.runJavaScriptResult = `ErrorCode:${(error as BusinessError).code}`;
                    return;
                  });
                } else {
                  this.controller.runJavaScriptExt(
                    this.runJavaScriptFunc,
                    (error, result) => {
                      if (error) {
                        this.runJavaScriptResult = `ErrorCode:${(error as BusinessError).code}`;
                        return;
                      }
                      if (result) {
                        try {
                          let type = result.getType();
                          switch (type) {
                            case webview.JsMessageType.STRING: {
                              this.runJavaScriptResult = `String:${result.getString()}`;
                              break;
                            }
                            case webview.JsMessageType.NUMBER: {
                              this.runJavaScriptResult = `Number:${result.getNumber()}`;
                              break;
                            }
                            case webview.JsMessageType.BOOLEAN: {
                              this.runJavaScriptResult = `Boolean:${result.getBoolean()}`;
                              break;
                            }
                            case webview.JsMessageType.ARRAY: {
                              this.runJavaScriptResult = "Array:" + result.getArray();
                              break;
                            }
                            default: {
                              this.runJavaScriptResult = "default break" + type;
                              break;
                            }
                          }
                        } catch (resError) {
                          this.runJavaScriptResult = `ErrorCode:${(resError as BusinessError).code}`;
                        }
                      }
                    });
                }
              } catch (resError) {
                this.runJavaScriptResult = `ErrorCode:${(resError as BusinessError).code}`;
              }
            })

        }
      }
    }
  }
}