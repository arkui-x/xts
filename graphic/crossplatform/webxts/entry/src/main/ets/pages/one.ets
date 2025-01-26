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

          Button("OnPageEndEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnPageEndEvent' })
            })
            .margin(3)

          Button("OnPageBeginEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnPageBeginEvent' })
            })
            .margin(3)

          Button("OnProgressChangeEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnProgressChangeEvent' })
            })
            .margin(3)

          Button("OnTitleReceiveEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnTitleReceiveEvent' })
            })
            .margin(3)

          Button("OnGeolocationShowEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnGeolocationShowEvent' })
            })
            .margin(3)

          Button("OnPromptEvent_handleConfirm")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnPromptEvent_handleConfirm' })
            })
            .margin(3)

          Button("OnPromptEvent_handlePromptConfirm")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnPromptEvent_handlePromptConfirm' })
            })
            .margin(3)

          Button("OnConsoleEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnConsoleEvent' })
            })
            .margin(3)

          Button("OnErrorReceiveEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnErrorReceiveEvent' })
            })
            .margin(3)

          Button("OnHttpErrorReceiveEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnHttpErrorReceiveEvent' })
            })
            .margin(3)

          Button("OnDownloadStartEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnDownloadStartEvent' })
            })
            .margin(3)

          Button("OnScaleChangeEvent")
            .width(200)
            .height(30)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OnScaleChangeEvent' })
            })
            .margin(3)

        }
        .width('100%')
      }
      .height('100%')
    }
  }
}