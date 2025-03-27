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
struct Page3 {
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

        Button('ReplaceUrl_TwoParameter_Callback:Page4')
          .id('ReplaceUrl_TwoParameter_Callback:Page4')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/combine/Page4'
              }, router.RouterMode.Standard, (err) => {
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

      }
      .width('100%')
    }
    .height('100%')
  }
}