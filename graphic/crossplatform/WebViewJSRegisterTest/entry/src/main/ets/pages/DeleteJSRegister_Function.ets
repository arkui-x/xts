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
  constructor(indexRef: Index) {
    if (indexRef) {
      this.indexRef = indexRef;
    }
  }

  testAsyncString(testAsyncStr: string): void {
    console.info('Web Component AsyncString:' + testAsyncStr);
    if (this.indexRef) {
      this.indexRef.message = "testAsyncString is call, parameter is: " + testAsyncStr;
    }
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
  @State router: Router = this.getUIContext().getRouter();
  @State testObj: TestObj = new TestObj(this);
  @State message: string = "Hello World";

  build() {
    Column() {
      Text(this.message)
        .id("Result")

      Scroll(this.scroller) {
        Column({ space: 5 }) {
          Button('RegisterAsyncMethodList')
            .id('RegisterAsyncMethodList')
            .width("90%")
            .height(28)
            .fontSize(15)
            .onClick(() => {
              try {
                this.controller.registerJavaScriptProxy(this.testObj, "backToEts",
                  [], ["testAsyncString"]);
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                  .message}`);
              }
            })

          Button('DeleteJavaScriptRegister')
            .id('DeleteJavaScriptRegister')
            .width("90%")
            .height(28)
            .fontSize(15)
            .onClick(() => {
              try {
                this.controller.deleteJavaScriptRegister('backToEts');
              } catch (error) {
                console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError)
                  .message}`);
              }
            })

          Button('TestAsyncString')
            .id("TestAsyncString")
            .width("90%")
            .height(28)
            .fontSize(15)
            .backgroundColor('#0D9FFB')
            .onClick(() => {
              this.controller.runJavaScriptExt('htmlTestAsyncString()');
              this.message = "testAsyncString is not call";
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

          Web({ src: $rawfile('index_Async.html'), controller: this.controller })
            .javaScriptAccess(true)
        }
      }
    }
  }
}