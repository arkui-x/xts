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

import webview from '@ohos.web.webview';

@Entry
@Component
struct WebEnableHapticFeedbackTest {
  @State enableHapticFeedback: boolean | null | undefined = true
  private controller: webview.WebviewController = new webview.WebviewController()

  build() {
    Column({ space: 8 }) {
      Text(`${this.enableHapticFeedback}`)
        .id('enableHapticFeedback')

      Web({ src: 'https://www.example.com/', controller: this.controller })
        .enableHapticFeedback(this.enableHapticFeedback)
        .key('web')
        .width('80%')
        .height(240)
        .enableHapticFeedback(this.enableHapticFeedback)

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