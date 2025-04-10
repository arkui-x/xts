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

@Entry
@Component
struct Page1 {
  @State router: Router = this.getUIContext().getRouter();
  @State errcode: string = "";

  build() {
    Row() {
      Column() {
        Text('PageName: ' + this.router.getState().name)
          .id('PageName')
          .fontSize(16)

        Text('Errcode: ' + this.errcode)
          .id('Errcode')
          .fontSize(12)
          .margin({ bottom: 4 })

        Button('ReplaceUrl_OneParameter_Callback:Page2')
          .id('ReplaceUrl_OneParameter_Callback:Page2')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/combine/Page2'
              }, (err) => {
                if (err) {
                  this.errcode = "" + err.code;
                  console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
              });
            } catch (err) {
              this.errcode = err.code;
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('Push:Page2')
          .id('Push:Page2')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              await this.router.pushUrl({
                url: 'pages/combine/Page2'
              })
            } catch (err) {
              this.errcode = err.code;
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('Back_OneParameter:Index')
          .id('Back_OneParameter:Index')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.back({
                url: 'pages/Index'
              });
            } catch (err) {
              this.errcode = err.code;
              console.error(`back failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

      }
      .width('100%')
    }
    .height('100%')
  }
}