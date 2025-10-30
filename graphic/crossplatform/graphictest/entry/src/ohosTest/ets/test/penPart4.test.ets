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
import colorSpaceManager from '@ohos.graphics.colorSpaceManager';
import common2D from '@ohos.graphics.common2D';
import { getRandomNumber } from './utils';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function penPart4Test() {
  describe('DrawingTsPenPart2Test', () => {
    const DEFAULT = 0;
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
    })
    beforeEach(async () => {
      await sleep(100)
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(async () => {
      await sleep(1000)
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(async () => {
      await sleep(500)
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0100
     * @tc.name      : testPenGetColorFilterNormal0001
     * @tc.desc      : Test for testPenGetColorFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenGetColorFilterNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetColorFilterNormal0001';
      const pen = new drawing.Pen();
      try {
        let cf = drawing.ColorFilter.createLumaColorFilter();
        let cf2 = pen.getColorFilter();
        console.info(msg + ' getColorFilter successed,colorFilter:' + cf2);
      } catch (e) {
        console.info(msg + ` getColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0200
     * @tc.name      : testPenGetColorFilterMultipleCalls0002
     * @tc.desc      : Test for testPenGetColorFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenGetColorFilterMultipleCalls0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenGetColorFilterMultipleCalls0002';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          let cf2 = pen.getColorFilter();
          console.info(msg + ' getColorFilter succeeded,colorFilter:' + cf2);
        } catch (e) {
          console.info(msg + ` getColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0300
     * @tc.name      : testPenConstructorNormal0003
     * @tc.desc      : Test for testPenConstructorNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenConstructorNormal0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenConstructorNormal0003';
      const pen = new drawing.Pen();

      try {
        const pen = new drawing.Pen();
        console.info(msg + ' drawing.Pen() successed');
      } catch (e) {
        console.info(msg + ` drawing.Pen() errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        const newpen = new drawing.Pen(pen);
        console.info(msg + ' drawing.Pen(pen) successed');
      } catch (e) {
        console.info(msg + ` drawing.Pen(pen) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let penColor: common2D.Color = ({
          alpha: 0,
          red: 0,
          green: 0,
          blue: 0
        });
        pen.setColor(penColor);
        let newpen = new drawing.Pen(pen);
        console.info(msg + ' drawing.Pen(pen) successed');
      } catch (e) {
        console.info(msg + ` drawing.Pen(pen) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0400
     * @tc.name      : testPenGetAlphaNormal0004
     * @tc.desc      : Test for testPenGetAlphaNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenGetAlphaNormal0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetAlphaNormal0004';
      const pen = new drawing.Pen();
      try {
        let alpha = pen.getAlpha();
        expect(alpha == 255).assertTrue();
        console.info(msg + ' pen.getAlpha() successed,alpha:' + alpha);
      } catch (e) {
        console.info(msg + ` pen.getAlpha() errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setAlpha(128);
        let alpha = pen.getAlpha();
        expect(alpha == 128).assertTrue();
        console.info(msg + ' pen.getAlpha() successed,alpha:' + alpha);
      } catch (e) {
        console.info(msg + ` pen.getAlpha() errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setAlpha(255.1);
        let alpha = pen.getAlpha();
        expect(alpha == 255).assertTrue();
        console.info(msg + ' pen.getAlpha() successed,alpha:' + alpha);
      } catch (e) {
        console.info(msg + ` pen.getAlpha() errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0500
     * @tc.name      : testPenGetAlphaMultipleCalls0005
     * @tc.desc      : Test for testPenGetAlphaMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenGetAlphaMultipleCalls0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenGetAlphaMultipleCalls0005';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          let alpha = pen.getAlpha();
          console.info(msg + ' pen.getAlpha() successed,alpha:' + alpha);
        } catch (e) {
          console.info(msg + ` pen.getAlpha() errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0600
     * @tc.name      : testPenIsAntiAliasNormal0006
     * @tc.desc      : Test for testPenIsAntiAliasNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenIsAntiAliasNormal0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenIsAntiAliasNormal0006';
      const pen = new drawing.Pen();

      try {
        let isAntiAlias = pen.isAntiAlias();
        expect(isAntiAlias == false).assertTrue();
        console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
      } catch (e) {
        console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setAntiAlias(true);
        let isAntiAlias = pen.isAntiAlias();
        expect(isAntiAlias == true).assertTrue()
        console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
      } catch (e) {
        console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setAntiAlias(false);
        let isAntiAlias = pen.isAntiAlias();
        expect(isAntiAlias == false).assertTrue()
        console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
      } catch (e) {
        console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0700
     * @tc.name      : testPenIsAntiAliasMultipleCalls0007
     * @tc.desc      : Test for testPenIsAntiAliasMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenIsAntiAliasMultipleCalls0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenIsAntiAliasMultipleCalls0007';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          let isAntiAlias = pen.isAntiAlias();
          expect(isAntiAlias == false).assertTrue();
          console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
        } catch (e) {
          console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0800
     * @tc.name      : testPenGetColorNormal0008
     * @tc.desc      : Test for testPenGetColorNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenGetColorNormal0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetColorNormal0008';
      const pen = new drawing.Pen();
      try {
        let colorGet = pen.getColor();
        expect(colorGet != null).assertTrue();
        console.info(msg + ' getColor successed,colorGet:' + JSON.stringify(colorGet));
      } catch (e) {
        console.info(msg + ` getColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        const colors: common2D.Color = {
          alpha: 0,
          red: 0,
          green: 0,
          blue: 0
        }
        pen.setColor(colors);
        let colorGet = pen.getColor();
        expect(JSON.stringify(colorGet) == JSON.stringify(colors)).assertTrue();
        console.info(msg + ' getColor2 successed,colorGet:' + JSON.stringify(colorGet));
      } catch (e) {
        console.info(msg + ` getColor2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        const colors: common2D.Color = {
          alpha: 255,
          red: 255,
          green: 255,
          blue: 255
        }
        pen.setColor(colors);
        let colorGet = pen.getColor();
        expect(JSON.stringify(colorGet) == JSON.stringify(colors)).assertTrue();
        console.info(msg + ' getColor2 successed,colorGet:' + JSON.stringify(colorGet));
      } catch (e) {
        console.info(msg + ` getColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0900
     * @tc.name      : testPenGetColorMultipleCalls0009
     * @tc.desc      : Test for testPenGetColorMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenGetColorMultipleCalls0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenGetColorMultipleCalls0009';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          let colorGet = pen.getColor();
          console.info(msg + ' getColor successed,colorGet:' + JSON.stringify(colorGet));
        } catch (e) {
          console.info(msg + ` getColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1000
     * @tc.name      : testPenGetWidthNormal0010
     * @tc.desc      : Test for testPenGetWidthNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenGetWidthNormal0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetWidthNormal0010';
      const pen = new drawing.Pen();

      try {
        let width = pen.getWidth();
        expect(width == 0).assertTrue();
        console.info(msg + ' getWidth successed,width:' + width);
      } catch (e) {
        console.info(msg + ` getWidth errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setStrokeWidth(30);
        let width = pen.getWidth();
        expect(width == 30).assertTrue();
        console.info(msg + ' getWidth successed,width:' + width);
      } catch (e) {
        console.info(msg + ` getWidth errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setStrokeWidth(50.1);
        let width = pen.getWidth();
        expect(Math.floor(width) == 50).assertTrue();
        console.info(msg + ' getWidth successed,width:' + width);
      } catch (e) {
        console.info(msg + ` getWidth errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1100
     * @tc.name      : testPenGetWidthMultipleCalls0011
     * @tc.desc      : Test for testPenGetWidthMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenGetWidthMultipleCalls0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenGetWidthMultipleCalls0011';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          let width = pen.getWidth();
          expect(width == 0).assertTrue();
          console.info(msg + ' getWidth successed,width:' + width);
        } catch (e) {
          console.info(msg + ` getWidth errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1200
     * @tc.name      : testPenSetGetMiterLimitNormal0012
     * @tc.desc      : Test for testPenSetGetMiterLimitNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetGetMiterLimitNormal0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetGetMiterLimitNormal0012';
      const pen = new drawing.Pen();

      try {
        let miter = pen.getMiterLimit();
        expect(miter != null).assertTrue();
        console.info(msg + ' getMiterLimit1 successed,miter:' + miter);
      } catch (e) {
        console.info(msg + ` getMiterLimit1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setMiterLimit(5);
        let miter = pen.getMiterLimit();
        expect(miter == 5).assertTrue();
        console.info(msg + ' getMiterLimit2 successed,miter:' + miter);
      } catch (e) {
        console.info(msg + ` getMiterLimit2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setMiterLimit(20.1);
        let miter = pen.getMiterLimit();
        expect(Math.floor(miter) == 20).assertTrue();
        console.info(msg + ' getMiterLimit3 successed,miter:' + miter);
      } catch (e) {
        console.info(msg + ` getMiterLimit3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setMiterLimit(0);
        let miter = pen.getMiterLimit();
        expect(miter == 0).assertTrue();
        console.info(msg + ' getMiterLimit4 successed,miter:' + miter);
      } catch (e) {
        console.info(msg + ` getMiterLimit4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setMiterLimit(-1);
        let miter = pen.getMiterLimit();
        expect(miter == -1).assertTrue();
        console.info(msg + ' getMiterLimit5 successed,miter:' + miter);
      } catch (e) {
        console.info(msg + ` getMiterLimit5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1300
     * @tc.name      : testPenSetGetMiterLimitNull0013
     * @tc.desc      : Test for testPenSetGetMiterLimitNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetGetMiterLimitNull0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetGetMiterLimitNull0013';
      const pen = new drawing.Pen();

      try {
        pen.setMiterLimit(undefined);
        console.info(msg + ' setMiterLimit(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setMiterLimit(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setMiterLimit(null);
        console.info(msg + ' setMiterLimit(null) succeeded');
      } catch (e) {
        console.info(msg + ` setMiterLimit(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1400
     * @tc.name      : testPenSetGetMiterLimitMultipleCalls0014
     * @tc.desc      : Test for testPenSetGetMiterLimitMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetGetMiterLimitMultipleCalls0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetGetMiterLimitMultipleCalls0014';
      const pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          pen.setMiterLimit(getRandomNumber(1, 100));
          console.info(msg + ' setMiterLimit succeeded');
        } catch (e) {
          console.info(msg + ` setMiterLimit errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }

      for (let i = 0; i < 20; i++) {
        try {
          pen.getMiterLimit();
          console.info(msg + ' getMiterLimit succeeded');
        } catch (e) {
          console.info(msg + ` getMiterLimit errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }

      for (let i = 0; i < 20; i++) {
        let randomNumber = getRandomNumber(1, 100)
        try {
          pen.setMiterLimit(randomNumber);
          let miter = pen.getMiterLimit();
          expect(miter == randomNumber).assertTrue();
          console.info(msg + ' setAndGetMiterLimit succeeded');
        } catch (e) {
          console.info(msg + ` setAndGetMiterLimit errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1500
     * @tc.name      : testPenSetShaderEffectNormal0015
     * @tc.desc      : Test for testPenSetShaderEffectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetShaderEffectNormal0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetShaderEffectNormal0015';
      const pen = new drawing.Pen();
      const shaderEffect = new drawing.ShaderEffect();

      try {
        pen.setShaderEffect(shaderEffect);
        console.info(msg + ' setShaderEffect successed');
      } catch (e) {
        console.info(msg + ` setShaderEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setShaderEffect(null);
        console.info(msg + ' setShaderEffect successed');
      } catch (e) {
        console.info(msg + ` setShaderEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1600
     * @tc.name      : testPenSetShaderEffectNull0016
     * @tc.desc      : Test for testPenSetShaderEffectNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetShaderEffectNull0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetShaderEffectNull0016';
      const pen = new drawing.Pen();

      try {
        pen.setShaderEffect(undefined);
        console.info(msg + ' setShaderEffect(null) succeeded');
      } catch (e) {
        console.info(msg + ` setShaderEffect(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1700
     * @tc.name      : testPenSetShaderEffectMultipleCalls0017
     * @tc.desc      : Test for testPenSetShaderEffectMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPenSetShaderEffectMultipleCalls0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetShaderEffectMultipleCalls0017';
      const pen = new drawing.Pen();
      const shaderEffect = new drawing.ShaderEffect();

      for (let i = 0; i < 20; i++) {
        try {
          pen.setShaderEffect(shaderEffect);
          console.info(msg + ' setShaderEffect succeeded');
        } catch (e) {
          console.info(msg + ` setShaderEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1800
     * @tc.name      : testPenResetNormal0018
     * @tc.desc      : Test for testPenResetNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenResetNormal0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenResetNormal0018';
      const pen = new drawing.Pen();

      try {
        pen.reset();
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        const brush_color: common2D.Color = {
          alpha: 255, // Alpha 透明度，完全不透明
          red: 255, // 红色分量
          green: 0, // 绿色分量
          blue: 0     // 蓝色分量
        };
        pen.setColor(brush_color);
        pen.reset();
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_1900
     * @tc.name      : testPenSetAndGetColor4fNormal0019
     * @tc.desc      : Test for testPenSetAndGetColor4fNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetAndGetColor4fNormal0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetAndGetColor4fNormal0019';
      const pen = new drawing.Pen();
      // 枚举值除去UNKNOWN与CUSTOM不可用于直接创建色域对象。
      let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG);
      let color4f: common2D.Color4f = {
        alpha: 0.8,
        red: 0.5,
        green: 0.4,
        blue: 0.7
      };
      try {
        pen.setColor4f(color4f, colorSpace);
        console.info(msg + ' setColor4f successed');
        let color = pen.getColor4f();
        console.info(msg + ' getColor4f successed color is: ' + JSON.stringify(color));
        let dif_alpha = Math.abs(color.alpha - color4f.alpha);
        expect(dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color.red - color4f.red);
        expect(dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color.green - color4f.green);
        expect(dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color.blue - color4f.blue);
        expect(dif_blue < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        color4f = {
          alpha: 1,
          red: 1,
          green: 1,
          blue: 1
        };
        pen.setColor4f(color4f, colorSpace);
        let color2 = pen.getColor4f();
        console.info(msg + ' setColor4f 2 successed');
        let color = pen.getColor4f();
        console.info(msg + ' getColor4f 2 successed color2 is: ' + JSON.stringify(color2));
        let dif_alpha = Math.abs(color2.alpha - color4f.alpha);
        expect(dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color2.red - color4f.red);
        expect(dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color2.green - color4f.green);
        expect(dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color2.blue - color4f.blue);
        expect(dif_blue < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        color4f = {
          alpha: 0,
          red: 0,
          green: 0,
          blue: 0
        };
        pen.setColor4f(color4f, colorSpace);
        console.info(msg + ' setColor4f 3 successed');
        let color3 = pen.getColor4f();
        console.info(msg + ' getColor4f 3 successed color3 is: ' + JSON.stringify(color3));
        let dif_alpha = Math.abs(color3.alpha - color4f.alpha);
        expect(dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color3.red - color4f.red);
        expect(dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color3.green - color4f.green);
        expect(dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color3.blue - color4f.blue);
        expect(dif_blue < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        pen.setColor4f(color4f, null);
        console.info(msg + ' setColor4f 4 successed');
        let color4 = pen.getColor4f();
        console.info(msg + ' getColor4f 4 successed color4 is: ' + JSON.stringify(color4));
        let dif_alpha = Math.abs(color4.alpha - color4f.alpha);
        expect(dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color4.red - color4f.red);
        expect(dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color4.green - color4f.green);
        expect(dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color4.blue - color4f.blue);
        expect(dif_blue < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2000
     * @tc.name      : testPenSetAndGetColor4fNull0020
     * @tc.desc      : testPenSetAndGetColor4fNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPenSetAndGetColor4fNull0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetAndGetColor4fNull0020';
      const pen = new drawing.Pen();
      let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG);
      try {
        pen.setColor4f(null, colorSpace);
        console.info(msg + `setColor4f 1 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `setColor4f 1 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        pen.setColor4f(undefined, colorSpace);
        console.info(msg + `setColor4f 2 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `setColor4f 2 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        pen.setColor4f(null, null);
        console.info(msg + `setColor4f 3 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `setColor4f 3 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2100
     * @tc.name      : testPenSetAndGetColor4fMultipleCalls0021
     * @tc.desc      : testPenSetAndGetColor4fMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPenSetAndGetColor4fMultipleCalls0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetAndGetColor4fMultipleCalls0021';
      try {
        for (let i = 0; i < 20; i += 1) {
          const pen = new drawing.Pen();
          let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG);
          let color4f: common2D.Color4f = {
            alpha: Math.random() * 1,
            red: Math.random() * 1,
            green: Math.random() * 1,
            blue: Math.random() * 1
          };
          console.info(msg + 'setColor4f  color4f is ' + JSON.stringify(color4f) + ' step: ' + i);
          pen.setColor4f(color4f, colorSpace);
          console.info(msg + 'setColor4f success step is ' + i);
          let color = pen.getColor4f();
          console.info(msg + 'getColor4f success color is ' + JSON.stringify(color) + ' step: ' + i);
          let dif_alpha = Math.abs(color.alpha - color4f.alpha);
          expect(dif_alpha < 0.0001).assertEqual(true);
          let dif_red = Math.abs(color.red - color4f.red);
          expect(dif_red < 0.0001).assertEqual(true);
          let dif_green = Math.abs(color.green - color4f.green);
          expect(dif_green < 0.0001).assertEqual(true);
          let dif_blue = Math.abs(color.blue - color4f.blue);
          expect(dif_blue < 0.0001).assertEqual(true);
        }
      } catch (e) {
        console.info(msg + `isInterpolate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_2200
     * @tc.name      : testPenSetAndGetColor4fBoundaryValue0022
     * @tc.desc      : testPenSetAndGetColor4fBoundaryValue
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPenSetAndGetColor4fBoundaryValue0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetAndGetColor4fBoundaryValue0022';
      const pen = new drawing.Pen();
      try {
        pen.setColor4f({
          alpha: 1.1,
          red: 1,
          green: 1,
          blue: 1
        }, null);
        console.info(msg + `setColor4f 1 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 1 errorCode is:  ${e.code} + errormsg is: ${e.message} `);
        expect().assertFail()
      }
      try {
        pen.setColor4f({
          alpha: -0.999,
          red: 1,
          green: 1,
          blue: 1
        }, null);
        console.info(msg + `setColor4f 2 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        pen.setColor4f({
          alpha: 1,
          red: 1.1,
          green: 1,
          blue: 1
        }, null);
        console.info(msg + `setColor4f 3 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        pen.setColor4f({
          alpha: 1,
          red: -0.999,
          green: 1,
          blue: 1
        }, null);
        console.info(msg + `setColor4f 4 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        pen.setColor4f({
          alpha: 1,
          red: 1,
          green: 1.1,
          blue: 1
        }, null);
        console.info(msg + `setColor4f 5 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        pen.setColor4f({
          alpha: 1,
          red: 1,
          green: -0.999,
          blue: 1
        }, null);
        console.info(msg + `setColor4f 6 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        pen.setColor4f({
          alpha: 1,
          red: 1,
          green: 1,
          blue: 1.1
        }, null);
        console.info(msg + `setColor4f 7 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        pen.setColor4f({
          alpha: 1,
          red: 1,
          green: 1,
          blue: -0.999
        }, null);
        console.info(msg + `setColor4f 8 successes`);
      } catch (e) {
        console.info(msg + `setColor4f 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })
  })
}