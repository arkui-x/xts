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

import { router } from '@kit.ArkUI';

@Entry
@Component
struct DarkModePage {
  @State selectedDarkMode: string = 'Off';

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('darkMode属性测试')
          .id('dark_mode_page_title_text')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)

        Button('Back')
          .id('btn_back')
          .width(200)
          .height(35)
          .margin({ top: 5 })
          .onClick(() => {
            router.back();
          })

        Divider()
          .id('dark_mode_page_divider_config')
          .strokeWidth(1)

        Text('请选择 darkMode 属性值：')
          .id('dark_mode_page_label_select')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Column({ space: 10 }) {
          Button('WebDarkMode.Off')
            .id('dark_mode_page_btn_off')
            .width('80%')
            .height(33)
            .type(this.selectedDarkMode === 'Off' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'Off' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'Off' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'Off'; })

          Button('WebDarkMode.On')
            .id('dark_mode_page_btn_on')
            .width('80%')
            .height(33)
            .type(this.selectedDarkMode === 'On' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'On' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'On' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'On'; })

          Button('WebDarkMode.Auto')
            .id('dark_mode_page_btn_auto')
            .width('80%')
            .height(33)
            .type(this.selectedDarkMode === 'Auto' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'Auto' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'Auto' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'Auto'; })

          Button('不设置（unset）')
            .id('dark_mode_page_btn_unset')
            .width('80%')
            .height(33)
            .type(this.selectedDarkMode === 'unset' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'unset' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'unset' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'unset'; })

          Button('null')
            .id('dark_mode_page_btn_null')
            .width('80%')
            .height(33)
            .type(this.selectedDarkMode === 'null' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'null' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'null' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'null'; })

          Button('undefined')
            .id('dark_mode_page_btn_undefined')
            .width('80%')
            .height(33)
            .type(this.selectedDarkMode === 'undefined' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'undefined' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'undefined' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'undefined'; })
        }
        .id('dark_mode_page_button_group')
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Divider()
          .id('dark_mode_page_divider_action')
          .strokeWidth(1)

        Button('显示 Web →')
          .id('dark_mode_page_btn_show_web')
          .width('80%')
          .height(35)
          .type(ButtonType.Capsule)
          .backgroundColor('#007DFF')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .onClick(() => {
            router.pushUrl({
              url: 'pages/WebDisplayPage',
              params: {
                pageType: 'darkMode',
                pageTitle: `darkMode = ${this.selectedDarkMode}`,
                src: 'darkMode.html',
                darkMode: this.selectedDarkMode
              }
            }).catch((err: Error) => {
              console.error('WebDisplayPage Navigation failed:', err);
            });
          })
      }
      .id('dark_mode_page_content_column')
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding({ bottom: 30 })
    }
    .id('dark_mode_page_scroll')
    .height('100%')
  }
}
