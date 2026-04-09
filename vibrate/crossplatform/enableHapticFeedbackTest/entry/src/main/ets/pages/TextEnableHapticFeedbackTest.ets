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
struct TextEnableHapticFeedbackTest {
  @State enableHapticFeedback: boolean | null | undefined = true
  @State hapticMode_bindMenu: HapticFeedbackMode | null | undefined = HapticFeedbackMode.ENABLED
  @State hapticMode_bindContextMenu: HapticFeedbackMode | null | undefined = HapticFeedbackMode.ENABLED
  private menuElements: MenuElement[] = [
    {
      value: 'Menu1',
      action: () => {

      }
    } as MenuElement,
    {
      value: 'Menu2',
      action: () => {

      }
    } as MenuElement
  ];

  @Builder
  MenuBuilder() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Button('Test ContextMenu1')
      Divider()
        .strokeWidth(2)
        .margin(5)
        .color(Color.Black)
      Button('Test ContextMenu2')
      Divider()
        .strokeWidth(2)
        .margin(5)
        .color(Color.Black)
      Button('Test ContextMenu3')
    }
    .width(200)
    .height(160)
  }

  build() {
    Column({ space: 8 }) {
      Text(`${this.hapticMode_bindMenu}`)
        .id('hapticMode_bindMenu')
      Text(`${this.hapticMode_bindContextMenu}`)
        .id('hapticMode_bindContextMenu')

      Text('Text enableHapticFeedback test')
        .key('text')
        .fontSize(20)
        .enableHapticFeedback(this.enableHapticFeedback)
        .padding(12)
        .bindMenu(this.menuElements, {
          hapticFeedbackMode: this.hapticMode_bindMenu
        })
        .bindContextMenu(this.MenuBuilder, ResponseType.LongPress, {
          hapticFeedbackMode: this.hapticMode_bindContextMenu
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
            this.hapticMode_bindMenu = HapticFeedbackMode.ENABLED
            this.hapticMode_bindContextMenu = HapticFeedbackMode.ENABLED
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
            this.hapticMode_bindMenu = HapticFeedbackMode.DISABLED
            this.hapticMode_bindContextMenu = HapticFeedbackMode.DISABLED
          })

        Button('AUTO')
          .id('hapticFeedbackMode_AUTO')
          .onClick(() => {
            this.hapticMode_bindMenu = HapticFeedbackMode.AUTO
            this.hapticMode_bindContextMenu = HapticFeedbackMode.AUTO
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