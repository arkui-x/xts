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
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import { DisplayRotation, Driver, MatchPattern, ON, ResizeDirection, WindowMode } from '@ohos.UiTest'
import Want from '@ohos.app.ability.Want';
import measure from '@ohos.measure'

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const waitReadyMs_100 = 100;
const waitReadyMs_1000 = 1000;
const fontSize_20 = 20;
const fontWeight_100 = 100;
const letterSpacing_10 = 10;
let driver = Driver.create();
let textContentResult_base: number;
let fontSizeResult_base: number;
let fontStyleResult_base: number;
let fontWeightResult_base: number;
let fontFamilyResult_base: number;
let letterSpacingResult_base: number;

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };
  await delegator.startAbility(want).then(result => {
    console.info(`MeasureTest, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`MeasureTest, start abilityFailed: ${err}`)
  })
  await sleep(waitReadyMs_100);
}

export default function MeasureTextTest() {
  beforeAll(async() => {
    await startAbility('com.example.measuretest', 'EntryAbility');
    await sleep(waitReadyMs_1000);
    textContentResult_base = measure.measureText({
      textContent: 'This\'s a test text.'
    })
    fontSizeResult_base = measure.measureText({
      textContent: 'This\'s a test text',
      fontSize: '16fp'
    })
    fontStyleResult_base = measure.measureText({
      textContent: 'This\'s a test text',
      fontStyle: FontStyle.Normal
    })
    fontWeightResult_base = measure.measureText({
      textContent: 'This\'s a test text',
      fontWeight: FontWeight.Normal
    })
    fontFamilyResult_base = measure.measureText({
      textContent: 'This\'s a test text',
      fontFamily: 'HarmonyOS Sans'
    })
    letterSpacingResult_base = measure.measureText({
      textContent: 'This\'s a test text',
      letterSpacing: 0
    })
  })
  beforeEach(async() => {
    await sleep(waitReadyMs_100);
  })

  describe('MeasureTextTest', () => {
    /**
     * @tc.number : SUB_Measure_measureText_Func_0010
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0010', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s another test text.',
        })
        expect(textContentResult_test).assertLarger(textContentResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0010 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0020
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0020', 0, async (done: Function) => {
      let text = await driver.findComponent(ON.id('SUB_Measure_measureText_Func_0020:textContentResult_test'));
      try {
        let textContentResult_test = Number(await text.getText());
        expect(textContentResult_test).assertLarger(textContentResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0020 error' + err.code);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0030
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0030', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s a test text.',
        })
        expect(textContentResult_test).assertEqual(textContentResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0030 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0040
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0040', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\’s a test text。',
        })
        expect(textContentResult_test).assertLarger(textContentResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0040 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0050
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0050', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: '中文文本',
        })
        expect(textContentResult_test).assertLess(textContentResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0050 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0060
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0060', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s a test text.加入中文',
        })
        expect(textContentResult_test).assertLarger(textContentResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0060 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0070
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0070', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s a test text.加入中文与全角符号。！',
        })
        expect(textContentResult_test).assertLarger(textContentResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0070 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0080
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0080', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: '',
        })
        expect(textContentResult_test).assertLess(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0080 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0090
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0090', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: $r('app.media.icon'),
        })
        expect(textContentResult_test).assertLess(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0090 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0100
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0100', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: null,
        })
        expect(textContentResult_test).assertLess(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0100 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0110
     * @tc.name   : MeasureText
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0110', 0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: undefined,
        })
        expect(textContentResult_test).assertLess(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0110 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0120
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0120', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: fontSize_20,
        })
        expect(fontSizeResult_test).assertLarger(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0120 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0130
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0130', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22fp',
        })
        expect(fontSizeResult_test).assertLarger(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0130 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0140
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0140', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22vp',
        })
        expect(fontSizeResult_test).assertLarger(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0140 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0150
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0150', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22px',
        })
        expect(fontSizeResult_test).assertLess(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0150 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0160
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0160', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22lpx',
        })
        expect(fontSizeResult_test).assertLess(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0160 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0170
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0170', 0, async (done: Function) => {
      let text = await driver.findComponent(ON.id('SUB_Measure_measureText_Func_0170:fontSizeResult_test'));
      try {
        let fontSizeResult_test = Number(await text.getText());
        expect(fontSizeResult_test).assertLarger(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0170 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0180
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0180', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: 0,
        })
        expect(fontSizeResult_test).assertEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0180 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0190
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0190', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: -1,
        })
        expect(fontSizeResult_test).assertEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0190 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0200
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0200', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: 'abc',
        })
        expect(fontSizeResult_test).assertEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0200 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0210
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0210', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '0',
        })
        expect(fontSizeResult_test).assertEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0210 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0220
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0220', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '',
        })
        expect(fontSizeResult_test).assertEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0220 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0230
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0230', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: $r('app.media.icon'),
        })
        expect(fontSizeResult_test).assertEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0230 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0240
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0240', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: null,
        })
        expect(fontSizeResult_test).assertEqual(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0240 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0250
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0250', 0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: undefined,
        })
        expect(fontSizeResult_test).assertEqual(fontSizeResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0250 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0260
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0260', 0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: 1,
        })
        expect(fontStyleResult_test).assertLessOrEqual(fontStyleResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0260 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0270
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0270', 0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: 0,
        })
        expect(fontStyleResult_test).assertEqual(fontStyleResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0270 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0280
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0280', 0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Normal,
        })
        expect(fontStyleResult_test).assertEqual(fontStyleResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0280 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0290
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0290', 0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Italic,
        })
        expect(fontStyleResult_test).assertLessOrEqual(fontStyleResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0290 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0300
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0300', 0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: -1,
        })
        expect(fontStyleResult_test).assertEqual(fontStyleResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0300 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0310
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0310', 0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: null,
        })
        expect(fontStyleResult_test).assertEqual(fontStyleResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0310 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0320
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0320', 0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: undefined,
        })
        expect(fontStyleResult_test).assertEqual(fontStyleResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0320 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0330
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0330', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: fontWeight_100,
        })
        expect(fontWeightResult_test).assertLessOrEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0330 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0340
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0340', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: 'medium',
        })
        expect(fontWeightResult_test).assertLargerOrEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0340 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0350
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0350', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Lighter,
        })
        expect(fontWeightResult_test).assertLessOrEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0350 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0360
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0360', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Normal,
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0360 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0370
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0370', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Regular,
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0370 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0380
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0380', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Medium,
        })
        expect(fontWeightResult_test).assertLargerOrEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0380 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0390
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0390', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bold,
        })
        expect(fontWeightResult_test).assertLargerOrEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0390 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0400
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0400', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bolder,
        })
        expect(fontWeightResult_test).assertLargerOrEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0400 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0410
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0410', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: 0,
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0410 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0420
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0420', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: -1,
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0420 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0430
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0430', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: 'abc',
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0430 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0440
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0440', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: '0',
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0440 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0450
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0450', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: '',
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0450 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0460
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0460', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: null,
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0460 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0470
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0470', 0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: undefined,
        })
        expect(fontWeightResult_test).assertEqual(fontWeightResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0470 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0480
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0480', 0, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: 'HarmonyOS Sans',
        })
        expect(fontFamilyResult_test).assertEqual(fontFamilyResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0480 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0490
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0490', 0, async (done: Function) => {
      let text = await driver.findComponent(ON.id('SUB_Measure_measureText_Func_0490:fontFamilyResult_test'));
      try {
        let fontFamilyResult_test = Number(await text.getText());
        expect(fontFamilyResult_test).assertEqual(fontFamilyResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0490 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0500
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0500', 0, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: 'abc',
        })
        expect(fontFamilyResult_test).assertEqual(fontFamilyResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0500 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0510
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0510', 0, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: '0',
        })
        expect(fontFamilyResult_test).assertEqual(fontFamilyResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0510 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0520
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0520', 0, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: '',
        })
        expect(fontFamilyResult_test).assertEqual(fontFamilyResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0520 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0530
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0530', 0, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: null,
        })
        expect(fontFamilyResult_test).assertEqual(fontFamilyResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0530 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0540
     * @tc.name   : MeasureText
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0540', 0, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: undefined,
        })
        expect(fontFamilyResult_test).assertEqual(fontFamilyResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0540 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0550
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0550', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: letterSpacing_10,
        })
        expect(letterSpacingResult_test).assertLarger(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0550 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0560
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0560', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: 0,
        })
        expect(letterSpacingResult_test).assertEqual(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0560 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0570
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0570', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '0',
        })
        expect(letterSpacingResult_test).assertEqual(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0570 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0580
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0580', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10vp',
        })
        expect(letterSpacingResult_test).assertLarger(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0580 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0590
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0590', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10fp',
        })
        expect(letterSpacingResult_test).assertLarger(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0590 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0600
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0600', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10px',
        })
        expect(letterSpacingResult_test).assertLarger(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0600 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0610
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0610', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10lpx',
        })
        expect(letterSpacingResult_test).assertLarger(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0610 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0620
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0620', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: 'abc',
        })
        expect(letterSpacingResult_test).assertEqual(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0620 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0630
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0630', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '',
        })
        expect(letterSpacingResult_test).assertEqual(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0630 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0640
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0640', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: null,
        })
        expect(letterSpacingResult_test).assertEqual(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0640 error' + err);
      }
      done();
    });
    /**
     * @tc.number : SUB_Measure_measureText_Func_0650
     * @tc.name   : MeasureText
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0650', 0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: undefined,
        })
        expect(letterSpacingResult_test).assertEqual(letterSpacingResult_base);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0650 error' + err);
      }
      done();
    });
  })
}
