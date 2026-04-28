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

import { display, router } from '@kit.ArkUI'

@Entry
@Component
struct GetDisplaySize {
  @State displayWidth: number = 0
  @State displayHeight: number = 0
  @State densityPixels: number = 0
  @State orientationText: string = '等待获取'
  @State resultCase001: string = '--'
  @State resultCase002: string = '--'
  @State resultCase003: string = '--'
  @State resultCase001Status: string = '等待执行'
  @State resultCase002Status: string = '等待执行'
  @State resultCase003Status: string = '等待执行'

  aboutToAppear(): void {
    this.refreshDisplayInfo()
    display.on('change', this.onDisplayChange)
  }

  aboutToDisappear(): void {
    display.off('change', this.onDisplayChange)
  }

  private onDisplayChange = (): void => {
    this.refreshDisplayInfo()
  }

  private refreshDisplayInfo(): void {
    const info = display.getDefaultDisplaySync()
    this.displayWidth = info.width
    this.displayHeight = info.height
    this.densityPixels = Number(info.densityPixels.toFixed(2))
    this.orientationText = this.formatOrientation(info.orientation)
    this.resultCase001 = `${info.width} x ${info.height}`
    this.resultCase002 = `${info.width} x ${info.height}`
    this.resultCase003 = '0 x 0'
    this.resultCase001Status = '主屏默认查询'
    this.resultCase002Status = 'displayId = 0'
    this.resultCase003Status = 'displayId = 1000'
  }

  private formatOrientation(orientation: display.Orientation): string {
    switch (orientation) {
      case display.Orientation.PORTRAIT:
        return '竖屏'
      case display.Orientation.LANDSCAPE:
        return '横屏'
      case display.Orientation.PORTRAIT_INVERTED:
        return '倒置竖屏'
      case display.Orientation.LANDSCAPE_INVERTED:
        return '倒置横屏'
      default:
        return '未知方向'
    }
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Button('返回')
            .id('getDisplaySizeBackButton')
            .width(92)
            .height(42)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor('#20324a')
            .borderRadius(20)
            .onClick(() => {
              router.back()
            })

          Blank()
            .id('getDisplaySizeHeaderBlank')

          Text('Display Size')
            .id('getDisplaySizeHeaderTitleText')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#10233d')
        }
        .id('getDisplaySizeHeaderRow')
        .width('100%')
        .margin({ bottom: 18 })

        Column({ space: 10 }) {
          Text('接口测试结果面板')
            .id('getDisplaySizeInfoLabelText')
            .fontSize(14)
            .fontColor('#4d6482')
          Text('实时展示当前页面拿到的屏幕尺寸、朝向和缩放信息')
            .id('getDisplaySizeInfoDescriptionText')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#10233d')
            .lineHeight(15)
        }
        .id('getDisplaySizeInfoCard')
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(20)
        .backgroundColor('#f4f8ff')
        .borderRadius(28)
        .margin({ bottom: 18 })

        Row({ space: 12 }) {
          Column({ space: 8 }) {
            Text('宽度')
              .id('getDisplaySizeWidthLabelText')
              .fontSize(13)
              .fontColor('#60738c')
            Text(`${this.displayWidth}`)
              .id('getDisplaySizeWidthValueText')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0f2f56')
            Text('px')
              .id('getDisplaySizeWidthUnitText')
              .fontSize(13)
              .fontColor('#60738c')
          }
          .id('getDisplaySizeWidthCard')
          .layoutWeight(1)
          .padding({ top: 6, bottom: 6, left: 6, right: 6 })
          .backgroundColor('#ffffff')
          .borderRadius(24)

          Column({ space: 8 }) {
            Text('高度')
              .id('getDisplaySizeHeightLabelText')
              .fontSize(13)
              .fontColor('#60738c')
            Text(`${this.displayHeight}`)
              .id('getDisplaySizeHeightValueText')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0f2f56')
            Text('px')
              .id('getDisplaySizeHeightUnitText')
              .fontSize(13)
              .fontColor('#60738c')
          }
          .id('getDisplaySizeHeightCard')
          .layoutWeight(1)
          .padding({ top: 6, bottom: 6, left: 6, right: 6 })
          .backgroundColor('#ffffff')
          .borderRadius(24)
        }
        .id('getDisplaySizeMetricRow')
        .width('100%')
        .margin({ bottom: 12 })

        Column({ space: 12 }) {
          Text('三组接口测试结果')
            .id('getDisplaySizeResultSectionTitleText')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#10233d')

          Column({ space: 6 }) {
            Row() {
              Text('test_get_display_size_001')
                .id('getDisplaySizeCase001LabelText')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#10233d')
              Blank()
                .id('getDisplaySizeCase001Blank')
              Text(this.resultCase001Status)
                .id('getDisplaySizeCase001StatusText')
                .fontSize(12)
                .fontColor('#5f738c')
            }
            .id('getDisplaySizeCase001HeaderRow')
            .width('100%')
            Text(this.resultCase001)
              .id('getDisplaySizeCase001ValueText')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0f2f56')
          }
          .id('getDisplaySizeCase001Card')
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(6)
          .backgroundColor('#ffffff')
          .borderRadius(22)

          Column({ space: 6 }) {
            Row() {
              Text('test_get_display_size_002')
                .id('getDisplaySizeCase002LabelText')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#10233d')
              Blank()
                .id('getDisplaySizeCase002Blank')
              Text(this.resultCase002Status)
                .id('getDisplaySizeCase002StatusText')
                .fontSize(12)
                .fontColor('#5f738c')
            }
            .id('getDisplaySizeCase002HeaderRow')
            .width('100%')
            Text(this.resultCase002)
              .id('getDisplaySizeCase002ValueText')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0f2f56')
          }
          .id('getDisplaySizeCase002Card')
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(6)
          .backgroundColor('#ffffff')
          .borderRadius(22)

          Column({ space: 6 }) {
            Row() {
              Text('test_get_display_size_003')
                .id('getDisplaySizeCase003LabelText')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#10233d')
              Blank()
                .id('getDisplaySizeCase003Blank')
              Text(this.resultCase003Status)
                .id('getDisplaySizeCase003StatusText')
                .fontSize(12)
                .fontColor('#8c4510')
            }
            .id('getDisplaySizeCase003HeaderRow')
            .width('100%')
            Text(this.resultCase003)
              .id('getDisplaySizeCase003ValueText')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor('#c2561a')
          }
          .id('getDisplaySizeCase003Card')
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(6)
          .backgroundColor('#fff6e8')
          .borderRadius(22)
        }
        .id('getDisplaySizeResultSection')
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(6)
        .backgroundColor('#f7faff')
        .borderRadius(24)
        .margin({ bottom: 12 })

      }
      .id('getDisplaySizeRootColumn')
      .width('100%')
      .padding({ top: 22, bottom: 26, left: 18, right: 18 })
    }
    .id('getDisplaySizeRootStack')
    .width('100%')
    .height('100%')
    .backgroundColor('#e8eef7')
  }
}
