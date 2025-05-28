/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { Router } from '@ohos.arkui.UIContext'
import router from '@ohos.router';

@Entry
@Component
struct Index {
  test: router.RouterMode = router.RouterMode.Standard;
  @State router: Router = this.getUIContext().getRouter();

  build() {
    Row() {
      Scroll() {
        Column({ space: 10 }) {
          Text('WebViewJS Test')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 30, bottom: 30 })

          Button('RegisterJSProxy_SyncMethod_Function')
            .id('RegisterJSProxy_SyncMethod_Function')
            .width("90%")
            .height(34)
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/RegisterJSProxy_SyncMethod_Function"
              })
            })

          Button('RegisterJSProxy_AsyncMethod_Function')
            .id('RegisterJSProxy_AsyncMethod_Function')
            .width("90%")
            .height(34)
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/RegisterJSProxy_AsyncMethod_Function"
              })
            })

          Button('RegisterJSProxy_Function_Exception')
            .id('RegisterJSProxy_Function_Exception')
            .width("90%")
            .height(34)
            .backgroundColor(Color.Orange)
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/RegisterJSProxy_Function_Exception"
              })
            })

          Button('RegisterJSProxy_SyncMethod_Component')
            .id('RegisterJSProxy_SyncMethod_Component')
            .width("90%")
            .height(34)
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/RegisterJSProxy_SyncMethod_Component"
              })
            })

          Button('RegisterJSProxy_AsyncMethod_Component')
            .id('RegisterJSProxy_AsyncMethod_Component')
            .width("90%")
            .height(34)
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/RegisterJSProxy_AsyncMethod_Component"
              })
            })

          Button('DeleteJSRegister_Function')
            .id('DeleteJSRegister_Function')
            .width("90%")
            .height(34)
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/DeleteJSRegister_Function"
              })
            })

          Button('DeleteJSRegister_Function_Exception')
            .id('DeleteJSRegister_Function_Exception')
            .width("90%")
            .height(34)
            .backgroundColor(Color.Orange)
            .onClick(() => {
              this.router.pushUrl({
                url: "pages/DeleteJSRegister_Function_Exception"
              })
            })

        }
        .width('100%')
      }
    }
    .height('100%')
  }
}