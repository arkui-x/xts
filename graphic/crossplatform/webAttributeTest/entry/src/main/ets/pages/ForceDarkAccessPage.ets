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
struct ForceDarkAccessPage {
  @State selectedDarkMode: string = 'Off';
  @State selectedForceDarkAccess: string = 'false';

  build() {
    Scroll() {
      Column({ space: 2 }) {
        Text('forceDarkAccess属性测试')
          .id('force_dark_page_title_text')
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
          .id('force_dark_page_divider_config')
          .strokeWidth(1)

        Text('1. 选择 darkMode 属性值：')
          .id('force_dark_page_label_dark_mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Column({ space: 8 }) {
          Button('WebDarkMode.Off')
            .id('force_dark_page_btn_dark_off')
            .width('80%')
            .height(30)
            .type(this.selectedDarkMode === 'Off' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'Off' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'Off' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'Off'; })

          Button('WebDarkMode.On')
            .id('force_dark_page_btn_dark_on')
            .width('80%')
            .height(30)
            .type(this.selectedDarkMode === 'On' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'On' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'On' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'On'; })

          Button('WebDarkMode.Auto')
            .id('force_dark_page_btn_dark_auto')
            .width('80%')
            .height(30)
            .type(this.selectedDarkMode === 'Auto' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'Auto' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'Auto' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'Auto'; })

          Button('不设置 darkMode')
            .id('force_dark_page_btn_dark_unset')
            .width('80%')
            .height(30)
            .type(this.selectedDarkMode === 'unset' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedDarkMode === 'unset' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedDarkMode === 'unset' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedDarkMode = 'unset'; })
        }
        .id('force_dark_page_dark_mode_group')
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Divider()
          .id('force_dark_page_divider_dark_mode')
          .strokeWidth(1)

        Text('2. 选择 forceDarkAccess 属性值：')
          .id('force_dark_page_label_force')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)

        Column({ space: 8 }) {
          Button('false')
            .id('force_dark_page_btn_force_false')
            .width('80%')
            .height(30)
            .type(this.selectedForceDarkAccess === 'false' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedForceDarkAccess === 'false' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedForceDarkAccess === 'false' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedForceDarkAccess = 'false'; })

          Button('true')
            .id('force_dark_page_btn_force_true')
            .width('80%')
            .height(30)
            .type(this.selectedForceDarkAccess === 'true' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedForceDarkAccess === 'true' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedForceDarkAccess === 'true' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedForceDarkAccess = 'true'; })

          Button('不设置 forceDarkAccess')
            .id('force_dark_page_btn_force_unset')
            .width('80%')
            .height(30)
            .type(this.selectedForceDarkAccess === 'unset' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedForceDarkAccess === 'unset' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedForceDarkAccess === 'unset' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedForceDarkAccess = 'unset'; })

          Button('null')
            .id('force_dark_page_btn_force_null')
            .width('80%')
            .height(30)
            .type(this.selectedForceDarkAccess === 'null' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedForceDarkAccess === 'null' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedForceDarkAccess === 'null' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedForceDarkAccess = 'null'; })

          Button('undefined')
            .id('force_dark_page_btn_force_undefined')
            .width('80%')
            .height(30)
            .type(this.selectedForceDarkAccess === 'undefined' ? ButtonType.Capsule : ButtonType.Normal)
            .backgroundColor(this.selectedForceDarkAccess === 'undefined' ? '#007DFF' : '#DEDEDE')
            .fontColor(this.selectedForceDarkAccess === 'undefined' ? '#FFFFFF' : '#182431')
            .onClick(() => { this.selectedForceDarkAccess = 'undefined'; })
        }
        .id('force_dark_page_force_group')
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Divider()
          .id('force_dark_page_divider_action')
          .strokeWidth(1)

        Button('显示 Web →')
          .id('force_dark_page_btn_show_web')
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
                pageType: 'forceDarkAccess',
                pageTitle: `darkMode=${this.selectedDarkMode}, forceDarkAccess=${this.selectedForceDarkAccess}`,
                src: 'darkMode.html',
                darkMode: this.selectedDarkMode,
                forceDarkAccess: this.selectedForceDarkAccess
              }
            }).catch((err: Error) => {
              console.error('WebDisplayPage Navigation failed:', err);
            });
          })

      }
      .id('force_dark_page_content_column')
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .padding({ bottom: 30 })
    }
    .id('force_dark_page_scroll')
    .height('100%')
    .align(Alignment.TopStart)
  }
}
