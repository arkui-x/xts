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
  router: Router = this.getUIContext().getRouter();
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      Scroll(this.scroller) {
        Column({ space: 20 }) {
          Button('返回')
            .onClick(() => {
              this.router.back();
            })

          Button('Data是string类型')
            .id('onInterceptRequest-data-string')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-data-string"
              })
            })

          Button('Data是ArrayBuffer类型image')
            .id('onInterceptRequest-data-array')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-data-array"
              })
            })

          Button('Data是空字符串')
            .id('onInterceptRequest-data-empty-string')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-data-empty-string"
              })
            })

          Button('Data是null')
            .id('onInterceptRequest-data-null')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-data-null"
              })
            })

          Button('Data是undefined')
            .id('onInterceptRequest-data-undefined')
            .width("90%")
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/onInterceptRequest/onInterceptRequest-data-undefined"
              })
            })

        }
      }
    }
  }
}