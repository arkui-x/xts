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

import { router } from '@kit.ArkUI'

@Entry
@Component
struct DragTest {
  @State message: string = 'Drag 测试界面';
  @State dragResult: string = '未拖拽'
  @State dropZoneText: string = '放置区域'
  @State dropZoneBgColor: string = '#FFFFFF'
  @State dropZoneBorderColor: string = '#E0E0E0'
  @State dragSourceText: string = '拖我到下方放置区域'
  @Builder pixelMapBuilder() {
    Column() {
      Text(this.dragSourceText)
        .id('dragPixelMapBuilderText')
        .width('50%').height(60).borderRadius(10)
        .textAlign(TextAlign.Center).backgroundColor(Color.Yellow)
    }
    .id('dragPixelMapBuilderColumn')
  }
  build() {
    Column() {
      Button("返回")
        .id('dragBackButton')
        .width('80%')
        .height(48)
        .margin({ top: 8 })
        .backgroundColor("#ff1c8602")
        .onClick(() => {
          router.back()
        })

      Text('拖拽测试')
        .id('dragTitleText')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 24 , bottom: 100 })

      // Draggable Text (drag source)
      Text(this.dragSourceText)
        .id('dragSourceText')
        .width('80%')
        .height(60)
        .fontSize(16)
        .textAlign(TextAlign.Center)
        .backgroundColor('#4A90E2')
        .fontColor(Color.White)
        .borderRadius(8)
        .margin({ top: 8 })
        .draggable(true)
        .onDragStart(() => {
          return this.pixelMapBuilder
        })
        .onDragEnd(() => {
          this.dragSourceText = '拖拽已完成'
        })

        // Drop Zone (drag target)
        Column() {
          Text(this.dropZoneText)
            .id('dragDropZoneLabelText')
            .fontSize(16)
            .fontColor(this.dropZoneBgColor === '#4CAF50' ? Color.White : Color.Gray)
        }
        .id('dragDropZone')
        .width('80%')
        .height(80)
        .margin({ top: 64 })
        .backgroundColor(this.dropZoneBgColor)
        .border({ width: 2, color: this.dropZoneBorderColor, radius: 8, style: BorderStyle.Dashed })
        .justifyContent(FlexAlign.Center)
        .onDragEnter(() => {
          this.dropZoneBorderColor = '#4A90E2'
          this.dropZoneText = '松手放置'
        })
        .onDragLeave(() => {
          this.dropZoneBorderColor = '#E0E0E0'
          this.dropZoneText = '放置区域'
        })
        .onDrop((event: DragEvent) => {
          this.dragResult = '拖拽成功'
          this.dropZoneText = '拖拽成功!'
          this.dropZoneBgColor = '#4CAF50'
          this.dropZoneBorderColor = '#4CAF50'
          event.setResult(DragResult.DRAG_SUCCESSFUL)
        })

        Text(this.dragResult)
          .id('dragResultText')
          .fontSize(16)
          .fontColor(this.dragResult === '拖拽成功' ? Color.Green : Color.Pink)
          .fontWeight(this.dragResult === '拖拽成功' ? FontWeight.Bold : FontWeight.Normal)
          .margin({ top: 8, bottom: 16 })


    }
    .height('100%')
    .width('100%')
    .id('dragRootColumn')
  }
}