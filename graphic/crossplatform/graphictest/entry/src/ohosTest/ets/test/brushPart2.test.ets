/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { getEnumCount, getRandomNumber } from './utils';
import colorSpaceManager from '@ohos.graphics.colorSpaceManager';

export default function brushTestPart2() {
  describe('DrawingTsBrushTest', () => {
    beforeAll(async () => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_0100
     * @tc.name      : testSetColor0001
     * @tc.desc      : Test for testBrushSetColorNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetColor0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetColorNormal';
      let brush = new drawing.Brush();
      let colors: Array<common2D.Color> = [
        {
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        },
        {
          alpha: 245.3,
          red: 251.1,
          green: 10.1,
          blue: 12.1
        },
      ];
      for (let i = 0; i < colors.length; i++) {
        try {
          brush.setColor(colors[i]);
          console.info(msg + ` setColor succeeded`);
        } catch (e) {
          console.info(msg + ` setColor failed. Error code is: ${e.code}. Error message is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_0200
     * @tc.name      : testSetColor0002
     * @tc.desc      : Test for testBrushSetColorNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColorNull';
      let brush = new drawing.Brush();
      let colors: Array<Partial<common2D.Color>> = [
        {
          alpha: undefined,
          red: 0x00,
          green: 0xFF,
          blue: 0x00
        },
        {
          alpha: 0xFF,
          red: undefined,
          green: 0xFF,
          blue: 0x00
        },
        {
          alpha: 0xFF,
          red: 0x00,
          green: undefined,
          blue: 0x00
        },
        {
          alpha: 0xFF,
          red: 0x00,
          green: 0xFF,
          blue: undefined
        },
        {
          alpha: undefined,
          red: 0x00,
          green: 0xFF,
          blue: 0x00
        },
        {
          alpha: 0xFF,
          red: undefined,
          green: 0xFF,
          blue: 0x00
        },
        {
          alpha: 0xFF,
          red: 0x00,
          green: undefined,
          blue: 0x00
        },
        {
          alpha: 0xFF,
          red: 0x00,
          green: 0xFF,
          blue: undefined
        },
      ];
      for (let i = 0; i < colors.length; i++) {
        try {
          brush.setColor(colors[i] as common2D.Color);
          console.info(msg + ` setColor succeeded`);
        } catch (e) {
          console.info(msg + ` setColor failed. Error code is: ${e.code}. Error message is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_0300
     * @tc.name      : testSetColor0003
     * @tc.desc      : Test for testBrushSetColorMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColorMultipleCalls';
      let brush = new drawing.Brush();
      for (let i = 0; i < 20; i++) {
        let alpha = Math.floor(Math.random() * 256);
        let red = Math.floor(Math.random() * 256);
        let green = Math.floor(Math.random() * 256);
        let blue = Math.floor(Math.random() * 256);
        try {
          brush.setColor({
            alpha,
            red,
            green,
            blue
          });
          console.info(msg + ' setColor successed');
        } catch (e) {
          console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_0400
     * @tc.name      : testSetColor0004
     * @tc.desc      : Test for testBrushSetColorBoundaryValue.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColorBoundaryValue';
      let brush = new drawing.Brush();
      let colors: Array<common2D.Color> = [
        {
          alpha: -1,
          red: 255,
          green: 0,
          blue: 255
        },
        {
          alpha: 256,
          red: 255,
          green: 0,
          blue: 255
        },
        {
          alpha: 255,
          red: -2,
          green: 0,
          blue: 255
        },
        {
          alpha: 255,
          red: 256,
          green: 0,
          blue: 255
        },
        {
          alpha: 255,
          red: 255,
          green: 256,
          blue: 255
        },
        {
          alpha: 255,
          red: 255,
          green: -1,
          blue: 255
        },
        {
          alpha: 255,
          red: 255,
          green: 0,
          blue: -1
        },
        {
          alpha: 255,
          red: 255,
          green: 0,
          blue: 256
        },
      ];
      for (let i = 0; i < colors.length; i++) {
        try {
          brush.setColor(colors[i]);
          console.info(msg + ' setColor successed');
        } catch (e) {
          console.info(msg + ` setColor errorCode is:  ${e.code} + errormsg is: ${e.message}`)
          expect(e.code).assertEqual(401);
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETANTIALIAS_0500
     * @tc.name      : testSetAntiAlias0005
     * @tc.desc      : Test for testBrushSetAntiAliasNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetAntiAlias0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetAntiAliasNormal';
      let brush = new drawing.Brush();

      try {
        brush.setAntiAlias(true);
        console.info(msg + ' setAntiAlias successed');
      } catch (e) {
        console.info(msg + ` setAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setAntiAlias(false);
        console.info(msg + ' setAntiAlias successed');
      } catch (e) {
        console.info(msg + ` setAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETANTIALIAS_0600
     * @tc.name      : testSetAntiAlias0006
     * @tc.desc      : Test for testBrushSetAntiAliasNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetAntiAlias0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetAntiAliasNull';
      let brush = new drawing.Brush();

      try {
        brush.setAntiAlias(undefined);
        console.info(msg + ' setAntiAlias successed');
      } catch (e) {
        console.info(msg + ` setAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        brush.setAntiAlias(null);
        console.info(msg + ' setAntiAlias successed');
      } catch (e) {
        console.info(msg + ` setAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETANTIALIAS_0700
     * @tc.name      : testSetAntiAlias0007
     * @tc.desc      : Test for testBrushSetAntiAliasMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetAntiAlias0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetAntiAliasMultipleCalls';
      let brush = new drawing.Brush();
      for (let i = 0; i < 20; i++) {
        try {
          let randomBoolean = Math.random() < 0.5;
          brush.setAntiAlias(randomBoolean);
          console.info(msg + ' setAntiAlias successed');
        } catch (e) {
          console.info(msg + ` setAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETALPHA_0800
     * @tc.name      : testSetAlpha0008
     * @tc.desc      : Test for testBrushSetAlphaNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetAlpha0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetAlphaNormal';
      let brush = new drawing.Brush();

      try {
        brush.setAlpha(255);
        console.info(msg + ' setAlpha successed');
      } catch (e) {
        console.info(msg + ` setAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setAlpha(0);
        console.info(msg + ' setAlpha successed');
      } catch (e) {
        console.info(msg + ` setAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setAlpha(255.562);
        console.info(msg + ' setAlpha successed');
      } catch (e) {
        console.info(msg + ` setAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETALPHA_0900
     * @tc.name      : testSetAlpha0009
     * @tc.desc      : Test for testBrushSetAlphaNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetAlpha0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetAlphaNull';
      let brush = new drawing.Brush();

      try {
        brush.setAlpha(undefined);
        console.info(msg + ' setAlpha successed');
      } catch (e) {
        console.info(msg + ` setAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        brush.setAlpha(null);
        console.info(msg + ' setAlpha successed');
      } catch (e) {
        console.info(msg + ` setAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETALPHA_1000
     * @tc.name      : testSetAlpha0010
     * @tc.desc      : Test for testBrushSetAlphaMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetAlpha0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetAlphaMultipleCalls';
      try {
        let brush = new drawing.Brush();
        for (let i = 0; i < 20; i++) {
          let randomAlpha = Math.floor(Math.random() * 256);
          brush.setAlpha(randomAlpha);
        }
        console.info(msg + ' setAlpha successed');
      } catch (e) {
        console.info(msg + ` setAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLORFILTER_1100
     * @tc.name      : testSetColorFilter0011
     * @tc.desc      : Test for testBrushSetColorFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetColorFilter0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetColorFilterNormal';
      try {
        let brush = new drawing.Brush();
        brush.setColorFilter(drawing.ColorFilter.createLinearToSRGBGamma());
        console.info(msg + ' setColorFilter successed');
      } catch (e) {
        console.info(msg + ` setColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLORFILTER_1200
     * @tc.name      : testSetColorFilter0012
     * @tc.desc      : Test for testBrushSetColorFilterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColorFilter0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColorFilterNull';
      let brush = new drawing.Brush();

      try {
        brush.setColorFilter(undefined);
        console.info(msg + ' setColorFilter successed');
      } catch (e) {
        console.info(msg + ` setColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        brush.setColorFilter(null);
        console.info(msg + ' setColorFilter successed');
      } catch (e) {
        console.info(msg + ` setColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLORFILTER_1300
     * @tc.name      : testSetColorFilter0013
     * @tc.desc      : Test for testBrushSetColorFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColorFilter0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColorFilterMultipleCalls';
      let brush = new drawing.Brush();
      try {
        for (let i = 0; i < 20; i++) {
          brush.setColorFilter(drawing.ColorFilter.createLinearToSRGBGamma());
        }
        console.info(msg + ' setColorFilter successed');
      } catch (e) {
        console.info(msg + ` setColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETMASKFILTER_1400
     * @tc.name      : testSetMaskFilter0014
     * @tc.desc      : Test for testBrushSetMaskFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetMaskFilter0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetMaskFilterNormal';
      try {
        let brush = new drawing.Brush();
        brush.setMaskFilter(drawing.MaskFilter.createBlurMaskFilter(drawing.BlurType.OUTER, 10));
        console.info(msg + ' setMaskFilter successed');
      } catch (e) {
        console.info(msg + ` setMaskFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETMASKFILTER_1500
     * @tc.name      : testSetMaskFilter0015
     * @tc.desc      : Test for testBrushSetMaskFilterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetMaskFilter0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetMaskFilterNull';
      try {
        let brush = new drawing.Brush();
        brush.setMaskFilter(undefined);
        brush.setMaskFilter(null);
        console.info(msg + ' setMaskFilter successed');
      } catch (e) {
        console.info(msg + ` setMaskFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETMASKFILTER_1600
     * @tc.name      : testSetMaskFilter0016
     * @tc.desc      : Test for testBrushSetMaskFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetMaskFilter0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetMaskFilterMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          let type = Math.floor(Math.random() * 4);
          brush.setMaskFilter(drawing.MaskFilter.createBlurMaskFilter(type, 10));
          console.info(msg + ' setMaskFilter successed');
        } catch (e) {
          console.info(msg + ` setMaskFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETSHADOWLAYER_1700
     * @tc.name      : testSetShadowLayer0017
     * @tc.desc      : Test for testBrushSetShadowLayerNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetShadowLayer0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetShadowLayerNormal';
      try {
        let brush = new drawing.Brush();
        brush.setShadowLayer(drawing.ShadowLayer.create(3, -3, 3, {
          alpha: 0xFF,
          red: 0x00,
          green: 0xFF,
          blue: 0x00
        }));
        console.info(msg + ' setShadowLayer successed');
      } catch (e) {
        console.info(msg + ` setShadowLayer errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETSHADOWLAYER_1800
     * @tc.name      : testSetShadowLayer0018
     * @tc.desc      : Test for testBrushSetShadowLayerNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetShadowLayer0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetShadowLayerNull';
      let brush = new drawing.Brush();

      try {
        brush.setShadowLayer(undefined);
        console.info(msg + ' setShadowLayer successed');
      } catch (e) {
        console.info(msg + ` setShadowLayer errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        brush.setShadowLayer(null);
        console.info(msg + ' setShadowLayer successed');
      } catch (e) {
        console.info(msg + ` setShadowLayer errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETSHADOWLAYER_1900
     * @tc.name      : testSetShadowLayer0019
     * @tc.desc      : Test for testBrushSetShadowLayerMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetShadowLayer0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetShadowLayerMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          let radius = Math.floor(getRandomNumber(1, 100));
          let dx = Math.floor(Math.random() * 100);
          let dy = Math.floor(Math.random() * 100);
          let color: common2D.Color = {
            alpha: Math.floor(Math.random() * 256),
            red: Math.floor(Math.random() * 256),
            green: Math.floor(Math.random() * 256),
            blue: Math.floor(Math.random() * 256),
          };
          brush.setShadowLayer(drawing.ShadowLayer.create(radius, dx, dy, color));
          console.info(msg + ' setShadowLayer successed');
        } catch (e) {
          console.info(msg + ` setShadowLayer errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETBLENDMODE_2000
     * @tc.name      : testSetBlendMode0020
     * @tc.desc      : Test for testBrushSetBlendModeNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetBlendMode0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetBlendModeNormal';
      let brush = new drawing.Brush();
      try {
        brush.setBlendMode(drawing.BlendMode.CLEAR);
        brush.setBlendMode(drawing.BlendMode.SRC);
        brush.setBlendMode(drawing.BlendMode.DST);
        brush.setBlendMode(drawing.BlendMode.SRC_OVER);
        brush.setBlendMode(drawing.BlendMode.DST_OVER);
        brush.setBlendMode(drawing.BlendMode.SRC_IN);
        brush.setBlendMode(drawing.BlendMode.DST_IN);
        brush.setBlendMode(drawing.BlendMode.SRC_OUT);
        brush.setBlendMode(drawing.BlendMode.DST_OUT);
        brush.setBlendMode(drawing.BlendMode.SRC_ATOP);
        brush.setBlendMode(drawing.BlendMode.DST_ATOP);
        brush.setBlendMode(drawing.BlendMode.XOR);
        brush.setBlendMode(drawing.BlendMode.PLUS);
        brush.setBlendMode(drawing.BlendMode.MODULATE);
        brush.setBlendMode(drawing.BlendMode.SCREEN);
        brush.setBlendMode(drawing.BlendMode.OVERLAY);
        brush.setBlendMode(drawing.BlendMode.DARKEN);
        brush.setBlendMode(drawing.BlendMode.LIGHTEN);
        brush.setBlendMode(drawing.BlendMode.COLOR_DODGE);
        brush.setBlendMode(drawing.BlendMode.COLOR_BURN);
        brush.setBlendMode(drawing.BlendMode.HARD_LIGHT);
        brush.setBlendMode(drawing.BlendMode.SOFT_LIGHT);
        brush.setBlendMode(drawing.BlendMode.DIFFERENCE);
        brush.setBlendMode(drawing.BlendMode.EXCLUSION);
        brush.setBlendMode(drawing.BlendMode.MULTIPLY);
        brush.setBlendMode(drawing.BlendMode.HUE);
        brush.setBlendMode(drawing.BlendMode.SATURATION);
        brush.setBlendMode(drawing.BlendMode.COLOR);
        brush.setBlendMode(drawing.BlendMode.LUMINOSITY);
        console.info(msg + ' setBlendMode successed');
      } catch (e) {
        console.info(msg + ` setBlendMode errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETBLENDMODE_2100
     * @tc.name      : testSetBlendMode0021
     * @tc.desc      : Test for testBrushSetBlendModeNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetBlendMode0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetBlendModeNull';
      let brush = new drawing.Brush();

      try {
        brush.setBlendMode(undefined);
        console.info(msg + ' setBlendMode successed');
      } catch (e) {
        console.info(msg + ` setBlendMode errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        brush.setBlendMode(null);
        console.info(msg + ' setBlendMode successed');
      } catch (e) {
        console.info(msg + ` setBlendMode errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETBLENDMODE_2200
     * @tc.name      : testSetBlendMode0022
     * @tc.desc      : Test for testBrushSetBlendModeMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetBlendMode0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetBlendModeMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          let randomEnum = Math.floor(Math.random() * getEnumCount(drawing.BlendMode));
          brush.setBlendMode(randomEnum);
          console.info(msg + ' setBlendMode successed');
        } catch (e) {
          console.info(msg + ` setBlendMode errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_2300
     * @tc.name      : testSetColor0023
     * @tc.desc      : testBrushSetColor12Normal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetColor0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetColor12Normal';
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, 0, 0);
        brush.setColor(245.3, 251.1, 10.1, 12.1);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_2400
     * @tc.name      : testSetColor0024
     * @tc.desc      : testBrushSetColor12Null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColor12Null';
      try {
        let brush = new drawing.Brush();
        brush.setColor(undefined, 255, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, undefined, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, undefined, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, 0, undefined);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(null, 255, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, null, 0, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, null, 0);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, 0, null);
        console.info(msg + 'setColor12 successed');
      } catch (e) {
        console.info(msg + `setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_2500
     * @tc.name      : testSetColor0025
     * @tc.desc      : testBrushSetColor12MultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColor12MultipleCalls';
      try {
        let brush = new drawing.Brush();
        for (let index = 0; index < 20; index++) {
          brush.setColor(Math.random() * 255, Math.random() * 255, Math.random() * 255, Math.random() * 255);
        }
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_2600
     * @tc.name      : testSetColor0026
     * @tc.desc      : testBrushSetColor12BoundaryValue
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColor12BoundaryValue';
      try {
        let brush = new drawing.Brush();
        brush.setColor(-1, 255, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, -1, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(256, 255, -1, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, 0, -1);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(256, 255, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 256, 0, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, 256, 0);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let brush = new drawing.Brush();
        brush.setColor(255, 255, 0, 256);
        console.info(msg + ' setColor12 successed');
      } catch (e) {
        console.info(msg + ` setColor12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETIMAGEFILTER_2700
     * @tc.name      : testSetImageFilter0027
     * @tc.desc      : Test for testBrushSetImageFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetImageFilter0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetImageFilterNormal';
      let brush = new drawing.Brush();
      let imgFilter = new drawing.ImageFilter();

      try {
        brush.setImageFilter(imgFilter);
        console.info(msg + ' setImageFilter successed');
      } catch (e) {
        console.info(msg + ` setImageFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setImageFilter(null);
        console.info(msg + ' setImageFilter(null) succeeded');
      } catch (e) {
        console.info(msg + ` setImageFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETIMAGEFILTER_2800
     * @tc.name      : testSetImageFilter0028
     * @tc.desc      : Test for testBrushSetImageFilterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetImageFilter0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetImageFilterNull';
      let brush = new drawing.Brush();

      try {
        brush.setImageFilter(undefined);
        console.info(msg + ' setImageFilter(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setImageFilter(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETIMAGEFILTER_2900
     * @tc.name      : testSetImageFilter0029
     * @tc.desc      : Test for testBrushSetImageFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetImageFilter0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetImageFilterMultipleCalls';
      let brush = new drawing.Brush();
      let imgFilter = new drawing.ImageFilter();

      for (let i = 0; i < 20; i++) {
        try {
          brush.setImageFilter(imgFilter);
          console.info(msg + ' setImageFilter succeeded');
        } catch (e) {
          console.info(msg + ` setImageFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_GETCOLORFILTER_3000
     * @tc.name      : testGetColorFilter0030
     * @tc.desc      : Test for testBrushGetColorFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetColorFilter0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushGetColorFilterNormal';
      let brush = new drawing.Brush();

      try {
        let cf = drawing.ColorFilter.createLumaColorFilter();
        let cf2 = brush.getColorFilter();
        console.info(msg + ' getColorFilter successed,cf:' + cf2);
      } catch (e) {
        console.info(msg + ` getColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_GETCOLORFILTER_3100
     * @tc.name      : testGetColorFilter0031
     * @tc.desc      : Test for testBrushGetColorFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetColorFilter0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushGetColorFilterMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          let cf2 = brush.getColorFilter();
          console.info(msg + ' getColorFilter successed,cf:' + cf2);
        } catch (e) {
          console.info(msg + ` getColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_GETALPHA_3200
     * @tc.name      : testGetAlpha0032
     * @tc.desc      : Test for testBrushGetAlphaNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetAlpha0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushGetAlphaNormal';
      let brush = new drawing.Brush();

      try {
        let alpha = brush.getAlpha();
        expect(alpha == 255).assertTrue();
        console.info(msg + ' getAlpha successed,alpha:' + alpha);
      } catch (e) {
        console.info(msg + ` getAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setAlpha(128);
        let alpha = brush.getAlpha();
        expect(alpha == 128).assertTrue();
        console.info(msg + ' getAlpha successed,alpha:' + alpha);
      } catch (e) {
        console.info(msg + ` getAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setAlpha(255.1);
        let alpha = brush.getAlpha();
        expect(alpha == 255).assertTrue();
        console.info(msg + ' getAlpha successed,alpha:' + alpha);
      } catch (e) {
        console.info(msg + ` getAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_GETALPHA_3300
     * @tc.name      : testGetAlpha0033
     * @tc.desc      : Test for testBrushGetAlphaMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetAlpha0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushGetAlphaMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          let alpha = brush.getAlpha();
          expect(alpha == 255).assertTrue();
          console.info(msg + ' getAlpha successed,alpha:' + alpha);
        } catch (e) {
          console.info(msg + ` getAlpha errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_ISANTIALIAS_3400
     * @tc.name      : testIsAntiAlias0034
     * @tc.desc      : Test for testBrushIsAntiAliasNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testIsAntiAlias0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushIsAntiAliasNormal';
      let brush = new drawing.Brush();

      try {
        let isAntiAlias = brush.isAntiAlias();
        expect(isAntiAlias == false).assertTrue();
        console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
      } catch (e) {
        console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setAntiAlias(true);
        let isAntiAlias = brush.isAntiAlias();
        expect(isAntiAlias == true).assertTrue();
        console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
      } catch (e) {
        console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setAntiAlias(false);
        let isAntiAlias = brush.isAntiAlias();
        expect(isAntiAlias == false).assertTrue();
        console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
      } catch (e) {
        console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_ISANTIALIAS_3500
     * @tc.name      : testIsAntiAlias0035
     * @tc.desc      : Test for testBrushIsAntiAliasMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testIsAntiAlias0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushIsAntiAliasMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          let isAntiAlias = brush.isAntiAlias();
          expect(isAntiAlias == false).assertTrue();
          console.info(msg + ' isAntiAlias successed,isAntiAlias:' + isAntiAlias);
        } catch (e) {
          console.info(msg + ` isAntiAlias errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_GETCOLOR_3600
     * @tc.name      : testGetColor0036
     * @tc.desc      : Test for testBrushGetColorNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetColor0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushGetColorNormal';
      let brush = new drawing.Brush();

      try {
        let colorGet = brush.getColor();
        expect(colorGet != null).assertTrue();
        console.info(msg + ' getColor successed,colorGet:' + JSON.stringify(colorGet));
      } catch (e) {
        console.info(msg + ` getColor1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let colors: common2D.Color = {
          alpha: 0,
          red: 0,
          green: 0,
          blue: 0
        }
        brush.setColor(colors);
        let colorGet = brush.getColor();
        expect(JSON.stringify(colorGet) == JSON.stringify(colors)).assertTrue();
        console.info(msg + ' getColor2 successed,colorGet:' + JSON.stringify(colorGet));
      } catch (e) {
        console.info(msg + ` getColor2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let colors: common2D.Color = {
          alpha: 255,
          red: 255,
          green: 255,
          blue: 255
        }
        brush.setColor(colors);
        let colorGet = brush.getColor();
        expect(JSON.stringify(colorGet) == JSON.stringify(colors)).assertTrue();
        console.info(msg + ' getColor3 successed,colorGet:' + JSON.stringify(colorGet));
      } catch (e) {
        console.info(msg + ` getColor3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_GETCOLOR_3700
     * @tc.name      : testGetColor0037
     * @tc.desc      : Test for testBrushGetColorMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetColor0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushGetColorMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          let colorGet = brush.getColor();
          expect(colorGet != null).assertTrue();
          console.info(msg + ' getColor successed');
        } catch (e) {
          console.info(msg + ` getColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETSHADEREFFECT_3800
     * @tc.name      : testSetShaderEffect0038
     * @tc.desc      : Test for testBrushSetShaderEffectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetShaderEffect0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetShaderEffectNormal';
      let brush = new drawing.Brush();
      let shaderEffect = new drawing.ShaderEffect();

      try {
        brush.setShaderEffect(shaderEffect);
        console.info(msg + ' setShaderEffect successed');
      } catch (e) {
        console.info(msg + ` setShaderEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setShaderEffect(null);
        console.info(msg + ' setShaderEffect successed');
      } catch (e) {
        console.info(msg + ` setShaderEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETSHADEREFFECT_3900
     * @tc.name      : testSetShaderEffect0039
     * @tc.desc      : Test for testBrushSetShaderEffectNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetShaderEffect0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetShaderEffectNull';
      let brush = new drawing.Brush();

      try {
        brush.setShaderEffect(undefined);
        console.info(msg + ' setShaderEffect(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setShaderEffect(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETSHADEREFFECT_4000
     * @tc.name      : testSetShaderEffect0040
     * @tc.desc      : Test for testBrushSetShaderEffectMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetShaderEffect0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetShaderEffectMultipleCalls';
      let brush = new drawing.Brush();
      let shaderEffect = new drawing.ShaderEffect();

      for (let i = 0; i < 20; i++) {
        try {
          brush.setShaderEffect(shaderEffect);
          console.info(msg + ' setShaderEffect succeeded');
        } catch (e) {
          console.info(msg + ` setShaderEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_RESET_4100
     * @tc.name      : testReset0041
     * @tc.desc      : Test for testBrushResetNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testReset0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushResetNormal';
      let brush = new drawing.Brush();

      try {
        brush.reset();
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        brush.setColor(255, 255, 0, 0);
        brush.reset();
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_RESET_4200
     * @tc.name      : testReset0042
     * @tc.desc      : Test for testBrushResetMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testReset0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushResetMultipleCalls';
      let brush = new drawing.Brush();

      for (let i = 0; i < 20; i++) {
        try {
          brush.reset();
          console.info(msg + ' reset succeeded');
        } catch (e) {
          console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR4F_4300
     * @tc.name      : testSetColor4f0043
     * @tc.desc      : Test for testBrushSetColor4fNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetColor4f0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testBrushSetColor4fNormal';
      let brush = new drawing.Brush();
      let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG); // 合法色域
      let color4f: common2D.Color4f;

      try {
        color4f = {
          alpha: 0.8,
          red: 0.5,
          green: 0.4,
          blue: 0.7
        };
        brush.setColor4f(color4f, colorSpace);
        console.info(msg + ' setColor4f (normal value) successed');
      } catch (e) {
        console.info(msg + ` setColor4f (normal) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        color4f = {
          alpha: 1,
          red: 1,
          green: 1,
          blue: 1
        };
        brush.setColor4f(color4f, colorSpace);
        console.info(msg + ' setColor4f (max value) successed');
      } catch (e) {
        console.info(msg + ` setColor4f (max) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        color4f = {
          alpha: 0,
          red: 0,
          green: 0,
          blue: 0
        };
        brush.setColor4f(color4f, colorSpace);
        console.info(msg + ' setColor4f (min value) successed');
      } catch (e) {
        console.info(msg + ` setColor4f (min) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        color4f = {
          alpha: 0,
          red: 0,
          green: 0,
          blue: 0
        };
        brush.setColor4f(color4f, null);
        console.info(msg + ' setColor4f (null colorSpace) successed');
      } catch (e) {
        console.info(msg + ` setColor4f (null colorSpace) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR4F_4400
     * @tc.name      : testSetColor4f0044
     * @tc.desc      : Test for testBrushSetColor4fNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor4f0044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColor4fInvalidParams';
      let brush = new drawing.Brush();
      let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG);

      try {
        brush.setColor4f(null, colorSpace);
        console.info(msg + ` setColor4f (null color) succeeded (unexpected)`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` setColor4f (null color) errorCode is: ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        brush.setColor4f(undefined, colorSpace);
        console.info(msg + ` setColor4f (undefined color) succeeded (unexpected)`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` setColor4f (undefined color) errorCode is: ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        brush.setColor4f(null, null);
        console.info(msg + ` setColor4f (null color + null space) succeeded (unexpected)`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` setColor4f (null color + null space) errorCode is: ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR4F_4500
     * @tc.name      : testSetColor4f0045
     * @tc.desc      : Test for testBrushSetColor4fMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor4f0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColor4fMultipleCalls';

      for (let i = 0; i < 20; i += 1) {
        try {
          let brush = new drawing.Brush();
          let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG);
          let randomColor4f: common2D.Color4f = {
            alpha: Math.random() * 1,
            red: Math.random() * 1,
            green: Math.random() * 1,
            blue: Math.random() * 1
          };
          console.info(msg + ` step ${i}: setColor4f with color = ${JSON.stringify(randomColor4f)}`);
          brush.setColor4f(randomColor4f, colorSpace);
          console.info(msg + ` step ${i}: setColor4f successed`);
        } catch (e) {
          console.info(msg + ` step ${i}: setColor4f errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR4F_4600
     * @tc.name      : testSetColor4f0046
     * @tc.desc      : Test for testBrushSetColor4fBoundaryValue.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetColor4f0046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testBrushSetColor4fBoundaryValue';
      let brush = new drawing.Brush();
      let testColor: common2D.Color4f;

      try {
        testColor = {
          alpha: 1.1,
          red: 1,
          green: 1,
          blue: 1
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (alpha>1) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (alpha>1) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        testColor = {
          alpha: -0.999,
          red: 1,
          green: 1,
          blue: 1
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (alpha<0) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (alpha<0) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        testColor = {
          alpha: 1,
          red: 1.1,
          green: 1,
          blue: 1
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (red>1) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (red>1) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        testColor = {
          alpha: 1,
          red: -0.999,
          green: 1,
          blue: 1
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (red<0) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (red<0) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        testColor = {
          alpha: 1,
          red: 1,
          green: 1.1,
          blue: 1
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (green>1) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (green>1) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        testColor = {
          alpha: 1,
          red: 1,
          green: -0.999,
          blue: 1
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (green<0) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (green<0) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        testColor = {
          alpha: 1,
          red: 1,
          green: 1,
          blue: 1.1
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (blue>1) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (blue>1) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        testColor = {
          alpha: 1,
          red: 1,
          green: 1,
          blue: -0.999
        };
        brush.setColor4f(testColor, null);
        console.info(msg + ` setColor4f (blue<0) successed`);
      } catch (e) {
        console.info(msg + ` setColor4f (blue<0) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLOR_4700
     * @tc.name      : testSetColor0047
     * @tc.desc      : Test for testBrushSetColor.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetColor0047', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let brush = new drawing.Brush();
        brush.setColor(null, 255, 0, 0);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of BrushSetColor Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of BrushSetColor Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETANTIALIAS_4800
     * @tc.name      : testSetAntiAlias0048
     * @tc.desc      : Test for testBrushSetAntiAlias.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetAntiAlias0048', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let brush = new drawing.Brush();
        brush.setAntiAlias(null);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of BrushSetAntiAlias Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of BrushSetAntiAlias Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETALPHA_4900
     * @tc.name      : testSetAlpha0049
     * @tc.desc      : Test for testBrushSetAlpha.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetAlpha0049', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let brush = new drawing.Brush();
        brush.setAlpha(null);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of BrushSetAlpha Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of BrushSetAlpha Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETCOLORFILTER_5000
     * @tc.name      : testSetColorFilter0050
     * @tc.desc      : Test for testBrushSetColorFilter.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetColorFilter0050', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let brush = new drawing.Brush();
        let colorFilter = drawing.ColorFilter.createLinearToSRGBGamma();
        brush.setColorFilter(null);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of BrushSetColorFilter Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of BrushSetColorFilter Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETMASKFILTER_5100
     * @tc.name      : testSetMaskFilter0051
     * @tc.desc      : Test for testBrushSetMaskFilter.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetMaskFilter0051', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let brush = new drawing.Brush();
        let maskFilter = drawing.MaskFilter.createBlurMaskFilter(drawing.BlurType.OUTER, 10);
        brush.setMaskFilter(null);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of BrushSetMaskFilter Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of BrushSetMaskFilter Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETSHADOWLAYER_5200
     * @tc.name      : testSetShadowLayer0052
     * @tc.desc      : Test for testBrushSetShadowLayer.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetShadowLayer0052', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let brush = new drawing.Brush();
        brush.setShadowLayer(null);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of BrushSetShadowLayer Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of BrushSetShadowLayer Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_SETBLENDMODE_5300
     * @tc.name      : testSetBlendMode0053
     * @tc.desc      : Test for testBrushSetBlendMode.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetBlendMode0053', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let brush = new drawing.Brush();
        brush.setBlendMode(null);
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of BrushSetBlendMode Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of BrushSetBlendMode Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_BRUSH_GETHEXCOLOR_5400
     * @tc.name      : testGetHexColor0054
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testGetHexColor0054', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = " ====testBrushGetHexColor==== "
      try {
        let color: common2D.Color = {
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        };
        let brush = new drawing.Brush();
        brush.setColor(color);
        let hex_color: number = brush.getHexColor();
        console.info(msg + ' brush.getHexColor:  ', hex_color.toString(16));
        console.info(msg + ' brush.getHexColor: ' + JSON.stringify(hex_color));
        done()
      } catch (err) {
        console.log(msg + " Faild in brush.getHexColor " + JSON.stringify(err))
        console.log(msg + " Faild in brush.getHexColor " + err)
        expect().assertFail()
        done()
      }
    })
  })
}
