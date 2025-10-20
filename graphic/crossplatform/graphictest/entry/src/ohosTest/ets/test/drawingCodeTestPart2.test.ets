/**
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from "@ohos/hypium"
import drawing from "@ohos.graphics.drawing"
import common2D from '@ohos.graphics.common2D';

export default function drawingCodeTestPart2() {
  describe('drawingCodeTest', () => {
    console.info('describe drawingCodeTest start!!!');
    beforeAll(() => {
      console.info('before all');
    })
    beforeEach(() => {
      console.info('before each');
    })
    afterEach(async (done: Function) => {
      console.info('afterEach');
      done();
    })
    afterAll(() => {
      console.info('afterAll');
    })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_ColorFilterCreateBlendModeColorFilter_0100
     * @tc.name      : testColorFilterCreateBlendModeColorFilter0001
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testColorFilterCreateBlendModeColorFilter0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const color: common2D.Color = {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          };
          let colorFilter = drawing.ColorFilter.createBlendModeColorFilter(null, drawing.BlendMode.SRC);
          console.log('test enum value of ColorFilterCreateBlendModeColorFilter Manager success');
          expect().assertFail();
          done();
        } catch (err) {
          if (err.code == 401) {
            console.log('test enum value of ColorFilterCreateBlendModeColorFilter Manager error' + err.code);
            done();
          } else {
            console.log('test enum value of ColorFilterCreateBlendModeColorFilter Manager error1' + JSON.stringify(err))
            expect().assertFail();
            done();
          }
        }
      })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_ColorFilterCreateComposeColorFilter_0200
     * @tc.name      : testColorFilterCreateComposeColorFilter0002
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testColorFilterCreateComposeColorFilter0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const color: common2D.Color = {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          };
          let colorFilter1 = drawing.ColorFilter.createBlendModeColorFilter(color, drawing.BlendMode.SRC);
          let colorFilter2 = drawing.ColorFilter.createBlendModeColorFilter(color, drawing.BlendMode.DST);
          let colorFilter = drawing.ColorFilter.createComposeColorFilter(null, null);
          console.log('test enum value of ColorFilterCreateComposeColorFilter Manager success');
          expect().assertFail();
          done();
        } catch (err) {
          if (err.code == 401) {
            console.log('test enum value of ColorFilterCreateComposeColorFilter Manager error' + err.code);
            done();
          } else {
            console.log('test enum value of ColorFilterCreateComposeColorFilter Manager error1' + JSON.stringify(err))
            expect().assertFail();
            done();
          }
        }
      })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_PenSetColor_0300
     * @tc.name      : testPenSetColor0003
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetColor0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const pen = new drawing.Pen();
        pen.setColor(null, 255, 0, 0);
        console.log('test enum value of PenSetColor Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetColor Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetColor Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_PenSetStrokeWidth_0400
     * @tc.name      : testPenSetStrokeWidth0004
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetStrokeWidth0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(null);
        console.log('test enum value of PenSetStrokeWidth Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetStrokeWidth Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetStrokeWidth Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_PenSetStrokeWidth_0500
     * @tc.name      : testPenSetStrokeWidth0005
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetStrokeWidth0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(null);
        console.log('test enum value of PenSetStrokeWidth Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetStrokeWidth Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetStrokeWidth Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_PenSetAntiAlias_0600
     * @tc.name      : testPenSetAntiAlias0006
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetAntiAlias0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const pen = new drawing.Pen();
        pen.setAntiAlias(null);
        console.log('test enum value of PenSetAntiAlias Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetAntiAlias Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetAntiAlias Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_PenSetJoinStyle_0700
     * @tc.name      : testPenSetJoinStyle0007
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetJoinStyle0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        pen.setJoinStyle(null);
        console.log('test enum value of PenSetJoinStyle Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PenSetJoinStyle Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of PenSetJoinStyle Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_DrawingCode_PenSetCapStyle_0800
     * @tc.name      : testPenSetCapStyle0008
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetCapStyle0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const pen = new drawing.Pen();
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
     * @tc.number    : SUB_GRAPHIC_DrawingCode_BrushSetColorFilter_0900
     * @tc.name      : testBrushSetColorFilter0009
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testBrushSetColorFilter0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const brush = new drawing.Brush();
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
     * @tc.number    : SUB_GRAPHIC_DrawingCode_BrushSetMaskFilter_1000
     * @tc.name      : testBrushSetMaskFilter0010
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testBrushSetMaskFilter0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        const brush = new drawing.Brush();
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
  })
}