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

import router from '@ohos.router';
import { Router } from '@ohos.arkui.UIContext'

@Entry
@Component
struct Index {
  router: Router = this.getUIContext().getRouter()

  build() {
    Row() {
      Column() {
        Button('return_index')
          .id('return_index')
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.back()
          })

        Button('TestNetErrorLIst1')
          .id("TestNetErrorLIst1")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst1'
            })
          })

        Button('TestNetErrorLIst2')
          .id("TestNetErrorLIst2")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst2'
            })
          })
        Button('TestNetErrorLIst3')
          .id("TestNetErrorLIst3")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst3'
            })
          })
        Button('TestNetErrorLIst4')
          .id("TestNetErrorLIst4")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst4'
            })
          })
        Button('TestNetErrorLIst5')
          .id("TestNetErrorLIst5")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
           this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst5'
            })
          })

        Button('TestNetErrorLIst6')
          .id("TestNetErrorLIst6")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst6'
            })
          })
        Button('TestNetErrorLIst7')
          .id("TestNetErrorLIst7")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst7'
            })
          })
        Button('TestNetErrorLIst8')
          .id("TestNetErrorLIst8")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst8'
            })
          })
        Button('TestNetErrorLIst9')
          .id("TestNetErrorLIst9")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst9'
            })
          })
        Button('TestNetErrorLIst10')
          .id("TestNetErrorLIst10")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst10'
            })
          })
        Button('TestNetErrorLIst11')
          .id("TestNetErrorLIst11")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst11'
            })
          })
        Button('TestNetErrorLIst12')
          .id("TestNetErrorLIst12")
          .width('75%')
          .height(30)
          .fontSize(15)
          .margin(5)
          .onClick(() => {
            this.router.pushUrl({
              url: 'pages/TestNetErrorLIst/TestNetErrorLIst12'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}