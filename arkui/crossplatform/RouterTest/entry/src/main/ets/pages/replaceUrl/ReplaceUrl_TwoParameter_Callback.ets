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
struct ReplaceUrl_callback {
  @State router: Router = this.getUIContext().getRouter();
  @State params: string = "";
  @State length: string = "";
  @State errcode: string = "";

  build() {
    Row() {
      Column() {
        Text('Params: ' + this.params)
          .id('Params')
          .fontSize(12)

        Text('StackLength: ' + this.length)
          .id('StackLength')
          .fontSize(12)

        Text('PageName: ' + this.router.getState().name)
          .id('PageName')
          .fontSize(12)

        Text('Errcode: ' + this.errcode)
          .id('Errcode')
          .fontSize(12)
          .margin({ bottom: 4 })

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

        Button('ReplaceUrl_TestPage page')
          .id('ReplaceUrl_TestPage page')
          .width('60%')
          .height(18)
          .onClick(async () => {
            this.router.pushUrl({
              url: 'pages/replaceUrl/TestPage'
            })
          })
          .margin({ bottom: 4 })

        Button('ReplaceUrl_TwoParameter_Url:TestPage')
          .id('ReplaceUrl_TwoParameter_Url:TestPage')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/replaceUrl/TestPage'
              }, router.RouterMode.Standard, (err) => {
                if (err) {
                  console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
              });
            } catch (err) {
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('ReplaceUrl_TwoParameter_Url:/')
          .id('ReplaceUrl_TwoParameter_Url:/')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: '/'
              }, router.RouterMode.Standard, (err) => {
                if (err) {
                  console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
              });
            } catch (err) {
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('ReplaceUrl_TwoParameter_Url:NotExistPage')
          .id('ReplaceUrl_TwoParameter_Url:NotExistPage')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/replaceUrl/NotExistPage'
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

        Button('ReplaceUrl_TwoParameter_Url:""')
          .id('ReplaceUrl_TwoParameter_Url:""')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: ''
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

        Button('ReplaceUrl_TwoParameter_Url:null')
          .id('ReplaceUrl_TwoParameter_Url:null')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: null
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

        Button('ReplaceUrl_TwoParameter_Url:undefined')
          .id('ReplaceUrl_TwoParameter_Url:undefined')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: undefined
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
          .margin({ bottom: 8 })

        Button('ReplaceUrl_TwoParameter_Params:message')
          .id('ReplaceUrl_TwoParameter_Params:message')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/replaceUrl/TestPage',
                params: {
                  data: 'The message from ReplaceUrl_TwoParameter_Callback page'
                }
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

        Button('ReplaceUrl_TwoParameter_Params:null')
          .id('ReplaceUrl_TwoParameter_Params:null')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/replaceUrl/TestPage',
                params: null
              }, router.RouterMode.Standard, (err) => {
                if (err) {
                  console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
              });
            } catch (err) {
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('ReplaceUrl_TwoParameter_Params:undefined')
          .id('ReplaceUrl_TwoParameter_Params:undefined')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/replaceUrl/TestPage',
                params: undefined
              }, router.RouterMode.Standard, (err) => {
                if (err) {
                  console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
              });
            } catch (err) {
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('ReplaceUrl_TwoParameter_RouterMode:Standard')
          .id('ReplaceUrl_TwoParameter_RouterMode:Standard')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/replaceUrl/TestPage',
                params: {
                  data: 'The message from ReplaceUrl_TwoParameter_Callback page'
                }
              }, router.RouterMode.Standard, (err) => {
                if (err) {
                  console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
              });
            } catch (err) {
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('ReplaceUrl_TwoParameter_RouterMode:Single')
          .id('ReplaceUrl_TwoParameter_RouterMode:Single')
          .height(18)
          .width('90%')
          .fontSize(14)
          .onClick(async () => {
            try {
              this.router.replaceUrl({
                url: 'pages/replaceUrl/TestPage',
                params: {
                  data: 'The message from ReplaceUrl_TwoParameter_Callback page'
                }
              }, router.RouterMode.Single, (err) => {
                if (err) {
                  console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
                  return;
                }
              });
            } catch (err) {
              console.error(`replaceUrl failed, code is ${err.code}, message is ${err.message}`);
            }
          })
          .margin({ bottom: 4 })

        Button('back')
          .id('back')
          .width('40%')
          .height(18)
          .fontSize(14)
          .onClick(async () => {
            this.router.back()
          })
          .margin({ bottom: 4 })

      }
      .width('100%')
    }
    .height('100%')
  }
}