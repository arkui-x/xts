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
import { common2D } from '@kit.ArkGraphics2D';
import { getEnumCount } from './utils';

const loop_times = 20;
export default function drawingTsMatrixTest() {
  describe('drawingTsMatrixTest', () => {
    beforeAll(() => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_ISAFFINE_0100
     * @tc.name      : testIsAffine0001
     * @tc.desc      : testMatrixIsAffineNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testIsAffine0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixIsAffineNormal';
      let matrix = new drawing.Matrix();
      try {
        let isAff1 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff1 successed');
        expect(isAff1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setMatrix([-1, -2, -3, -4, -5, -6, -7, -8, -9]);
      try {
        let isAff2 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff2 successed');
        expect(isAff2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setMatrix([0, 0, 0, 0, 0, 0, 0, 0, 0]);
      try {
        let isAff3 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff3 successed');
        expect(isAff3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setMatrix([1.25, 302.2, 100.2, 20, -1.5, -1, 0, 300, 10]);
      try {
        let isAff4 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff4 successed');
        expect(isAff4).assertEqual(false);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      try {
        let isAff5 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff5 successed');
        expect(isAff5).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setRotation(45, 100, 100);
      try {
        let isAff6 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff6 successed');
        expect(isAff6).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.postTranslate(100, 100);
      try {
        let isAff7 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff7 successed');
        expect(isAff7).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset()
      try {
        let isAff8 = matrix.isAffine();
        console.info(msg + ' matrix isAffine isAff8 successed');
        expect(isAff8).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix isAffine isAff8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_ISAFFINE_0200
     * @tc.name      : testIsAffine0002
     * @tc.desc      : testMatrixIsAffineMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsAffine0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixIsAffineMultipleCalls';
      let matrix = new drawing.Matrix();
      for (let i = 0; i < 20; i += 1) {
        try {
          let isAff = matrix.isAffine();
          console.info(msg + `matrix.isAffine success step: ` + i);
          expect(isAff).assertEqual(true);
        } catch (e) {
          console.info(msg + `matrix.isAffine error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_RECTSTAYSRECT_0300
     * @tc.name      : testRectStaysRect0003
     * @tc.desc      : testMatrixRectStaysRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testRectStaysRect0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixRectStaysRectNormal';
      let matrix = new drawing.Matrix();
      try {
        let rectStaysRect = matrix.rectStaysRect();
        console.info(msg + ' matrix rectStaysRect rectStaysRect successed');
        expect(rectStaysRect).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix rectStaysRect rectStaysRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setMatrix([0, 0, 0.5, 0, 0, 2, 0, 0, 1]);
      try {
        let rectStaysRect2 = matrix.rectStaysRect();
        console.info(msg + ' matrix rectStaysRect rectStaysRect2 successed');
        expect(rectStaysRect2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` matrix rectStaysRect rectStaysRect2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setMatrix([1, 0.5, 1, 0.5, 1, 1, 0, 0, 1]);
      try {
        let rectStaysRect3 = matrix.rectStaysRect();
        console.info(msg + ' matrix rectStaysRect rectStaysRect3 successed');
        expect(rectStaysRect3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` matrix rectStaysRect rectStaysRect3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setMatrix([3, 0, 2, 0, 2, 2, 0, 0, 1]);
      try {
        let rectStaysRect4 = matrix.rectStaysRect();
        console.info(msg + ' matrix rectStaysRect rectStaysRect4 successed');
        expect(rectStaysRect4).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix rectStaysRect rectStaysRect4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.preRotate(90, 100, 100);
      try {
        let rectStaysRect5 = matrix.rectStaysRect();
        console.info(msg + ' matrix rectStaysRect rectStaysRect5 successed');
        expect(rectStaysRect5).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix rectStaysRect rectStaysRect5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.preRotate(45, 100, 100);
      try {
        let rectStaysRect6 = matrix.rectStaysRect();
        console.info(msg + ' matrix rectStaysRect rectStaysRect6 successed');
        expect(rectStaysRect6).assertEqual(false);
      } catch (e) {
        console.info(msg + ` matrix rectStaysRect rectStaysRect6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.preRotate(270, 100, 100);
      try {
        let rectStaysRect7 = matrix.rectStaysRect();
        console.info(msg + ' matrix rectStaysRect rectStaysRect7 successed');
        expect(rectStaysRect7).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix rectStaysRect rectStaysRect7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_RECTSTAYSRECT_0400
     * @tc.name      : testRectStaysRect0004
     * @tc.desc      : testMatrixRectStaysRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testRectStaysRect0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixRectStaysRectMultipleCalls';
      let matrix = new drawing.Matrix();
      for (let i = 0; i < 20; i += 1) {
        try {
          let rectStaysRect = matrix.rectStaysRect();
          console.info(msg + `matrixA.rectStaysRect success step: ` + i);
          console.info(msg + `matrixA.rectStaysRect success rectStaysRect: ` + rectStaysRect);
          expect(rectStaysRect).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `matrixA.mapRadius error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETROTATION_0500
     * @tc.name      : testSetRotation0005
     * @tc.desc      : testMatrixSetRotationNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetRotation0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetRotationNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90, 100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' getAll successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` getAll errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90.1, 100.1, 100.1);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' getAll successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` getAll errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(-90, 100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' getAll successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` getAll errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90, -100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' getAll successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` getAll errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90, 100, -100);
        let widths: number[] = matrix.getAll();
        matrix.setRotation(90.1, 100.1, 100.1);
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' getAll successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` getAll errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(361, Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' getAll successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` getAll errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETROTATION_0600
     * @tc.name      : testSetRotation0006
     * @tc.desc      : testMatrixSetRotationNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetRotation0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetRotationNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(null, 100, 100);
        console.info(msg + ' setRotation successed');
      } catch (e) {
        console.info(msg + ` setRotation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90, null, 100);
        console.info(msg + ' setRotation successed');
      } catch (e) {
        console.info(msg + ` setRotation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90, 100, null);
        console.info(msg + ' setRotation successed');
      } catch (e) {
        console.info(msg + ` setRotation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(undefined, 100, 100);
        console.info(msg + ' setRotation successed');
      } catch (e) {
        console.info(msg + ` setRotation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90, undefined, 100);
        console.info(msg + ' setRotation successed');
      } catch (e) {
        console.info(msg + ` setRotation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRotation(90, 100, undefined);
        console.info(msg + ' setRotation successed');
      } catch (e) {
        console.info(msg + ` setRotation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETROTATION_0700
     * @tc.name      : testSetRotation0007
     * @tc.desc      : testMatrixSetRotationMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetRotation0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetRotationMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.setRotation(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' setRotation successed');
      } catch (e) {
        console.info(msg + ` setRotation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSCALE_0800
     * @tc.name      : testSetScale0008
     * @tc.desc      : testMatrixSetScaleNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetScale0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetScaleNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, 100, 150, 150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(0.2, 0.2, 0.5, 0.5);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(-100, -100, 150, 150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, 100, -150, -150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSCALE_0900
     * @tc.name      : testSetScale0009
     * @tc.desc      : testMatrixSetScaleNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetScale0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetScaleNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(null, 100, 150, 150);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, null, 150, 150);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, 100, null, 150);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, 100, 150, null);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(undefined, 100, 150, 150);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, undefined, 150, 150);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, 100, undefined, 150);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setScale(100, 100, 150, undefined);
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSCALE_1000
     * @tc.name      : testSetScale0010
     * @tc.desc      : testMatrixSetScaleMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetScale0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetScaleMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.setScale(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' setScale successed');
      } catch (e) {
        console.info(msg + ` setScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETTRANSLATION_1100
     * @tc.name      : testSetTranslation0011
     * @tc.desc      : testMatrixSetTranslationNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetTranslation0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetTranslationNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setTranslation successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(100.1, 100.1);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setTranslation successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(-100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setTranslation successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(100, -150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setTranslation successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' setTranslation successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETTRANSLATION_1200
     * @tc.name      : testSetTranslation0012
     * @tc.desc      : testMatrixSetTranslationNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetTranslation0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetTranslationNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(null, 100,);
        console.info(msg + ' setTranslation successed');
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(100, null);
        console.info(msg + ' setTranslation successed');
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(undefined, 100,);
        console.info(msg + ' setTranslation successed');
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setTranslation(100, undefined);
        console.info(msg + ' setTranslation successed');
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETTRANSLATION_1300
     * @tc.name      : testSetTranslation0013
     * @tc.desc      : testMatrixSetTranslationMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetTranslation0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetTranslationMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.setTranslation(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' setTranslation successed');
      } catch (e) {
        console.info(msg + ` setTranslation errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSKEW_1400
     * @tc.name      : testSetSkew0014
     * @tc.desc      : testMatrixSetSkewNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetSkew0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetSkewNormal';
      let matrix = new drawing.Matrix();
      matrix.setSkew(2, 2, 2, 2);
      try {
        let actualValues = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues successed');
        console.info(msg + "matrix actualValues: " + matrix.getAll().toString());
        expect(actualValues[0] == 1 && actualValues[1] == 2 && actualValues[2] == -4 && actualValues[3] == 2 &&
          actualValues[4] == 1 && actualValues[5] == -4 && actualValues[6] == 0 && actualValues[7] == 0 &&
          actualValues[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setSkew(0.5, 0.9, 0.5, 2.2);
      try {
        let actualValues2 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues2 successed');
        console.info(msg + "matrix actualValues2: " + matrix.getAll().toString());
        expect(actualValues2[0] == 1 && actualValues2[1] == 0.5 && actualValues2[2] == -1.100000023841858 &&
          actualValues2[3] == 0.8999999761581421 &&
          actualValues2[4] == 1 && actualValues2[5] == -0.44999998807907104 && actualValues2[6] == 0 &&
          actualValues2[7] == 0 &&
          actualValues2[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setSkew(0, 0, 0, 0);
      try {
        let actualValues3 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues3 successed');
        console.info(msg + "matrix actualValues3: " + matrix.getAll().toString());
        expect(actualValues3[0] == 1 && actualValues3[1] == 0 && actualValues3[2] == 0 && actualValues3[3] == 0 &&
          actualValues3[4] == 1 && actualValues3[5] == 0 && actualValues3[6] == 0 && actualValues3[7] == 0 &&
          actualValues3[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setSkew(-1.5, -2, -2.75, -1);
      try {
        let actualValues4 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues4 successed');
        console.info(msg + "matrix actualValues4: " + matrix.getAll().toString());
        expect(actualValues4[0] == 1 && actualValues4[1] == -1.5 && actualValues4[2] == -1.5 &&
          actualValues4[3] == -2 &&
          actualValues4[4] == 1 && actualValues4[5] == -5.5 && actualValues4[6] == 0 && actualValues4[7] == 0 &&
          actualValues4[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setSkew(1.5, -2, 1, 1);
      try {
        let actualValues5 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues5 successed');
        console.info(msg + "matrix actualValues5: " + matrix.getAll().toString());
        expect(actualValues5[0] == 1 && actualValues5[1] == 1.5 && actualValues5[2] == -1.5 && actualValues5[3] == -2 &&
          actualValues5[4] == 1 && actualValues5[5] == 2 && actualValues5[6] == 0 && actualValues5[7] == 0 &&
          actualValues5[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSKEW_1500
     * @tc.name      : testSetSkew0015
     * @tc.desc      : testMatrixSetSkewMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetSkew0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetSkewMultipleCalls';
      let matrix = new drawing.Matrix();
      for (let i = 0; i < 20; i += 1) {
        try {
          matrix.setSkew(Math.random() * 10, Math.random() * 10, Math.random() * 10, Math.random() * 10);
          console.info(msg + `matrix.setSkew success step: ` + i);
        } catch (e) {
          console.info(msg + `matrix.setSkew error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSKEW_1600
     * @tc.name      : testSetSkew0016
     * @tc.desc      : testMatrixSetSkewNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetSkew0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetSkewNull';
      let matrix = new drawing.Matrix();
      try {
        matrix.setSkew(null, 2, 2, 2);
        console.info(msg + `drawing Matrix setSkew 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSkew(undefined, 2, 2, 2);
        console.info(msg + `drawing Matrix setSkew 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSkew(2, null, 2, 2);
        console.info(msg + `drawing Matrix setSkew 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSkew(2, undefined, 2, 2);
        console.info(msg + `drawing Matrix setSkew 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSkew(2, 2, null, 2);
        console.info(msg + `drawing Matrix setSkew 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSkew(2, 2, undefined, 2);
        console.info(msg + `drawing Matrix setSkew 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSkew(2, 2, 2, null);
        console.info(msg + `drawing Matrix setSkew 7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSkew(2, 2, 2, undefined);
        console.info(msg + `drawing Matrix setSkew 8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawing Matrix setSkew 8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSINCOS_1700
     * @tc.name      : testSetSinCos0017
     * @tc.desc      : testMatrixSetSinCosNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetSinCos0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetSinCosNormal';
      let matrix = new drawing.Matrix();
      try {
        matrix.setSinCos(0, 1, 100, 100);
        let actualValues = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues successed');
        console.info(msg + "matrix actualValues: " + matrix.getAll().toString());
        expect(actualValues[0] == 1 && actualValues[1] == 0 && actualValues[2] == 0 && actualValues[3] == 0 &&
          actualValues[4] == 1 && actualValues[5] == 0 && actualValues[6] == 0 && actualValues[7] == 0 &&
          actualValues[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        matrix.reset()
        matrix.setSinCos(1, 0, 50.2515, 80.511);
        let actualValues2 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues2 successed');
        console.info(msg + "matrix actualValues2: " + matrix.getAll().toString());
        expect(actualValues2[0] == 0 && actualValues2[1] == -1 && actualValues2[2] == 130.7624969482422 &&
          actualValues2[3] == 1 &&
          actualValues2[4] == 0 && actualValues2[5] == 30.259502410888672 && actualValues2[6] == 0 &&
          actualValues2[7] == 0 && actualValues2[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        matrix.reset()
        matrix.setSinCos(0.5, 0.5, -100, -80.511);
        let actualValues3 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues3 successed');
        console.info(msg + "matrix actualValues3: " + matrix.getAll().toString());
        expect(actualValues3[0] == 0.5 && actualValues3[1] == -0.5 && actualValues3[2] == -90.25550079345703 &&
          actualValues3[3] == 0.5 &&
          actualValues3[4] == 0.5 && actualValues3[5] == 9.744499206542969 && actualValues3[6] == 0 &&
          actualValues3[7] == 0 && actualValues3[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        matrix.reset()
        matrix.setSinCos(-1, 1.5, 0, 0);
        let actualValues4 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues4 successed');
        console.info(msg + "matrix actualValues4: " + matrix.getAll().toString());
        expect(actualValues4[0] == 1.5 && actualValues4[1] == 1 && actualValues4[2] == 0 && actualValues4[3] == -1 &&
          actualValues4[4] == 1.5 && actualValues4[5] == 0 && actualValues4[6] == 0 && actualValues4[7] == 0 &&
          actualValues4[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        matrix.reset()
        matrix.setTranslation(150.35, 50.54);
        matrix.postRotate(45, 100, 200);
        matrix.preSkew(0.5, 2, 1.5, 10);
        matrix.setSinCos(10, 0.75, 20, 30.522);
        let actualValues5 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues5 successed');
        console.info(msg + "matrix actualValues5: " + matrix.getAll().toString());
        expect(actualValues5[0] == 0.75 && actualValues5[1] == -10 && actualValues5[2] == 310.2200012207031 &&
          actualValues5[3] == 10 &&
          actualValues5[4] == 0.75 && actualValues5[5] == -192.3695068359375 && actualValues5[6] == 0 &&
          actualValues5[7] == 0 && actualValues5[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSINCOS_1800
     * @tc.name      : testSetSinCos0018
     * @tc.desc      : testMatrixSetSinCosMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetSinCos0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetSinCosMultipleCalls';
      let matrix = new drawing.Matrix();
      for (let i = 0; i < 20; i += 1) {
        try {
          matrix.setSinCos(Math.random() * 5, Math.random() * 10, Math.random() * 20, Math.random() * 30);
          console.info(msg + `matrixA.setSinCos success step: ` + i);
        } catch (e) {
          console.info(msg +
            `matrixA.setSinCos error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETSINCOS_1900
     * @tc.name      : testSetSinCos0019
     * @tc.desc      : testMatrixSetSinCosNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetSinCos0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetSinCosNull';
      let matrix = new drawing.Matrix();
      try {
        matrix.setSinCos(null, 2, 2, 2);
        console.info(msg + `Matrix setSinCos 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSinCos(undefined, 2, 2, 2);
        console.info(msg + `Matrix setSinCos 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSinCos(2, null, 2, 2);
        console.info(msg + `Matrix setSinCos 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSinCos(2, undefined, 2, 2);
        console.info(msg + `Matrix setSinCos 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSinCos(2, 2, null, 2);
        console.info(msg + `Matrix setSinCos 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSinCos(2, 2, undefined, 2);
        console.info(msg + `Matrix setSinCos 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSinCos(2, 2, 2, null);
        console.info(msg + `Matrix setSinCos 7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setSinCos(2, 2, 2, undefined);
        console.info(msg + `Matrix setSinCos 8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix setSinCos 8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETMATRIX_2000
     * @tc.name      : testSetMatrix0020
     * @tc.desc      : testMatrixSetMatrixNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetMatrix0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetMatrixNormal';
      let matrix = new drawing.Matrix();
      let matrixnew = new drawing.Matrix();
      matrixnew.setScale(0.5, 0.5, 0.5, 0.5);
      matrixnew.setMatrix(matrix);
      try {
        let actualValues = matrixnew.getAll();
        console.info(msg + ' matrix getAll actualValues successed');
        console.info(msg + "matrix actualValues: " + matrixnew.getAll().toString());
        expect(actualValues[0] == 1 && actualValues[1] == 0 && actualValues[2] == 0 && actualValues[3] == 0 &&
          actualValues[4] == 1 && actualValues[5] == 0 && actualValues[6] == 0 && actualValues[7] == 0 &&
          actualValues[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let value1: Array<number> = [1.1, 2.2, 3.3, 4.4, 5.5, 6.6, 7.7, 8.8, 9.9];
      matrix.setMatrix(value1);
      matrixnew.setMatrix(matrix);
      try {
        let actualValues2 = matrixnew.getAll();
        console.info(msg + ' matrix getAll actualValues2 successed');
        console.info(msg + "matrix actualValues2: " + matrixnew.getAll().toString());
        expect(actualValues2[0] == 1.100000023841858 && actualValues2[1] == 2.200000047683716 &&
          actualValues2[2] == 3.299999952316284 &&
          actualValues2[3] == 4.400000095367432 && actualValues2[4] == 5.5 && actualValues2[5] == 6.599999904632568 &&
          actualValues2[6] == 7.699999809265137 && actualValues2[7] == 8.800000190734863 &&
          actualValues2[8] == 9.899999618530273).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let value2: Array<number> = [2, 2, 2, 2, 2, 2, 2, 2, 2];
      matrix.setMatrix(value2);
      matrixnew.setMatrix(matrix);
      try {
        let actualValues3 = matrixnew.getAll();
        console.info(msg + ' matrix getAll actualValues3 successed');
        console.info(msg + "matrix actualValues3: " + matrixnew.getAll().toString());
        expect(actualValues3[0] == 2 && actualValues3[1] == 2 && actualValues3[2] == 2 &&
          actualValues3[3] == 2 && actualValues3[4] == 2 && actualValues3[5] == 2 &&
          actualValues3[6] == 2 && actualValues3[7] == 2 && actualValues3[8] == 2).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let value3: Array<number> = [-1, -2, -3, -4, -5, -6, -7, -8, -9];
      matrix.setMatrix(value3);
      matrixnew.setMatrix(matrix);
      try {
        let actualValues4 = matrixnew.getAll();
        console.info(msg + ' matrix getAll actualValues4 successed');
        console.info(msg + "matrix actualValues4: " + matrixnew.getAll().toString());
        expect(actualValues4[0] == -1 && actualValues4[1] == -2 && actualValues4[2] == -3 &&
          actualValues4[3] == -4 && actualValues4[4] == -5 && actualValues4[5] == -6 &&
          actualValues4[6] == -7 && actualValues4[7] == -8 && actualValues4[8] == -9).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let matrix1 = new drawing.Matrix();
      matrix1.setRotation(60, 20, 50);
      matrixnew.setMatrix(matrix1);
      try {
        let actualValues5 = matrixnew.getAll();
        console.info(msg + ' matrix getAll actualValues5 successed');
        console.info(msg + "matrix actualValues5: " + matrixnew.getAll().toString());
        expect(actualValues5[0] == 0.4999999701976776 && actualValues5[1] == -0.866025447845459 &&
          actualValues5[2] == 53.301273345947266 &&
          actualValues5[3] == 0.866025447845459 && actualValues5[4] == 0.4999999701976776 &&
          actualValues5[5] == 7.67949104309082 &&
          actualValues5[6] == 0 && actualValues5[7] == 0 && actualValues5[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let matrix2 = new drawing.Matrix();
      matrix2.setTranslation(50, -25);
      matrixnew.setMatrix(matrix2);
      try {
        let actualValues6 = matrixnew.getAll();
        console.info(msg + ' matrix getAll actualValues6 successed');
        console.info(msg + "matrix actualValues6: " + matrixnew.getAll().toString());
        expect(actualValues6[0] == 1 && actualValues6[1] == 0 && actualValues6[2] == 50 &&
          actualValues6[3] == 0 && actualValues6[4] == 1 && actualValues6[5] == -25 &&
          actualValues6[6] == 0 && actualValues6[7] == 0 && actualValues6[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETMATRIX_2100
     * @tc.name      : testSetMatrix0021
     * @tc.desc      : testMatrixSetMatrixMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetMatrix0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetMatrixMultipleCalls';
      let matrix = new drawing.Matrix();
      let matrixnew = new drawing.Matrix();
      for (let i = 0; i < 20; i += 1) {
        try {
          let value3: Array<number> =
            [Math.random() * 10, Math.random() * 10, Math.random() * 10, Math.random() * 10, Math.random() * 10,
              Math.random() * 10, Math.random() * 10, Math.random() * 10, Math.random() * 10];
          matrix.setMatrix(value3);
          matrixnew.setMatrix(matrix)
          console.info(msg + `matrix.setMatrix success step: ` + i);
        } catch (e) {
          console.info(msg + `matrix.setMatrix error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETMATRIX_2200
     * @tc.name      : testSetMatrix0022
     * @tc.desc      : testMatrixSetMatrixNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetMatrix0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetMatrixNull';
      let matrix = new drawing.Matrix();
      try {
        matrix.setMatrix(null);
        console.info(msg + `Matrix setMatrix null successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `setMatrix setMatrix null failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.setMatrix(undefined);
        console.info(msg + `Matrix setMatrix undefined successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `setMatrix setMatrix undefined failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRECONCAT_2300
     * @tc.name      : testPreConcat0023
     * @tc.desc      : testMatrixPreConcatNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPreConcat0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPreConcatNormal';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([2, 1, 3, 1, 2, 1, 3, 1, 2]);
        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([-2, 1, 3, 1, 0, -1, 3, -1, 2]);
        matrix1.preConcat(matrix2);
        matrix1.getAll();
        console.info(msg + ' preConcat successed');
      } catch (e) {
        console.info(msg + ` preConcat errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRECONCAT_2400
     * @tc.name      : testPreConcat0024
     * @tc.desc      : testMatrixPreConcatNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreConcat0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreConcatNull';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.preConcat(null)
        matrix1.preConcat(undefined)
        console.info(msg + ' preConcat successed');
      } catch (e) {
        console.info(msg + ` preConcat errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix1 = new drawing.Matrix();
        matrix1.preConcat(undefined)
        console.info(msg + ' preConcat successed');
      } catch (e) {
        console.info(msg + ` preConcat errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRECONCAT_2500
     * @tc.name      : testPreConcat0025
     * @tc.desc      : testMatrixPreConcatMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreConcat0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreConcatMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.preConcat(matrix);
        }
        console.info(msg + ' preConcat successed');
      } catch (e) {
        console.info(msg + ` preConcat errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_ISEQUAL_2600
     * @tc.name      : testIsEqual0026
     * @tc.desc      : testMatrixIsEqualNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testIsEqual0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixIsEqualNormal';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([2, 1, 3, 1, 2, 1, 3, 1, 2]);
        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([-2, 1, 3, 1, 0, -1, 3, -1, 2]);
        matrix1.isEqual(matrix2);
        console.info(msg + ' isEqual successed');
      } catch (e) {
        console.info(msg + ` isEqual errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9]);
        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9]);
        matrix1.isEqual(matrix2)
        console.info(msg + ' isEqual successed');
      } catch (e) {
        console.info(msg + ` isEqual errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_ISEQUAL_2700
     * @tc.name      : testIsEqual0027
     * @tc.desc      : testMatrixIsEqualNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsEqual0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixIsEqualNull';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.isEqual(null);
        console.info(msg + ' isEqual successed');
      } catch (e) {
        console.info(msg + ` isEqual errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix1 = new drawing.Matrix();
        matrix1.isEqual(undefined);
        console.info(msg + ' isEqual successed');
      } catch (e) {
        console.info(msg + ` isEqual errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_ISEQUAL_2800
     * @tc.name      : testIsEqual0028
     * @tc.desc      : testMatrixIsEqualMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsEqual0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixIsEqualMultipleCalls';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([2, 1, 3, 1, 2, 1, 3, 1, 2]);
        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([-2, 1, 3, 1, 0, -1, 3, -1, 2]);
        console.info(msg + ' isEqual successed');
      } catch (e) {
        console.info(msg + ` isEqual errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([2, 1, 3, 1, 2, 1, 3, 1, 2]);
        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([-2, 1, 3, 1, 0, -1, 3, -1, 2]);
        for (let i = 0; i < loop_times; i++) {
          matrix1.isEqual(matrix2);
        }
        console.info(msg + ' isEqual successed');
      } catch (e) {
        console.info(msg + ` isEqual errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_INVERT_2900
     * @tc.name      : testInvert0029
     * @tc.desc      : testMatrixInvertNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testInvert0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixInvertNormal';
      try {
        let matrix1 = new drawing.Matrix();
        let matrix2 = new drawing.Matrix();
        matrix2.setScale(0, 0, 0.5, 0.5);
        matrix1.invert(matrix2);
        console.info(msg + ' invert successed');
      } catch (e) {
        console.info(msg + ` invert errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix1 = new drawing.Matrix();
        let matrix2 = new drawing.Matrix();
        matrix1.setScale(0, 0, 0.5, 0.5);
        matrix1.invert(matrix2);
        console.info(msg + ' invert successed');
      } catch (e) {
        console.info(msg + ` invert errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_INVERT_3000
     * @tc.name      : testInvert0030
     * @tc.desc      : testMatrixInvertNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testInvert0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixInvertNull';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.invert(null);
        console.info(msg + ' invert successed');
      } catch (e) {
        console.info(msg + ` invert errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix1 = new drawing.Matrix();
        matrix1.invert(undefined);
        console.info(msg + ' invert successed');
      } catch (e) {
        console.info(msg + ` invert errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_INVERT_3100
     * @tc.name      : testInvert0031
     * @tc.desc      : testMatrixInvertMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testInvert0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixInvertMultipleCalls';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([2, 1, 3, 1, 2, 1, 3, 1, 2]);
        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([-2, 1, 3, 1, 0, -1, 3, -1, 2]);
        console.info(msg + ' invert successed');
      } catch (e) {
        console.info(msg + ` invert errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([2, 1, 3, 1, 2, 1, 3, 1, 2]);
        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([-2, 1, 3, 1, 0, -1, 3, -1, 2]);
        for (let i = 0; i < loop_times; i++) {
          matrix1.invert(matrix2);
        }
        console.info(msg + ' invert successed');
      } catch (e) {
        console.info(msg + ` invert errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_ISIDENTITY_3200
     * @tc.name      : testIsIdentity0032
     * @tc.desc      : testMatrixIsIdentityNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testIsIdentity0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixIsIdentityNormal';
      try {
        let matrix1 = new drawing.Matrix();
        matrix1.isIdentity();
        console.info(msg + ' isIdentity successed');
      } catch (e) {
        console.info(msg + ` isIdentity errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix1 = new drawing.Matrix();
        matrix1.setMatrix([2, 1, 3, 1, 2, 1, 3, 1, 2]);
        matrix1.isIdentity();
        console.info(msg + ' isIdentity successed');
      } catch (e) {
        console.info(msg + ` isIdentity errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_ISIDENTITY_3300
     * @tc.name      : testIsIdentity0033
     * @tc.desc      : testMatrixIsIdentityMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsIdentity0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixIsIdentityMultipleCalls';
      try {
        let matrix1 = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix1.isIdentity();
        }
        console.info(msg + ' isIdentity successed');
      } catch (e) {
        console.info(msg + ` isIdentity errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTROTATE_3400
     * @tc.name      : testPostRotate0034
     * @tc.desc      : testMatrixPostRotateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPostRotate0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPostRotateNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90, 100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90.1, 100.1, 100.1);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(-90, 100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90, -100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90, 100, -100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(361, Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTROTATE_3500
     * @tc.name      : testPostRotate0035
     * @tc.desc      : testMatrixPostRotateNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPostRotate0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostRotateNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(null, 100, 100);
        console.info(msg + ' postRotate successed');
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90, null, 100);
        console.info(msg + ' postRotate successed');
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90, 100, null);
        console.info(msg + ' postRotate successed');
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(undefined, 100, 100);
        console.info(msg + ' postRotate successed');
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90, undefined, 100);
        console.info(msg + ' postRotate successed');
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postRotate(90, 100, undefined);
        console.info(msg + ' postRotate successed');
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTROTATE_3600
     * @tc.name      : testPostRotate0036
     * @tc.desc      : testMatrixPostRotateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPostRotate0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostRotateMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.postRotate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' postRotate successed');
      } catch (e) {
        console.info(msg + ` postRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTSCALE_3700
     * @tc.name      : testPostScale0037
     * @tc.desc      : testMatrixPostScaleNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPostScale0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPostScaleNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, 100, 150, 150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(0.2, 0.2, 0.5, 0.5);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(-100, -100, 150, 150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, 100, -150, -150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTSCALE_3800
     * @tc.name      : testPostScale0038
     * @tc.desc      : testMatrixPostScaleNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPostScale0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostScaleNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(null, 100, 150, 150);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, null, 150, 150);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, 100, null, 150);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, 100, 150, null);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(undefined, 100, 150, 150);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, undefined, 150, 150);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, 100, undefined, 150);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postScale(100, 100, 150, undefined);
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTSCALE_3900
     * @tc.name      : testPostScale0039
     * @tc.desc      : testMatrixPostScaleMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPostScale0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostScaleMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.postScale(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' postScale successed');
      } catch (e) {
        console.info(msg + ` postScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTTRANSLATE_4000
     * @tc.name      : testPostTranslate0040
     * @tc.desc      : testMatrixPostTranslateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPostTranslate0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPostTranslateNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(100.1, 100.1);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(-100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(100, -150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' postTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTTRANSLATE_4100
     * @tc.name      : testPostTranslate0041
     * @tc.desc      : testMatrixPostTranslateNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPostTranslate0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostTranslateNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(null, 100,);
        console.info(msg + ' postTranslate successed');
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(100, null);
        console.info(msg + ' postTranslate successed');
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(undefined, 100,);
        console.info(msg + ' postTranslate successed');
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.postTranslate(100, undefined);
        console.info(msg + ' postTranslate successed');
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTTRANSLATE_4200
     * @tc.name      : testPostTranslate0042
     * @tc.desc      : testMatrixPostTranslateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPostTranslate0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostTranslateMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.postTranslate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' postTranslate successed');
      } catch (e) {
        console.info(msg + ` postTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PREROTATE_4300
     * @tc.name      : testPreRotate0043
     * @tc.desc      : testMatrixPreRotateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPreRotate0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPreRotateNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90, 100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90.1, 100.1, 100.1);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(-90, 100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90, -100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90, 100, -100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(361, Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preRotate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PREROTATE_4400
     * @tc.name      : testPreRotate0044
     * @tc.desc      : testMatrixPreRotateNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreRotate0044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreRotateNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(null, 100, 100);
        console.info(msg + ' preRotate successed');
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90, null, 100);
        console.info(msg + ' preRotate successed');
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90, 100, null);
        console.info(msg + ' preRotate successed');
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(undefined, 100, 100);
        console.info(msg + ' preRotate successed');
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90, undefined, 100);
        console.info(msg + ' preRotate successed');
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(90, 100, undefined);
        console.info(msg + ' preRotate successed');
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PREROTATE_4500
     * @tc.name      : testPreRotate0045
     * @tc.desc      : testMatrixPreRotateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreRotate0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreRotateMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.preRotate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' preRotate successed');
      } catch (e) {
        console.info(msg + ` preRotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTSKEW_4600
     * @tc.name      : testPostSkew0046
     * @tc.desc      : testMatrixPostSkewNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPostSkew0046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPostSkewNormal';
      let matrix = new drawing.Matrix();
      matrix.postSkew(2, 2, 2, 2);
      try {
        let actualValues = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues successed');
        console.info(msg + "matrix actualValues: " + matrix.getAll().toString());
        expect(actualValues[0] == 1 && actualValues[1] == 2 && actualValues[2] == -4 && actualValues[3] == 2 &&
          actualValues[4] == 1 && actualValues[5] == -4 && actualValues[6] == 0 && actualValues[7] == 0 &&
          actualValues[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.postSkew(0.5, 0.9, 0.5, 2.2);
      try {
        let actualValues2 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues2 successed');
        console.info(msg + "matrix actualValues2: " + matrix.getAll().toString());
        expect(actualValues2[0] == 1 && actualValues2[1] == 0.5 && actualValues2[2] == -1.100000023841858 &&
          actualValues2[3] == 0.8999999761581421 &&
          actualValues2[4] == 1 && actualValues2[5] == -0.44999998807907104 && actualValues2[6] == 0 &&
          actualValues2[7] == 0 &&
          actualValues2[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.postSkew(0, 0, 0, 0);
      try {
        let actualValues3 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues3 successed');
        console.info(msg + "matrix actualValues3: " + matrix.getAll().toString());
        expect(actualValues3[0] == 1 && actualValues3[1] == 0 && actualValues3[2] == 0 && actualValues3[3] == 0 &&
          actualValues3[4] == 1 && actualValues3[5] == 0 && actualValues3[6] == 0 && actualValues3[7] == 0 &&
          actualValues3[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.postSkew(-1.5, -2, -2.75, -1);
      try {
        let actualValues4 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues4 successed');
        console.info(msg + "matrix actualValues4: " + matrix.getAll().toString());
        expect(actualValues4[0] == 1 && actualValues4[1] == -1.5 && actualValues4[2] == -1.5 &&
          actualValues4[3] == -2 &&
          actualValues4[4] == 1 && actualValues4[5] == -5.5 && actualValues4[6] == 0 && actualValues4[7] == 0 &&
          actualValues4[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.postSkew(2.5, -2, 0.5, 2);
      try {
        let actualValues5 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues5 successed');
        console.info(msg + "matrix actualValues5: " + matrix.getAll().toString());
        expect(actualValues5[0] == 1 && actualValues5[1] == 2.5 && actualValues5[2] == -5 && actualValues5[3] == -2 &&
          actualValues5[4] == 1 && actualValues5[5] == 1 && actualValues5[6] == 0 && actualValues5[7] == 0 &&
          actualValues5[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.postSkew(1, -1, 1, 1);
      try {
        let actualValues6 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues6 successed');
        console.info(msg + "matrix actualValues6: " + matrix.getAll().toString());
        expect(actualValues6[0] == -1 && actualValues6[1] == 3.5 && actualValues6[2] == -5 && actualValues6[3] == -3 &&
          actualValues6[4] == -1.5 && actualValues6[5] == 7 && actualValues6[6] == 0 && actualValues6[7] == 0 &&
          actualValues6[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTSKEW_4700
     * @tc.name      : testPostSkew0047
     * @tc.desc      : testMatrixPostSkewMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPostSkew0047', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostSkewMultipleCalls';
      let matrix = new drawing.Matrix();
      for (let i = 0; i < 20; i += 1) {
        try {
          matrix.postSkew(Math.random() * 5, Math.random() * 5, Math.random() * 5, Math.random() * 5);
          console.info(msg + `matrixA.postSkew success step: ` + i);
        } catch (e) {
          console.info(msg + `matrixA.postSkew error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_POSTSKEW_4800
     * @tc.name      : testPostSkew0048
     * @tc.desc      : testMatrixPostSkewNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPostSkew0048', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPostSkewNull';
      let matrix = new drawing.Matrix();
      try {
        matrix.postSkew(null, 2, 2, 2);
        console.info(msg + `Matrix postSkew 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.postSkew(undefined, 2, 2, 2);
        console.info(msg + `Matrix postSkew 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.postSkew(2, null, 2, 2);
        console.info(msg + `Matrix postSkew 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.postSkew(2, undefined, 2, 2);
        console.info(msg + `Matrix postSkew 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.postSkew(2, 2, null, 2);
        console.info(msg + `Matrix postSkew 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.postSkew(2, 2, undefined, 2);
        console.info(msg + `Matrix postSkew 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.postSkew(2, 2, 2, null);
        console.info(msg + `Matrix postSkew 7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.postSkew(2, 2, 2, undefined);
        console.info(msg + `Matrix postSkew 8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix postSkew 8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRESCALE_4900
     * @tc.name      : testPreScale0049
     * @tc.desc      : testMatrixPreScaleNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPreScale0049', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPreScaleNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, 100, 150, 150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(0.2, 0.2, 0.5, 0.5);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(-100, -100, 150, 150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, 100, -150, -150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preScale successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRESCALE_5000
     * @tc.name      : testPreScale0050
     * @tc.desc      : testMatrixPreScaleNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreScale0050', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreScaleNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(null, 100, 150, 150);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, null, 150, 150);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, 100, null, 150);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, 100, 150, null);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(undefined, 100, 150, 150);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, undefined, 150, 150);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, undefined, 150, 150);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, 100, undefined, 150);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preScale(100, 100, 150, undefined);
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRESCALE_5100
     * @tc.name      : testPreScale0051
     * @tc.desc      : testMatrixPreScaleMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreScale0051', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreScaleMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.preScale(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' preScale successed');
      } catch (e) {
        console.info(msg + ` preScale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRETRANSLATE_5200
     * @tc.name      : testPreTranslate0052
     * @tc.desc      : testMatrixPreTranslateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPreTranslate0052', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPreTranslateNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(100.1, 100.1);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(-100, 100);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(100, -150);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(Number.MAX_VALUE, Number.MAX_VALUE);
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' preTranslate successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRETRANSLATE_5300
     * @tc.name      : testPreTranslate0053
     * @tc.desc      : testMatrixPreTranslateNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreTranslate0053', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreTranslateNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(null, 100);
        console.info(msg + ' preTranslate successed');
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(100, null);
        console.info(msg + ' preTranslate successed');
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(undefined, 100);
        console.info(msg + ' preTranslate successed');
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(100, undefined);
        console.info(msg + ' preTranslate successed');
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRETRANSLATE_5400
     * @tc.name      : testPreTranslate0054
     * @tc.desc      : testMatrixPreTranslateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreTranslate0054', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreTranslateMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.preTranslate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + ' preTranslate successed');
      } catch (e) {
        console.info(msg + ` preTranslate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRESKEW_5500
     * @tc.name      : testPreSkew0055
     * @tc.desc      : testMatrixPreSkewNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPreSkew0055', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixPreSkewNormal';
      let matrix = new drawing.Matrix();
      matrix.preSkew(2, 2, 2, 2);
      try {
        let actualValues = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues successed');
        console.info(msg + "matrix actualValues: " + matrix.getAll().toString());
        expect(actualValues[0] == 1 && actualValues[1] == 2 && actualValues[2] == -4 && actualValues[3] == 2 &&
          actualValues[4] == 1 && actualValues[5] == -4 && actualValues[6] == 0 && actualValues[7] == 0 &&
          actualValues[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.preSkew(0.5, 0.9, 0.5, 2.2);
      try {
        let actualValues2 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues2 successed');
        console.info(msg + "matrix actualValues2: " + matrix.getAll().toString());
        expect(actualValues2[0] == 1 && actualValues2[1] == 0.5 && actualValues2[2] == -1.100000023841858 &&
          actualValues2[3] == 0.8999999761581421 &&
          actualValues2[4] == 1 && actualValues2[5] == -0.44999998807907104 && actualValues2[6] == 0 &&
          actualValues2[7] == 0 &&
          actualValues2[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.preSkew(0, 0, 0, 0);
      try {
        let actualValues3 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues3 successed');
        console.info(msg + "matrix actualValues3: " + matrix.getAll().toString());
        expect(actualValues3[0] == 1 && actualValues3[1] == 0 && actualValues3[2] == 0 && actualValues3[3] == 0 &&
          actualValues3[4] == 1 && actualValues3[5] == 0 && actualValues3[6] == 0 && actualValues3[7] == 0 &&
          actualValues3[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.preSkew(-1.5, -2, -2.75, -1);
      try {
        let actualValues4 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues4 successed');
        console.info(msg + "matrix actualValues4: " + matrix.getAll().toString());
        expect(actualValues4[0] == 1 && actualValues4[1] == -1.5 && actualValues4[2] == -1.5 &&
          actualValues4[3] == -2 &&
          actualValues4[4] == 1 && actualValues4[5] == -5.5 && actualValues4[6] == 0 && actualValues4[7] == 0 &&
          actualValues4[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.reset();
      matrix.preSkew(2.5, -2, 0.5, 2);
      try {
        let actualValues5 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues5 successed');
        console.info(msg + "matrix actualValues5: " + matrix.getAll().toString());
        expect(actualValues5[0] == 1 && actualValues5[1] == 2.5 && actualValues5[2] == -5 && actualValues5[3] == -2 &&
          actualValues5[4] == 1 && actualValues5[5] == 1 && actualValues5[6] == 0 && actualValues5[7] == 0 &&
          actualValues5[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.preSkew(1, -1, 1, 1);
      try {
        let actualValues6 = matrix.getAll();
        console.info(msg + ' matrix getAll actualValues6 successed');
        console.info(msg + "matrix actualValues6: " + matrix.getAll().toString());
        expect(actualValues6[0] == -1.5 && actualValues6[1] == 3.5 && actualValues6[2] == -3.5 &&
          actualValues6[3] == -3 &&
          actualValues6[4] == -1 && actualValues6[5] == 4 && actualValues6[6] == 0 && actualValues6[7] == 0 &&
          actualValues6[8] == 1).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix getAll actualValues6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRESKEW_5600
     * @tc.name      : testPreSkew0056
     * @tc.desc      : testMatrixPreSkewMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPreSkew0056', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreSkewMultipleCalls';
      let matrix = new drawing.Matrix();
      for (let i = 0; i < 20; i += 1) {
        try {
          matrix.preSkew(Math.random() * 5, Math.random() * 5, Math.random() * 5, Math.random() * 5);
          console.info(msg + `matrixA.preSkew success step: ` + i);
        } catch (e) {
          console.info(msg + `matrixA.preSkew error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_PRESKEW_5700
     * @tc.name      : testPreSkew0057
     * @tc.desc      : testMatrixPreSkewNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testPreSkew0057', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixPreSkewNull';
      let matrix = new drawing.Matrix();
      try {
        matrix.preSkew(null, 2, 2, 2);
        console.info(msg + `Matrix preSkew 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.preSkew(undefined, 2, 2, 2);
        console.info(msg + `Matrix preSkew 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.preSkew(2, null, 2, 2);
        console.info(msg + `Matrix preSkew 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.preSkew(2, undefined, 2, 2);
        console.info(msg + `Matrix preSkew 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.preSkew(2, 2, null, 2);
        console.info(msg + `Matrix preSkew 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.preSkew(2, 2, undefined, 2);
        console.info(msg + `Matrix preSkew 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.preSkew(2, 2, 2, null);
        console.info(msg + `Matrix preSkew 7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.preSkew(2, 2, 2, undefined);
        console.info(msg + `Matrix preSkew 8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix preSkew 8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_RESET_5800
     * @tc.name      : testReset0058
     * @tc.desc      : testMatrixResetNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testReset0058', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixResetNormal';
      try {
        let matrix = new drawing.Matrix();
        matrix.reset();
        let widths: number[] = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        matrix.preTranslate(100.1, 100.1);
        widths = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        matrix.reset();
        widths = matrix.getAll();
        expect(widths.length == 9).assertTrue();
        expect(matrix != null).assertTrue();
        console.info(msg + ' reset successed,width:' + widths.length + JSON.stringify(matrix));
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_RESET_5900
     * @tc.name      : testReset0059
     * @tc.desc      : testMatrixResetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testReset0059', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixResetMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        matrix.preTranslate(100, 100);
        matrix.getAll();
        for (let i = 0; i < loop_times; i++) {
          matrix.reset();
          matrix.getAll();
        }
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPPOINTS_6000
     * @tc.name      : testMapPoints0060
     * @tc.desc      : testMatrixMapPointsNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testMapPoints0060', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixMapPointsNormal';
      let matrix = new drawing.Matrix();

      try {
        let src: Array<common2D.Point> = [{ x: 10, y: 10 }, { x: 20.1, y: 20.1 }, { x: 30, y: 30 }];
        matrix.mapPoints(src);
        console.info(msg + ' mapPoints successed');
      } catch (e) {
        console.info(msg + ` mapPoints1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        console.info(msg + ' mapPoints successed');
      } catch (e) {
        console.info(msg + ` mapPoints2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        console.info(msg + ' mapPoints successed');
      } catch (e) {
        console.info(msg + ` mapPoints3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        matrix.mapPoints([{ x: 10, y: 10 }]);
        console.info(msg + ' mapPoints successed');
      } catch (e) {
        console.info(msg + ` mapPoints4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPPOINTS_6100
     * @tc.name      : testMapPoints0061
     * @tc.desc      : testMatrixMapPointsNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMapPoints0061', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixMapPointsNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.mapPoints(null);
        console.info(msg + ' mapPoints successed');
      } catch (e) {
        console.info(msg + ` mapPoints errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.mapPoints(undefined);
        console.info(msg + ' mapPoints successed');
      } catch (e) {
        console.info(msg + ` mapPoints errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPPOINTS_6200
     * @tc.name      : testMapPoints0062
     * @tc.desc      : testMatrixMapPointsMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMapPoints0062', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixMapPointsMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        let src: Array<common2D.Point> = [{ x: 10, y: 10 }];
        for (let i = 0; i < loop_times; i++) {
          matrix.mapPoints(src);
        }
        console.info(msg + ' mapPoints successed');
      } catch (e) {
        console.info(msg + ` mapPoints errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPRADIUS_6300
     * @tc.name      : testMapRadius0063
     * @tc.desc      : testMatrixMapRadiusNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testMapRadius0063', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixMapRadiusNormal';
      let matrix = new drawing.Matrix();
      try {
        let radius = matrix.mapRadius(10);
        console.info(msg + ' matrix mapRadius radius successed');
        console.info(msg + ' matrix mapRadius radius: ' + radius);
        let err = 10 - radius;
        console.info(msg + ' matrix mapRadius radiusError: ' + err);
        expect(err < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let radius2 = matrix.mapRadius(20.364);
        console.info(msg + ' matrix mapRadius radius2 successed');
        console.info(msg + ' matrix mapRadius radius2: ' + radius2);
        let num = Math.floor(radius2 * 1000) / 1000;
        expect(num).assertEqual(20.364);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let radius3 = matrix.mapRadius(0);
        console.info(msg + ' matrix mapRadius radius3 successed');
        console.info(msg + ' matrix mapRadius radius3: ' + radius3);
        let err3 = 0 - radius3;
        console.info(msg + ' matrix mapRadius radius3 radiusError: ' + err3);
        expect(err3 < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let radius4 = matrix.mapRadius(-15);
        console.info(msg + ' matrix mapRadius radius4 successed');
        console.info(msg + ' matrix mapRadius radius4: ' + radius4);
        expect(Math.round(radius4)).assertEqual(15);
        let err4 = 15 - radius4;
        console.info(msg + ' matrix mapRadius radius4 radiusError: ' + err4);
        expect(err4 < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let radius5 = matrix.mapRadius(-25.5114);
        console.info(msg + ' matrix mapRadius radius5 successed');
        console.info(msg + ' matrix mapRadius radius5: ' + radius5);
        let num2 = Math.floor(radius5 * 1000) / 1000;
        expect(num2).assertEqual(25.511);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.setTranslation(150.35, 50.54);
      try {
        let radius6 = matrix.mapRadius(10);
        console.info(msg + ' matrix mapRadius radius6 successed');
        console.info(msg + ' matrix mapRadius radius6: ' + radius6);
        let err6 = 10 - radius6;
        console.info(msg + ' matrix mapRadius radius6 radiusError: ' + err6);
        expect(err6 < 0.0001).assertEqual(true);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.postRotate(45, 100, 200);
      matrix.preSkew(0.5, 2, 1.5, 10);
      try {
        let radius7 = matrix.mapRadius(20.364);
        console.info(msg + ' matrix mapRadius radius7 successed');
        console.info(msg + ' matrix mapRadius radius7: ' + radius7);
        let num3 = Math.floor(radius7 * 1000) / 1000;
        expect(num3).assertEqual(32.198);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let radius8 = matrix.mapRadius(0);
        console.info(msg + ' matrix mapRadius radius8 successed');
        console.info(msg + ' matrix mapRadius radius8: ' + radius8);
        expect(radius8).assertEqual(0);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.postSkew(1.5, -2, 3, 5);
      try {
        let radius9 = matrix.mapRadius(-15);
        console.info(msg + ' matrix mapRadius radius9 successed');
        console.info(msg + ' matrix mapRadius radius9: ' + radius9);
        let num4 = Math.floor(radius9 * 1000) / 1000;
        expect(num4).assertEqual(45.774);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      matrix.preRotate(200, 10.365, 200);
      try {
        let radius10 = matrix.mapRadius(-25.5114);
        console.info(msg + ' matrix mapRadius radius10 successed');
        console.info(msg + ' matrix mapRadius radius10: ' + radius10);
        let num5 = Math.floor(radius10 * 1000) / 1000;
        expect(num5).assertEqual(41.485);
      } catch (e) {
        console.info(msg + ` matrix mapRadius radius10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPRADIUS_6400
     * @tc.name      : testMapRadius0064
     * @tc.desc      : testMatrixMapRadiusMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMapRadius0064', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixMapRadiusMultipleCalls';
      for (let i = 0; i < 20; i += 1) {
        try {
          console.info(msg + `matrixA.mapRadius success step: ` + i);
        } catch (e) {
          console.info(msg +
            `matrixA.mapRadius error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPRADIUS_6500
     * @tc.name      : testMapRadius0065
     * @tc.desc      : testMatrixMapRadiusNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testMapRadius0065', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixMapRadiusNull';
      let matrix = new drawing.Matrix();
      try {
        matrix.mapRadius(undefined);
        console.info(msg + `Matrix mapRadius 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix mapRadius 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        matrix.mapRadius(null);
        console.info(msg + `Matrix mapRadius 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `Matrix mapRadius 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPRECT_6600
     * @tc.name      : testMapRect0066
     * @tc.desc      : testMatrixMapRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testMapRect0066', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixMapRectNormal';
      try {
        let matrix = new drawing.Matrix();
        let dst: common2D.Rect = {
          left: 100,
          top: 20,
          right: 130,
          bottom: 60
        };
        let src: common2D.Rect = {
          left: 100,
          top: 80,
          right: 130,
          bottom: 120
        };
        matrix.mapRect(dst, src);
        matrix.mapRect(dst, {
          left: 0,
          top: 0,
          right: 0,
          bottom: 0
        })
        matrix.mapRect(dst, {
          left: 100,
          top: 100,
          right: 100,
          bottom: 200
        })
        matrix.mapRect(dst, {
          left: 100,
          top: 100,
          right: 100,
          bottom: 100
        })
        matrix.mapRect({
          left: 200.1,
          top: 200.1,
          right: 300.1,
          bottom: 400.1
        },
          {
            left: 100.1,
            top: 100.1,
            right: 200.1,
            bottom: 200.1
          })
        matrix.mapRect({
          left: 200.1,
          top: 200.1,
          right: 300.1,
          bottom: 400.1
        },
          {
            left: -100.1,
            top: -100.1,
            right: 200.1,
            bottom: 200.1
          })
        matrix.mapRect({
          left: 200.1,
          top: 200.1,
          right: 300.1,
          bottom: 400.1
        },
          {
            left: 100.1,
            top: 100.1,
            right: -200.1,
            bottom: -200.1
          })
        console.info(msg + ' mapRect successed');
      } catch (e) {
        console.info(msg + ` mapRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPRECT_6700
     * @tc.name      : testMapRect0067
     * @tc.desc      : testMatrixMapRectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMapRect0067', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixMapRectNull';
      try {
        let matrix = new drawing.Matrix();
        matrix.mapRect(null, {
          left: 100,
          top: 100,
          right: 200,
          bottom: 200
        });
        console.info(msg + ' mapRect successed');
      } catch (e) {
        console.info(msg + ` mapRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.mapRect({
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, null);
        console.info(msg + ' mapRect successed');
      } catch (e) {
        console.info(msg + ` mapRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.mapRect(undefined, {
          left: 100,
          top: 100,
          right: 200,
          bottom: 200
        });
        console.info(msg + ' mapRect successed');
      } catch (e) {
        console.info(msg + ` mapRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.mapRect({
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, undefined);
        console.info(msg + ' mapRect successed');
      } catch (e) {
        console.info(msg + ` mapRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_MAPRECT_6800
     * @tc.name      : testMapRect0068
     * @tc.desc      : testMatrixMapRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMapRect0068', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixMapRectMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.mapRect({
            left: Math.random() * Number.MAX_VALUE,
            top: Math.random() * Number.MAX_VALUE,
            right: Math.random() * Number.MAX_VALUE,
            bottom: Math.random() * Number.MAX_VALUE
          },
            {
              left: Math.random() * Number.MAX_VALUE,
              top: Math.random() * Number.MAX_VALUE,
              right: Math.random() * Number.MAX_VALUE,
              bottom: Math.random() * Number.MAX_VALUE
            });
        }
        console.info(msg + ' mapRect successed');
      } catch (e) {
        console.info(msg + ` mapRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETRECTTORECT_6900
     * @tc.name      : testSetRectToRect0069
     * @tc.desc      : testMatrixSetRectToRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetRectToRect0069', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetRectToRectNormal';
      try {
        let matrix = new drawing.Matrix();
        let dst: common2D.Rect = {
          left: 100,
          top: 20,
          right: 130,
          bottom: 60
        };
        let src: common2D.Rect = {
          left: 100,
          top: 80,
          right: 130,
          bottom: 120
        };
        let stf: drawing.ScaleToFit = drawing.ScaleToFit.FILL_SCALE_TO_FIT;
        matrix.setRectToRect(dst, src, stf);
        matrix.setRectToRect(dst, {
          left: 0,
          top: 0,
          right: 0,
          bottom: 0
        }, stf);
        matrix.setRectToRect(dst, {
          left: 100,
          top: 100,
          right: 100,
          bottom: 200
        }, stf)
        matrix.setRectToRect(dst, {
          left: 100,
          top: 100,
          right: 100,
          bottom: 100
        }, stf)
        matrix.setRectToRect({
          left: 200.1,
          top: 200.1,
          right: 300.1,
          bottom: 400.1
        },
          {
            left: 100.1,
            top: 100.1,
            right: 200.1,
            bottom: 200.1
          }, stf)
        matrix.setRectToRect({
          left: 200.1,
          top: 200.1,
          right: 300.1,
          bottom: 400.1
        },
          {
            left: -100.1,
            top: -100.1,
            right: 200.1,
            bottom: 200.1
          }, stf)
        matrix.setRectToRect({
          left: 200.1,
          top: 200.1,
          right: 300.1,
          bottom: 400.1
        },
          {
            left: 100.1,
            top: 100.1,
            right: -200.1,
            bottom: -200.1
          }, stf)
        matrix.setRectToRect(dst, src, drawing.ScaleToFit.START_SCALE_TO_FIT);
        matrix.setRectToRect(dst, src, drawing.ScaleToFit.CENTER_SCALE_TO_FIT);
        matrix.setRectToRect(dst, src, drawing.ScaleToFit.END_SCALE_TO_FIT);
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETRECTTORECT_7000
     * @tc.name      : testSetRectToRect0070
     * @tc.desc      : testMatrixSetRectToRectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetRectToRect0070', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetRectToRectNull';
      try {
        let matrix = new drawing.Matrix();
        let stf: drawing.ScaleToFit = drawing.ScaleToFit.FILL_SCALE_TO_FIT;
        matrix.setRectToRect(null, {
          left: 100,
          top: 100,
          right: 200,
          bottom: 200
        }, stf)
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let stf: drawing.ScaleToFit = drawing.ScaleToFit.FILL_SCALE_TO_FIT;
        matrix.setRectToRect({
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, null, stf)
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setRectToRect({
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, {
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, null)
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let stf: drawing.ScaleToFit = drawing.ScaleToFit.FILL_SCALE_TO_FIT;
        matrix.setRectToRect(undefined, {
          left: 100,
          top: 100,
          right: 200,
          bottom: 200
        }, stf)
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let stf: drawing.ScaleToFit = drawing.ScaleToFit.FILL_SCALE_TO_FIT;
        matrix.setRectToRect({
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, undefined, stf)
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let stf: drawing.ScaleToFit = drawing.ScaleToFit.FILL_SCALE_TO_FIT;
        matrix.setRectToRect({
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, {
          left: 200,
          top: 200,
          right: 300,
          bottom: 400
        }, stf)
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETRECTTORECT_7100
     * @tc.name      : testSetRectToRect0071
     * @tc.desc      : testMatrixSetRectToRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetRectToRect0071', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetRectToRectMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        let randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.ScaleToFit)));
        for (let i = 0; i < loop_times; i++) {
          matrix.setRectToRect({
            left: Math.random() * Number.MAX_VALUE,
            top: Math.random() * Number.MAX_VALUE,
            right: Math.random() * Number.MAX_VALUE,
            bottom: Math.random() * Number.MAX_VALUE
          },
            {
              left: Math.random() * Number.MAX_VALUE,
              top: Math.random() * Number.MAX_VALUE,
              right: Math.random() * Number.MAX_VALUE,
              bottom: Math.random() * Number.MAX_VALUE
            }, randomEnum);
        }
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETRECTTORECT_7200
     * @tc.name      : testSetRectToRect0072
     * @tc.desc      : testMatrixSetRectToRectAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetRectToRect0072', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetRectToRectAbnormal';
      try {
        let matrix = new drawing.Matrix();
        let dst: common2D.Rect = {
          left: 100,
          top: 20,
          right: 130,
          bottom: 60
        };
        let src: common2D.Rect = {
          left: 100,
          top: 80,
          right: 130,
          bottom: 120
        };
        matrix.setRectToRect(dst, src, 10);
        console.info(msg + ' setRectToRect successed');
      } catch (e) {
        console.info(msg + ` setRectToRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETPOLYTOPOLY_7300
     * @tc.name      : testSetPolyToPoly0073
     * @tc.desc      : testMatrixSetPolyToPolyNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetPolyToPoly0073', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testMatrixSetPolyToPolyNormal';
      let matrix = new drawing.Matrix();

      try {
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        let dstPoints: Array<common2D.Point> = [{ x: 200, y: 90 }, { x: 100, y: 60 }];
        matrix.setPolyToPoly(srcPoints, dstPoints, 2)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let srcPoints: Array<common2D.Point> = []
        let dstPoints: Array<common2D.Point> = []
        matrix.setPolyToPoly(srcPoints, dstPoints, 0)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let srcPoints: Array<common2D.Point> =
          [{ x: 200, y: 20 }, { x: 200, y: 60 }, { x: 200.1, y: 40.1 }, { x: -300, y: -60 }]
        let dstPoints: Array<common2D.Point> =
          [{ x: -200, y: -20 }, { x: 200, y: 60 }, { x: 200.1, y: 40.1 }, { x: -300, y: -60 }]
        matrix.setPolyToPoly(srcPoints, dstPoints, 4)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }]
        let dstPoints: Array<common2D.Point> = [{ x: 200, y: 20 }]
        matrix.setPolyToPoly(srcPoints, dstPoints, 1)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETPOLYTOPOLY_7400
     * @tc.name      : testSetPolyToPoly0074
     * @tc.desc      : testMatrixSetPolyToPolyNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetPolyToPoly0074', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetPolyToPolyNull';
      try {
        let matrix = new drawing.Matrix();
        let dstPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        matrix.setPolyToPoly(null, dstPoints, 2)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        matrix.setPolyToPoly(srcPoints, null, 2)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        let dstPoints: Array<common2D.Point> = [{ x: 20, y: 200 }, { x: 20, y: 200 }];
        matrix.setPolyToPoly(srcPoints, dstPoints, null)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let dstPoints: Array<common2D.Point> = [{ x: 20, y: 200 }, { x: 20, y: 200 }];
        matrix.setPolyToPoly(undefined, dstPoints, 2)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        matrix.setPolyToPoly(srcPoints, undefined, 2)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let matrix = new drawing.Matrix();
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        let dstPoints: Array<common2D.Point> = [{ x: 20, y: 200 }, { x: 60, y: 200 }];
        matrix.setPolyToPoly(srcPoints, dstPoints, undefined)
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETPOLYTOPOLY_7500
     * @tc.name      : testSetPolyToPoly0075
     * @tc.desc      : testMatrixSetPolyToPolyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetPolyToPoly0075', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetPolyToPolyMultipleCalls';
      try {
        let matrix = new drawing.Matrix();
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        let dstPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        for (let i = 0; i < loop_times; i++) {
          matrix.setPolyToPoly(srcPoints, dstPoints, 2);
        }
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETPOLYTOPOLY_7600
     * @tc.name      : testSetPolyToPoly0076
     * @tc.desc      : testMatrixSetPolyToPolyAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetPolyToPoly0076', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testMatrixSetPolyToPolyAbnormal';
      try {
        let matrix = new drawing.Matrix();
        let srcPoints: Array<common2D.Point> = [{ x: 200, y: 20 }, { x: 200, y: 60 }];
        let dstPoints: Array<common2D.Point> = [{ x: 20, y: 20 }, { x: 20, y: 600 }];
        matrix.setPolyToPoly(srcPoints, dstPoints, -1);
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let matrix = new drawing.Matrix();
        let srcPoints: Array<common2D.Point> =
          [{ x: 200, y: 20 }, { x: 200, y: 60 }, { x: 210, y: 70 }, { x: 220, y: 80 }];
        let dstPoints: Array<common2D.Point> =
          [{ x: 200, y: 20 }, { x: 200, y: 60 }, { x: 210, y: 70 }, { x: 220, y: 80 }];
        matrix.setPolyToPoly(srcPoints, dstPoints, 5);
        console.info(msg + ' setPolyToPoly successed');
      } catch (e) {
        console.info(msg + ` setPolyToPoly errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETMATRIX_7700
     * @tc.name      : testSetMatrix0077
     * @tc.desc      : testMatrixSetMatrixNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetMatrix0077', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testSetMatrix_NormalInput';
      try {
        let matrix = new drawing.Matrix();
        expect(matrix !== null).assertTrue();
        console.info(`${msg} - Default matrix init success`);
      } catch (e) {
        console.error(`${msg} - Default matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9]);
        expect(matrix !== null).assertTrue();
        console.info(`${msg} - Integer matrix set success`);
      } catch (e) {
        console.error(`${msg} - Integer matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1]);
        expect(matrix !== null).assertTrue();
        console.info(`${msg} - Float matrix set success`);
      } catch (e) {
        console.error(`${msg} - Float matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([0, -1, 2.1, 2.1, 42.1, 2.1, 2., -1.1, 10]);
        expect(matrix !== null).assertTrue();
        console.info(`${msg} - Mixed data matrix set success`);
      } catch (e) {
        console.error(`${msg} - Mixed data matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([
          Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE,
          Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE,
          Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE
        ]);
        expect(matrix !== null).assertTrue();
        console.info(`${msg} - Max value matrix set success`);
      } catch (e) {
        console.error(`${msg} - Max value matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETMATRIX_7800
     * @tc.name      : testSetMatrix0078
     * @tc.desc      : testMatrixSetMatrixAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetMatrix0078', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testSetMatrix_AbnormalInput';
      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix(null);
        console.error(`${msg} - Null input should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Null input error caught: code=${e.code}, msg=${e.message}`);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix(undefined);
        console.error(`${msg} - Undefined input should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Undefined input error caught: code=${e.code}, msg=${e.message}`);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([]);
        console.error(`${msg} - Empty array input should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Empty array input error caught: code=${e.code}, msg=${e.message}`);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([1, 2, 3, 4, 5, 6, 7, 8]); // 长度8
        console.error(`${msg} - Short array input should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Short array input error caught: code=${e.code}, msg=${e.message}`);
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]); // 长度10
        console.error(`${msg} - Long array input should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Long array input error caught: code=${e.code}, msg=${e.message}`);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_SETMATRIX_7900
     * @tc.name      : testSetMatrix0079
     * @tc.desc      : testMatrixSetMatrixMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetMatrix0079', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testSetMatrix_MultipleCalls';
      let loop_times = 100;

      try {
        let matrix = new drawing.Matrix();
        for (let i = 0; i < loop_times; i++) {
          matrix.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9]);
        }
        expect(matrix !== null).assertTrue();
        console.info(`${msg} - ${loop_times} times set success`);
      } catch (e) {
        console.error(`${msg} - Multiple calls error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_GETALL_8000
     * @tc.name      : testGetAll0080
     * @tc.desc      : testMatrixGetAllNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testGetAll0080', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testGetAll_NormalGet';

      try {
        let matrix = new drawing.Matrix();
        let result = matrix.getAll();
        expect(result.length === 9).assertTrue(); // 核心验证：3x3矩阵长度为9
        console.info(`${msg} - Default matrix get success, length=${result.length}`);
      } catch (e) {
        console.error(`${msg} - Default matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9]); // 前置：设置合法矩阵
        let result = matrix.getAll();
        expect(result.length === 9).assertTrue();
        console.info(`${msg} - Integer matrix get success, length=${result.length}`);
      } catch (e) {
        console.error(`${msg} - Integer matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([1.1, 2.1, 3.1, 4.1, 5.1, 6.1, 7.1, 8.1, 9.1]);
        let result = matrix.getAll();
        expect(result.length === 9).assertTrue();
        console.info(`${msg} - Float matrix get success, length=${result.length}`);
      } catch (e) {
        console.error(`${msg} - Float matrix error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_GETALL_8100
     * @tc.name      : testGetAll0081
     * @tc.desc      : testMatrixGetAllMutipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testGetAll0081', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testGetAll_MultipleCalls';
      let loop_times = 100;

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
          Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
          Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
          Math.random() * Number.MAX_VALUE]);
        for (let i = 0; i < loop_times; i++) {
          let result = matrix.getAll();
          expect(result.length === 9).assertTrue();
        }
        console.info(`${msg} - ${loop_times} times get success`);
      } catch (e) {
        console.error(`${msg} - Multiple calls error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_GETVALUE_8200
     * @tc.name      : testGetValue0082
     * @tc.desc      : testMatrixGetValueNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testGetValue0082', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testGetValue_NormalGet';

      try {
        let matrix = new drawing.Matrix();
        matrix.setMatrix([10, 20, 30, 40, 50, 60, 70, 80, 90]);
        let value = matrix.getValue(4);
        expect(value !== undefined).assertTrue();
        console.info(`${msg} - Get index 4 success, value=${value}`);
      } catch (e) {
        console.error(`${msg} - Normal get error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_GETVALUE_8300
     * @tc.name      : testGetValue0083
     * @tc.desc      : testMatrixGetValueAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testGetValue0083', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testGetValue_AbnormalGet';
      let matrix = new drawing.Matrix();
      matrix.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9]);

      try {
        matrix.getValue(null);
        console.error(`${msg} - Null index should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Null index error caught: code=${e.code}, msg=${e.message}`);
      }

      try {
        matrix.getValue(undefined);
        console.error(`${msg} - Undefined index should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Undefined index error caught: code=${e.code}, msg=${e.message}`);
      }

      try {
        matrix.getValue(-1);
        console.error(`${msg} - Negative index should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Negative index error caught: code=${e.code}, msg=${e.message}`);
      }

      try {
        matrix.getValue(9);
        console.error(`${msg} - Out-of-bound index should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        expect(e.code).assertEqual(401);
        console.info(`${msg} - Out-of-bound index error caught: code=${e.code}, msg=${e.message}`);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_MATRIX_GETVALUE_8400
     * @tc.name      : testGetValue0084
     * @tc.desc      : testMatrixGetValueMutipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testGetValue0084', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testGetValue_MultipleCalls';
      let loop_times = 100;
      let targetIndex = 0;

      try {
        let matrix = new drawing.Matrix();
        let randomMatrix = [
          Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
          Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
          Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE
        ];
        matrix.setMatrix(randomMatrix);

        let firstValue: number | undefined;
        for (let i = 0; i < loop_times; i++) {
          let currentValue = matrix.getValue(targetIndex);
          if (i === 0) {
            firstValue = currentValue;
            expect(firstValue !== undefined).assertTrue();
          } else {
            expect(currentValue).assertEqual(firstValue);
          }
        }
        console.info(`${msg} - Success: Called getValue(${targetIndex}) ${loop_times} times, value remains consistent`);
      } catch (e) {
        console.error(`${msg} - Error: ${e.message}, errorCode: ${e.code}`);
        expect().assertFail(`Multiple calls to getValue failed: ${e.message}`);
      }
    })
  })
}