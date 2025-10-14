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
  router: Router = this.getUIContext().getRouter();
  @State currentUrl: string = '';
  @State originUrl: string = '';

  build() {
    Column() {
      Button('返回')
        .onClick(() => {
          this.router.back();
        })

      Text(this.currentUrl)
        .id('currentUrl')
        .width('100%')
        .height(30)
        .opacity(0)

      Text(this.originUrl)
        .id('originUrl')
        .width('100%')
        .height(30)
        .opacity(0)

      Web({ src: 'https://www.openharmony.cn/', controller: this.controller })
        .onPageEnd(() => {
          try{
            this.currentUrl = this.controller.getUrl();
            this.originUrl = this.controller.getOriginalUrl();
            console.info(`currentUrl = ${this.currentUrl}\n`+
            `originUrl = ${this.originUrl}\n`);
          } catch (err) {
            console.error(err);
          }
        })
        .onInterceptRequest((event) => {
          return null
        })
        .javaScriptAccess(true)
        .domStorageAccess(true)
    }
  }
}
