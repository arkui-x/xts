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
import { Router } from '@ohos.arkui.UIContext'
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State router: Router = this.getUIContext().getRouter();
  @State mode: router.RouterMode = router.RouterMode.Standard

  build() {
    Row() {
      Column() {
        Text('enableHapticFeedbackTest')
          .id('enableHapticFeedbackTest')
          .fontSize(16)

        Button('sliderTest')
          .id('sliderTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/SliderEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('searchTest')
          .id('searchTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/SearchEnableHapticFeedBackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('textTest')
          .id('textTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/TextEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('textInputTest')
          .id('textInputTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/TextInputEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('textAreaTest')
          .id('textAreaTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/TextAreaEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('richEditorTest')
          .id('richEditorTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/RichEditorEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('alphabetIndexerTest')
          .id('alphabetIndexerTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/AlphabetIndexerEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('webTest')
          .id('webTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/WebEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('uiPickerComponentTest')
          .id('uiPickerComponentTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/UIPickerComponentEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('textPickerTest')
          .id('textPickerTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/TextPickerEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('timePickerTest')
          .id('timePickerTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/TimePickerEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('datePickerTest')
          .id('datePickerTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/DatePickerEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })

        Button('textPickerDialogTest')
          .id('textPickerDialogTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/TextPickerDialogEnableHapticFeedback'
            })
          })
          .margin({ bottom: 4 })

        Button('timePickerDialogTest')
          .id('timePickerDialogTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/TimePickerDialogEnableHapticFeedback'
            })
          })
          .margin({ bottom: 4 })

        Button('datePickerDialogTest')
          .id('datePickerDialogTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/DatePickerDialogEnableHapticFeedback'
            })
          })
          .margin({ bottom: 4 })

        Button('imageDragTest')
          .id('imageDragTest')
          .width('80%')
          .height(20)
          .onClick(async () => {
            await this.router.pushUrl({
              url: 'pages/ImageDragEnableHapticFeedbackTest'
            })
          })
          .margin({ bottom: 4 })
      }
      .width('100%')
    }
    .height('100%')
  }
}