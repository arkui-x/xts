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
struct UIPickerComponentEnableHapticFeedbackTest {
  @State enableHapticFeedback: boolean | null | undefined = true
  private dataArray: string[] = []

  aboutToAppear() {
    if (this.dataArray.length > 0) {
      return
    }
    for (let i = 1; i <= 10; i++) {
      this.dataArray.push(i.toString())
    }
  }

  build() {
    Column({ space: 8 }) {
      UIPickerComponent() {
        ForEach(this.dataArray, (item: string) => {
          Text(item)
        }, (item: string) => item)
      }
      .key('uiPickerComponent')
      .canLoop(true)
      .enableHapticFeedback(this.enableHapticFeedback)
      .width('80%')
      .height(180)

      Button('true')
        .id('enableHapticFeedback_true')
        .onClick(() => {
          this.enableHapticFeedback = true
        })

      Button('false')
        .id('enableHapticFeedback_false')
        .onClick(() => {
          this.enableHapticFeedback = false
        })

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