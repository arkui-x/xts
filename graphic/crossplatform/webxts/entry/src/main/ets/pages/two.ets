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
import router from '@ohos.router'

@Entry
@Component
struct Index {
  @State message: string = 'Web'

  build() {
    Row() {
      Scroll() {
        Column() {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)

          Button("OnHttpAuthRequestEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnHttpAuthRequestEvent' })
            })
            .margin(5)

          Button("OnPermissionRequestEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnPermissionRequestEvent' })
            })
            .margin(5)

          Button("OnScrollEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnScrollEvent' })
            })
            .margin(5)

          Button("OnPageVisibleEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnPageVisibleEvent' })
            })
            .margin(5)

          Button("OnLoadInterceptEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnLoadInterceptEvent' })
            })
            .margin(5)

          Button("OnAlertEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnAlertEvent' })
            })
            .margin(5)

          Button("OnConfirmEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnConfirmEvent' })
            })
            .margin(5)
        }
        .width('100%')
      }
      .height('100%')
    }
  }
}