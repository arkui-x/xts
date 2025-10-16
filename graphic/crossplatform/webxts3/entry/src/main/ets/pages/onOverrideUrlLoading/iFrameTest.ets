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

@Entry
@Component
struct IframeCallbackTest {
  private webController: webview.WebviewController = new webview.WebviewController();
  private thisUrl : string | Resource = $rawfile('iframe_test.html');
  private readonly options: string[] = ['false', 'true', 'undefined', 'null'];
  @State callbackLogs: string = "回调触发日志：\n等待页面加载...";
  @State selectedIndex: number = 0;   //false
  @State access: boolean | null | undefined = false;
  @State selectColor: Color = Color.Blue;

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

      Button('测试')
        .id("test")
        .width(200)
        .margin(10)
        .onClick(() => {
          this.webController.loadUrl($rawfile('iframe_test.html'));
        })

      Button('返回')
        .width(200)
        .margin(5)
        .onClick(() => {
          this.getUIContext().getRouter().back();
        })

      Scroll() {
        Text(this.callbackLogs)
          .id("callbackLogs")
          .fontSize(14)
          .padding(10)
          .backgroundColor('#f9f9f9')
          .borderRadius(8)
          .width('90%')
      }
      .height('15%')
      .margin(10)
      .border({ width: 1, color: '#eeeeee' })

      Web({ src: this.thisUrl, controller: this.webController })
        .onOverrideUrlLoading((request: WebResourceRequest) => {
          if (!request) return false;
          const url = request.getRequestUrl();
          const time = new Date().toTimeString().slice(0, 8);

          let protocol = "未知协议";
          if (url.startsWith('https://')) protocol = "HTTPS协议";
          else if (url.startsWith('about:')) protocol = "about协议";
          else if (url.startsWith('data:')) protocol = "非HTTP(s)协议";

          const log = `[${time}] 触发回调！\nProtocol：${protocol
          }\nURL：${url.slice(0, 15)}\n是否拦截：${this.access ? '是' : '否'}`;
          this.callbackLogs = log ;
          return this.access;
        })
        .width('100%')
        .height('60%')
        .textZoomRatio(150)
        .javaScriptAccess(true)
        .domStorageAccess(true)
    }
    .width('100%')
    .height('100%')
    .padding(5)
  }
}
