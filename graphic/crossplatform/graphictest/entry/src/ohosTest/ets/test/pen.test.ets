/*
 * Copyright (c) 2025 Shenzhen Kaihong Digital Industry Development Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType, Size, Level } from '@ohos/hypium';
import drawing from '@ohos.graphics.drawing';
import common2D from '@ohos.graphics.common2D';
import { getRandomNumber } from './utils';

export default function penTest() {
  describe('DrawingTsPenTest', () => {
    const DEFAULT = 0;
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0100
     * @tc.name      : testPenSetColorNormal0001
     * @tc.desc      : Test for testPenSetColorNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetColorNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetColorNormal0001';
      const pen = new drawing.Pen();
      try {
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        pen.setColor({
          alpha: 245.3,
          red: 251.1,
          green: 10.1,
          blue: 12.1
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0200
     * @tc.name      : testPenSetColorNull0002
     * @tc.desc      : Test for testPenSetColorNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColorNull0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColorNull0002';
      const pen = new drawing.Pen();

      try {
        pen.setColor(undefined);
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor(null);
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0300
     * @tc.name      : testPenSetColorMultipleCalls0003
     * @tc.desc      : Test for testPenSetColorMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColorMultipleCalls0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColorMultipleCalls0003';
      try {
        const pen = new drawing.Pen();
        for (let i = 0; i < 20; i++) {
          pen.setColor({
            alpha: Math.floor(Math.random() * 256),
            red: Math.floor(Math.random() * 256),
            green: Math.floor(Math.random() * 256),
            blue: Math.floor(Math.random() * 256),
          });
        }
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0400
     * @tc.name      : testPenSetColorBoundaryValue0004
     * @tc.desc      : Test for testPenSetColorBoundaryValue.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColorBoundaryValue0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColorBoundaryValue0004';
      const pen = new drawing.Pen();

      try {
        pen.setColor({
          alpha: -1,
          red: 255,
          green: 0,
          blue: 255
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor({
          alpha: 256,
          red: 255,
          green: 0,
          blue: 255
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor({
          alpha: 255,
          red: -2,
          green: 0,
          blue: 255
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor({
          alpha: 255,
          red: 256,
          green: 0,
          blue: 255
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 256,
          blue: 255
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor({
          alpha: 255,
          red: 255,
          green: -1,
          blue: 255
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: -1
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 256
        });
        console.info(msg + ' setColor successed');
      } catch (e) {
        console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0500
     * @tc.name      : testPenSetStrokeWidthNormal0005
     * @tc.desc      : Test for testPenSetStrokeWidthNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetStrokeWidthNormal0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetStrokeWidthNormal0005';
      const pen = new drawing.Pen();

      try {
        pen.setStrokeWidth(20);
        console.info(msg + ' setStrokeWidth(20) succeeded');
      } catch (e) {
        console.info(msg + ` setStrokeWidth(20) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setStrokeWidth(1.1);
        console.info(msg + ' setStrokeWidth(1.1) succeeded');
      } catch (e) {
        console.info(msg + ` setStrokeWidth(1.1) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setStrokeWidth(0);
        console.info(msg + ' setStrokeWidth(0) succeeded');
      } catch (e) {
        console.info(msg + ` setStrokeWidth(0) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setStrokeWidth(-1);
        console.info(msg + ' setStrokeWidth(-1) succeeded');
      } catch (e) {
        console.info(msg + ` setStrokeWidth(-1) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0600
     * @tc.name      : testPenSetStrokeWidthNull0006
     * @tc.desc      : Test for testPenSetStrokeWidthNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetStrokeWidthNull0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetStrokeWidthNull0006';
      const pen = new drawing.Pen();

      try {
        pen.setStrokeWidth(undefined);
        console.info(msg + ' setStrokeWidth(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setStrokeWidth(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setStrokeWidth(null);
        console.info(msg + ' setStrokeWidth(null) succeeded');
      } catch (e) {
        console.info(msg + ` setStrokeWidth(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0700
     * @tc.name      : testPenSetStrokeWidthMultipleCalls0007
     * @tc.desc      : Test for testPenSetStrokeWidthMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetStrokeWidthMultipleCalls0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetStrokeWidthMultipleCalls0007';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          const randomStrokeWidth = Math.random() * 100; // Generate a random stroke width
          pen.setStrokeWidth(randomStrokeWidth);
          console.info(msg + ' setStrokeWidth(' + randomStrokeWidth + ') succeeded');
        } catch (e) {
          console.info(msg + ` setStrokeWidth errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0800
     * @tc.name      : testPenSetAntiAliasNormal0008
     * @tc.desc      : Test for testPenSetAntiAliasNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetAntiAliasNormal0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetAntiAliasNormal0008';
      const pen = new drawing.Pen();

      try {
        pen.setAntiAlias(true);
        console.info(msg + ' setAntiAlias(true) succeeded');
      } catch (e) {
        console.info(msg + ` setAntiAlias(true) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setAntiAlias(false);
        console.info(msg + ' setAntiAlias(false) succeeded');
      } catch (e) {
        console.info(msg + ` setAntiAlias(false) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0900
     * @tc.name      : testPenSetAntiAliasNull0009
     * @tc.desc      : Test for testPenSetAntiAliasNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetAntiAliasNull0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetAntiAliasNull0009';
      const pen = new drawing.Pen();

      try {
        pen.setAntiAlias(undefined);
        console.info(msg + ' setAntiAlias(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setAntiAlias(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setAntiAlias(null);
        console.info(msg + ' setAntiAlias(null) succeeded');
      } catch (e) {
        console.info(msg + ` setAntiAlias(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1000
     * @tc.name      : testPenSetAntiAliasMultipleCalls0010
     * @tc.desc      : Test for testPenSetAntiAliasMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetAntiAliasMultipleCalls0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetAntiAliasMultipleCalls0010';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          const randomBoolean = Math.random() < 0.5;
          pen.setAntiAlias(randomBoolean);
          console.info(msg + ' setAntiAlias(' + randomBoolean + ') succeeded');
        } catch (e) {
          console.info(msg + ` setAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1100
     * @tc.name      : testPenSetAlphaNormal0011
     * @tc.desc      : Test for testPenSetAlphaNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetAlphaNormal0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetAlphaNormal0011';
      const pen = new drawing.Pen();

      try {
        pen.setAlpha(255);
        console.info(msg + ' setAlpha(255) succeeded');
      } catch (e) {
        console.info(msg + ` setAlpha(255) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setAlpha(0);
        console.info(msg + ' setAlpha(0) succeeded');
      } catch (e) {
        console.info(msg + ` setAlpha(0) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setAlpha(255.562);
        console.info(msg + ' setAlpha(255.562) succeeded');
      } catch (e) {
        console.info(msg + ` setAlpha(255.562) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1200
     * @tc.name      : testPenSetAlphaNull0012
     * @tc.desc      : Test for testPenSetAlphaNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetAlphaNull0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetAlphaNull0012';
      const pen = new drawing.Pen();

      try {
        pen.setAlpha(undefined);
        console.info(msg + ' setAlpha(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setAlpha(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setAlpha(null);
        console.info(msg + ' setAlpha(null) succeeded');
      } catch (e) {
        console.info(msg + ` setAlpha(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1300
     * @tc.name      : testPenSetAlphaMultipleCalls0013
     * @tc.desc      : Test for testPenSetAlphaMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetAlphaMultipleCalls0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetAlphaMultipleCalls0013';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          const randomAlpha = Math.floor(Math.random() * 256);
          pen.setAlpha(randomAlpha);
          console.info(msg + ' setAlpha(' + randomAlpha + ') succeeded');
        } catch (e) {
          console.info(msg + ` setAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1400
     * @tc.name      : testPenSetColorFilterNormal0014
     * @tc.desc      : Test for testPenSetColorFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetColorFilterNormal0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetColorFilterNormal0014';
      try {
        const pen = new drawing.Pen();
        pen.setColorFilter(drawing.ColorFilter.createLinearToSRGBGamma());
        console.info(msg + ' setColorFilter successed');
      } catch (e) {
        console.info(msg + ` setColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1500
     * @tc.name      : testPenSetColorFilterNull0015
     * @tc.desc      : Test for testPenSetColorFilterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColorFilterNull0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColorFilterNull0015';
      const pen = new drawing.Pen();

      try {
        pen.setColorFilter(undefined);
        console.info(msg + ' setColorFilter(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setColorFilter(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setColorFilter(null);
        console.info(msg + ' setColorFilter(null) succeeded');
      } catch (e) {
        console.info(msg + ` setColorFilter(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1600
     * @tc.name      : testPenSetColorFilterMultipleCalls0016
     * @tc.desc      : Test for testPenSetColorFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColorFilterMultipleCalls0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColorFilterMultipleCalls0016';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          pen.setColorFilter(drawing.ColorFilter.createLinearToSRGBGamma());
          console.info(msg + ' setColorFilter successed');
        } catch (e) {
          console.info(msg + ` setColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1700
     * @tc.name      : testPenSetMaskFilterNormal0017
     * @tc.desc      : Test for testPenSetMaskFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetMaskFilterNormal0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetMaskFilterNormal0017';
      try {
        const pen = new drawing.Pen();
        pen.setMaskFilter(drawing.MaskFilter.createBlurMaskFilter(drawing.BlurType.OUTER, 10));
        console.info(msg + ' setMaskFilter successed');
      } catch (e) {
        console.info(msg + ` setMaskFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1800
     * @tc.name      : testPenSetMaskFilterNull0018
     * @tc.desc      : Test for testPenSetMaskFilterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetMaskFilterNull0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetMaskFilterNull0018';
      const pen = new drawing.Pen();

      try {
        pen.setMaskFilter(undefined);
        console.info(msg + ' setMaskFilter(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setMaskFilter(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setMaskFilter(null);
        console.info(msg + ' setMaskFilter(null) succeeded');
      } catch (e) {
        console.info(msg + ` setMaskFilter(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1900
     * @tc.name      : testPenSetMaskFilterMultipleCalls0019
     * @tc.desc      : Test for testPenSetMaskFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetMaskFilterMultipleCalls0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetMaskFilterMultipleCalls0019';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          const randomBlurType = Math.floor(Math.random() * 4);
          const randomValue = Math.floor(Math.random() * 100) + 1;
          pen.setMaskFilter(drawing.MaskFilter.createBlurMaskFilter(randomBlurType, randomValue));
          console.info(msg + ' setMaskFilter(' + randomBlurType + ', ' + randomValue + ') succeeded');
        } catch (e) {
          console.info(msg + ` setMaskFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2000
     * @tc.name      : testPenSetShadowLayerNormal0020
     * @tc.desc      : Test for testPenSetShadowLayerNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetShadowLayerNormal0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetShadowLayerNormal0020';
      try {
        const pen = new drawing.Pen();
        pen.setShadowLayer(drawing.ShadowLayer.create(3, -3, 3, {
          alpha: 0xFF,
          red: 0x00,
          green: 0xFF,
          blue: 0x00
        }));
        console.info(msg + ' setShadowLayer succeeded');
      } catch (e) {
        console.info(msg + ` setShadowLayer errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2100
     * @tc.name      : testPenSetShadowLayerMultipleCalls0021
     * @tc.desc      : Test for testPenSetShadowLayerMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetShadowLayerMultipleCalls0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetShadowLayerMultipleCalls0021';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          const randomColor: common2D.Color = {
            alpha: Math.floor(Math.random() * 256),
            red: Math.floor(Math.random() * 256),
            green: Math.floor(Math.random() * 256),
            blue: Math.floor(Math.random() * 256),
          };
          pen.setShadowLayer(drawing.ShadowLayer.create(Math.random() * 100, Math.random() * 100, Math.random() * 100,
            randomColor));
          console.info(msg + ' setShadowLayer succeeded');
        } catch (e) {
          console.info(msg + ` setShadowLayer errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2200
     * @tc.name      : testPenSetBlendModeNormal0022
     * @tc.desc      : Test for testPenSetBlendModeNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetBlendModeNormal0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetBlendModeNormal0022';
      try {
        const pen = new drawing.Pen();
        pen.setBlendMode(drawing.BlendMode.SRC);
        console.info(msg + ' setBlendMode successed');
      } catch (e) {
        console.info(msg + ` setBlendMode errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2300
     * @tc.name      : testPenSetGetJoinStyleNormal0023
     * @tc.desc      : Test for testPenSetGetJoinStyleNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetGetJoinStyleNormal0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetGetJoinStyleNormal0023';
      const pen = new drawing.Pen();
      try {
        pen.setJoinStyle(drawing.JoinStyle.ROUND_JOIN);
        expect(pen.getJoinStyle()).assertEqual(drawing.JoinStyle.ROUND_JOIN);
        pen.setJoinStyle(drawing.JoinStyle.MITER_JOIN);
        expect(pen.getJoinStyle()).assertEqual(drawing.JoinStyle.MITER_JOIN);
        pen.setJoinStyle(drawing.JoinStyle.BEVEL_JOIN);
        expect(pen.getJoinStyle()).assertEqual(drawing.JoinStyle.BEVEL_JOIN);
        console.info(msg + ' setJoinStyle successed');
      } catch (e) {
        console.info(msg + ` setJoinStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2400
     * @tc.name      : testPenSetGetCapStyleNormal0024
     * @tc.desc      : Test for testPenSetGetCapStyleNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetGetCapStyleNormal0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetGetCapStyleNormal0024';
      const pen = new drawing.Pen();
      try {
        pen.setCapStyle(drawing.CapStyle.SQUARE_CAP);
        expect(pen.getCapStyle()).assertEqual(drawing.CapStyle.SQUARE_CAP);
        pen.setCapStyle(drawing.CapStyle.FLAT_CAP);
        expect(pen.getCapStyle()).assertEqual(drawing.CapStyle.FLAT_CAP);
        pen.setCapStyle(drawing.CapStyle.ROUND_CAP);
        expect(pen.getCapStyle()).assertEqual(drawing.CapStyle.ROUND_CAP);
        console.info(msg + ' setCapStyle successed');
      } catch (e) {
        console.info(msg + ` setCapStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2500
     * @tc.name      : testPenSetPathEffectNormal0025
     * @tc.desc      : Test for testPenSetPathEffectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetPathEffectNormal0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetPathEffectNormal0025';
      const pen = new drawing.Pen();
      try {
        pen.setPathEffect(drawing.PathEffect.createDashPathEffect([30, 10], 0));
        console.info(msg + ' setPathEffect successed');
      } catch (e) {
        console.info(msg + ` setPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2600
     * @tc.name      : testPenSetPathEffectMultipleCalls0026
     * @tc.desc      : Test for testPenSetPathEffectMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetPathEffectMultipleCalls0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetPathEffectMultipleCalls0026';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          const dashPathEffect = drawing.PathEffect.createDashPathEffect([30, 10], 0);
          pen.setPathEffect(dashPathEffect);
          console.info(msg + ' setPathEffect succeeded');
        } catch (e) {
          console.info(msg + ` setPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2700
     * @tc.name      : testPenSetColor12Normal0027
     * @tc.desc      : testPenSetColor12Normal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetColor12Normal0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetColor12Normal0027';
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, 0, 0);
        pen.setColor(245.3, 251.1, 10.1, 12.1);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2800
     * @tc.name      : testPenSetColor12Null0028
     * @tc.desc      : testPenSetColor12Null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColor12Null0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColor12Null0028';
      try {
        const pen = new drawing.Pen();
        pen.setColor(undefined, 255, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, undefined, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, undefined, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, 0, undefined);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(null, 255, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, null, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, null, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, 0, null);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2900
     * @tc.name      : testPenSetColor12MultipleCalls0029
     * @tc.desc      : testPenSetColor12MultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColor12MultipleCalls0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColor12MultipleCalls0029';
      try {
        const pen = new drawing.Pen();
        for (let index = 0; index < 20; index++) {
          pen.setColor(getRandomNumber(0, 255), getRandomNumber(0, 255), getRandomNumber(0, 255),
            getRandomNumber(0, 255));
        }
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_3000
     * @tc.name      : testPenSetColor12BoundaryValue0030
     * @tc.desc      : testPenSetColor12BoundaryValue
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetColor12BoundaryValue0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetColor12BoundaryValue0030';
      try {
        const pen = new drawing.Pen();
        pen.setColor(-1, 255, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, -1, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(256, 255, -1, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, 0, -1);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(256, 255, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 256, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, 256, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setColor(255, 255, 0, 256);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })
  })
}