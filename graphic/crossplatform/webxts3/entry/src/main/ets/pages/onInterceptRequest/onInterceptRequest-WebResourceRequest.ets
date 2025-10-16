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
import { Router } from '@ohos.arkui.UIContext';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  responseWeb: WebResourceResponse = new WebResourceResponse();
  router: Router = this.getUIContext().getRouter();
  heads: Header[] = new Array();
  @State private logs: string = '>>> request日志 <<<\n';
  @State private currentUrlData : string ='';

  webData: string = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head>\n" +
    "<title>intercept test</title>\n" +
    "</head>\n" +
    "<body>\n" +
    "<h1>intercept test</h1>\n" +
    "</body>\n" +
    "</html>";

  build() {
    Column() {
      Button('返回')
        .onClick(() => {
          this.router.back();
        })

      Web({ src: 'https://www.openharmony.cn/', controller: this.controller })
        .onInterceptRequest((event) => {
          if (event) {
            //this.logs +=`[RequestUrl] ${event.request.getRequestUrl()}\n${this.currentUrlData}\n`;
          } else {
            return null
          }
          let head1: Header = {
            headerKey: "Connection",
            headerValue: "keep-alive"
          }
          let head2: Header = {
            headerKey: "Cache-Control",
            headerValue: "no-cache"
          }

          let length = this.heads.push(head1);
          length = this.heads.push(head2);
          console.log('The response header result length is :' + length);
          const promise: Promise<String> = new Promise((resolve: Function, reject: Function) => {
            this.responseWeb.setResponseHeader(this.heads);
            this.responseWeb.setResponseData(this.webData);
            this.responseWeb.setResponseEncoding('utf-8');
            this.responseWeb.setResponseMimeType('text/html');
            this.responseWeb.setResponseCode(200);
            this.responseWeb.setReasonMessage('OK');
            resolve("success");
          })
          promise.then(() => {
            this.currentUrlData += `[CurrentUrlData] ${this.responseWeb.getResponseDataEx()}}\n`
            this.logs +=`[RequestUrl] ${event.request.getRequestUrl()}\n${this.currentUrlData}\n`;
            this.responseWeb.setResponseIsReady(true);
          })
          this.responseWeb.setResponseIsReady(false);
          return this.responseWeb;
        })
          .width('100%')
          .height('60%')

      Scroll() {
        Text(`${this.logs}`)
          .id('callbackLogs')
          .fontSize(14)
          .margin(5)
          .width('90%')
          .textAlign(TextAlign.Start)
      }
      .height('30%')
      .margin({ left: 10, right: 10, bottom: 10 })
      .border({ width: 1, color: '#eeeeee' })
      .borderRadius(8)
    }
  }
}
