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
struct WaitForComponentTest {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Button("返回")
        .id('waitForComponentBackButton')
        .width('80%')
        .height(48)
        .margin({ top: 8 })
        .backgroundColor("#ff1c8602")
        .onClick(() => {
          router.back()
        })

      Text('WaitForComponent测试')
        .id('waitForComponentTitleText')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 24 , bottom: 50 })

      Row() {
        Text('Button A 存在')
          .id('waitForComponentOptionAText')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Center)
        Checkbox()
          .id('waitForComponentFoundCheckbox')
      }
      .id('waitForComponentOptionARow')

      Row() {
        Text('Button B 不存在')
          .id('waitForComponentOptionBText')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Center)
        Checkbox()
          .id('waitForComponentMissingCheckbox')
      }.margin({ top: 24 , bottom: 50 })
      .id('waitForComponentOptionBRow')

      Button("A")
        .id('waitForComponentButtonA')
        .width('80%')
        .height(48)
        .margin({ top: 8 })


    }
    .height('100%')
    .width('100%')
    .id('waitForComponentRootColumn')
  }
}