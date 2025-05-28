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

class TestObj {
  constructor(indexRef?: Index) {
    if (indexRef) {
      this.indexRef = indexRef;
    }
  }

  testSyncNumber(testSyncNum: number): number {
    console.log('Web Component SyncNumber:' + testSyncNum);
    if (this.indexRef) {
      this.indexRef.message = "testSyncNumber is call, parameter is: " + testSyncNum;
    }
    return testSyncNum;
  }

  testSyncString(testSyncStr: string): string {
    console.info('Web Component SyncString:' + testSyncStr);
    if (this.indexRef) {
      this.indexRef.message = "testSyncString is call, parameter is: " + testSyncStr;
    }
    return testSyncStr;
  }

  testSyncBoolean(testSyncBoolean: boolean): boolean {
    console.log('Web Component SyncBoolean:' + testSyncBoolean);
    if (this.indexRef) {
      this.indexRef.message = "testSyncBoolean is call, parameter is: " + testSyncBoolean;
    }
    return testSyncBoolean;
  }

  testSyncNumberArray(testSyncNumberArray: Array<number>): Array<number> {
    console.log('Web Component SyncNumberArray:' + testSyncNumberArray);
    if (this.indexRef) {
      this.indexRef.message = "testSyncNumberArray is call, parameter is: " + testSyncNumberArray;
    }
    return testSyncNumberArray;
  }

  testSyncStringArray(testSyncStringArray: Array<string>): Array<string> {
    console.log('Web Component SyncStringArray:' + testSyncStringArray);
    if (this.indexRef) {
      this.indexRef.message = "testSyncStringArray is call, parameter is: " + testSyncStringArray;
    }
    return testSyncStringArray;
  }

  testSyncBooleanArray(testSyncBooleanArray: Array<boolean>): Array<boolean> {
    console.log('Web Component SyncBooleanArray:' + testSyncBooleanArray);
    if (this.indexRef) {
      this.indexRef.message = "testSyncBooleanArray is call, parameter is: " + testSyncBooleanArray;
    }
    return testSyncBooleanArray;
  }

  testSyncNumberDictionary(testSyncNumberDictionary: Record<string, number>): Record<string, number> {
    console.log('Web Component SyncNumberDictionary:' + JSON.stringify(testSyncNumberDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testSyncNumberDictionary is call, parameter is: " + JSON.stringify(testSyncNumberDictionary);
    }
    return testSyncNumberDictionary;
  }

  testSyncStringDictionary(testSyncStringDictionary: Record<string, string>): Record<string, string> {
    console.log('Web Component SyncStringDictionary:' + JSON.stringify(testSyncStringDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testSyncStringDictionary is call, parameter is: " + JSON.stringify(testSyncStringDictionary);
    }
    return testSyncStringDictionary;
  }

  testSyncBooleanDictionary(testSyncBooleanDictionary: Record<string, boolean>): Record<string, boolean> {
    console.log('Web Component SyncBooleanDictionary:' + JSON.stringify(testSyncBooleanDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testSyncBooleanDictionary is call, parameter is: " + JSON.stringify(testSyncBooleanDictionary);
    }
    return testSyncBooleanDictionary;
  }

  testSyncArray10(testSyncArray10: Array<Array<Array<Array<Array<Array<Array<Array<Array<Array<Array<
    number>>>>>>>>>>>) {
    console.log('Web Component testSyncArray10:' + JSON.stringify(testSyncArray10));
    if (this.indexRef) {
      this.indexRef.message =
        "testSyncArray10 is call, parameter is: " + JSON.stringify(testSyncArray10);
    }
    return testSyncArray10;
  }

  testSyncDictionary10(testSyncDictionary10: Record<string, Record<string, Record<string, Record<string, Record<string,
    Record<string, Record<string, Record<string, Record<string, Record<string, Record<string, number>>>>>>>>>>>) {
    console.log('Web Component testSyncDictionary10:' + JSON.stringify(testSyncDictionary10));
    if (this.indexRef) {
      this.indexRef.message =
        "testSyncDictionary10 is call, parameter is: " + JSON.stringify(testSyncDictionary10);
    }
    return testSyncDictionary10;
  }

  testSyncArrayDictionary10(testSyncArrayDictionary10: Record<string,
    Array<Array<Array<Array<Array<Array<Array<Array<Array<Array<Array<number>>>>>>>>>>>>) {
    console.log('Web Component testSyncArrayDictionary10' + testSyncArrayDictionary10);
    if (this.indexRef) {
      this.indexRef.message =
        "testSyncArrayDictionary10 is call, parameter is: " + JSON.stringify(testSyncArrayDictionary10);
    }
    return testSyncArrayDictionary10;
  }

  private indexRef: Index | null = null;
}

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

@Entry
@Component
struct Index {
  scroller: Scroller = new Scroller();
  controller: webview.WebviewController = new webview.WebviewController();
  @State router: Router = this.getUIContext().getRouter();
  @State testObj: TestObj = new TestObj(this);
  @State message: string = "Hello World";

  build() {
      Column() {
        Text(this.message)
          .id("Result")

        Scroll(this.scroller) {
          Column({ space: 5 }) {
            Button('RegisterSyncMethodList')
              .id('RegisterSyncMethodList')
              .width("90%")
              .height(28)
              .fontSize(15)
              .onClick(() => {
                try {
                  this.controller.registerJavaScriptProxy(this.testObj, "backToEts",
                    ["testSyncString", "testSyncNumber", "testSyncBoolean", "testSyncNumberArray",
                      "testSyncStringArray", "testSyncBooleanArray", "testSyncNumberDictionary",
                      "testSyncStringDictionary", "testSyncBooleanDictionary", "testSyncArray10",
                      "testSyncDictionary10", "testSyncArrayDictionary10"]);
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
                }
              })

            Button('TestSyncString')
              .id("TestSyncString")
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncString()');
              })

            Button('TestSyncNumber')
              .id("TestSyncNumber")
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncNumber()');
              })

            Button('TestSyncBoolean')
              .id("TestSyncBoolean")
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncBoolean()');
              })

            Button('TestSyncNumberArray')
              .id("TestSyncNumberArray")
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncNumberArray()');
              })

            Button('TestSyncStringArray')
              .id("TestSyncStringArray")
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncStringArray()');
              })

            Button('TestSyncBooleanArray')
              .id('TestSyncBooleanArray')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncBooleanArray()');
              })

            Button('TestSyncNumberDictionary')
              .id('TestSyncNumberDictionary')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncNumberDictionary()');
              })

            Button('TestSyncStringDictionary')
              .id('TestSyncStringDictionary')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncStringDictionary()');
              })

            Button('TestSyncBooleanDictionary')
              .id('TestSyncBooleanDictionary')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                this.controller.runJavaScriptExt('htmlTestSyncBooleanDictionary()');
              })

          Button('TestSyncArray10')
            .id('TestSyncArray10')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestSyncArray10()');
            })

          Button('TestSyncDictionary10')
            .id('TestSyncDictionary10')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestSyncDictionary10()');
            })

          Button('TestSyncArrayDictionary10')
            .id('TestSyncArrayDictionary10')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestSyncArrayDictionary10()');
            })

            Button('Refresh')
              .id('Refresh')
              .width("90%")
              .height(28)
              .fontSize(15)
              .backgroundColor('#0D9FFB')
              .onClick(() => {
                try {
                  if (platform.startsWith('OpenHarmony')) {
                    this.controller.refresh();
                  }
                } catch (error) {
                  console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                    .message}`);
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

            Web({ src: $rawfile('index_Sync.html'), controller: this.controller })
              .javaScriptAccess(true)
          }
        }
     }
  }
}