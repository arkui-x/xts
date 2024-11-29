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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import measure from '@ohos.measure'
import deviceInfo from '@ohos.deviceInfo';
import { getResult } from '../testability/pages/Index';

const waitReadyMs_50 = 50;
const waitReadyMs_1000 = 1000;
const waitReadyMs_2000 = 2000;
const constraintWidth_150 = 150;
const fontSize_20 = 20;
const fontWeight_100 = 100;
const letterSpacing_10 = 10;
const lineHeight_34 = 34;
const baselineOffset_15 = 15;
const textCase_2 = 2;
const textIndent_100 = 100;
const maxLines_2 = 2;
const maxLines_3 = 3;
let textContentResult_width_base: Length | undefined;
let textContentResult_height_base: Length | undefined;
let constraintWidthResult_width_base: Length | undefined;
let constraintWidthResult_height_base: Length | undefined;
let fontSizeResult_width_base: Length | undefined;
let fontSizeResult_height_base: Length | undefined;
let fontStyleResult_width_base: Length | undefined;
let fontStyleResult_height_base: Length | undefined;
let fontWeightResult_width_base: Length | undefined;
let fontWeightResult_height_base: Length | undefined;
let fontFamilyResult_width_base: Length | undefined;
let fontFamilyResult_height_base: Length | undefined;
let letterSpacingResult_width_base: Length | undefined;
let letterSpacingResult_height_base: Length | undefined;
let textAlignResult_width_base: Length | undefined;
let textAlignResult_height_base: Length | undefined;
let overflowResult_width_base: Length | undefined;
let overflowResult_height_base: Length | undefined;
let maxLinesResult_width_base: Length | undefined;
let maxLinesResult_height_base: Length | undefined;
let lineHeightResult_width_base: Length | undefined;
let lineHeightResult_height_base: Length | undefined;
let baselineOffsetResult_width_base: Length | undefined;
let baselineOffsetResult_height_base: Length | undefined;
let textCaseResult_width_base: Length | undefined;
let textCaseResult_height_base: Length | undefined;
let textIndentResult_width_base: Length | undefined;
let textIndentResult_height_base: Length | undefined;
let wordBreakResult_width_base: Length | undefined;
let wordBreakResult_height_base: Length | undefined;
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function MeasureTextSizeTest() {
  describe('MeasureTextSizeTest', () => {
    beforeAll(async() => {
      await sleep(waitReadyMs_1000);
      textContentResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text.'
      }).width
      textContentResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text.'
      }).height
      constraintWidthResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text'
      }).width
      constraintWidthResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text'
      }).height
      fontSizeResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontSize: '16fp'
      }).width
      fontSizeResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontSize: '16fp'
      }).height
      fontStyleResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontStyle: FontStyle.Normal
      }).width
      fontStyleResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontStyle: FontStyle.Normal
      }).height
      fontWeightResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontWeight: FontWeight.Normal
      }).width
      fontWeightResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontWeight: FontWeight.Normal
      }).height
      fontFamilyResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontFamily: 'HarmonyOS Sans'
      }).width
      fontFamilyResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        fontFamily: 'HarmonyOS Sans'
      }).height
      letterSpacingResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        letterSpacing: 0
      }).width
      letterSpacingResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        letterSpacing: 0
      }).height
      textAlignResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        textAlign: TextAlign.Start
      }).width
      textAlignResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        textAlign: TextAlign.Start
      }).height
      overflowResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        overflow: TextOverflow.None
      }).width
      overflowResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        overflow: TextOverflow.None
      }).height
      maxLinesResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        constraintWidth: '100vp',
        maxLines: maxLines_3
      }).width
      maxLinesResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        constraintWidth: '100vp',
        maxLines: maxLines_3
      }).height
      lineHeightResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
      }).width
      lineHeightResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
      }).height
      baselineOffsetResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        baselineOffset: 0
      }).width
      baselineOffsetResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        baselineOffset: 0
      }).height
      textCaseResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        textCase: TextCase.Normal
      }).width
      textCaseResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        textCase: TextCase.Normal
      }).height
      textIndentResult_width_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        constraintWidth: constraintWidth_150,
        maxLines: maxLines_2,
        textIndent: 0
      }).width
      textIndentResult_height_base = measure.measureTextSize({
        textContent: 'This\'s a test text',
        constraintWidth: constraintWidth_150,
        maxLines: maxLines_2,
        textIndent: 0
      }).height
      wordBreakResult_width_base = measure.measureTextSize({
        textContent: 'abcdefghigklmnopqrstuvwxyz',
        constraintWidth: '100vp',
        wordBreak: WordBreak.BREAK_WORD
      }).width
      wordBreakResult_height_base = measure.measureTextSize({
        textContent: 'abcdefghigklmnopqrstuvwxyz',
        constraintWidth: '100vp',
        wordBreak: WordBreak.BREAK_WORD
      }).height
    })
    beforeEach(async() => {
      await sleep(waitReadyMs_50);
    })
    afterAll(async() => {
      await sleep(waitReadyMs_2000);
    })

    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0010
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0010', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s another test text.',
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s another test text.',
        }).height
        expect(textContentResult_width_test).assertLarger(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0010 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0020
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0020', 0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureTextSize_0020.width).assertLarger(0);
          expect(globalThis.MeasureTextSize_0020.height).assertLarger(0);
        } else {
          expect(getResult().MeasureTextSize_0020.width).assertLarger(0);
          expect(getResult().MeasureTextSize_0020.height).assertLarger(0);
        }
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0020 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0030
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0030', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text.',
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text.',
        }).height
        expect(textContentResult_width_test).assertLarger(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0030 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0040
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0040', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: 'This\’s a test text。',
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: 'This\’s a test text。',
        }).height
        expect(textContentResult_width_test).assertLarger(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0040 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0050
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0050', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: '中文文本',
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: '中文文本',
        }).height
        expect(textContentResult_width_test).assertLarger(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0050 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0060
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0060', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text.加入中文',
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text.加入中文',
        }).height
        expect(textContentResult_width_test).assertLarger(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0060 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0070
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0070', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text.加入中文与全角符号。！',
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text.加入中文与全角符号。！',
        }).height
        expect(textContentResult_width_test).assertLarger(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0070 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0080
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0080', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: '',
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: '',
        }).height
        expect(textContentResult_width_test).assertEqual(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0080 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0090
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0090', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: $r('app.media.icon'),
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: $r('app.media.icon'),
        }).height
        expect(textContentResult_width_test).assertEqual(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0090 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0100
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0100', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: null,
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: null,
        }).height
        expect(textContentResult_width_test).assertEqual(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0100 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0110
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textContent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0110', 0, async (done: Function) => {
      try {
        let textContentResult_width_test = measure.measureTextSize({
          textContent: undefined,
        }).width
        let textContentResult_height_test = measure.measureTextSize({
          textContent: undefined,
        }).height
        expect(textContentResult_width_test).assertEqual(0);
        expect(textContentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0110 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0120
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0120', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150
        }).height
        expect(constraintWidthResult_width_test).assertLarger(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0120 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0130
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0130', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150vp'
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150vp'
        }).height
        expect(constraintWidthResult_width_test).assertLarger(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0130 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0140
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0140', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150fp'
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150fp'
        }).height
        expect(constraintWidthResult_width_test).assertLarger(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0140 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0150
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0150', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150px'
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150px'
        }).height
        expect(constraintWidthResult_width_test).assertLarger(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0150 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0160
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0160', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150lpx'
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '150lpx'
        }).height
        expect(constraintWidthResult_width_test).assertLarger(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0160 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0170
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0170', 0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureTextSize_0170.width).assertLarger(0);
          expect(globalThis.MeasureTextSize_0170.height).assertLarger(0);
        } else {
          expect(getResult().MeasureTextSize_0170.width).assertLarger(0);
          expect(getResult().MeasureTextSize_0170.height).assertLarger(0);
        }
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0170 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0180
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0180', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: 0
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: 0
        }).height
        expect(constraintWidthResult_width_test).assertEqual(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0180 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0190
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0190', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: 'abc'
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: 'abc'
        }).height
        expect(constraintWidthResult_width_test).assertEqual(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0190 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0200
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0200', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '0'
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '0'
        }).height
        expect(constraintWidthResult_width_test).assertEqual(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0200 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0210
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0210', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: ''
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: ''
        }).height
        expect(constraintWidthResult_width_test).assertEqual(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0210 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0220
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0220', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: $r('app.media.icon')
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: $r('app.media.icon')
        }).height
        expect(constraintWidthResult_width_test).assertEqual(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0220 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0230
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0230', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: null
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: null
        }).height
        expect(constraintWidthResult_width_test).assertLarger(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0230 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0240
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the constraintWidth property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0240', 0, async (done: Function) => {
      try {
        let constraintWidthResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: undefined
        }).width
        let constraintWidthResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: undefined
        }).height
        expect(constraintWidthResult_width_test).assertLarger(0);
        expect(constraintWidthResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0240 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0250
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0250', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: fontSize_20
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: fontSize_20
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0250 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0260
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0260', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22fp'
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22fp'
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0260 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0270
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0270', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22vp'
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22vp'
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0270 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0280
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0280', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22px'
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22px'
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0280 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0290
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0290', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22lpx'
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '22lpx'
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0290 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0300
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0300', 0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureTextSize_0300.width).assertLarger(0);
          expect(globalThis.MeasureTextSize_0300.height).assertLarger(0);
        } else {
          expect(getResult().MeasureTextSize_0300.width).assertLarger(0);
          expect(getResult().MeasureTextSize_0300.height).assertLarger(0);
        }
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0300 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0310
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0310', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: 0
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: 0
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0310 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0320
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0320', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: -1
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: -1
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0320 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0330
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0330', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: 'abc'
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: 'abc'
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0330 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0340
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0340', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '0'
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: '0'
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0340 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0350
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0350', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: ''
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: ''
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0350 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0360
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0360', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: $r('app.media.icon')
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: $r('app.media.icon')
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0360 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0370
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0370', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: null
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: null
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0370 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0380
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontSize property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0380', 0, async (done: Function) => {
      try {
        let fontSizeResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: undefined
        }).width
        let fontSizeResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontSize: undefined
        }).height
        expect(fontSizeResult_width_test).assertLarger(0);
        expect(fontSizeResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0380 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0390
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontStyle property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0390', 0, async (done: Function) => {
      try {
        let fontStyleResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: 1
        }).width
        let fontStyleResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: 1
        }).height
        expect(fontStyleResult_width_test).assertLarger(0);
        expect(fontStyleResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0390 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0400
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontStyle property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0400', 0, async (done: Function) => {
      try {
        let fontStyleResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: 0
        }).width
        let fontStyleResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: 0
        }).height
        expect(fontStyleResult_width_test).assertLarger(0);
        expect(fontStyleResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0400 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0410
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontStyle property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0410', 0, async (done: Function) => {
      try {
        let fontStyleResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Normal
        }).width
        let fontStyleResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Normal
        }).height
        expect(fontStyleResult_width_test).assertLarger(0);
        expect(fontStyleResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0410 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0420
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontStyle property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0420', 0, async (done: Function) => {
      try {
        let fontStyleResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Italic
        }).width
        let fontStyleResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Italic
        }).height
        expect(fontStyleResult_width_test).assertLarger(0);
        expect(fontStyleResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0420 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0430
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontStyle property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0430', 0, async (done: Function) => {
      try {
        let fontStyleResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: -1
        }).width
        let fontStyleResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: -1
        }).height
        expect(fontStyleResult_width_test).assertLarger(0);
        expect(fontStyleResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0430 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0440
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontStyle property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0440', 0, async (done: Function) => {
      try {
        let fontStyleResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: null
        }).width
        let fontStyleResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: null
        }).height
        expect(fontStyleResult_width_test).assertLarger(0);
        expect(fontStyleResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0440 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0450
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontStyle property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0450', 0, async (done: Function) => {
      try {
        let fontStyleResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: undefined
        }).width
        let fontStyleResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontStyle: undefined
        }).height
        expect(fontStyleResult_width_test).assertLarger(0);
        expect(fontStyleResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0450 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0460
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0460', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: fontWeight_100
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: fontWeight_100
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0460 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0470
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0470', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: 'medium'
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: 'medium'
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0470 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0480
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0480', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Lighter
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Lighter
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0480 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0490
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0490', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Normal
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Normal
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0490 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0500
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0500', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Regular
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Regular
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0500 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0510
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0510', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Medium
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Medium
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0510 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0520
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0520', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bold
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bold
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0520 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0530
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0530', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bolder
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bolder
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0530 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0540
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0540', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: 0
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: 0
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0540 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0550
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0550', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: -1
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: -1
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0550 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0560
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0560', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: 'abc'
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: 'abc'
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0560 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0570
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0570', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: '0'
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: '0'
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0570 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0580
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0580', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: ''
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: ''
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0580 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0590
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0590', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: null
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: null
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0590 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0600
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontWeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0600', 0, async (done: Function) => {
      try {
        let fontWeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: undefined
        }).width
        let fontWeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontWeight: undefined
        }).height
        expect(fontWeightResult_width_test).assertLarger(0);
        expect(fontWeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0600 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0610
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0610', 0, async (done: Function) => {
      try {
        let fontFamilyResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: 'HarmonyOS Sans'
        }).width
        let fontFamilyResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: 'HarmonyOS Sans'
        }).height
        expect(fontFamilyResult_width_test).assertLarger(0);
        expect(fontFamilyResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0610 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0620
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0620', 0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureTextSize_0620.width).assertLarger(0);
          expect(globalThis.MeasureTextSize_0620.height).assertLarger(0);
        } else {
          expect(getResult().MeasureTextSize_0620.width).assertLarger(0);
          expect(getResult().MeasureTextSize_0620.height).assertLarger(0);
        }
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0620 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0630
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0630', 0, async (done: Function) => {
      try {
        let fontFamilyResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: 'abc'
        }).width
        let fontFamilyResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: 'abc'
        }).height
        expect(fontFamilyResult_width_test).assertLarger(0);
        expect(fontFamilyResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0630 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0640
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0640', 0, async (done: Function) => {
      try {
        let fontFamilyResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: '0'
        }).width
        let fontFamilyResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: '0'
        }).height
        expect(fontFamilyResult_width_test).assertLarger(0);
        expect(fontFamilyResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0640 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0650
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0650', 0, async (done: Function) => {
      try {
        let fontFamilyResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: ''
        }).width
        let fontFamilyResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: ''
        }).height
        expect(fontFamilyResult_width_test).assertLarger(0);
        expect(fontFamilyResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0650 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0660
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0660', 0, async (done: Function) => {
      try {
        let fontFamilyResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: $r('app.media.icon')
        }).width
        let fontFamilyResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: $r('app.media.icon')
        }).height
        expect(fontFamilyResult_width_test).assertLarger(0);
        expect(fontFamilyResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0660 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0670
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0670', 0, async (done: Function) => {
      try {
        let fontFamilyResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: null
        }).width
        let fontFamilyResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: null
        }).height
        expect(fontFamilyResult_width_test).assertLarger(0);
        expect(fontFamilyResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0670 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0680
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the fontFamily property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0680', 0, async (done: Function) => {
      try {
        let fontFamilyResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: undefined
        }).width
        let fontFamilyResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          fontFamily: undefined
        }).height
        expect(fontFamilyResult_width_test).assertLarger(0);
        expect(fontFamilyResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0680 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0690
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0690', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: letterSpacing_10
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: letterSpacing_10
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0690 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0700
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0700', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: 0
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: 0
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0700 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0710
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0710', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '0'
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '0'
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0710 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0720
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0720', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10vp'
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10vp'
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0720 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0730
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0730', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10fp'
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10fp'
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0730 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0740
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0740', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10px'
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10px'
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0740 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0750
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0750', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10lpx'
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: '10lpx'
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0750 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0760
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0760', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: 'abc'
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: 'abc'
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0760 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0770
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0770', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: ''
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: ''
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0770 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0780
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0780', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: null
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: null
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0780 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0790
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the letterSpacing property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0790', 0, async (done: Function) => {
      try {
        let letterSpacingResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: undefined
        }).width
        let letterSpacingResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          letterSpacing: undefined
        }).height
        expect(letterSpacingResult_width_test).assertLarger(0);
        expect(letterSpacingResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0790 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0800
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0800', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: 1
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: 1
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0800 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0810
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0810', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: 0
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: 0
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0810 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0820
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0820', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.Start
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.Start
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0820 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0830
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0830', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.Center
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.Center
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0830 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0840
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0840', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.End
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.End
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0840 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0850
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0850', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.JUSTIFY
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: TextAlign.JUSTIFY
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0850 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0860
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0860', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: -1
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: -1
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0860 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0870
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0870', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: null
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: null
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0870 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0880
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textAlign property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0880', 0, async (done: Function) => {
      try {
        let textAlignResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: undefined
        }).width
        let textAlignResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textAlign: undefined
        }).height
        expect(textAlignResult_width_test).assertLarger(0);
        expect(textAlignResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0880 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0890
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0890', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: 1,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: 1,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0890 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0900
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0900', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: 0,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: 0,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0900 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0910
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0910', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.None,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.None,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0910 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0920
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0920', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.Clip,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.Clip,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0920 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0930
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0930', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.Ellipsis,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.Ellipsis,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0930 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0940
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0940', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.MARQUEE,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: TextOverflow.MARQUEE,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0940 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0950
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0950', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: -1,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: -1,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0950 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0960
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0960', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: null,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: null,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0960 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0970
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the overflow property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_0970', 0, async (done: Function) => {
      try {
        let overflowResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: undefined,
        }).width
        let overflowResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          overflow: undefined,
        }).height
        expect(overflowResult_width_test).assertLarger(0);
        expect(overflowResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0970 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0980
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the maxLines property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0980', 0, async (done: Function) => {
      try {
        let maxLinesResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: 1
        }).width
        let maxLinesResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: 1
        }).height
        expect(maxLinesResult_width_test).assertLarger(0);
        expect(maxLinesResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0980 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_0990
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the maxLines property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_0990', 0, async (done: Function) => {
      try {
        let maxLinesResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: 0
        }).width
        let maxLinesResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: 0
        }).height
        expect(maxLinesResult_width_test).assertLarger(0);
        expect(maxLinesResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_0990 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1000
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the maxLines property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1000', 0, async (done: Function) => {
      try {
        let maxLinesResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: -1
        }).width
        let maxLinesResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: -1
        }).height
        expect(maxLinesResult_width_test).assertLarger(0);
        expect(maxLinesResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1000 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1010
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the maxLines property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1010', 0, async (done: Function) => {
      try {
        let maxLinesResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: null
        }).width
        let maxLinesResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: null
        }).height
        expect(maxLinesResult_width_test).assertLarger(0);
        expect(maxLinesResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1010 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1020
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the maxLines property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1020', 0, async (done: Function) => {
      try {
        let maxLinesResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: undefined
        }).width
        let maxLinesResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: '100vp',
          maxLines: undefined
        }).height
        expect(maxLinesResult_width_test).assertLarger(0);
        expect(maxLinesResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1020 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1030
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1030', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: lineHeight_34
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: lineHeight_34
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1030 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1040
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1040', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '34vp'
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '34vp'
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1040 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1050
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1050', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '34fp'
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '34fp'
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1050 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1060
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1060', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '24px'
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '24px'
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1060 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1070
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1070', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '24lpx'
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '24lpx'
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1070 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1080
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1080', 0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureTextSize_1080.width).assertLarger(0);
          expect(globalThis.MeasureTextSize_1080.height).assertLarger(0);
        } else {
          expect(getResult().MeasureTextSize_1080.width).assertLarger(0);
          expect(getResult().MeasureTextSize_1080.height).assertLarger(0);
        }
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1080 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1090
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1090', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: 0
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: 0
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1090 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1100
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1100', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: 'abc'
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: 'abc'
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1100 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1110
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1110', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '0'
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: '0'
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1110 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1120
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1120', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: ''
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: ''
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1120 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1130
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1130', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: $r('app.media.icon')
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: $r('app.media.icon')
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1130 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1140
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1140', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: null
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: null
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1140 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1150
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the lineHeight property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1150', 0, async (done: Function) => {
      try {
        let lineHeightResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: undefined
        }).width
        let lineHeightResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          lineHeight: undefined
        }).height
        expect(lineHeightResult_width_test).assertLarger(0);
        expect(lineHeightResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1150 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1160
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1160', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: baselineOffset_15
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: baselineOffset_15
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1160 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1170
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1170', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: 0
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: 0
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1170 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1180
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1180', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '0'
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '0'
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1180 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1190
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1190', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15vp'
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15vp'
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1190 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1200
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1200', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15fp'
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15fp'
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1200 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1210
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1210', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15px'
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15px'
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1210 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1220
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1220', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15lpx'
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: '15lpx'
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1220 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1230
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1230', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: 'abc'
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: 'abc'
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1230 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1240
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1240', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: ''
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: ''
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1240 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1250
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1250', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: null
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: null
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1250 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1260
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the baselineOffset property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1260', 0, async (done: Function) => {
      try {
        let baselineOffsetResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: undefined
        }).width
        let baselineOffsetResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          baselineOffset: undefined
        }).height
        expect(baselineOffsetResult_width_test).assertLarger(0);
        expect(baselineOffsetResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1260 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1270
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1270', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: textCase_2
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: textCase_2
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1270 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1280
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1280', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: 0
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: 0
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1280 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1290
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1290', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: TextCase.Normal
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: TextCase.Normal
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1290 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1300
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1300', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: TextCase.LowerCase
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: TextCase.LowerCase
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1300 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1310
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1310', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: TextCase.UpperCase
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: TextCase.UpperCase
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1310 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1320
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1320', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: -1
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: -1
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1320 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1330
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1330', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: null
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: null
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1330 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1340
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textCase property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1340', 0, async (done: Function) => {
      try {
        let textCaseResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: undefined
        }).width
        let textCaseResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          textCase: undefined
        }).height
        expect(textCaseResult_width_test).assertLarger(0);
        expect(textCaseResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1340 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1350
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1350', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: textIndent_100
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: textIndent_100
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1350 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1360
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1360', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: 0
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: 0
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1360 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1370
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1370', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '0'
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '0'
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1370 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1380
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1380', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '120vp'
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '120vp'
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1380 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1390
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1390', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '120fp'
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '120fp'
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1390 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1400
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1400', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '140px'
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '140px'
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1400 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1410
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1410', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '140lpx'
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: '140lpx'
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1410 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1420
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1420', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: -10
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: -10
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1420 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1430
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1430', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: 'abc'
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: 'abc'
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1430 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1440
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1440', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: ''
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: ''
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1440 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1450
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1450', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: null
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: null
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1450 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1460
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the textIndent property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1460', 0, async (done: Function) => {
      try {
        let textIndentResult_width_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: undefined
        }).width
        let textIndentResult_height_test = measure.measureTextSize({
          textContent: 'This\'s a test text',
          constraintWidth: constraintWidth_150,
          maxLines: maxLines_2,
          textIndent: undefined
        }).height
        expect(textIndentResult_width_test).assertLarger(0);
        expect(textIndentResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1460 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1470
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the wordBreak property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1470', 0, async (done: Function) => {
      try {
        let wordBreakResult_width_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: WordBreak.NORMAL
        }).width
        let wordBreakResult_height_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: WordBreak.NORMAL
        }).height
        expect(wordBreakResult_width_test).assertLarger(0);
        expect(wordBreakResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1470 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1480
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the wordBreak property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1480', 0, async (done: Function) => {
      try {
        let wordBreakResult_width_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: WordBreak.BREAK_ALL
        }).width
        let wordBreakResult_height_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: WordBreak.BREAK_ALL
        }).height
        expect(wordBreakResult_width_test).assertLarger(0);
        expect(wordBreakResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1480 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1490
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the wordBreak property of the measureTextSize
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureTextSize_Func_1490', 0, async (done: Function) => {
      try {
        let wordBreakResult_width_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: WordBreak.BREAK_WORD
        }).width
        let wordBreakResult_height_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: WordBreak.BREAK_WORD
        }).height
        expect(wordBreakResult_width_test).assertLarger(0);
        expect(wordBreakResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1490 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1500
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the wordBreak property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1500', 0, async (done: Function) => {
      try {
        let wordBreakResult_width_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: null
        }).width
        let wordBreakResult_height_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: null
        }).height
        expect(wordBreakResult_width_test).assertLarger(0);
        expect(wordBreakResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1500 error' + err);
        done();
      }
    });
    /**
     * @tc.number : SUB_Measure_measureTextSize_Func_1510
     * @tc.name   : MeasureTextSize
     * @tc.desc   : Test the wordBreak property of the measureTextSize
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureTextSize_Func_1510', 0, async (done: Function) => {
      try {
        let wordBreakResult_width_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: undefined
        }).width
        let wordBreakResult_height_test = measure.measureTextSize({
          textContent: 'abcdefghigklmnopqrstuvwxyz',
          constraintWidth: '100vp',
          wordBreak: undefined
        }).height
        expect(wordBreakResult_width_test).assertLarger(0);
        expect(wordBreakResult_height_test).assertLarger(0);
        done();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureTextSize_Func_1510 error' + err);
        done();
      }
    });
  })
}
