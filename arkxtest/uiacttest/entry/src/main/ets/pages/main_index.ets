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
struct ScrollExample {
  scroller: Scroller = new Scroller()
  @State hoverText : string = 'jump'
  @State text: string = 'onChange'
  @State switchPointColor: string = '#FF008000'
  controller: TextInputController = new TextInputController()
  @State accumulateTime: number = 0
  @State timeZoneOffset: number = -8
  @State format: string = 'hms'
  @State status: string = 'run'
  @State change: string = 'no change'
  @State outSetValueOne: number = 40
  @State radioGroup : string = 'radioGroup'
  @State color:Color = Color.Blue
  public valueArr: number[] = [10, 10, 10, 10, 10, 10, 10, 10, 10]
  // 导入对象
  TextClockController: TextClockController = new TextClockController()

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Text('MainPage')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
      Stack({ alignContent: Alignment.TopStart }) {
        Scroll(this.scroller) {
          Column() {

            Button() {
              Text('1')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
                .id('my-key-new')
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })

            Button() {
              Text('next page false')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })
            .enabled(false)
            .onClick(() => {
              router.pushUrl({ url: 'pages/second' })
            })
            .gesture(
              LongPressGesture({ repeat: false })
                .onAction((event: GestureEvent) => {
                  router.pushUrl({ url: 'pages/fourth' })
                })
            )


            Button() {
              Text('Click twice false')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
            }
            .enabled(false)
            .type(ButtonType.Capsule)
            .margin({ top: 20 })
            .gesture(
              TapGesture({ count: 1 })
                .onAction(() => {
                  router.pushUrl({ url: 'pages/third' })
                })
            )

            Button() {
              Text("id null")
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
                .id(null)
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })

            Button() {
              Text('test')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })

            Button() {
              Text('❤❥웃유♋')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })

            Button() {
              Text('next page')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })

            .onClick(() => {
              router.pushUrl({ url: 'pages/second' })
            })
            .gesture(
            LongPressGesture({ repeat: false })
              .onAction((event: GestureEvent) => {
                router.pushUrl({ url: 'pages/fourth' })
              })
            )
            Button() {
              Text('Click twice')
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })
            .gesture(
            TapGesture({ count: 1 })
              .onAction(() => {
                router.pushUrl({ url: 'pages/third' })
              })
            )
            Button() {
              Text(this.hoverText)
                .fontSize(25)
                .fontWeight(FontWeight.Bold)
                .id('my-key')
            }
            .type(ButtonType.Capsule)
            .margin({ top: 20 })
            .onHover((isHover: boolean) => {
              if (isHover) {
                this.hoverText = 'hover'
              }
          })
            .onMouse((event: MouseEvent) => {
              switch (event.button) {
                case MouseButton.Left :
                  this.hoverText = 'left'
                  break
                case MouseButton.Right :
                  this.hoverText = 'right'
                  break
                case MouseButton.Middle :
                  this.hoverText = 'middle'
                  break
              }
            })
            .onClick(() => {
              router.pushUrl({ url: 'pages/screen' })
            })
            .gesture(
            LongPressGesture({ repeat: false })
              .onAction((event: GestureEvent) => {
                router.pushUrl({ url: 'pages/drag' })
              })
            )
            Flex({direction: FlexDirection.Row,justifyContent: FlexAlign.Center}) {
              // checkbox方框组件
              Checkbox({ name: 'hi' })
                .size({ width: 40, height: 40 })
                .select(true)


              // 单选框组件
              Toggle({ type: ToggleType.Switch})
                .key('Toggle')
                .margin({ top: 10 })
                .size({width:50,height:30})
                .selectedColor('#007DFF')
                .switchPointColor(this.switchPointColor)
                .onChange((isOn: boolean) => {
                  this.text = "switch " + isOn.toString()
                  console.info('Component status:' + isOn)
                })
              // 复选框组件
              Toggle({ type: ToggleType.Checkbox, isOn: true })
                .size({ width: 40, height: 40 })
                .selectedColor('#007DFF')
                .onChange((isOn: boolean) => {
                  console.info('Component status:' + isOn)
                })

              Radio({ value: 'Radio2', group: this.radioGroup }).checked(true)
                .height(40)
                .width(40)
                .key('Radio')
                .enabled(false)
                .focusable(true)
                .onChange((isChecked: boolean) => {
                  console.log('Radio2 status is ' + isChecked)
                })
              Gauge({ value: 75 })
                .value(25) // 属性和参数都设置时以参数为准
                .width(40).height(40)
                .colors([[0x317AF7, 1], [0x5BA854, 1], [0xE08C3A, 1], [0x9C554B, 1]])
                .margin({left:10})
            }
            Flex({direction: FlexDirection.Row,justifyContent: FlexAlign.Center}){
              TextInput({ placeholder: 'welcome', text: 'Hello World'})
                .type(InputType.Normal)
                .width(200)
                .height(40)
                .fontSize(24)
                .enabled(true)
                .margin({ top: 10 })
                .key('TextInput')
                .textAlign(TextAlign.Center)
              // TextArea
              TextArea({
                text: this.text,
                placeholder: 'The text area can hold an unlimited amount of text. input your word...',
              })
                .placeholderFont({ size: 16, weight: 400 })
                .width(260)
                .height(40)
                .fontSize(24)
                .margin({ top: 10 })
                .fontColor('#182431')
                .backgroundColor('#FFFFFF')
                .onChange((value: string) => {
                  this.text = value
                })
            }
              // input 框输入
              Text('first')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/first`})
              })
            Text('second')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/second`})
              })
            Text('third')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/third`})
              })
            Text('fourth')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/fourth`})
              })
            Text('fifth')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/fourth`})
              })
            Text('sixth')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/fourth`})
              })
            Text('seventh')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/fourth`})
              })
            Text('eighth')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/fourth`})
              })
            Text('ninth')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/fourth`})
              })
            Text('tenth')
              .width('100%')
              .height('7%')
              .backgroundColor(0xFFFFFF)
              .borderRadius(75)
              .fontSize(24)
              .textAlign(TextAlign.Center)
              .margin({ top: 10 })
              .onClick(() => {
                router.pushUrl({ url: `pages/fourth`})
              })
        // 底部样式
            Flex({direction: FlexDirection.Row,justifyContent: FlexAlign.Center}) {
              TextClock({ timeZoneOffset: this.timeZoneOffset, controller: this.TextClockController })
                .format(this.format)
                .key('textClock')
                .onDateChange((value: number) => {
                  this.change = 'change'
                  this.accumulateTime = value
                })
                .margin(5)
                .fontSize(20)

              Button() {
                Text('bottom')
                  .fontSize(25)
                  .fontWeight(FontWeight.Bold)
              }.type(ButtonType.Capsule)
              .margin({
                top: 10, left: 10
              })
              .onClick(() => {
                router.pushUrl({ url: 'pages/second' })
              })
            }
            // slider
            Row() {
              Slider({
                value: this.outSetValueOne,
                min: 0,
                max: 100,
                style: SliderStyle.OutSet
              })
                .showTips(true)
                .onChange((value: number, mode: SliderChangeMode) => {
                  this.outSetValueOne = value
                  console.info('value:' + value + 'mode:' + mode.toString())
                })
              // toFixed(0)将滑动条返回值处理为整数精度
              Text(this.outSetValueOne.toFixed(0)).fontSize(12)

            }
            .width('80%')
            // slider结束
            // datapanel
            DataPanel({ values: this.valueArr, max: 100, type: DataPanelType.Line }).width(300).height(10).key('dp3')
            // dataPanel结束
            // rating 评分开始
            Row() {
              Image('resources/base/media/image.png')
                .width(40)
                .height(40)
                .borderRadius(20)
                .margin({ left: 24 })
              Column() {
                Text('Yue')
                  .fontSize(16)
                  .fontColor('#182431')
                  .fontWeight(500)
                Row() {
                  Rating({ rating: 3.5, indicator: true }).margin({ top: 1, right: 8 })
                  Text('2021/06/02')
                    .fontSize(10)
                    .fontColor('#182431')
                }
              }.margin({ left: 12 }).alignItems(HorizontalAlign.Start)

              Text('1st Floor')
                .fontSize(10)
                .fontColor('#182431')
                .position({ x: 295, y: 8 })
            }.width(300).height(50).backgroundColor('#FFFFFF').margin({ top: 2 })
            // rating评分结束
          }.width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.On)
        .scrollBarColor(Color.Gray)
        .scrollBarWidth(30)
        .onScroll((xOffset: number, yOffset: number) => {
          console.info(xOffset + ' ' + yOffset)
        })
      }.width('100%').height('100%').backgroundColor(0xDCDCDC)
      Text('MainPage_End')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
  }
}

