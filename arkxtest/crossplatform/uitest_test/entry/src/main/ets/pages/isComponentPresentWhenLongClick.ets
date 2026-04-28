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
struct IsComponentPresentWhenLongClick {
  @State message: string = 'Hello World';
  @State isShowLongEventCom: boolean = false;
  @State longClickEvent: string = 'Hello World';

  build() {
    Column() {
      Button("返回")
        .id('longClickBackButton')
        .width('80%')
        .height(48)
        .margin({ top: 8 })
        .backgroundColor("#ff1c8602")
        .onClick(() => {
          router.back()
        })

      Text('IsComponentPresentWhenLongClick测试')
        .id('longClickTitleText')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 24 , bottom: 100 })

      Row() {
        if (this.isShowLongEventCom) {
          Text('ShowLongEventText')
            .id('longClickVisibleIndicatorText')
            .fontSize(10)
        }
        Text('longClick')
          .id('longClickTriggerText')
          .fontSize(10)
          .margin({ left: 10 })
          .gesture(LongPressGesture({ repeat: true }).onAction((event: GestureEvent) => {
            if (event && event.repeat) {
              this.isShowLongEventCom = true;
              this.longClickEvent = 'longClickEvent'
            }
          }).onActionEnd((event: GestureEvent) => {
            this.isShowLongEventCom = false;
          }))
        Text(this.longClickEvent)
          .margin({
            left: 10
          })
          .backgroundColor(Color.Green)
          .id('longClickResultText')
      }
      .id('longClickActionRow')
      .backgroundColor(Color.Red)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .id('longClickRootColumn')

  }
}