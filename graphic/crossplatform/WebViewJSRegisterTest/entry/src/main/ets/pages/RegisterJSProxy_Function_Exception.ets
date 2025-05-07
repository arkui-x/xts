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
import deviceInfo from '@ohos.deviceInfo';
import { Router } from '@ohos.arkui.UIContext'

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

class TestObj {
  constructor(indexRef: Index) {
    if (indexRef) {
      this.indexRef = indexRef;
    }
  }

  testNumber(testNum: number): number {
    console.log('Web Component number:' + testNum);
    return testNum;
  }

  testString(testStr: string): string {
    console.info('Web Component string:' + testStr);
    if (this.indexRef) {
      this.indexRef.message = "testString is call, parameter is: " + testStr;
    }
    return testStr;
  }

  testBoolean(testBoolean: boolean): boolean {
    console.log('Web Component boolean:' + testBoolean);
    return testBoolean;
  }

  testNumberArray(testNumberArray: Array<number>): Array<number> {
    console.log('Web Component NumberArray:' + testNumberArray);
    return testNumberArray;
  }

  testStringArray(testStringArray: Array<string>): Array<string> {
    console.log('Web Component StringArray:' + testStringArray);
    return testStringArray;
  }

  testBooleanArray(testBooleanArray: Array<boolean>): Array<boolean> {
    console.log('Web Component BooleanArray:' + testBooleanArray);
    return testBooleanArray;
  }

  private indexRef: Index | null = null;
}

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

@Entry
@Component
struct Index {
  scroller: Scroller = new Scroller()
  controller: webview.WebviewController = new webview.WebviewController();
  controller1: webview.WebviewController = new webview.WebviewController();
  @State router: Router = this.getUIContext().getRouter();
  @State testObj: TestObj = new TestObj(this);
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
                  this.controller1.registerJavaScriptProxy(this.testObj, "backToEts", ["testString"]);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterObjectIsNull')
              .id('RegisterObjectIsNull')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(null, "backToEts", ["testString"]);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterObjectIsUndefined')
              .id('RegisterObjectIsUndefined')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(undefined, "backToEts", ["testString"]);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterNameIsNull')
              .id('RegisterNameIsNull')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, null, ["testString"]);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterNameIsUndefined')
              .id('RegisterNameIsUndefined')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, undefined, ["testString"]);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterSyncMethodListIsNull')
              .id('RegisterSyncMethodListIsNull')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, "backToEts", null);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterSyncMethodListIsUndefined')
              .id('RegisterSyncMethodListIsUndefined')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, "backToEts", undefined);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterAsyncMethodListIsNull')
              .id('RegisterAsyncMethodListIsNull')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, "backToEts", [], null);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterAsyncMethodListIsUndefined')
              .id('RegisterAsyncMethodListIsUndefined')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, "backToEts", [], undefined);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('RegisterAsyncMethodAndSyncMethod')
              .id('RegisterAsyncMethodAndSyncMethod')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(async () => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, "backToEts", ["testString"], ["testString"]);
                  await sleep(400);
                  if (platform.startsWith('OpenHarmony')) {
                    this.controller.refresh();
                  }
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                  this.message =
                    `ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`;
                }
              })

            Button('TestString')
              .id('TestString')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(async () => {
                try {
                  this.controller.runJavaScriptExt('htmlTestString()');
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