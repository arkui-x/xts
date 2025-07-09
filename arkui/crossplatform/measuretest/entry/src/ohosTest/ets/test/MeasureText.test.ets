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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level } from '@ohos/hypium'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import measure from '@ohos.measure'
import deviceInfo from '@ohos.deviceInfo';
import { getResult } from '../testability/pages/Index';
import Want from '@ohos.app.ability.Want';

const waitReadyMs_50 = 50;
const waitReadyMs_2000 = 2000;
const fontSize_20 = 20;
const fontWeight_100 = 100;
const letterSpacing_10 = 10;
let textContentResult_base: number;
let fontSizeResult_base: number;
let fontStyleResult_base: number;
let fontWeightResult_base: number;
let fontFamilyResult_base: number;
let letterSpacingResult_base: number;
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];
const delegator = abilityDelegatorRegistry.getAbilityDelegator();

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
  await sleep(waitReadyMs_50);
}

export default function MeasureTextTest() {
  describe('MeasureTextTest', () => {
    beforeAll(async() => {
      await startAbility('com.example.measuretest', 'EntryAbility');
      await sleep(waitReadyMs_2000);
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
      await sleep(waitReadyMs_50);
    })


    /**
     * @tc.number : SUB_Measure_measureText_Func_0010
     * @tc.name   : SUB_Measure_measureText_Func_0010
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0010', Level.LEVEL0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s another test text.',
        })
        expect(textContentResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0010 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0020
     * @tc.name   : SUB_Measure_measureText_Func_0020
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0020', Level.LEVEL0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureText_0020).assertLarger(textContentResult_base);
        } else {
          expect(getResult().MeasureText_0020).assertLarger(textContentResult_base);
        }
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0020 error' + err.code);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0030
     * @tc.name   : SUB_Measure_measureText_Func_0030
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0030', Level.LEVEL0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s a test text.',
        })
        expect(textContentResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0030 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0040
     * @tc.name   : SUB_Measure_measureText_Func_0040
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0040', Level.LEVEL0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\’s a test text。',
        })
        expect(textContentResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0040 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0050
     * @tc.name   : SUB_Measure_measureText_Func_0050
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0050', Level.LEVEL0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: '中文文本',
        })
        expect(textContentResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0050 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0060
     * @tc.name   : SUB_Measure_measureText_Func_0060
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0060', Level.LEVEL0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s a test text.加入中文',
        })
        expect(textContentResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0060 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0070
     * @tc.name   : SUB_Measure_measureText_Func_0070
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0070', Level.LEVEL0, async (done: Function) => {
      try {
        let textContentResult_test = measure.measureText({
          textContent: 'This\'s a test text.加入中文与全角符号。！',
        })
        expect(textContentResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0070 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0080
     * @tc.name   : SUB_Measure_measureText_Func_0080
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0080', Level.LEVEL2, async (done: Function) => {
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
     * @tc.name   : SUB_Measure_measureText_Func_0090
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0090', Level.LEVEL0, async (done: Function) => {
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
     * @tc.name   : SUB_Measure_measureText_Func_0100
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0100', Level.LEVEL0, async (done: Function) => {
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
     * @tc.name   : SUB_Measure_measureText_Func_0110
     * @tc.desc   : Test the textContent property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0110', Level.LEVEL2, async (done: Function) => {
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
     * @tc.name   : SUB_Measure_measureText_Func_0120
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0120', Level.LEVEL0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: fontSize_20,
        })
        expect(fontSizeResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0120 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0130
     * @tc.name   : SUB_Measure_measureText_Func_0130
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0130', Level.LEVEL0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22fp',
        })
        expect(fontSizeResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0130 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0140
     * @tc.name   : SUB_Measure_measureText_Func_0140
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0140', Level.LEVEL0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22vp',
        })
        expect(fontSizeResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0140 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0150
     * @tc.name   : SUB_Measure_measureText_Func_0150
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0150', Level.LEVEL0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22px',
        })
        expect(fontSizeResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0150 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0160
     * @tc.name   : SUB_Measure_measureText_Func_0160
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0160', Level.LEVEL0, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '22lpx',
        })
        expect(fontSizeResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0160 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0170
     * @tc.name   : SUB_Measure_measureText_Func_0170
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0170', Level.LEVEL0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureText_0170).assertLarger(0);
        } else {
          expect(getResult().MeasureText_0170).assertLarger(0);
        }
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0170 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0180
     * @tc.name   : SUB_Measure_measureText_Func_0180
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0180', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: Level.LEVEL0,
        })
        expect(fontSizeResult_test).assertLargerOrEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0180 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0190
     * @tc.name   : SUB_Measure_measureText_Func_0190
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0190', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: -1,
        })
        expect(fontSizeResult_test).assertLargerOrEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0190 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0200
     * @tc.name   : SUB_Measure_measureText_Func_0200
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0200', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: 'abc',
        })
        expect(fontSizeResult_test).assertLargerOrEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0200 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0210
     * @tc.name   : SUB_Measure_measureText_Func_0210
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0210', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '0',
        })
        expect(fontSizeResult_test).assertLargerOrEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0210 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0220
     * @tc.name   : SUB_Measure_measureText_Func_0220
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0220', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: '',
        })
        expect(fontSizeResult_test).assertLargerOrEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0220 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0230
     * @tc.name   : SUB_Measure_measureText_Func_0230
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0230', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: $r('app.media.icon'),
        })
        expect(fontSizeResult_test).assertLargerOrEqual(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0230 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0240
     * @tc.name   : SUB_Measure_measureText_Func_0240
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0240', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: null,
        })
        expect(fontSizeResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0240 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0250
     * @tc.name   : SUB_Measure_measureText_Func_0250
     * @tc.desc   : Test the fontSize property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0250', Level.LEVEL2, async (done: Function) => {
      try {
        let fontSizeResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontSize: undefined,
        })
        expect(fontSizeResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0250 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0260
     * @tc.name   : SUB_Measure_measureText_Func_0260
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0260', Level.LEVEL0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: 1,
        })
        expect(fontStyleResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0260 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0270
     * @tc.name   : SUB_Measure_measureText_Func_0270
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0270', Level.LEVEL0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: Level.LEVEL0,
        })
        expect(fontStyleResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0270 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0280
     * @tc.name   : SUB_Measure_measureText_Func_0280
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0280', Level.LEVEL0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Normal,
        })
        expect(fontStyleResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0280 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0290
     * @tc.name   : SUB_Measure_measureText_Func_0290
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0290', Level.LEVEL0, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: FontStyle.Italic,
        })
        expect(fontStyleResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0290 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0300
     * @tc.name   : SUB_Measure_measureText_Func_0300
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0300', Level.LEVEL2, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: -1,
        })
        expect(fontStyleResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0300 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0310
     * @tc.name   : SUB_Measure_measureText_Func_0310
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0310', Level.LEVEL2, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: null,
        })
        expect(fontStyleResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0310 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0320
     * @tc.name   : SUB_Measure_measureText_Func_0320
     * @tc.desc   : Test the fontStyle property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0320', Level.LEVEL2, async (done: Function) => {
      try {
        let fontStyleResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontStyle: undefined,
        })
        expect(fontStyleResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0320 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0330
     * @tc.name   : SUB_Measure_measureText_Func_0330
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0330', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: fontWeight_100,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0330 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0340
     * @tc.name   : SUB_Measure_measureText_Func_0340
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0340', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: 'medium',
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0340 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0350
     * @tc.name   : SUB_Measure_measureText_Func_0350
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0350', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Lighter,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0350 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0360
     * @tc.name   : SUB_Measure_measureText_Func_0360
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0360', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Normal,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0360 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0370
     * @tc.name   : SUB_Measure_measureText_Func_0370
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0370', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Regular,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0370 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0380
     * @tc.name   : SUB_Measure_measureText_Func_0380
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0380', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Medium,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0380 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0390
     * @tc.name   : SUB_Measure_measureText_Func_0390
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0390', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bold,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0390 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0400
     * @tc.name   : SUB_Measure_measureText_Func_0400
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0400', Level.LEVEL0, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: FontWeight.Bolder,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0400 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0410
     * @tc.name   : SUB_Measure_measureText_Func_0410
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0410', Level.LEVEL2, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: Level.LEVEL0,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0410 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0420
     * @tc.name   : SUB_Measure_measureText_Func_0420
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0420', Level.LEVEL2, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: -1,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0420 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0430
     * @tc.name   : SUB_Measure_measureText_Func_0430
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0430', Level.LEVEL2, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: 'abc',
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0430 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0440
     * @tc.name   : SUB_Measure_measureText_Func_0440
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0440', Level.LEVEL2, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: '0',
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0440 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0450
     * @tc.name   : SUB_Measure_measureText_Func_0450
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0450', Level.LEVEL2, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: '',
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0450 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0460
     * @tc.name   : SUB_Measure_measureText_Func_0460
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0460', Level.LEVEL2, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: null,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0460 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0470
     * @tc.name   : SUB_Measure_measureText_Func_0470
     * @tc.desc   : Test the fontWeight property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0470', Level.LEVEL2, async (done: Function) => {
      try {
        let fontWeightResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontWeight: undefined,
        })
        expect(fontWeightResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0470 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0480
     * @tc.name   : SUB_Measure_measureText_Func_0480
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0480', Level.LEVEL0, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: 'HarmonyOS Sans',
        })
        expect(fontFamilyResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0480 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0490
     * @tc.name   : SUB_Measure_measureText_Func_0490
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0490', Level.LEVEL0, async (done: Function) => {
      try {
        if (platform != "Android" && platform != "iOS") {
          expect(globalThis.MeasureText_0490).assertLarger(0);
        } else {
          expect(getResult().MeasureText_0490).assertLarger(0);
        }
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0490 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0500
     * @tc.name   : SUB_Measure_measureText_Func_0500
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0500', Level.LEVEL2, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: 'abc',
        })
        expect(fontFamilyResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0500 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0510
     * @tc.name   : SUB_Measure_measureText_Func_0510
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0510', Level.LEVEL2, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: '0',
        })
        expect(fontFamilyResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0510 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0520
     * @tc.name   : SUB_Measure_measureText_Func_0520
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0520', Level.LEVEL2, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: '',
        })
        expect(fontFamilyResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0520 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0530
     * @tc.name   : SUB_Measure_measureText_Func_0530
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0530', Level.LEVEL2, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: null,
        })
        expect(fontFamilyResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0530 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0540
     * @tc.name   : SUB_Measure_measureText_Func_0540
     * @tc.desc   : Test the fontFamily property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0540', Level.LEVEL2, async (done: Function) => {
      try {
        let fontFamilyResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          fontFamily: undefined,
        })
        expect(fontFamilyResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0540 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0550
     * @tc.name   : SUB_Measure_measureText_Func_0550
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0550', Level.LEVEL0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: letterSpacing_10,
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0550 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0560
     * @tc.name   : SUB_Measure_measureText_Func_0560
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0560', Level.LEVEL0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: Level.LEVEL0,
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0560 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0570
     * @tc.name   : SUB_Measure_measureText_Func_0570
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0570', Level.LEVEL0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '0',
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0570 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0580
     * @tc.name   : SUB_Measure_measureText_Func_0580
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0580', Level.LEVEL0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10vp',
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0580 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0590
     * @tc.name   : SUB_Measure_measureText_Func_0590
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0590', Level.LEVEL0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10fp',
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0590 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0600
     * @tc.name   : SUB_Measure_measureText_Func_0600
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0600', Level.LEVEL0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10px',
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0600 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0610
     * @tc.name   : SUB_Measure_measureText_Func_0610
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_Measure_measureText_Func_0610', Level.LEVEL0, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '10lpx',
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0610 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0620
     * @tc.name   : SUB_Measure_measureText_Func_0620
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0620', Level.LEVEL2, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: 'abc',
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0620 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0630
     * @tc.name   : SUB_Measure_measureText_Func_0630
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0630', Level.LEVEL2, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: '',
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0630 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0640
     * @tc.name   : SUB_Measure_measureText_Func_0640
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0640', Level.LEVEL2, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: null,
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0640 error' + err);
      }
      done();
    });

    /**
     * @tc.number : SUB_Measure_measureText_Func_0650
     * @tc.name   : SUB_Measure_measureText_Func_0650
     * @tc.desc   : Test the letterSpacing property of the measureText
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_Measure_measureText_Func_0650', Level.LEVEL2, async (done: Function) => {
      try {
        let letterSpacingResult_test = measure.measureText({
          textContent: 'This\'s a test text',
          letterSpacing: undefined,
        })
        expect(letterSpacingResult_test).assertLarger(0);
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_Measure_measureText_Func_0650 error' + err);
      }
      done();
    });
  })
}
