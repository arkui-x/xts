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

import router from '@ohos.router';

@Entry
@Component

struct Index {
  @State tempResult: string = '';
  build() {
    Row() {
      Scroll() {
        Column() {

          Text('Sample Xcomponent')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
          Button('Test Surface mode')
            .fontSize(20)
            .width('80%')
            .height(50)
            .margin({ top: 15, bottom: 15 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/TestSurface' });
            })
        }
        .width('100%')
      }.scrollBar(BarState.Off)
    }
    .height('100%')
  }
}