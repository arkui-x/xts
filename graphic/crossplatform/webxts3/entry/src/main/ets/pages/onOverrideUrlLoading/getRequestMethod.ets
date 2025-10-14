/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

@Entry
@Component
struct WebViewRequestMethodTest {
  private webController: webview.WebviewController = new webview.WebviewController();
  private readonly options: string[] = ['false', 'true', 'undefined', 'null'];
  private maxRequests = 5;
  @State selectedIndex: number = 0;
  @State access: boolean | null | undefined = false;
  @State selectColor: Color = Color.Blue;
  @State private requestInfo: string = "等待请求...";
  @State url: string | Resource = $rawfile("Method.html");
  @State method : string = '';
  @State runJavaScriptFunc: string | null | undefined = "";
  @State usePromise: boolean = false;

  build() {
    Column() {
      Select([{ value: 'false' }, { value: 'true' }, { value: 'undefined' }, { value: 'null' }])
        .id('是否拦截跳转Url:')
        .selected(this.selectedIndex)
        .value(`是否拦截跳转Url: ${this.options[this.selectedIndex]}`)
        .backgroundColor(this.selectColor)
        .fontColor(Color.White)
        .onSelect((index: number) => {
          this.selectedIndex = index;
          switch (index) {
            case 0:
              this.access = false;
              this.selectColor = Color.Green;
              break;
            case 1:
              this.access = true;
              this.selectColor = Color.Red;
              break;
            case 2:
              this.access = undefined;
              this.selectColor = Color.Green;
              break;
            case 3:
              this.access = null;
              this.selectColor = Color.Green;
              break;
          }
        })

      Row(){
        Button('sendGetRequest')
          .margin(10)
          .onClick(() => {
            try {
              this.webController.runJavaScriptExt("sendGetRequest()", (error, result) => {});
            } catch (Error) {
              this.requestInfo = `ErrorCode:${(Error as BusinessError).code}`;
            }
          })

        Button('sendPostRequest')
          .margin(10)
          .onClick(() => {
            try {
              this.webController.runJavaScriptExt("sendPostRequest()", (error, result) => {});
            } catch (Error) {
              this.requestInfo = `ErrorCode:${(Error as BusinessError).code}`;
            }
          })
      }

      Button('Back')
        .width(300)
        .height(30)
        .margin(5)
        .onClick(() => {
          try {
            this.requestInfo = "等待请求...";
            this.webController.runJavaScriptExt("backToInitial()", (error, result) => {});
          } catch (Error) {
            this.requestInfo = `ErrorCode:${(Error as BusinessError).code}`;
          }
        })

      Text('请求信息区域')
        .fontSize(14)
        .margin(10)
        .textAlign(TextAlign.Start)

      Scroll() {
        Text(this.requestInfo)
          .id('requestInfo')
          .fontSize(14)
          .padding(10)
          .backgroundColor('#f5f5f5')
          .borderRadius(8)
          .width('95%')
      }
      .height('10%')
      .margin({ left: 10, right: 10, bottom: 10 })
      .border({ width: 1, color: '#eeeeee' })
      .borderRadius(8)

      Web({ src: $rawfile("Method.html"), controller: this.webController })
        .onOverrideUrlLoading((request: WebResourceRequest) => {
          if (!request) {
            console.error("WebResourceRequest is null");
            return false;
          }
          const time = new Date().toTimeString().slice(0, 8);
          this.url = request.getRequestUrl();
          this.method = request.getRequestMethod();
          const newRequest = `[${time}]触发回调!\n请求方法为: ${this.method}\nURL为: ${this.url.slice(0, 15)}
            \n是否拦截：${this.access ? '是' : '否'}`;

          this.updateRequestInfo(newRequest);
          return this.access;
        })
        .width('100%')
        .height('50%')
        .textZoomRatio(200)
        .javaScriptAccess(true)
        .domStorageAccess(true)

      Button('返回')
        .width(250)
        .margin(10)
        .onClick(() => {
          this.getUIContext().getRouter().back();
        })
    }
    .width('100%')
    .height('100%')
    .padding(5)
  }

  private updateRequestInfo(newRequest: string) {
    const requests = this.requestInfo.split('\n\n');
    if (requests.length > this.maxRequests) {
      requests.pop();
    }
    this.requestInfo = newRequest;
  }
}

