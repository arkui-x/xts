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
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  responseWeb: WebResourceResponse = new WebResourceResponse();
  router: Router = this.getUIContext().getRouter();
  currentWebContent: string = "正在截取网页内容...\n";
  isCapturing: boolean = false;
  heads: Header[] = new Array();
  @State private responselogs: string = '>>> response日志 <<<\n';

  webData: string = "<!DOCTYPE html>\n" +
    "<html>\n" +
    "<head>\n" +
    "<title>intercept test</title>\n" +
    "</head>\n" +
    "<body>\n" +
    "<h1>intercept test</h1>\n" +
    "</body>\n" +
    "</html>";

  async captureWebContent() {
    this.isCapturing = true;
    try {
      const textContent = await this.controller.runJavaScript("document.body.innerText");
      this.currentWebContent = `当前网页文本内容：${textContent.substring(0, 500)}\n`;
      console.info(`${this.currentWebContent}`);
    } catch (error) {
      const err = error as BusinessError;
      this.currentWebContent = `截取失败: ${err.message}`;
      console.error("网页内容截取错误:", err);
    } finally {
      this.isCapturing = false;
    }
  }

  build() {
    Column() {
      Button('返回')
        .onClick(() => {
          this.router.back();
        })

      Text(this.currentWebContent)
        .id('currentWebContent')
        .width('100%')
        .height(30)
        .opacity(0)

      Web({ src: 'https://www.openharmony.cn/', controller: this.controller })
        .onPageEnd(()=>{
          this.captureWebContent();
          console.info(`${this.currentWebContent}`);
        })
        .onInterceptRequest((event) => {
          if (event) {
            console.log('[InterceptTest] getRequestHeader:' + JSON.stringify(event.request.getRequestHeader()));
            console.log('[InterceptTest] url:' + event.request.getRequestUrl());
            console.log('[InterceptTest] isMainFrame:' + event.request.isMainFrame());
            console.log('[InterceptTest] isRedirect:' + event.request.isRedirect());
            console.log('[InterceptTest] isRequestGesture:' + event.request.isRequestGesture());
            console.log('[InterceptTest] getRequestMethod:' + event.request.getRequestMethod());
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
            this.responseWeb.setResponseCode(204);
            this.responseWeb.setReasonMessage('No Content');
            resolve("success");
          })
          promise.then(() => {
            this.responselogs += `[Encoding] ${this.responseWeb.getResponseEncoding()}\n`;
            this.responselogs += `[MimeType] ${this.responseWeb.getResponseMimeType()}\n`;
            this.responselogs += `[Code] ${this.responseWeb.getResponseCode()}\n`;
            this.responselogs += `[ReasonMessage] ${this.responseWeb.getReasonMessage()}\n`;
            this.responselogs += `[Headers] ${JSON.stringify(this.responseWeb.getResponseHeader())}\n\n`;
            this.responseWeb.setResponseIsReady(true);
          })
          this.responseWeb.setResponseIsReady(false);
          return this.responseWeb;
        })
          .width('100%')
          .height('60%')

      TextArea({
        text: this.currentWebContent + this.responselogs,
        placeholder: 'response日志将显示在这里...'
      })
        .id("callbackLogs")
        .width('100%')
        .height('30%')
        .margin(10)
        .fontColor('#333')
        .backgroundColor('#f5f5f5')
        .borderRadius(8)
    }
  }
}
