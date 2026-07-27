/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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
struct SslErrorInvalid {
  @State invalidValue: string = '' + SslError.Invalid;
  @State checkResult: string = SslError.Invalid === 0 ? '✅ 通过' : '❌ 失败';
  @State checkColor: string = SslError.Invalid === 0 ? '#2AAE67' : '#E84026';

  build() {
    Column({ space: 16 }) {
      // 返回
      Row() {
        Row({ space: 4 }) {
          Text('←').fontSize(14).fontColor('#FFFFFF')
          Text('返回').fontSize(14).fontColor('#FFFFFF')
        }
        .padding({
          left: 14,
          right: 16,
          top: 6,
          bottom: 6
        })
        .backgroundColor('#999999')
        .borderRadius(6)
        .id('sslErrorBack')
        .onClick(() => {
          router.back();
        })
      }
      .width('100%')

      // 标题
      Text('SslError.Invalid')
        .fontSize(26).fontWeight(FontWeight.Bold).fontColor('#1A1A1A').width('100%')

      // 枚举值卡片
      Column({ space: 6 }) {
        Text('枚举值').fontSize(12).fontColor('#999999').width('100%')
        Text(this.invalidValue)
          .id('invalidValue')
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0A59F7')
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: '#E5EAF0' })

      // 验证结果卡片
      Column({ space: 6 }) {
        Text('SslError.Invalid === 0').fontSize(12).fontColor('#999999').width('100%')
        Text(this.checkResult)
          .id('checkResult')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checkColor)
          .width('100%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: this.checkColor })
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F9FC')
  }
}
