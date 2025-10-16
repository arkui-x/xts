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

import { Router } from '@ohos.arkui.UIContext';

@Entry
@Component
struct Index {
  router: Router = this.getUIContext().getRouter()
  scroller: Scroller = new Scroller()

  build() {
    Column() {
      Scroll(this.scroller) {
        Column({ space: 20 }) {
          Button('返回')
            .id('back')
            .onClick(() => {
              this.router.back();
            })

          Button('WebResourceRequest信息')
            .id('onInterceptRequest-WebResourceRequest')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-WebResourceRequest"
              })
            })

          Button('MimeType和Encoding')
            .id('onInterceptRequest-MimeType-Encoding')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-MimeType-Encoding"
              })
            })

          Button('ResponseCode和ReasonMessage')
            .id('Code-Reason')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-code-reason"
              })
            })

          Button('setResponseData测试')
            .id('onInterceptRequest-data')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-data"
              })
            })

          Button('callback is null 测试')
            .id('onInterceptRequest-callback-null')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-callback-null"
              })
            })

          Button('callback is undefined 测试')
            .id('onInterceptRequest-callback-undefined')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-callback-undefined"
              })
            })

          Button('无响应数据测试')
            .id('onInterceptRequest-no-response')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-no-response"
              })
            })

          Button('模拟延迟测试')
            .id('onInterceptRequest-mock-delay')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-mock-delay"
              })
            })
        }
      }
    }
  }
}