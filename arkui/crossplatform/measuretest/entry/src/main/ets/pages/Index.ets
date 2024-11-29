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
import measure from '@ohos.measure'

@Entry
@Component
struct Index {
  async aboutToAppear() {
    globalThis.MeasureText_0020 = measure.measureText({
      textContent: $r('app.string.my_textContent')
    });
    globalThis.MeasureText_0170 = measure.measureText({
      textContent: 'This\'s a test text',
      fontSize: $r('app.string.my_fontSize')
    });
    globalThis.MeasureText_0490 = measure.measureText({
      textContent: 'This\'s a test text',
      fontFamily: $r('app.string.my_fontFamily')
    });
    globalThis.MeasureTextSize_0020 = measure.measureTextSize({
      textContent: $r('app.string.my_textContent')
    });
    globalThis.MeasureTextSize_0170 = measure.measureTextSize({
      textContent: 'This\'s a test text',
      constraintWidth: $r('app.string.my_constraintWidth')
    });
    globalThis.MeasureTextSize_0300 = measure.measureTextSize({
      textContent: 'This\'s a test text',
      fontSize: $r('app.string.my_fontSize')
    });
    globalThis.MeasureTextSize_0620 = measure.measureTextSize({
      textContent: 'This\'s a test text',
      fontFamily: $r('app.string.my_fontFamily')
    });
    globalThis.MeasureTextSize_1080 = measure.measureTextSize({
      textContent: 'This\'s a test text',
      lineHeight: $r('app.string.my_lineHeight')
    });
  }
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}
