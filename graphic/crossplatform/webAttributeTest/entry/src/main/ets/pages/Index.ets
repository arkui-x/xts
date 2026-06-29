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
struct Index {
  build() {
    Column() {
      Scroll() {
        Column({ space: 20 }) {
          Text('【ArkWeb】【渲染引擎】web组件属性适配跨平台')
            .id('index_title_text')
            .fontSize(28)

          Button('overviewModeAccess')
            .id('index_btn_overview_mode_access')
            .width('80%')
            .height(35)
            .onClick(() => {
              router.pushUrl({ url: 'pages/OverviewModePage' }).catch((err: Error) => {
                console.error('OverviewModePage Navigation failed:', err);
              });
            })

          Button('layoutMode')
            .id('index_btn_layout_mode')
            .width('80%')
            .height(35)
            .onClick(() => {
              router.pushUrl({ url: 'pages/LayoutModePage' }).catch((err: Error) => {
                console.error('LayoutModePage Navigation failed:', err);
              });
            })

          Button('darkMode')
            .id('index_btn_dark_mode')
            .width('80%')
            .height(35)
            .onClick(() => {
              router.pushUrl({ url: 'pages/DarkModePage' }).catch((err: Error) => {
                console.error('DarkModePage Navigation failed:', err);
              });
            })

          Button('forceDarkAccess')
            .id('index_btn_force_dark_access')
            .width('80%')
            .height(35)
            .onClick(() => {
              router.pushUrl({ url: 'pages/ForceDarkAccessPage' }).catch((err: Error) => {
                console.error('ForceDarkAccessPage Navigation failed:', err);
              });
            })

          Button('defaultFontSize')
            .id('index_btn_default_font_size')
            .width('80%')
            .height(35)
            .onClick(() => {
              router.pushUrl({ url: 'pages/DefaultFontSizePage' }).catch((err: Error) => {
                console.error('DefaultFontSizePage Navigation failed:', err);
              });
            })
        }
        .width('100%')
        .padding(20)
      }
      .id('index_scroll')
      .layoutWeight(1)
    }
    .id('index_root_column')
    .height('100%')
  }
}
