/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State message: string = 'uiTest测试'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .id('indexTitleText')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button("drag")
          .id('indexDragNavButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/drag' })
          })

        Button("waitForComponent")
          .id('indexWaitForComponentNavButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/waitForComponent' })
          })

        Button("waitForIdle")
          .id('indexWaitForIdleNavButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/waitForIdle' })
          })

        Button("screenCapture")
          .id('indexScreenCaptureNavButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/screenCapture' })
          })

        Button("isComponentPresentWhenLongClick")
          .id('indexLongClickNavButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/isComponentPresentWhenLongClick' })
          })

        Button("setDisplayRotation")
          .id('indexSetDisplayRotationNavButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/setDisplayRotation' })
          })

        Button("getDisplaySize")
          .id('indexGetDisplaySizeNavButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .onClick(() => {
             router.pushUrl({ url: 'pages/getDisplaySize' })
          })

      }
      .width('100%')
      .id('indexRootColumn')
    }
    .height('100%')
    .id('indexRootRow')
  }
}