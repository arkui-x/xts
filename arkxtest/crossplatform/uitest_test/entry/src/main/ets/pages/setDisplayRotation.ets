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
struct SetDisplayRotation {

  build() {
    Scroll() {
      Column() {
        Button("返回")
          .id('setDisplayRotationBackButton')
          .width('80%')
          .height(48)
          .margin({ top: 8 })
          .backgroundColor("#ff1c8602")
          .onClick(() => {
            router.back()
          })

        Text('测试用例页面')
          .id('setDisplayRotationTitleText')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 20 })

        Video({ src: $rawfile('video.mp4') })
          .id('setDisplayRotationVideo')
          .width('30%')
          .height('30%')
          .margin({ top: 20 })
          .controls(true)
          .autoPlay(true)

        // ========== 旋转测试提示区域 ==========
        Text('屏幕旋转测试')
          .id('setDisplayRotationAnchorText')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Start)
          .margin({ left: 16 })

        Text('旋转后页面应保持可见并可继续交互')
          .id('setDisplayRotationResultText')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ top: 8, bottom: 20 })
      }
      .id('setDisplayRotationRootColumn')
      .width('100%')
      .padding({ top: 10 })
    }
    .id('setDisplayRotationRootScroll')
    .width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
  }
}
