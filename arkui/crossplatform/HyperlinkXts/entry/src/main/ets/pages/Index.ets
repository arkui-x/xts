/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
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

const LONG_STRING: string = 'a'.repeat(500)
@Entry
@Component
struct Index {
  @State borderImageOption: BorderImageOption = {
    source: {
      angle: 90,
      direction: GradientDirection.Left,
      colors: [[0xAEE1E1, 0.0], [0xD3E0DC, 0.3], [0xFCD1D1, 1.0]]
    },
    slice: {
      top: 10,
      bottom: 10,
      left: 10,
      right: 10
    },
    width: {
      top: "10px",
      bottom: "10px",
      left: "10px",
      right: "10px"
    },
    repeat: RepeatMode.Stretch,
    fill: false
  }
  @State paddingOption: Padding = {
    top: 7,
    bottom: 7,
    left: 7,
    right: 7
  }

  build() {
    Row() {
      Scroll() {
        Column() {

          Column() {
            Hyperlink('http://hcl.baidu.com/', '测试项：address，设置值为 http 类型网址') {
            }.id('ArkUIX_Component_Hyperlink_address_0100')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink($r('app.string.Test_100'), '测试项：address，Resource类型，设置值为 http 类型网址') {
            }.id('ArkUIX_Component_Hyperlink_address_0200')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.gov.cn/', '测试项：address，设置值为 https 类型网址') {
            }.id('ArkUIX_Component_Hyperlink_address_0300')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink($r('app.string.Test_200'), '测试项：address，Resource类型，设置值为 https 类型网址') {
            }.id('ArkUIX_Component_Hyperlink_address_0400')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('ABcd1234中文!@#！@#￥%', '测试项：address，设置值为 错误值 ABcd1234中文!@#！@#￥%') {
            }.id('ArkUIX_Component_Hyperlink_address_0500')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink(
              $r('app.string.Test_001'),
              '测试项：address，Resource类型，设置值为 错误值 ResABcd1234中文!@#！@#￥%') {
            }.id('ArkUIX_Component_Hyperlink_address_0600')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('', '测试项：address，设置值为 错误值 空字符串') {
            }.id('ArkUIX_Component_Hyperlink_address_0700')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink(
              $r('app.string.Test_002'),
              '测试项：address，Resource类型，设置值为 错误值 空字符串') {
            }.id('ArkUIX_Component_Hyperlink_address_0800')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })


          Column() {
            Hyperlink(LONG_STRING, '测试项：address，设置值为 错误值 长字符串') {
            }.id('ArkUIX_Component_Hyperlink_address_0900')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink(
              $r('app.string.Test_003'),
              '测试项：address，Resource类型，设置值为 错误值 长字符串') {
            }.id('ArkUIX_Component_Hyperlink_address_1000')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink(
              $r('app.media.startIcon'),
              '测试项：address，Resource类型，设置值为 错误值 错误资源值') {
            }.id('ArkUIX_Component_Hyperlink_address_1100')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink(
              $r('sys.string.calendar_picker_mon'),
              '测试项：address，Resource类型，设置值为 错误值 系统资源') {
            }.id('ArkUIX_Component_Hyperlink_address_1200')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink(null, '测试项：address，设置值为 null') {
            }.id('ArkUIX_Component_Hyperlink_address_1300')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink(undefined, '测试项：address，设置值为 undefined') {
            }.id('ArkUIX_Component_Hyperlink_address_1400')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Divider().size({ width: '100%', height: 5 }).backgroundColor(Color.Black).margin({ top: 20, bottom: 20 })

          Column() {
            Text('测试项：content，设置值为 不设置')
            Hyperlink('https://www.baidu.com/') {
            }.id('ArkUIX_Component_Hyperlink_content_0100')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，设置值为 ABcd1234中文!@#！@#￥%')
            Hyperlink('https://www.baidu.com/', 'ABcd1234中文!@#！@#￥%') {
            }.id('ArkUIX_Component_Hyperlink_content_0200')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，设置值为 空字符串')
            Hyperlink('https://www.baidu.com/', '') {
            }.id('ArkUIX_Component_Hyperlink_content_0300')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，设置值为 长字符串')
            Hyperlink('https://www.baidu.com/', LONG_STRING) {
            }.id('ArkUIX_Component_Hyperlink_content_0400')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，Resource类型，设置值为 ResABcd1234中文!@#！@#￥%')
            Hyperlink('https://www.baidu.com/', $r('app.string.Test_001')) {
            }.id('ArkUIX_Component_Hyperlink_content_0500')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，Resource类型，设置值为 空字符串')
            Hyperlink('https://www.baidu.com/', $r('app.string.Test_002')) {
            }.id('ArkUIX_Component_Hyperlink_content_0600')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，Resource类型，设置值为 长字符串')
            Hyperlink('https://www.baidu.com/', $r('app.string.Test_003')) {
            }.id('ArkUIX_Component_Hyperlink_content_0700')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，Resource类型，设置值为 错误资源')
            Hyperlink('https://www.baidu.com/', $r('app.media.startIcon')) {
            }.id('ArkUIX_Component_Hyperlink_content_0800')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，Resource类型，设置值为 系统资源')
            Hyperlink('https://www.baidu.com/', $r('sys.string.calendar_picker_mon')) {
            }.id('ArkUIX_Component_Hyperlink_content_0900')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，设置值为 null')
            Hyperlink('https://www.baidu.com/', null) {
            }.id('ArkUIX_Component_Hyperlink_content_1000')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：content，设置值为 undefined')
            Hyperlink('https://www.baidu.com/', undefined) {
            }.id('ArkUIX_Component_Hyperlink_content_1100')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Divider().size({ width: '100%', height: 5 }).backgroundColor(Color.Black).margin({ top: 20, bottom: 20 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 不设置(默认值)') {
            }.id('ArkUIX_Component_Hyperlink_color_0100')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Black') {
            }.id('ArkUIX_Component_Hyperlink_color_0200')
            .color(Color.Black)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Blue') {
            }.id('ArkUIX_Component_Hyperlink_color_0300')
            .color(Color.Blue)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Brown') {
            }.id('ArkUIX_Component_Hyperlink_color_0400')
            .color(Color.Brown)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Gray') {
            }.id('ArkUIX_Component_Hyperlink_color_0500')
            .color(Color.Gray)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Grey') {
            }.id('ArkUIX_Component_Hyperlink_color_0600')
            .color(Color.Grey)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Green') {
            }.id('ArkUIX_Component_Hyperlink_color_0700')
            .color(Color.Green)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Orange') {
            }.id('ArkUIX_Component_Hyperlink_color_0800')
            .color(Color.Orange)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Pink') {
            }.id('ArkUIX_Component_Hyperlink_color_0900')
            .color(Color.Pink)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Red') {
            }.id('ArkUIX_Component_Hyperlink_color_1000')
            .color(Color.Red)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：color，设置值为 Color.White')
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.White') {
            }.id('ArkUIX_Component_Hyperlink_color_1100')
            .color(Color.White)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Yellow') {
            }.id('ArkUIX_Component_Hyperlink_color_1200')
            .color(Color.Yellow)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：color，设置值为 Color.Transparent')
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Color.Transparent') {
            }.id('ArkUIX_Component_Hyperlink_color_1300')
            .color(Color.Transparent)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })
          .backgroundColor(Color.Red)

          Column() {
            Text('测试项：color，设置值为 0xffffff')
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 0xffffff') {
            }.id('ArkUIX_Component_Hyperlink_color_1400')
            .color(0xffffff)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 0xffff0000') {
            }.id('ArkUIX_Component_Hyperlink_color_1500')
            .color(0xffff0000)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：color，设置值为 -1')
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 -1') {
            }.id('ArkUIX_Component_Hyperlink_color_1600')
            .color(-1)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Text('测试项：color，设置值为 #ffffff')
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 #ffffff') {
            }.id('ArkUIX_Component_Hyperlink_color_1700')
            .color('#ffffff')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 #ff000000') {
            }.id('ArkUIX_Component_Hyperlink_color_1800')
            .color('#ff000000')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 rgb(255, 100, 255)') {
            }.id('ArkUIX_Component_Hyperlink_color_1900')
            .color('rgb(255, 100, 255)')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 rgba(255, 100, 255, 0.5)') {
            }.id('ArkUIX_Component_Hyperlink_color_2000')
            .color('rgba(255, 100, 255, 0.5)')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 Abc123中文!@#！@#') {
            }.id('ArkUIX_Component_Hyperlink_color_2100')
            .color('Abc123中文!@#！@#')
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 应用颜色资源Resource') {
            }.id('ArkUIX_Component_Hyperlink_color_2200')
            .color($r('app.color.test_color'))
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 系统颜色资源Resource') {
            }.id('ArkUIX_Component_Hyperlink_color_2300')
            .color($r('sys.color.alert'))
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 非颜色资源值') {
            }.id('ArkUIX_Component_Hyperlink_color_2400')
            .color($r('app.string.app_name'))
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 null') {
            }.id('ArkUIX_Component_Hyperlink_color_2500')
            .color(null)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Column() {
            Hyperlink('https://www.baidu.com/', '测试项：color，设置值为 undefined') {
            }.id('ArkUIX_Component_Hyperlink_color_2600')
            .color(undefined)
          }
          .borderImage(this.borderImageOption)
          .padding(this.paddingOption)
          .margin({ top: 7, bottom: 7 })

          Row() {
          }.size({ width: '100%', height: 35 })
        }
        .width('100%')
      }.scrollBar(BarState.Off)
    }
    .height('100%')
  }
}
