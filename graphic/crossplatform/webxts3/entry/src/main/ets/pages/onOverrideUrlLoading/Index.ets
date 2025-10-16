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

@Entry
@Component
struct Index {
  build() {
    Column() {
      Button('返回主页')
        .id('返回主页')
        .onClick(() => {
          this.getUIContext().getRouter().back({
            url: 'pages/Index'
          })
        })

      Scroll() {
        Column({ space: 20 }) {
          Button('Test')
            .id("Test")
            .onClick(() => {
              this.getUIContext().getRouter().pushUrl({
                url: 'pages/onOverrideUrlLoading/loadUrlTest'
              })
            })

          Button('MethodTest')
            .id("MethodTest")
            .onClick(() => {
              this.getUIContext().getRouter().pushUrl({
                url: 'pages/onOverrideUrlLoading/getRequestMethod'
              })
            })

          Button('iFrameTest')
            .id("iFrameTest")
            .onClick(() => {
              this.getUIContext().getRouter().pushUrl({
                url: 'pages/onOverrideUrlLoading/iFrameTest'
              })
            })
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .margin({ top: 20 })
      }
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .margin({ top: 20 })
  }
}






