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
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();
  requestUrl : string | Resource = '';
  method : string = '';
  private readonly options: string[] = ['false', 'true', 'undefined', 'null'];
  @State selectedIndex: number = 0;
  @State access: boolean | null | undefined = false;
  @State selectColor: Color = Color.Blue;
  @State url: string | Resource = 'https://www.example.com';
  @State callbackLogs: string = "回调日志: 等待操作...";
  @State currentUrl : string = '';
  @State webHeight: number = 0;

  async getWebHeightAndFindLink(targetY: number) {
    try {
      const heightScript = `
        document.documentElement.scrollHeight ||
        document.body.scrollHeight ||
        window.innerHeight
      `;

      const heightResult = await this.controller.getPageHeight();
      this.webHeight = heightResult;
      console.info(`网页高度: ${this.webHeight}px`);

      const findLinkScript = `
        (function(targetY) {
          // 获取所有链接元素
          const links = document.getElementsByTagName('a');
          let closestLink = null;
          let minDistance = Infinity;

          // 遍历链接查找最接近目标Y坐标的元素
          for (let link of links) {
            const rect = link.getBoundingClientRect();
            const linkMidY = rect.top + rect.height / 2;
            const distance = Math.abs(linkMidY - targetY);

            if (distance < minDistance) {
              minDistance = distance;
              closestLink = {
                href: link.href,
                text: link.textContent,
                top: rect.top,
                bottom: rect.bottom
              };
            }
          }

          // 如果找到链接，模拟点击
          if (closestLink) {
            // 滚动到链接位置
            window.scrollTo({
              top: closestLink.top - 100,
              behavior: 'smooth'
            });

            // 延迟点击，确保滚动完成
            setTimeout(() => {
              const linkElement = document.querySelector(\`a[href="\${closestLink.href}"]\`);
              if (linkElement) linkElement.click();
            }, 500);

            return closestLink;
          }
          return null;
        })(${targetY})
      `;

      const linkResult = await this.controller.runJavaScript(findLinkScript);
    } catch (error) {
      const err = error as BusinessError;
      console.error(`WebView操作错误: ${JSON.stringify(err)}`);
    }
  }

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

      Button('loadUrl方法测试')
        .id("loadUrlTest")
        .width(210)
        .margin(5)
        .onClick(() => {
          this.callbackLogs = '不触发onOverrideUrlLoading回调\n';
          this.controller.loadUrl($rawfile('blank.html'));
        })

      Button('点击跳转链接')
        .id("regularTest")
        .width(210)
        .margin(5)
        .onClick(() => {
          this.getWebHeightAndFindLink(300);
        })

      Scroll() {
        Text(this.callbackLogs)
          .id('callbackLogs')
          .fontSize(14)
          .margin(5)
          .width('90%')
          .textAlign(TextAlign.Start)
      }
      .height('20%')
      .margin({ left: 10, right: 10, bottom: 10 })
      .border({ width: 1, color: '#eeeeee' })
      .borderRadius(8)

      Button('Back')
        .width(210)
        .margin(5)
        .onClick(() => {
          this.getUIContext().getRouter().back();
        })

      Web({ src: "https://www.example.com", controller: this.controller })
        .onOverrideUrlLoading((webResourceRequest: WebResourceRequest) => {
          if (!webResourceRequest) {
            console.error("WebResourceRequest is null");
            return false;
          }
          const time = new Date().toTimeString().slice(0, 8);
          this.requestUrl = webResourceRequest.getRequestUrl();
          this.method = webResourceRequest.getRequestMethod();
          this.callbackLogs = `\n[${time}]触发回调\nURL：${this.requestUrl
          }\nRequestMethod: ${this.method};\n是否拦截：${this.access ? '是' : '否'}`;

          return this.access;
        })
        .onPageEnd(()=>{
          this.currentUrl = this.controller.getUrl();
          console.log(`[loadUrlTest]_currentUrl = ${this.currentUrl}\n`);
          this.callbackLogs = `页面加载完成\nCurrentUrl:${this.currentUrl}\n` + this.callbackLogs;
        })
        .width('100%')
        .height('50%')
        .javaScriptAccess(true)
        .domStorageAccess(true)
    }
    .width('100%')
    .height('100%')
    .padding(10)
  }
}
