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

import font from '@ohos.font';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear() {
    font.registerFont({
      familyName: 'test_01',
      familySrc: '/font/test_03.ttf'
    })
    font.registerFont({
      familyName: $r('app.string.fontName02'),
      familySrc: $rawfile('test_02.ttf')
    })
    font.registerFont({
      familyName: 'test_03',
      familySrc: $rawfile('test_01.ttf')
    })
    font.registerFont({
      familyName: 'test_04',
      familySrc: $r('app.string.fontSrc04')
    })

    font.registerFont({
      familyName: '',
      familySrc: $rawfile('test_01.ttf')
    })
    font.registerFont({
      familyName: null,
      familySrc: $rawfile('test_01.ttf')
    })
    font.registerFont({
      familyName: undefined,
      familySrc: $rawfile('test_01.ttf')
    })
    font.registerFont({
      familyName: $r('app.color.color'),
      familySrc: $rawfile('test_01.ttf')
    })
    font.registerFont({
      familyName: $r('app.media.icon'),
      familySrc: $rawfile('test_01.ttf')
    })
    font.registerFont({
      familyName: $rawfile('test_01.ttf'),
      familySrc: $rawfile('test_01.ttf')
    })

    font.registerFont({
      familyName: 'test_21',
      familySrc: '123456ABAC'
    })
    font.registerFont({
      familyName: 'test_21',
      familySrc: ''
    })
    font.registerFont({
      familyName: 'test_21',
      familySrc: null
    })
    font.registerFont({
      familyName: 'test_21',
      familySrc: undefined
    })
    font.registerFont({
      familyName: 'test_21',
      familySrc: $r('app.color.color')
    })
    font.registerFont({
      familyName: 'test_21',
      familySrc: $r('app.media.icon')
    })
    font.registerFont({
      familyName: 'test_21',
      familySrc: $rawfile('icon.png')
    })
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(10)
          .id('text01')
          .fontFamily('test_01')
        Text(this.message)
          .fontSize(10)
          .id('text02')
          .fontFamily('test_02')
        Text(this.message)
          .fontSize(10)
          .id('text03')
          .fontFamily('test_03')
        Text(this.message)
          .fontSize(10)
          .id('text04')
          .fontFamily('test_04')


        Text(this.message)
          .fontSize(10)
          .id('text11')
          .fontFamily('')
        Text(this.message)
          .fontSize(10)
          .id('text12')
          .fontFamily(null)
        Text(this.message)
          .fontSize(10)
          .id('text13')
          .fontFamily(undefined)
        Text(this.message)
          .fontSize(10)
          .id('text14')
          .fontFamily($r('app.color.color'))
        Text(this.message)
          .fontSize(10)
          .id('text15')
          .fontFamily($r('app.media.icon'))
        Text(this.message)
          .fontSize(10)
          .id('text16')
          .fontFamily($rawfile('test_01.ttf'))


        Text(this.message)
          .fontSize(10)
          .id('text21')
          .fontFamily('test_21')
        Text(this.message)
          .fontSize(10)
          .id('text22')
          .fontFamily('test_21')
        Text(this.message)
          .fontSize(10)
          .id('text23')
          .fontFamily('test_21')
        Text(this.message)
          .fontSize(10)
          .id('text24')
          .fontFamily('test_21')
        Text(this.message)
          .fontSize(10)
          .id('text25')
          .fontFamily('test_21')
        Text(this.message)
          .fontSize(10)
          .id('text26')
          .fontFamily('test_21')
        Text(this.message)
          .fontSize(10)
          .id('text27')
          .fontFamily('test_21')
      }
      .width('100%')
    }
    .height('100%')
  }
}