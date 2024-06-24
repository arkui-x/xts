/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import router from '@ohos.router';

@Entry
@Component
struct NavigationPage {

  build() {
    Column() {
      Text('NavigationPage')
        .width('100%')
        .height(45)
        .fontSize(21)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .backgroundColor(Color.Gray)

      Button('TextInputPage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/TextInputPage' })
        })

      Button('GetBoundsHalfPage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/GetBoundsHalfPage' })
        })

      Button('GetBoundsFullPage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/GetBoundsFullPage' })
        })

      Button('MultiFingerOperationPage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/MultiFingerOperationPage' })
        })

      Button('MultiFingerSlidingPage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/MultiFingerSlidingPage' })
        })

      Button('HorizontallySlidePage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/HorizontallySlidePage' })
        })

      Button('WithBeforAfterPage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/WithBeforAfterPage' })
        })

      Button('RotatePage')
        .fontSize(21)
        .margin({top: 30})
        .onClick(() => {
          router.pushUrl({ url: 'pages/RotatePage' })
        })

    }
    .width('100%')
    .height('100%')
  }
}