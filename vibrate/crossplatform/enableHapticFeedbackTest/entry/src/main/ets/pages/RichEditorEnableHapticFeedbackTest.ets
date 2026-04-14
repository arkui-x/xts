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

@Entry
@Component
struct RichEditorEnableHapticFeedbackTest {
  @State enableHapticFeedback: boolean | null | undefined = true
  @State hapticMode: HapticFeedbackMode | null | undefined = HapticFeedbackMode.ENABLED
  private controller: RichEditorController = new RichEditorController()

  @Builder
  panel() {
    Column() {
      Text('HapticFeedbackMode')
    }.width(100).height(20).backgroundColor(Color.Red)
  }

  build() {
    Column({ space: 8 }) {
      Text(`${this.hapticMode}`)
        .id('hapticMode')

      RichEditor({ controller: this.controller })
        .key('richEditor')
        .width('80%')
        .height(160)
        .enableHapticFeedback(this.enableHapticFeedback)
        .onReady(() => {
          this.controller.addTextSpan('Rich editor test content')
        })
        .bindSelectionMenu(RichEditorSpanType.DEFAULT, this.panel, RichEditorResponseType.DEFAULT, {
          previewMenuOptions: {
            hapticFeedbackMode: this.hapticMode
          }
        })

      Row({ space: 10 }) {
        Button('true')
          .id('enableHapticFeedback_true')
          .onClick(() => {
            this.enableHapticFeedback = true
          })

        Button('ENABLED')
          .id('hapticFeedbackMode_ENABLED')
          .onClick(() => {
            this.hapticMode = HapticFeedbackMode.ENABLED
          })
      }

      Row({ space: 10 }) {
        Button('false')
          .id('enableHapticFeedback_false')
          .onClick(() => {
            this.enableHapticFeedback = false
          })

        Button('DISABLED')
          .id('hapticFeedbackMode_DISABLED')
          .onClick(() => {
            this.hapticMode = HapticFeedbackMode.DISABLED
          })

        Button('AUTO')
          .id('hapticFeedbackMode_AUTO')
          .onClick(() => {
            this.hapticMode = HapticFeedbackMode.AUTO
          })
      }

      Button('null')
        .id('enableHapticFeedback_null')
        .onClick(() => {
          this.enableHapticFeedback = null
        })

      Button('undefined')
        .id('enableHapticFeedback_undefined')
        .onClick(() => {
          this.enableHapticFeedback = undefined
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}