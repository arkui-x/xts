/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import matrix4 from '@ohos.matrix4';

@Entry
@Component
struct Index {
  private matrix1 = matrix4.identity().translate({ x: 100, y: 10, z: 100 });
  private matrix2 = matrix4.identity().translate({ x: 120, y: 15, z: 105 });
  private matrix3 = matrix4.identity().translate({ x: 130, y: 20, z: 110 });
  @State Updateflag: boolean = true
  @State transformData: matrix4.Matrix4Transit = matrix4.identity().translate({ x: 120, y: 10, z: 100 });
  @State translateData: TranslateOptions = { x: 10, y: 5, z: 20 }
  @State scaleData: ScaleOptions = {
    x: 1,
    y: 1,
    z: 1,
    centerX: 50,
    centerY: 60,
  }
  @State rotateData: RotateOptions = {
    x: 1,
    y: 1,
    z: 1,
    centerX: 50,
    centerY: 60,
    angle: 250
  }
  @State widthData: string = '250px'
  @State heightData: string = '240px'

  build() {
    Row() {
      Column() {
        Button('数据更新')
          .height(50)
          .width("80%")
          .fontSize(20)
          .margin({ top: 15, bottom: 15 })
          .id('BT1')
          .onClick(() => {
            console.info("Acts ComponentUtils Test ; BT1 click")
            if (this.Updateflag) {
              this.Updateflag = false
              this.transformData = matrix4.identity().translate({ x: 125, y: 15, z: 105 });
              this.translateData = { x: 15, y: 10, z: 25 }
              this.scaleData = {
                x: 1.5,
                y: 1.5,
                z: 1,
                centerX: 55,
                centerY: 55,
              }
              this.rotateData = {
                x: 1.5,
                y: 1.5,
                z: 1.5,
                angle: 255,
                centerX: 55,
                centerY: 55
              }
              this.widthData = '50px'
              this.heightData = '50px'
            } else {
              this.Updateflag = true
              this.transformData = matrix4.identity().translate({ x: 120, y: 10, z: 100 });
              this.translateData = { x: 10, y: 5, z: 20 }
              this.scaleData = {
                x: 1,
                y: 1,
                z: 1,
                centerX: 50,
                centerY: 60,
              }
              this.rotateData = {
                x: 1,
                y: 1,
                z: 1,
                angle: 250,
                centerX: 50,
                centerY: 60
              }
              this.widthData = '250px'
              this.heightData = '240px'
            }
          })

        Image($r("app.media.icon"))
          .id("Test0010")
          .transform(this.matrix1)//{ x: 100, y: 10, z: 100 }
          .translate({ x: 10, y: 5, z: 20 })
          .scale({
            x: 0.5,
            y: 1.5,
            z: 1,
            centerX: 50,
            centerY: 60,
          })
          .rotate({
            x: 1,
            y: 1,
            z: 1,
            centerX: 50,
            centerY: 60,
            angle: 250
          })
          .width('200px')
          .height('190px')

        Row()
          .margin({ top: 15, bottom: 15 })
          .backgroundColor('#ff1585f6')
          .id("Test0020")
          .transform(this.matrix2)//{ x: 120, y: 15, z: 105 }
          .translate({ x: 10, y: 5, z: 20 })
          .scale({
            x: 0.5,
            y: 1.5,
            z: 1,
            centerX: 50,
            centerY: 60,
          })
          .rotate({
            x: 1,
            y: 1,
            z: 1,
            centerX: 50,
            centerY: 60,
            angle: 250
          })
          .width('210px')
          .height('200px')

        Rect({ width: 40, height: 50 })
          .fill(Color.Pink)
          .id("Test0030")
          .transform(this.matrix3)//{ x: 130, y: 20, z: 110 }
          .translate({ x: 10, y: 5, z: 20 })
          .scale({
            x: 0.5,
            y: 1.5,
            z: 1,
            centerX: 50,
            centerY: 60,
          })
          .rotate({
            x: 1,
            y: 1,
            z: 1,
            centerX: 50,
            centerY: 60,
            angle: 250
          })
          .width('40px')
          .height('50px')

        Image($r("app.media.icon"))
          .id("Test0040")
          .transform(this.transformData)
          .translate(this.translateData)
          .scale(this.scaleData)
          .rotate(this.rotateData)
          .width(this.widthData)
          .height(this.heightData)

      }
      .width('100%')
    }
    .height('100%')
  }
}