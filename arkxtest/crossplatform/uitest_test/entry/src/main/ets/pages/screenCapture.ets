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
import { common } from '@kit.AbilityKit'

@Entry
@Component
struct ScreenCaptureTest {
  @State message: string = 'Hello World';
  @State captureImagePath1: string = '';
  @State captureImagePath2: string = '';

  build() {
    Column() {
      Button("返回")
        .id('screenCaptureBackButton')
        .width('80%')
        .height(48)
        .margin({ top: 8 })
        .backgroundColor("#ff1c8602")
        .onClick(() => {
          router.back()
        })

      Text('ScreenCapture测试')
        .id('screenCaptureTitleText')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Center)
        .margin({ top: 24 , bottom: 10 })

      Row() {
        Text('截全屏:')
          .id('screenCaptureFullScreenLabelText')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Center)

        Checkbox()
          .id('screenCaptureFullScreenCheckbox')
          .onChange((value: boolean) => {
            if (value) {
              let ctx = getContext(this) as common.UIAbilityContext;
              if (ctx && ctx.filesDir) {
                this.captureImagePath1 = 'file://' + ctx.filesDir + '/fullScreen.png';
                console.log('[UITEST_ETS] fullScreen capture path: ' + this.captureImagePath1);
              }
            }
          })
      }
      .id('screenCaptureFullScreenRow')

      Row() {
        Text('截区域:')
          .id('screenCapturePartScreenLabelText')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .alignSelf(ItemAlign.Center)

        Checkbox()
          .id('screenCapturePartScreenCheckbox')
          .onChange((value: boolean) => {
            if (value) {
              let ctx = getContext(this) as common.UIAbilityContext;
              if (ctx && ctx.filesDir) {
                this.captureImagePath2 = 'file://' + ctx.filesDir + '/partScreen.png';
                console.log('[UITEST_ETS] partScreen capture path: ' + this.captureImagePath2);
              }
            }
          })
      }.margin({ bottom: 20 })
      .id('screenCapturePartScreenRow')

      Image($rawfile('sky.jpg'))
        .id('screenCaptureSourceImage')
        .width('80%')
        .height('30%')
        .margin({ bottom: 10 })

      Row() {
        if (this.captureImagePath1 !== '') {
          Image(this.captureImagePath1)
            .id('screenCaptureFullScreenPreviewImage')
            .width('45%')
            .height(200)
            .objectFit(ImageFit.Contain)
            .margin({ right: 10 })
        }

        if (this.captureImagePath2 !== '') {
          Image(this.captureImagePath2)
            .id('screenCapturePartScreenPreviewImage')
            .width('45%')
            .height(200)
            .objectFit(ImageFit.Contain)
        }
      }
      .id('screenCapturePreviewRow')

    }
    .height('100%')
    .width('100%')
    .id('screenCaptureRootColumn')
  }
}