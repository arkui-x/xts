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

  async testAsyncNumber(testAsyncNum: number): Promise<void> {
    console.log('Web Component AsyncNumber:' + testAsyncNum);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncNumber is call, parameter is: " + testAsyncNum;
    }
  }

  async testAsyncString(testAsyncStr: string): Promise<void> {
    console.info('Web Component AsyncString:' + testAsyncStr);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncString is call, parameter is: " + testAsyncStr;
    }
  }

  async testAsyncBoolean(testAsyncBoolean: boolean): Promise<void> {
    console.log('Web Component AsyncBoolean:' + testAsyncBoolean);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncBoolean is call, parameter is: " + testAsyncBoolean;
    }
  }

  async testAsyncNumberArray(testAsyncNumberArray: Array<number>): Promise<void> {
    console.log('Web Component AsyncNumberArray:' + testAsyncNumberArray);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncNumberArray is call, parameter is: " + testAsyncNumberArray;
    }
  }

  async testAsyncStringArray(testAsyncStringArray: Array<string>): Promise<void> {
    console.log('Web Component AsyncStringArray:' + testAsyncStringArray);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncStringArray is call, parameter is: " + testAsyncStringArray;
    }
  }

  async testAsyncBooleanArray(testAsyncBooleanArray: Array<boolean>): Promise<void> {
    console.log('Web Component AsyncBooleanArray:' + testAsyncBooleanArray);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncBooleanArray is call, parameter is: " + testAsyncBooleanArray;
    }
  }

  async testAsyncNumberDictionary(testAsyncNumberDictionary: Record<string, number>): Promise<void> {
    console.log('Web Component AsyncNumberDictionary:' + JSON.stringify(testAsyncNumberDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncNumberDictionary is call, parameter is: " + JSON.stringify(testAsyncNumberDictionary);
    }
  }

  async testAsyncStringDictionary(testAsyncStringDictionary: Record<string, string>): Promise<void> {
    console.log('Web Component AsyncStringDictionary:' + JSON.stringify(testAsyncStringDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncStringDictionary is call, parameter is: " + JSON.stringify(testAsyncStringDictionary);
    }
  }

  async testAsyncBooleanDictionary(testAsyncBooleanDictionary: Record<string, boolean>): Promise<void> {
    console.log('Web Component AsyncBooleanDictionary:' + JSON.stringify(testAsyncBooleanDictionary));
    if (this.indexRef) {
      this.indexRef.message =
        "testAsyncBooleanDictionary is call, parameter is: " + JSON.stringify(testAsyncBooleanDictionary);
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
              asyncMethodList: ["testAsyncString", "testAsyncNumber", "testAsyncBoolean", "testAsyncNumberArray", "testAsyncStringArray",
                "testAsyncBooleanArray", "testAsyncNumberDictionary", "testAsyncStringDictionary", "testAsyncBooleanDictionary"],
              controller: this.controller,
            })
        }
      }
    }
  }
}