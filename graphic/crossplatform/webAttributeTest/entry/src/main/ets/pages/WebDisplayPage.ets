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
import { webview } from '@kit.ArkWeb';

interface WebDisplayParams {
  pageType: string;
  pageTitle: string;
  src: string;
  darkMode?: string;
  forceDarkAccess?: string;
  fontSizeMode?: string;
  layoutMode?: string;
  overviewModeAccess?: string;
  targetHeight?: number;
  blockCount?: number;
}

class AttrModifier implements AttributeModifier<WebAttribute> {
  applyFn: (instance: WebAttribute) => void;

  constructor(applyFn: (instance: WebAttribute) => void) {
    this.applyFn = applyFn;
  }

  applyNormalAttribute(instance: WebAttribute): void {
    this.applyFn(instance);
  }
}

@Entry
@Component
struct WebDisplayPage {
  controller: webview.WebviewController = new webview.WebviewController();
  params: WebDisplayParams = router.getParams() as WebDisplayParams;
  @State dynamicFontSize: number = 24;
  @State webComponentHeight: number = 0;
  @State result: string = '';
  @State webFontSize: string = '未获取';
  @State webColorScheme: string = '未获取';

  private onErr: () => void = () => {
    this.result = '网页加载失败';
  };
  private onOk: () => void = () => {
    this.result = '网页加载成功';
  };

  getSrc(): Resource {
    const s: string = this.params.src;
    if (s === 'darkMode.html') return $rawfile('darkMode.html');
    if (s === 'defaultFontSize.html') return $rawfile('defaultFontSize.html');
    if (s === 'layoutMode.html') return $rawfile('layoutMode.html');
    if (s === 'overviewMode.html') return $rawfile('overviewMode.html');
    return $rawfile('darkMode.html');
  }

  @Builder
  buildWeb(id: string, w: string | number, h: string | number, modifier: AttributeModifier<WebAttribute>) {
    Web({ src: this.getSrc(), controller: this.controller })
      .id(id)
      .width(w)
      .height(h)
      .onErrorReceive(this.onErr)
      .onPageEnd(this.onOk)
      .onAreaChange((_oldValue: Area, newValue: Area) => {
        this.webComponentHeight = Number(newValue.height);
      })
      .attributeModifier(modifier)
  }

  @Builder
  buildDarkModeWeb() {
    if (this.params.darkMode === 'Off')
      this.buildWeb('web_display_dark_mode_off', '100%', '100%',
        new AttrModifier((w) => w.darkMode(WebDarkMode.Off)))
    else if (this.params.darkMode === 'On')
      this.buildWeb('web_display_dark_mode_on', '100%', '100%',
        new AttrModifier((w) => w.darkMode(WebDarkMode.On)))
    else if (this.params.darkMode === 'Auto')
      this.buildWeb('web_display_dark_mode_auto', '100%', '100%',
        new AttrModifier((w) => w.darkMode(WebDarkMode.Auto)))
    else if (this.params.darkMode === 'null')
      this.buildWeb('web_display_dark_mode_null', '100%', '100%',
        new AttrModifier((w) => w.darkMode(null)))
    else if (this.params.darkMode === 'undefined')
      this.buildWeb('web_display_dark_mode_undefined', '100%', '100%',
        new AttrModifier((w) => w.darkMode(undefined)))
    else
      this.buildWeb('web_display_dark_mode_unset', '100%', '100%',
        new AttrModifier(() => {}))
  }

  @Builder
  buildForceDarkWeb() {
    // darkMode = Off
    if (this.params.darkMode === 'Off') {
      if (this.params.forceDarkAccess === 'false')
        this.buildWeb('web_display_force_dark_off_false', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Off).forceDarkAccess(false)))
      else if (this.params.forceDarkAccess === 'true')
        this.buildWeb('web_display_force_dark_off_true', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Off).forceDarkAccess(true)))
      else if (this.params.forceDarkAccess === 'null')
        this.buildWeb('web_display_force_dark_off_null', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Off).forceDarkAccess(null)))
      else if (this.params.forceDarkAccess === 'undefined')
        this.buildWeb('web_display_force_dark_off_undefined', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Off).forceDarkAccess(undefined)))
      else
        this.buildWeb('web_display_force_dark_off_unset', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Off)))
    }
    // darkMode = On
    else if (this.params.darkMode === 'On') {
      if (this.params.forceDarkAccess === 'false')
        this.buildWeb('web_display_force_dark_on_false', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.On).forceDarkAccess(false)))
      else if (this.params.forceDarkAccess === 'true')
        this.buildWeb('web_display_force_dark_on_true', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.On).forceDarkAccess(true)))
      else if (this.params.forceDarkAccess === 'null')
        this.buildWeb('web_display_force_dark_on_null', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.On).forceDarkAccess(null)))
      else if (this.params.forceDarkAccess === 'undefined')
        this.buildWeb('web_display_force_dark_on_undefined', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.On).forceDarkAccess(undefined)))
      else
        this.buildWeb('web_display_force_dark_on_unset', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.On)))
    }
    // darkMode = Auto
    else if (this.params.darkMode === 'Auto') {
      if (this.params.forceDarkAccess === 'false')
        this.buildWeb('web_display_force_dark_auto_false', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Auto).forceDarkAccess(false)))
      else if (this.params.forceDarkAccess === 'true')
        this.buildWeb('web_display_force_dark_auto_true', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Auto).forceDarkAccess(true)))
      else if (this.params.forceDarkAccess === 'null')
        this.buildWeb('web_display_force_dark_auto_null', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Auto).forceDarkAccess(null)))
      else if (this.params.forceDarkAccess === 'undefined')
        this.buildWeb('web_display_force_dark_auto_undefined', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Auto).forceDarkAccess(undefined)))
      else
        this.buildWeb('web_display_force_dark_auto_unset', '100%', '100%',
          new AttrModifier((w) => w.darkMode(WebDarkMode.Auto)))
    }
    // darkMode = unset
    else {
      if (this.params.forceDarkAccess === 'false')
        this.buildWeb('web_display_force_dark_unset_false', '100%', '100%',
          new AttrModifier((w) => w.forceDarkAccess(false)))
      else if (this.params.forceDarkAccess === 'true')
        this.buildWeb('web_display_force_dark_unset_true', '100%', '100%',
          new AttrModifier((w) => w.forceDarkAccess(true)))
      else if (this.params.forceDarkAccess === 'null')
        this.buildWeb('web_display_force_dark_unset_null', '100%', '100%',
          new AttrModifier((w) => w.forceDarkAccess(null)))
      else if (this.params.forceDarkAccess === 'undefined')
        this.buildWeb('web_display_force_dark_unset_undefined', '100%', '100%',
          new AttrModifier((w) => w.forceDarkAccess(undefined)))
      else
        this.buildWeb('web_display_force_dark_unset_unset', '100%', '100%',
          new AttrModifier(() => {}))
    }
  }

  @Builder
  buildDefaultFontSizeWeb() {
    if (this.params.fontSizeMode === '16')
      this.buildWeb('web_display_font_size_16', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(16)))
    else if (this.params.fontSizeMode === 'dynamic')
      this.buildWeb('web_display_font_size_dynamic', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(this.dynamicFontSize)))
    else if (this.params.fontSizeMode === 'max')
      this.buildWeb('web_display_font_size_max', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(2147483647)))
    else if (this.params.fontSizeMode === 'min')
      this.buildWeb('web_display_font_size_min', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(-2147483648)))
    else if (this.params.fontSizeMode === 'over_max')
      this.buildWeb('web_display_font_size_over_max', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(2147483648)))
    else if (this.params.fontSizeMode === 'under_min')
      this.buildWeb('web_display_font_size_under_min', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(-2147483649)))
    else if (this.params.fontSizeMode === 'null')
      this.buildWeb('web_display_font_size_null', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(null)))
    else if (this.params.fontSizeMode === 'undefined')
      this.buildWeb('web_display_font_size_undefined', '100%', '100%',
        new AttrModifier((w) => w.defaultFontSize(undefined)))
    else
      this.buildWeb('web_display_font_size_unset', '100%', '100%',
        new AttrModifier(() => {}))
  }

  @Builder
  buildLayoutModeWeb() {
    if (this.params.layoutMode === 'NONE')
      this.buildWeb('web_display_layout_mode_none', '100%', 300,
        new AttrModifier((w) => w.layoutMode(WebLayoutMode.NONE)))
    else if (this.params.layoutMode === 'FIT_CONTENT')
      this.buildWeb('web_display_layout_mode_fit_content', '100%', 300,
        new AttrModifier((w) => {
          w.nestedScroll({
            scrollForward: NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.PARENT_FIRST,
          });
          w.layoutMode(WebLayoutMode.FIT_CONTENT);
        }))
    else if (this.params.layoutMode === 'null')
      this.buildWeb('web_display_layout_mode_null', '100%', 300,
        new AttrModifier((w) => w.layoutMode(null)))
    else if (this.params.layoutMode === 'undefined')
      this.buildWeb('web_display_layout_mode_undefined', '100%', 300,
        new AttrModifier((w) => w.layoutMode(undefined)))
    else
      this.buildWeb('web_display_layout_mode_unset', '100%', 300,
        new AttrModifier(() => {}))
  }

  @Builder
  buildOverviewModeWeb() {
    if (this.params.overviewModeAccess === 'false')
      this.buildWeb('web_display_overview_mode_false', '100%', '100%',
        new AttrModifier((w) => w.overviewModeAccess(false)))
    else if (this.params.overviewModeAccess === 'true')
      this.buildWeb('web_display_overview_mode_true', '100%', '100%',
        new AttrModifier((w) => w.overviewModeAccess(true)))
    else if (this.params.overviewModeAccess === 'null')
      this.buildWeb('web_display_overview_mode_null', '100%', '100%',
        new AttrModifier((w) => w.overviewModeAccess(null)))
    else if (this.params.overviewModeAccess === 'undefined')
      this.buildWeb('web_display_overview_mode_undefined', '100%', '100%',
        new AttrModifier((w) => w.overviewModeAccess(undefined)))
    else
      this.buildWeb('web_display_overview_mode_unset', '100%', '100%',
        new AttrModifier(() => {}))
  }

  @Builder
  buildColorSchemeRow(btnId: string, textId: string, rowId: string) {
    Row({ space: 12 }) {
      Button('获取网页配色状态')
        .id(btnId)
        .fontSize(14)
        .height(40)
        .onClick(() => {
          this.controller.runJavaScript('getColorScheme()')
            .then((value: string) => {
              this.webColorScheme = `配色: ${value}`;
            })
            .catch((err: Error) => {
              this.webColorScheme = `获取失败: ${err.message}`;
            });
        })

      Text(this.webColorScheme)
        .id(textId)
        .fontSize(14)
        .fontColor('#007DFF')
    }
    .id(rowId)
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 8, bottom: 8 })
  }

  build() {
    Column() {
      // Title bar
      Row() {
        Button('← 返回')
          .id('btn_back')
          .fontSize(16)
          .height(44)
          .onClick(() => {
            router.back();
          })

        Text(this.params.pageTitle)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .id('web_display_title_row')
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })

      Divider()
        .id('web_display_divider_title')
        .strokeWidth(1)

      // 网页加载结果，供自动化测试判断
      Text(this.result)
        .id('web_display_result_text')
        .fontSize(16)
        .fontColor('#333')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .width('100%')
        .textAlign(TextAlign.Center)

      // Web content area
      if (this.params.pageType === 'darkMode') {
        this.buildColorSchemeRow('web_display_dark_color_btn', 'web_display_dark_color_text', 'web_display_dark_color_row')
        this.buildDarkModeWeb()
      } else if (this.params.pageType === 'forceDarkAccess') {
        this.buildColorSchemeRow('web_display_force_color_btn', 'web_display_force_color_text', 'web_display_force_color_row')
        this.buildForceDarkWeb()
      } else if (this.params.pageType === 'defaultFontSize') {
        if (this.params.fontSizeMode === 'dynamic') {
          // 动态改变字体模式：显示切换按钮
          Row({ space: 12 }) {
            Button('设置字体 16')
              .id('web_display_btn_font_16')
              .fontSize(14)
              .height(40)
              .type(this.dynamicFontSize === 16 ? ButtonType.Capsule : ButtonType.Normal)
              .backgroundColor(this.dynamicFontSize === 16 ? '#007DFF' : '#DEDEDE')
              .fontColor(this.dynamicFontSize === 16 ? '#FFFFFF' : '#182431')
              .onClick(() => { this.dynamicFontSize = 16; })

            Button('设置字体 24')
              .id('web_display_btn_font_24')
              .fontSize(14)
              .height(40)
              .type(this.dynamicFontSize === 24 ? ButtonType.Capsule : ButtonType.Normal)
              .backgroundColor(this.dynamicFontSize === 24 ? '#007DFF' : '#DEDEDE')
              .fontColor(this.dynamicFontSize === 24 ? '#FFFFFF' : '#182431')
              .onClick(() => { this.dynamicFontSize = 24; })
          }
          .id('web_display_font_switch_row')
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: 8, bottom: 8 })

          Text(`当前字体: ${this.dynamicFontSize}`)
            .id('web_display_font_current_label')
            .fontSize(14)
            .fontColor('#666')
            .padding({ bottom: 4 })
        }

        Row({ space: 12 }) {
          Button('获取字体大小')
            .id('web_display_font_btn_get_size')
            .fontSize(14)
            .height(40)
            .onClick(() => {
              this.controller.runJavaScript('getFontSize()')
                .then((value: string) => {
                  this.webFontSize = `当前字体大小: ${value}`;
                })
                .catch((err: Error) => {
                  this.webFontSize = `获取失败: ${err.message}`;
                });
            })

          Text(this.webFontSize)
            .id('web_display_font_size_text')
            .fontSize(14)
            .fontColor('#007DFF')
        }
        .id('web_display_font_size_row')
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 8, bottom: 8 })

        this.buildDefaultFontSizeWeb()
      } else if (this.params.pageType === 'layoutMode') {
        Text(`Web 组件高度: ${this.webComponentHeight} px`)
          .id('web_display_layout_web_height_text')
          .fontSize(16)
          .fontColor('#007DFF')
          .padding({ top: 8, bottom: 8 })
        Scroll() {
          Column() {
            this.buildLayoutModeWeb()

            Text(`这是scroll底部Text组件`)
              .id('web_display_layout_attr_text')
              .fontSize(24)
              .fontColor('#333')
              .padding(16)
              .width('100%')
              .textAlign(TextAlign.Center)
          }
          .id('web_display_layout_content_column')
          .width('100%')
        }
        .id('web_display_layout_scroll')
        .layoutWeight(1)
      } else if (this.params.pageType === 'overviewModeAccess') {
        this.buildOverviewModeWeb()
      } else {
        this.buildWeb('web_display_default', '100%', '100%', new AttrModifier(() => {}))
      }
    }
    .id('web_display_root_column')
    .width('100%').height('100%')
  }
}
