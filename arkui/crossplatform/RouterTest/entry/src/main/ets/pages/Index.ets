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
struct Index {
  @State router: Router = this.getUIContext().getRouter();
  @State params: string = "";
  @State length: string = "";
  @State errCode: string = "";

  build() {
    Row() {
      Scroll() {
        Column() {
          Text('Params: ' + this.params)
            .id('Params')
            .fontSize(16)

          Text('StackLength: ' + this.length)
            .id('StackLength')
            .fontSize(16)

          Text('PageName: ' + this.router.getState().name)
            .id('PageName')
            .fontSize(16)

          Text('ErrCode: ' + this.errCode)
            .id('ErrCode')
            .fontSize(16)
            .margin({ bottom: 5 })

          Button('getPageInfo')
            .id('getPageInfo')
            .width('80%')
            .height(20)
            .onClick(async () => {
              if (this.router.getParams() !== undefined) {
                this.params = (this.router.getParams() as Record<string, string>)["data"];
              } else {
                this.params = "";
              }
              this.length = this.router.getLength();
            })
            .margin({ bottom: 4 })

          Button('ReplaceUrl_OneParameter_Promise page')
            .id('ReplaceUrl_OneParameter_Promise page')
            .width('80%')
            .height(20)
            .onClick(async () => {
              await this.router.pushUrl({
                url: 'pages/replaceUrl/ReplaceUrl_OneParameter_Promise'
              })
            })
            .margin({ bottom: 5 })

          Button('ReplaceUrl_OneParameter_Callback page')
            .id('ReplaceUrl_OneParameter_Callback page')
            .width('80%')
            .height(20)
            .onClick(async () => {
              await this.router.pushUrl({
                url: 'pages/replaceUrl/ReplaceUrl_OneParameter_Callback'
              })
            })
            .margin({ bottom: 5 })

          Button('ReplaceUrl_TwoParameter_Promise page')
            .id('ReplaceUrl_TwoParameter_Promise page')
            .width('80%')
            .height(20)
            .onClick(async () => {
              await this.router.pushUrl({
                url: 'pages/replaceUrl/ReplaceUrl_TwoParameter_Promise'
              })
            })
            .margin({ bottom: 5 })

          Button('ReplaceUrl_TwoParameter_Callback page')
            .id('ReplaceUrl_TwoParameter_Callback page')
            .width('80%')
            .height(20)
            .onClick(async () => {
              await this.router.pushUrl({
                url: 'pages/replaceUrl/ReplaceUrl_TwoParameter_Callback'
              })
            })
            .margin({ bottom: 5 })

          Button('BackPage page')
            .id('BackPage page')
            .width('80%')
            .height(20)
            .onClick(async () => {
              await this.router.pushUrl({
                url: 'pages/back/BackPage'
              })
            })
            .margin({ bottom: 5 })
      
        }
        .width('100%')
      }
      .height('80%')
    }
    .height('100%')
  }
}