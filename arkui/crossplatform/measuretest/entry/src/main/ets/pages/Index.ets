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
  build() {
    Row() {
      Column() {
        Flex() {
          Text('measureText_0020: ')
          Text('' + measure.measureText({
            textContent: $r('app.string.my_textContent')
          }))
            .id('SUB_Measure_measureText_Func_0020:textContentResult_test')
        }
        Flex() {
          Text('measureText_0170: ')
          Text('' + measure.measureText({
            textContent: 'This\'s a test text',
            fontSize: $r('app.string.my_fontSize')
          }))
            .id('SUB_Measure_measureText_Func_0170:fontSizeResult_test')
        }
        Flex() {
          Text('measureText_0490: ')
          Text('' + measure.measureText({
            textContent: 'This\'s a test text',
            fontFamily: $r('app.string.my_fontFamily')
          }))
            .id('SUB_Measure_measureText_Func_0490:fontFamilyResult_test')
        }

        Flex() {
          Text('measureTextSize_0020: ')
          Text('' + measure.measureTextSize({
            textContent: $r('app.string.my_textContent')
          }).width)
            .id('SUB_Measure_measureTextSize_Func_0020:textContentResult_width_test')
          Text(', ')
          Text('' + measure.measureTextSize({
            textContent: $r('app.string.my_textContent')
          }).height)
            .id('SUB_Measure_measureTextSize_Func_0020:textContentResult_height_test')
        }
        Flex() {
          Text('measureTextSize_0170: ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            constraintWidth: $r('app.string.my_constraintWidth')
          }).width)
            .id('SUB_Measure_measureTextSize_Func_0170:constraintWidthResult_width_test')
          Text(', ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            constraintWidth: $r('app.string.my_constraintWidth')
          }).height)
            .id('SUB_Measure_measureTextSize_Func_0170:constraintWidthResult_height_test')
        }
        Flex() {
          Text('measureTextSize_0300: ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            fontSize: $r('app.string.my_fontSize')
          }).width)
            .id('SUB_Measure_measureTextSize_Func_0300:fontSizeResult_width_test')
          Text(', ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            fontSize: $r('app.string.my_fontSize')
          }).height)
            .id('SUB_Measure_measureTextSize_Func_0300:fontSizeResult_height_test')
        }
        Flex() {
          Text('measureTextSize_0620: ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            fontFamily: $r('app.string.my_fontFamily')
          }).width)
            .id('SUB_Measure_measureTextSize_Func_0620:fontFamilyResult_width_test')
          Text(', ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            fontFamily: $r('app.string.my_fontFamily')
          }).height)
            .id('SUB_Measure_measureTextSize_Func_0620:fontFamilyResult_height_test')
        }
        Flex() {
          Text('measureTextSize_1080: ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            lineHeight: $r('app.string.my_lineHeight')
          }).width)
            .id('SUB_Measure_measureTextSize_Func_1080:lineHeightResult_width_test')
          Text(', ')
          Text('' + measure.measureTextSize({
            textContent: 'This\'s a test text',
            lineHeight: $r('app.string.my_lineHeight')
          }).height)
            .id('SUB_Measure_measureTextSize_Func_1080:lineHeightResult_height_test')
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}