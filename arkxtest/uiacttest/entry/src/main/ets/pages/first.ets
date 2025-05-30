/**
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
 import router from '@ohos.router';
@Entry
@Component
struct DragExample {
  @State numbers: string[] = ['first', 'second', 'third', 'fourth', 'five', 'six']
  @State text: string = ''
  @State bool: boolean = false
  @State bool1: boolean = false
  @State appleVisible: Visibility = Visibility.Visible
  @State orangeVisible: Visibility = Visibility.Visible
  @State bananaVisible: Visibility = Visibility.Visible
  @State select: number = 0

  @Builder pixelMapBuilder() {
    Column() {
      Text(this.text)
        .width('50%').height(60).fontSize(16).borderRadius(10)
        .textAlign(TextAlign.Center).backgroundColor(Color.Yellow)
    }
  }

  build() {
    Column() {
      Text('There are three Text elements here')
        .fontSize(12).fontColor(0xCCCCCC).width('90%')
        .textAlign(TextAlign.Start).margin(5)
      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
        Text('apple').width('25%').height(35).fontSize(16)
          .textAlign(TextAlign.Center).backgroundColor(0xAFEEEE)
          .visibility(this.appleVisible)
        Text('orange').width('25%').height(35).fontSize(16)
          .textAlign(TextAlign.Center).backgroundColor(0xAFEEEE)
          .visibility(this.orangeVisible)
        Text('banana').width('25%').height(35).fontSize(16)
          .textAlign(TextAlign.Center).backgroundColor(0xAFEEEE)
          .visibility(this.bananaVisible)
      }.border({ width: 1 }).width('90%').padding({ top: 10, bottom: 10 }).margin(10)

      // Text('This is a List element').fontSize(12)
      //   .fontColor(0xCCCCCC).width('90%')
      //   .textAlign(TextAlign.Start).margin(15)
      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.numbers, (item: string) => {
          ListItem() {
            Text('' + item)
              .width('100%').height(80).fontSize(16).borderRadius(10)
              .textAlign(TextAlign.Center).backgroundColor(0xAFEEEE)
              .onClick(() => {
                router.pushUrl({ url: `pages/${item}`})
              })
          }
        })
      }
      .height('50%').width('90%').border({ width: 1 })
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 })
    }.width('100%').height('100%').padding({ top: 20 }).margin({ top: 20 })
  }
}