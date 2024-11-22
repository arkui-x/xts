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
import promptAction from '@ohos.promptAction';

@Entry
@Component
struct TestSurface {
  @State getMsg: string = ""
  @State angleArray: Array<number> = new Array<number>();
  private xcomponentId: string = 'xcomponent_napi';
  private panOption: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.All });
  private xcomponentController: XComponentController = new XComponentController()
  @State testSurfaceId: string = '';
  @State XComponentProperty: string = '';
  @State Context: string = '';
  scroller: Scroller = new Scroller()

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
            controller: this.xcomponentController
          })
            .width('400px')
            .height('400px')
            .onLoad(() => {
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


        Button('GetXComponentContext')
          .id('GetXComponentContext')
          .onClick(() => {
            let result = (this.xcomponentController.getXComponentContext() != null)
            this.getMsg += 'getXComponentContextResult:' + result + '\n';
            this.getMsg += 'getXComponentContext:' + this.xcomponentId + '\n';
            this.XComponentProperty = this.xcomponentId;
          })
      }.width("50%")

    }.size({ width: '100%', height: '100%' })
  }
}