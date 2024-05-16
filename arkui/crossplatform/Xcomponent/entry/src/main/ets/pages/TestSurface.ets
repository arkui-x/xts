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

import { Logger } from '../utils/Logger';
import router from '@ohos.router';
import { XcomponentNapiObject } from 'libxcomponent_napi.so'
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct TestSurface {
  @State getMsg: string = ""
  @State angleArray: Array<number> = new Array<number>();
  @State shaftRotation: string = '';
  private xcomponentId: string = 'xcomponent_napi';
  private panOption: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.All });
  @State nativeContext: XcomponentNapiObject = null;
  private xcomponentController: XComponentController = new XComponentController()
  @State testSurfaceId: string = '';
  @State testGetContextResult: string = '';
  @State testWidth: number = -1;
  @State testHeight: number = -1;
  @State testOffsetX: number = -1;
  @State testOffsetY: number = -1;
  @State testTouchInfo: string = '';
  @State XComponentProperty: string = '';
  scroller: Scroller = new Scroller()
  @State XComponentSize: SizeOptions = { width: 0, height: 0 }
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State GetFocus: string = '';
  @State LostFocus: string = '';

  async aboutToAppear() {
    Logger.info('aboutToAppear');
    this.angleArray[0] = 30;
    this.angleArray[1] = 45;
  }

  build() {
    Row() {
      Column() {
        Column() {
          XComponent({
            id: this.xcomponentId,
            type: 'surface',
            libraryname: 'xcomponent_napi',
            controller: this.xcomponentController
          })
            .width('400px')
            .height('400px')
            .id('xComponent')
            .backgroundColor(Color.Yellow)
            .onLoad((context: XcomponentNapiObject) => {
              this.nativeContext = context;

              Logger.info('====Test:onLoad==');
              this.getMsg += "onload:已加载 \n"
              this.XComponentProperty = "onload:已加载"
              promptAction.showToast({
                message: "XComponent onLoad",
                duration: 1000,
                bottom: "30%",
              })
            })
            .onDestroy(() => {
              this.XComponentProperty = "onDestroy:已加载"
              Logger.info('====Test:onDestroy==');
              promptAction.showToast({
                message: "XComponent onDestroy",
                duration: 1000,
                bottom: "30%",
              })
            })
        }
        .justifyContent(FlexAlign.SpaceAround)
        .gesture(
          PanGesture(this.panOption)
            .onActionStart((event: GestureEvent) => {
              Logger.info('Gesture onActionStart');
            })
            .onActionUpdate((event: GestureEvent) => {
              this.angleArray = this.nativeContext.updateAngle(event.offsetX, event.offsetY);
              Logger.info('Gesture onActionUpdate : offSet ' + event.offsetX + ',' + event.offsetY);
            })
            .onActionEnd(() => {
              Logger.info('Gesture onActionEnd');
            })
        )

        Column() {
          Row() {
            Text('Log').fontColor(0x000000).width('60%').height(30).fontSize(20)
            Button() {
              Text('clear')
                .fontSize(10)
                .fontColor('#F1F3F5')
                .fontWeight(30)
            }
            .type(ButtonType.Capsule)
            .backgroundColor('#0D9FFB')
            .width('20%')
            .height(30)
            .fontSize(15)
            .onClick(() => {
              this.getMsg = ''
            })
          }.size({ width: '90%', height: 35 })

          Column() {
            Scroll(this.scroller) {
              Column() {
                Text(this.getMsg).fontSize(15)
              }
            }.scrollBar(BarState.Off)
          }
          .height(100)
          .width('90%')
          .backgroundColor(Color.Blue)
        }
        .size({ width: '90%', height: 140 })
        .backgroundColor('blue')
        .borderRadius(24)

        Text('' + this.XComponentProperty)
          .id('result')
        Text('' + this.XComponentSize.height)
          .id('XComponentHeight')
        Text('' + this.XComponentSize.width)
          .id('XComponentWidth')
        Text('' + this.offsetX)
          .id('XComponentOffsetX')
        Text('' + this.offsetY)
          .id('XComponentOffsetY')
      }.width('50%')

      Column() {
        Button('onDestroy')
          .id('onDestroy')
          .onClick(() => {
            router.back({
              url: "pages/Index",
            })
          })

        Text('XComponent Common事件')
          .fontSize(12)
          .fontFamily('HarmonyHeiTi-Bold')
        Button('GetXComponentSurfaceId')
          .id('GetXComponentSurfaceId')
          .onClick(() => {
            this.testSurfaceId = this.xcomponentController.getXComponentSurfaceId();
            this.getMsg += 'SurfaceId:' + this.testSurfaceId + '\n';
            this.XComponentProperty = this.testSurfaceId;
          })

        Button('GetXComponentSize')
          .id('GetXComponentSize')
          .onClick(() => {
            this.testWidth = this.nativeContext.GetXComponentSize_Width();
            this.testHeight = this.nativeContext.GetXComponentSize_Height();
            this.getMsg += 'Size:' + this.testWidth + '*' + this.testHeight + '\n';
            this.XComponentSize.width = this.testWidth;
            this.XComponentSize.height = this.testHeight;
          })

        Button('GetXComponentContext')
          .id('GetXComponentContext')
          .onClick(() => {
            let mycontext: XcomponentNapiObject = this.xcomponentController.getXComponentContext();
            this.testGetContextResult = mycontext.GetXComponentId();
            this.getMsg += 'Context:' + mycontext.GetXComponentId() + '\n';
            this.XComponentProperty = mycontext.GetXComponentId();
          })

        Button('GetXComponentOffset')
          .id('GetXComponentOffset')
          .onClick(() => {
            this.testOffsetX = this.nativeContext.GetXComponentOffset_x();
            this.testOffsetY = this.nativeContext.GetXComponentOffset_y();
            this.getMsg += 'Offset:' + '[' + this.testOffsetX + ',' + this.testOffsetY + ']' + '\n';
            this.offsetX += this.testOffsetX;
            this.offsetY += this.testOffsetY;
          })

        Text('XComponent 触摸事件')
          .fontSize(12)
          .fontFamily('HarmonyHeiTi-Bold')
        Button('GetXComponent_TouchEvent')
          .id('GetXComponent_TouchEvent')
          .onClick(() => {
            if (this.nativeContext.GetXComponent_TouchEvent()) {
              this.testTouchInfo = this.nativeContext.GetXComponent_TouchEvent().touchInfo;
              this.getMsg += "---------------------------- \n";
              this.getMsg += 'TouchEvent:' + this.testTouchInfo + '\n';
              this.XComponentProperty = "TouchEvent success";
            } else {
              this.XComponentProperty = "未获取TouchEvent";
              promptAction.showToast({
                message: "未获取TouchEvent，请滑动上面xcompoment组件 （三棱锥视图）后在点击此按钮获取touch事件~",
                duration: 1000,
                bottom: "30%",
              })
            }
          })
      }.width("50%")

    }.size({ width: '100%', height: '100%' })
  }
}