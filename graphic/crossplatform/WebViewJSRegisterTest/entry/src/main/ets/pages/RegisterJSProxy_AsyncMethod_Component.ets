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
import { Router } from '@ohos.arkui.UIContext'

class TestObj {
  constructor(indexRef: Index) {
    if (indexRef) {
      this.indexRef = indexRef;
    }
  }

  testAsyncNumber(testAsyncNum: number): void {
    console.log('Web Component AsyncNumber:' + testAsyncNum);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncNumber is call, parameter is: " + testAsyncNum;
    }
  }

  testAsyncString(testAsyncStr: string): void {
    console.info('Web Component AsyncString:' + testAsyncStr);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncString is call, parameter is: " + testAsyncStr;
    }
  }

  testAsyncBoolean(testAsyncBoolean: boolean): void {
    console.log('Web Component AsyncBoolean:' + testAsyncBoolean);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncBoolean is call, parameter is: " + testAsyncBoolean;
    }
  }

  testAsyncNumberArray(testAsyncNumberArray: Array<number>): void {
    console.log('Web Component AsyncNumberArray:' + testAsyncNumberArray);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncNumberArray is call, parameter is: " + testAsyncNumberArray;
    }
  }

  testAsyncStringArray(testAsyncStringArray: Array<string>): void {
    console.log('Web Component AsyncStringArray:' + testAsyncStringArray);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncStringArray is call, parameter is: " + testAsyncStringArray;
    }
  }

  testAsyncBooleanArray(testAsyncBooleanArray: Array<boolean>): void {
    console.log('Web Component AsyncBooleanArray:' + testAsyncBooleanArray);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncBooleanArray is call, parameter is: " + testAsyncBooleanArray;
    }
  }

  testAsyncNumberDictionary(testAsyncNumberDictionary: Record<string, number>): void {
    console.log('Web Component AsyncNumberDictionary:' + JSON.stringify(testAsyncNumberDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncNumberDictionary is call, parameter is: " + JSON.stringify(testAsyncNumberDictionary);
    }
  }

  testAsyncStringDictionary(testAsyncStringDictionary: Record<string, string>): void {
    console.log('Web Component AsyncStringDictionary:' + JSON.stringify(testAsyncStringDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncStringDictionary is call, parameter is: " + JSON.stringify(testAsyncStringDictionary);
    }
  }

  testAsyncBooleanDictionary(testAsyncBooleanDictionary: Record<string, boolean>): void {
    console.log('Web Component AsyncBooleanDictionary:' + JSON.stringify(testAsyncBooleanDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncBooleanDictionary is call, parameter is: " + JSON.stringify(testAsyncBooleanDictionary);
    }
  }

  testAsyncArray10(testAsyncArray10: Array<Array<Array<Array<Array<Array<Array<Array<Array<Array<Array<
    number>>>>>>>>>>>): void {
    console.log('Web Component testAsyncArray10:' + JSON.stringify(testAsyncArray10));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncArray10 is call, parameter is: " + JSON.stringify(testAsyncArray10);
    }
  }

  testAsyncDictionary10(testAsyncDictionary10: Record<string, Record<string, Record<string, Record<string,
    Record<string, Record<string, Record<string, Record<string, Record<string, Record<string, Record<string,
    number>>>>>>>>>>>): void {
    console.log('Web Component testAsyncDictionary10:' + JSON.stringify(testAsyncDictionary10));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncDictionary10 is call, parameter is: " + JSON.stringify(testAsyncDictionary10);
    }
  }

  testAsyncArrayDictionary10(testAsyncArrayDictionary10: Record<string, Array<Array<Array<Array<Array<Array<Array<
    Array<Array<Array<Array<number>>>>>>>>>>>>): void {
    console.log('Web Component testAsyncArrayDictionary10' + testAsyncArrayDictionary10);
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncArrayDictionary10 is call, parameter is: " + JSON.stringify(testAsyncArrayDictionary10);
    }
  }

  private indexRef: Index | null = null;
}

@Entry
@Component
struct Index {
  scroller: Scroller = new Scroller()
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
          Button('TestAsyncString')
            .id("TestAsyncString")
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncString()');
            })

          Button('TestAsyncNumber')
            .id("TestAsyncNumber")
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncNumber()');
            })

          Button('TestAsyncBoolean')
            .id("TestAsyncBoolean")
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncBoolean()');
            })

          Button('TestAsyncNumberArray')
            .id("TestAsyncNumberArray")
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncNumberArray()');
            })

          Button('TestAsyncStringArray')
            .id("TestAsyncStringArray")
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncStringArray()');
            })

          Button('TestAsyncBooleanArray')
            .id('TestAsyncBooleanArray')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncBooleanArray()');
            })

          Button('TestAsyncNumberDictionary')
            .id('TestAsyncNumberDictionary')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncNumberDictionary()');
            })

          Button('TestAsyncStringDictionary')
            .id('TestAsyncStringDictionary')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncStringDictionary()');
            })

          Button('TestAsyncBooleanDictionary')
            .id('TestAsyncBooleanDictionary')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncBooleanDictionary()');
            })

          Button('TestAsyncArray10')
            .id('TestAsyncArray10')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncArray10()');
            })

          Button('TestAsyncDictionary10')
            .id('TestAsyncDictionary10')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncDictionary10()');
            })

          Button('TestAsyncArrayDictionary10')
            .id('TestAsyncArrayDictionary10')
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncArrayDictionary10()');
            })

          Button('Back')
            .id('Back')
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.router.back()
            })

          Web({ src: $rawfile('index_Async.html'), controller: this.controller })
            .javaScriptAccess(true)
            .javaScriptProxy({
              object: this.testObj,
              name: "backToEts",
              methodList: [],
              asyncMethodList: ["testAsyncString", "testAsyncNumber", "testAsyncBoolean", "testAsyncNumberArray",
                "testAsyncStringArray", "testAsyncBooleanArray", "testAsyncNumberDictionary",
                "testAsyncStringDictionary", "testAsyncBooleanDictionary", "testAsyncArray10", "testAsyncDictionary10",
                "testAsyncArrayDictionary10"],
              controller: this.controller,
            })
        }
      }
    }
  }
}