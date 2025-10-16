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

export default function penPart3Test() {
  describe('DrawingTsPenTest', () => {
    beforeAll(async () => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETIMAGEFILTER_0100
     * @tc.name      : testSetImageFilter0001
     * @tc.desc      : Test for testPenSetImageFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetImageFilter0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetImageFilterNormal';
      let pen = new drawing.Pen();
      let imgFilter = new drawing.ImageFilter();

      try {
        pen.setImageFilter(imgFilter);
        console.info(msg + ' setImageFilter successed');
      } catch (e) {
        console.info(msg + ` setImageFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pen.setImageFilter(null);
        console.info(msg + ' setImageFilter(null) succeeded');
      } catch (e) {
        console.info(msg + ` setImageFilter(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETIMAGEFILTER_0200
     * @tc.name      : testSetImageFilter0002
     * @tc.desc      : Test for testPenSetImageFilterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetImageFilter0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetImageFilterNull';
      let pen = new drawing.Pen();

      try {
        pen.setImageFilter(undefined);
        console.info(msg + ' setImageFilter(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setImageFilter(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETIMAGEFILTER_0300
     * @tc.name      : testSetImageFilter0003
     * @tc.desc      : Test for testPenSetImageFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetImageFilter0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetImageFilterMultipleCalls';
      let pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        let imgFilter = new drawing.ImageFilter();
        try {
          pen.setImageFilter(imgFilter);
          console.info(msg + ' setImageFilter succeeded');
        } catch (e) {
          console.info(msg + ` setImageFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETMASKFILTER_0400
     * @tc.name      : testSetMaskFilter0004
     * @tc.desc      : Test for testPenSetMaskFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetMaskFilter0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetMaskFilterNormal';
      try {
        let pen = new drawing.Pen();
        pen.setMaskFilter(drawing.MaskFilter.createBlurMaskFilter(drawing.BlurType.OUTER, 10));
        console.info(msg + ' setMaskFilter successed');
      } catch (e) {
        console.info(msg + ` setMaskFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETMASKFILTER_0500
     * @tc.name      : testSetMaskFilter0005
     * @tc.desc      : Test for testPenSetMaskFilterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetMaskFilter0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetMaskFilterNull';
      let pen = new drawing.Pen();

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
     * @tc.number    : SUB_GRAPHIC_PEN_SETMASKFILTER_0600
     * @tc.name      : testSetMaskFilter0006
     * @tc.desc      : Test for testPenSetMaskFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetMaskFilter0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetMaskFilterMultipleCalls';
      let pen = new drawing.Pen();
      for (let i = 0; i < 20; i++) {
        try {
          let randomBlurType = Math.floor(Math.random() * 4);
          let randomValue = Math.floor(Math.random() * 100) + 1;
          pen.setMaskFilter(drawing.MaskFilter.createBlurMaskFilter(randomBlurType, randomValue));
          console.info(msg + ' setMaskFilter(' + randomBlurType + ', ' + randomValue + ') succeeded');
        } catch (e) {
          console.info(msg + ` setMaskFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETPATHEFFECT_0700
     * @tc.name      : testSetPathEffect0007
     * @tc.desc      : Test for testPenSetPathEffectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPathEffect0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetPathEffectNormal';
      let pen = new drawing.Pen();
      try {
        pen.setPathEffect(drawing.PathEffect.createDashPathEffect([30, 10], 0));
        console.info(msg + ' setPathEffect successed');
      } catch (e) {
        console.info(msg + ` setPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETPATHEFFECT_0800
     * @tc.name      : testSetPathEffect0008
     * @tc.desc      : Test for testPenSetPathEffectNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetPathEffect0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetPathEffectNull';
      let pen = new drawing.Pen();
      try {
        pen.setPathEffect(undefined);
        console.info(msg + ' setPathEffect(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setPathEffect(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setPathEffect(null);
        console.info(msg + ' setPathEffect(null) succeeded');
      } catch (e) {
        console.info(msg + ` setPathEffect(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETPATHEFFECT_0900
     * @tc.name      : testSetPathEffect0009
     * @tc.desc      : Test for testPenSetPathEffectMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetPathEffect0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetPathEffectMultipleCalls';
      let pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          let dashPathEffect = drawing.PathEffect.createDashPathEffect([30, 10], 0);
          pen.setPathEffect(dashPathEffect);
          console.info(msg + ' setPathEffect succeeded');
        } catch (e) {
          console.info(msg + ` setPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETSHADOWLAYER_1000
     * @tc.name      : testSetShadowLayer0010
     * @tc.desc      : Test for testPenSetShadowLayerNormal.
     * @tc.size      : MediuTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetShadowLayer0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetShadowLayerNormal';
      try {
        let pen = new drawing.Pen();
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
     * @tc.number    : SUB_GRAPHIC_PEN_SETSHADOWLAYER_1100
     * @tc.name      : testSetShadowLayer0011
     * @tc.desc      : Test for testPenSetShadowLayerNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetShadowLayer0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetShadowLayerNull';
      let pen = new drawing.Pen();
      try {
        pen.setShadowLayer(undefined);
        console.info(msg + ' setShadowLayer(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setShadowLayer(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setShadowLayer(null);
        console.info(msg + ' setShadowLayer(null) succeeded');
      } catch (e) {
        console.info(msg + ` setShadowLayer(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETSHADOWLAYER_1200
     * @tc.name      : testSetShadowLayer0012
     * @tc.desc      : Test for testPenSetShadowLayerMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetShadowLayer0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetShadowLayerMultipleCalls';
      let pen = new drawing.Pen();
      for (let i = 0; i < 20; i++) {
        try {
          let randomColor: common2D.Color = {
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
     * @tc.number    : SUB_GRAPHIC_PEN_SETBLENDMODE_1300
     * @tc.name      : testSetBlendMode0013
     * @tc.desc      : Test for testPenSetBlendModeNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetBlendMode0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetBlendModeNormal';
      try {
        let pen = new drawing.Pen();
        pen.setBlendMode(drawing.BlendMode.SRC);
        console.info(msg + ' setBlendMode successed');
      } catch (e) {
        console.info(msg + ` setBlendMode errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETBLENDMODE_1400
     * @tc.name      : testSetBlendMode0014
     * @tc.desc      : Test for testPenSetBlendModeNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetBlendMode0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetBlendModeNull';
      let pen = new drawing.Pen();

      try {
        pen.setBlendMode(undefined);
        console.info(msg + ' setBlendMode(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setBlendMode(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setBlendMode(null);
        console.info(msg + ' setBlendMode(null) succeeded');
      } catch (e) {
        console.info(msg + ` setBlendMode(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETBLENDMODE_1500
     * @tc.name      : testSetBlendMode0015
     * @tc.desc      : Test for testPenSetBlendModeMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetBlendMode0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetBlendModeMultipleCalls';
      let pen = new drawing.Pen();

      for (let i = 0; i < 20; i++) {
        try {
          let randomBlendMode = Math.floor(Math.random() * 29);
          pen.setBlendMode(randomBlendMode);
          console.info(msg + ' setBlendMode(' + randomBlendMode + ') succeeded');
        } catch (e) {
          console.info(msg + ` setBlendMode errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETBLENDMODE_1600
     * @tc.name      : testSetBlendMode0016
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetBlendMode0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let pen = new drawing.Pen();
        pen.setBlendMode(null);
        console.log('test enum value of PenSetBlendMode Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetBlendMode Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetBlendMode Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETDITHER_1700
     * @tc.name      : testSetDither0017
     * @tc.desc      : Test for testPenSetDitherNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetDither0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetDitherNormal';
      let pen = new drawing.Pen();
      try {
        pen.setDither(true);
        console.info(msg + ' setDither successed');
      } catch (e) {
        console.info(msg + ` setDither errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        pen.setDither(false);
        console.info(msg + ' setDither successed');
      } catch (e) {
        console.info(msg + ` setDither errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETDITHER_1800
     * @tc.name      : testSetDither0018
     * @tc.desc      : Test for testPenSetDitherNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetDither0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetDitherNull';
      let pen = new drawing.Pen();
      try {
        pen.setDither(undefined);
        console.info(msg + ' setDither(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setDither(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        pen.setDither(null);
        console.info(msg + ' setDither(null) succeeded');
      } catch (e) {
        console.info(msg + ` setDither(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETDITHER_1900
     * @tc.name      : testSetDither0019
     * @tc.desc      : Test for testPenSetDitherMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetDither0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetDitherMultipleCalls';
      let pen = new drawing.Pen();
      for (let i = 0; i < 20; i++) {
        try {
          let randomBoolean = Math.random() < 0.5;
          pen.setDither(randomBoolean);
          console.info(msg + ' setDither(' + randomBoolean + ') succeeded');
        } catch (e) {
          console.info(msg + ` setDither errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETDITHER_2000
     * @tc.name      : testSetDither0020
     * @tc.desc      : Test for testPenSetDitherMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetDither0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let pen = new drawing.Pen();
        pen.setDither(null);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetDither Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetDither Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETJOINSTYLE_2100
     * @tc.name      : testSetJoinStyle0021
     * @tc.desc      : Test for testPenSetJoinStyleNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetJoinStyle0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetJoinStyleNormal';
      let pen = new drawing.Pen();
      try {
        pen.setJoinStyle(drawing.JoinStyle.ROUND_JOIN);
        pen.setJoinStyle(drawing.JoinStyle.MITER_JOIN);
        pen.setJoinStyle(drawing.JoinStyle.BEVEL_JOIN);
        console.info(msg + ' setJoinStyle successed');
      } catch (e) {
        console.info(msg + ` setJoinStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETJOINSTYLE_2200
     * @tc.name      : testSetJoinStyle0022
     * @tc.desc      : Test for testPenSetJoinStyleNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('estSetJoinStyle0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetJoinStyleInvalidParams';
      let pen = new drawing.Pen();
      try {
        pen.setJoinStyle(undefined);
        console.info(msg + ' setJoinStyle(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setJoinStyle(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.setJoinStyle(null);
        console.info(msg + ' setJoinStyle(null) succeeded');
      } catch (e) {
        console.info(msg + ` setJoinStyle(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETJOINSTYLE_2300
     * @tc.name      : testSetJoinStyle0023
     * @tc.desc      : Test for testPenSetJoinStyleMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetJoinStyle0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetJoinStyleMultipleCalls';
      let pen = new drawing.Pen();
      for (let i = 0; i < 20; i++) {
        try {
          let randomJoinStyle = Math.floor(Math.random() * 3);
          pen.setJoinStyle(randomJoinStyle);
        } catch (e) {
          console.info(msg + ` setJoinStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETJOINSTYLE_2400
     * @tc.name      : testGetJoinStyle0024
     * @tc.desc      : Test for testPenGetJoinStyleNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetJoinStyle0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetJoinStyle';
      let pen = new drawing.Pen();
      try {
        pen.setJoinStyle(drawing.JoinStyle.ROUND_JOIN);
        expect(pen.getJoinStyle()).assertEqual(drawing.JoinStyle.ROUND_JOIN);

        pen.setJoinStyle(drawing.JoinStyle.MITER_JOIN);
        expect(pen.getJoinStyle()).assertEqual(drawing.JoinStyle.MITER_JOIN);

        pen.setJoinStyle(drawing.JoinStyle.BEVEL_JOIN);
        expect(pen.getJoinStyle()).assertEqual(drawing.JoinStyle.BEVEL_JOIN);

        console.info(msg + ' getJoinStyle successed');
      } catch (e) {
        console.info(msg + ` getJoinStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETJOINSTYLE_2500
     * @tc.name      : testGetJoinStyle0025
     * @tc.desc      : Test for testPenGetJoinStyleMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetJoinStyle0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenGetJoinStyleMultipleCalls';
      let pen = new drawing.Pen();
      pen.setJoinStyle(drawing.JoinStyle.ROUND_JOIN);
      for (let i = 0; i < 20; i++) {
        try {
          pen.getJoinStyle();
        } catch (e) {
          console.info(msg + ` getJoinStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETJOINSTYLE_2600
     * @tc.name      : testGetJoinStyle0026
     * @tc.desc      : Test for testPenGetJoinStyleDefault.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetJoinStyle0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let msg = 'testPenGetJoinStyleDefault';
      let pen = new drawing.Pen();
      try {
        pen.getJoinStyle();
        console.info(msg + ' getJoinStyle successed');
      } catch (e) {
        console.info(msg + ` getJoinStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETCAPSTYLE_2700
     * @tc.name      : testSetCapStyle0027
     * @tc.desc      : Test for testPenSetCapStyleNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetCapStyle0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenSetCapStyleNormal';
      let pen = new drawing.Pen();
      try {
        pen.setCapStyle(drawing.CapStyle.SQUARE_CAP);
        pen.setCapStyle(drawing.CapStyle.FLAT_CAP);
        pen.setCapStyle(drawing.CapStyle.ROUND_CAP);
        console.info(msg + ' setCapStyle successed');
      } catch (e) {
        console.info(msg + ` setCapStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETCAPSTYLE_2800
     * @tc.name      : testSetCapStyle0028
     * @tc.desc      : Test for testPenSetCapStyleNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetCapStyle0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetCapStyleInvalidParams';
      let pen = new drawing.Pen();
      try {
        pen.setCapStyle(undefined);
        console.info(msg + ' setCapStyle(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` setCapStyle(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        pen.setCapStyle(null);
        console.info(msg + ' setCapStyle(null) succeeded');
      } catch (e) {
        console.info(msg + ` setCapStyle(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETCAPSTYLE_2900
     * @tc.name      : testSetCapStyle0029
     * @tc.desc      : Test for testPenSetCapStyleMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetCapStyle0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenSetCapStyleMultipleCalls';
      let pen = new drawing.Pen();
      for (let i = 0; i < 20; i++) {
        try {
          let randomCapStyle = Math.floor(Math.random() * 3);
          pen.setCapStyle(randomCapStyle);
          console.info(msg + ` setCapStyle(${randomCapStyle}) succeeded`);
        } catch (e) {
          console.info(msg + ` setCapStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_SETCAPSTYLE_3000
     * @tc.name      : testSetCapStyle0030
     * @tc.desc      : Test for testPenSetCapStyleNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetCapStyle0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        pen.setCapStyle(null);
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetCapStyle Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetCapStyle Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETCAPSTYLE_3100
     * @tc.name      : testGetCapStyle0031
     * @tc.desc      : Test for testPenGetCapStyleNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetCapStyle0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetCapStyleMatchSet';
      let pen = new drawing.Pen();
      try {
        pen.setCapStyle(drawing.CapStyle.SQUARE_CAP);
        expect(pen.getCapStyle()).assertEqual(drawing.CapStyle.SQUARE_CAP);
        pen.setCapStyle(drawing.CapStyle.FLAT_CAP);
        expect(pen.getCapStyle()).assertEqual(drawing.CapStyle.FLAT_CAP);
        pen.setCapStyle(drawing.CapStyle.ROUND_CAP);
        expect(pen.getCapStyle()).assertEqual(drawing.CapStyle.ROUND_CAP);
        console.info(msg + ' getCapStyle matches set value successed');
      } catch (e) {
        console.info(msg + ` getCapStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETCAPSTYLE_3200
     * @tc.name      : testGetCapStyle0032
     * @tc.desc      : Test for testPenGetCapStyleNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetCapStyle0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenGetCapStyleMultipleCalls';
      let pen = new drawing.Pen();
      let presetCapStyle = drawing.CapStyle.ROUND_CAP;
      pen.setCapStyle(presetCapStyle);

      for (let i = 0; i < 20; i++) {
        try {
          pen.getCapStyle();
          console.info(msg + ' getCapStyle succeeded');
        } catch (e) {
          console.info(msg + ` getCapStyle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
      for (let i = 0; i < 20; i++) {
        try {
          let randomCapStyle = Math.floor(Math.random() * 3);
          pen.setCapStyle(randomCapStyle);
          let getCapStyle = pen.getCapStyle();
          expect(randomCapStyle).assertEqual(getCapStyle);
          console.info(msg + ` setCapStyle(${randomCapStyle}) and getCapStyle(${getCapStyle}) succeeded`);
        } catch (e) {
          console.info(msg + ` errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETCAPSTYLE_3300
     * @tc.name      : testGetCapStyle0033
     * @tc.desc      : Test for testPenGetCapStyleDefault.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCapStyle0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let msg = 'testPenGetCapStyleDefault';
      let pen = new drawing.Pen();

      try {
        pen.getCapStyle();
        console.info(msg + ' getCapStyle (default) successed');
      } catch (e) {
        console.info(msg + ` getCapStyle (default) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_RESET_3400
     * @tc.name      : testReset0034
     * @tc.desc      : Test for testPenResetNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testReset0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenResetNormal';
      let pen = new drawing.Pen();

      try {
        pen.reset();
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let brush_color: common2D.Color = {
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
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
     * @tc.number    : SUB_GRAPHIC_PEN_RESET_3500
     * @tc.name      : testReset0035
     * @tc.desc      : Test for testPenResetMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testReset0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenResetMultipleCalls';
      let pen = new drawing.Pen();
      for (let i = 0; i < 20; i++) {
        try {
          pen.reset();
          console.info(msg + ' reset succeeded');
        } catch (e) {
          console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETFILLPATH_3600
     * @tc.name      : testGetFillPath0036
     * @tc.desc      : Test for testPenGetFillPathNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetFillPath0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetFillPathNormal';
      let pen = new drawing.Pen();
      let pathSrc: drawing.Path = new drawing.Path();
      let pathDst: drawing.Path = new drawing.Path();

      try {
        let fillPath = pen.getFillPath(pathSrc, pathDst);
        expect(fillPath == false).assertTrue();
        console.info(msg + ' getFillPath successed,fillPath:' + fillPath);
      } catch (e) {
        console.info(msg + ` getFillPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        pathSrc.moveTo(0, 0);
        pathSrc.lineTo(100, 100);
        let fillPath = pen.getFillPath(pathSrc, pathDst);
        expect(fillPath == false).assertTrue();
        console.info(msg + ' getFillPath successed,fillPath:' + fillPath);
      } catch (e) {
        console.info(msg + ` getFillPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETFILLPATH_3700
     * @tc.name      : testGetFillPath0037
     * @tc.desc      : Test for testPenGetFillPathNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetFillPath0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPenGetFillPathNull';
      let pen = new drawing.Pen();
      let pathSrc: drawing.Path = new drawing.Path();
      let pathDst: drawing.Path = new drawing.Path();

      try {
        pen.getFillPath(null, pathDst);
        console.info(msg + ' getFillPath(null) succeeded');
      } catch (e) {
        console.info(msg + ` getFillPath(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.getFillPath(pathSrc, null);
        console.info(msg + ' getFillPath(null) succeeded');
      } catch (e) {
        console.info(msg + ` getFillPath(null) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.getFillPath(undefined, pathDst);
        console.info(msg + ' getFillPath(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` getFillPath(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        pen.getFillPath(pathSrc, undefined);
        console.info(msg + ' getFillPath(undefined) succeeded');
      } catch (e) {
        console.info(msg + ` getFillPath(undefined) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_PEN_GETFILLPATH_3800
     * @tc.name      : testGetFillPath0038
     * @tc.desc      : Test for testPenGetFillPathMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetFillPath0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPenGetFillPathMultipleCalls';
      let pen = new drawing.Pen();
      for (let i = 0; i < 20; i++) {
        let pathSrc: drawing.Path = new drawing.Path();
        let pathDst: drawing.Path = new drawing.Path();
        try {
          let fillPath = pen.getFillPath(pathSrc, pathDst);
          expect(fillPath == false).assertTrue();
          console.info(msg + ' getFillPath successed,fillPath:' + fillPath);
        } catch (e) {
          console.info(msg + ` getFillPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })
  })
}