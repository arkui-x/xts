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
struct LayoutModePage {
  @State selectedLayoutMode: string = 'FIT_CONTENT';

  build() {
    Column({ space: 16 }) {
      Scroll() {
        Column({ space: 16 }) {
          Text('layoutMode属性测试')
            .id('layout_mode_page_title_text')
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
            .id('layout_mode_page_divider_config')
            .strokeWidth(1)

          Text('请选择 layoutMode 属性值：')
            .id('layout_mode_page_label_select')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)

          Column({ space: 10 }) {
            Button('WebLayoutMode.NONE')
              .id('layout_mode_page_btn_none')
              .width('80%')
              .height(30)
              .type(this.selectedLayoutMode === 'NONE' ? ButtonType.Capsule : ButtonType.Normal)
              .backgroundColor(this.selectedLayoutMode === 'NONE' ? '#007DFF' : '#DEDEDE')
              .fontColor(this.selectedLayoutMode === 'NONE' ? '#FFFFFF' : '#182431')
              .onClick(() => { this.selectedLayoutMode = 'NONE'; })

            Button('WebLayoutMode.FIT_CONTENT')
              .id('layout_mode_page_btn_fit_content')
              .width('80%')
              .height(30)
              .type(this.selectedLayoutMode === 'FIT_CONTENT' ? ButtonType.Capsule : ButtonType.Normal)
              .backgroundColor(this.selectedLayoutMode === 'FIT_CONTENT' ? '#007DFF' : '#DEDEDE')
              .fontColor(this.selectedLayoutMode === 'FIT_CONTENT' ? '#FFFFFF' : '#182431')
              .onClick(() => { this.selectedLayoutMode = 'FIT_CONTENT'; })

            Button('不设置（unset）')
              .id('layout_mode_page_btn_unset')
              .width('80%')
              .height(30)
              .type(this.selectedLayoutMode === 'unset' ? ButtonType.Capsule : ButtonType.Normal)
              .backgroundColor(this.selectedLayoutMode === 'unset' ? '#007DFF' : '#DEDEDE')
              .fontColor(this.selectedLayoutMode === 'unset' ? '#FFFFFF' : '#182431')
              .onClick(() => { this.selectedLayoutMode = 'unset'; })

            Button('null')
              .id('layout_mode_page_btn_null')
              .width('80%')
              .height(30)
              .type(this.selectedLayoutMode === 'null' ? ButtonType.Capsule : ButtonType.Normal)
              .backgroundColor(this.selectedLayoutMode === 'null' ? '#007DFF' : '#DEDEDE')
              .fontColor(this.selectedLayoutMode === 'null' ? '#FFFFFF' : '#182431')
              .onClick(() => { this.selectedLayoutMode = 'null'; })

            Button('undefined')
              .id('layout_mode_page_btn_undefined')
              .width('80%')
              .height(30)
              .type(this.selectedLayoutMode === 'undefined' ? ButtonType.Capsule : ButtonType.Normal)
              .backgroundColor(this.selectedLayoutMode === 'undefined' ? '#007DFF' : '#DEDEDE')
              .fontColor(this.selectedLayoutMode === 'undefined' ? '#FFFFFF' : '#182431')
              .onClick(() => { this.selectedLayoutMode = 'undefined'; })
          }
          .id('layout_mode_page_button_group')
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          Divider()
            .id('layout_mode_page_divider_action')
            .strokeWidth(1)

          Button('显示 Web →')
            .id('layout_mode_page_btn_show_web')
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
                  pageType: 'layoutMode',
                  pageTitle: `layoutMode = ${this.selectedLayoutMode}`,
                  src: 'layoutMode.html',
                  layoutMode: this.selectedLayoutMode
                }
              }).catch((err: Error) => {
                console.error('WebDisplayPage Navigation failed:', err);
              });
            })
        }
        .id('layout_mode_page_content_column')
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: 30 })
      }
      .id('layout_mode_page_scroll')
      .layoutWeight(1)
    }
    .id('layout_mode_page_root_column')
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}
