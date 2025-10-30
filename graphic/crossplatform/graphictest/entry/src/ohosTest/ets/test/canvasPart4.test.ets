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
import image from '@ohos.multimedia.image';
import drawing from '@ohos.graphics.drawing';
import { getEnumCount } from './utils';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function drawingTsCanvasPart2Test() {
  describe('DrawingTsCanvasPart4Test', () => {
    let pixel: image.PixelMap;
    const DEFAULT = 0;
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
      const color: ArrayBuffer = new ArrayBuffer(40000); // 96为需要创建的像素buffer大小，取值为：height * width *4
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100
        }
      }
      pixel = await image.createPixelMap(color, opts);
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0100
     * @tc.name      : testCanvasAttachPenDetachPenNormal0001
     * @tc.desc      : testCanvasAttachPenDetachPenNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasAttachPenDetachPenNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasAttachPenDetachPenNormal0001';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0,
          right: 0,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0200
     * @tc.name      : testCanvasAttachPenDetachPenMultipleCalls0002
     * @tc.desc      : testCanvasAttachPenDetachPenMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachPenDetachPenMultipleCalls0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachPenDetachPenMultipleCalls0002';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        for (let index = 0; index < 20; index++) {
          canvas.attachPen(pen);
        }
        canvas.drawRect({
          left: 0,
          right: 0,
          top: 10,
          bottom: 10
        });
        for (let index = 0; index < 20; index++) {
          canvas.detachPen();
        }
        for (let index = 0; index < 20; index++) {
          canvas.attachPen(pen);
          canvas.drawRect({
            left: 0,
            right: 0,
            top: 10,
            bottom: 10
          });
          canvas.detachPen();
        }
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0300
     * @tc.name      : testCanvasAttachPenOly0003
     * @tc.desc      : testCanvasAttachPenOly
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachPenOly0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachPenOly0003';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0,
          right: 0,
          top: 10,
          bottom: 10
        });
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0400
     * @tc.name      : testCanvasClipPathNormal0004
     * @tc.desc      : testCanvasClipPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasClipPathNormal0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasClipPathNormal0004';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, true);
        canvas.clipPath(path, drawing.ClipOp.INTERSECT, true);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, false);
        canvas.clipPath(path, drawing.ClipOp.INTERSECT, false);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE);
        canvas.clipPath(path);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0500
     * @tc.name      : testCanvasClipPathNull0005
     * @tc.desc      : testCanvasClipPathNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipPathNull0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipPathNull0005';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipPath(undefined, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, undefined, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, undefined);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipPath(null, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, null, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, null);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0600
     * @tc.name      : testCanvasClipPathMultipleCalls0006
     * @tc.desc      : testCanvasClipPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipPathMultipleCalls0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipPathMultipleCalls0006';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          let path = new drawing.Path();
          path.moveTo(10, 10);
          path.cubicTo(Math.random() * Number.MAX_VALUE, 10, 10, 10, 15, 15);
          path.close();
          const randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.ClipOp)));
          canvas.clipPath(path, randomEnum, Math.random() == 1 ? true : false);
        }
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0700
     * @tc.name      : testCanvasClipRectNull0007
     * @tc.desc      : testCanvasClipRectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRectNull0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRectNull0007';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect(undefined, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        }, undefined, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        }, drawing.ClipOp.DIFFERENCE, undefined);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect(null, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        }, null, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        }, drawing.ClipOp.DIFFERENCE, null);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: null,
          right: 0,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 0,
          right: null,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 0,
          right: 100,
          top: null,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0,
          right: 100,
          top: 10,
          bottom: null
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: undefined,
          right: 0,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 0,
          right: undefined,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 0,
          right: 100,
          top: undefined,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.clipRect({
          left: 0,
          right: 100,
          top: 10,
          bottom: undefined
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0800
     * @tc.name      : testCanvasClipRectMultipleCalls0008
     * @tc.desc      : testCanvasClipRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRectMultipleCalls0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRectMultipleCalls0008';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          const randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.ClipOp)));
          canvas.drawCircle(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
          canvas.clipRect({
            left: Math.random() * Number.MAX_VALUE,
            right: Math.random() * Number.MAX_VALUE,
            top: Math.random() * Number.MAX_VALUE,
            bottom: Math.random() * Number.MAX_VALUE
          }, randomEnum, Math.random() == 1 ? true : false);
        }
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0900
     * @tc.name      : testCanvasScaleNormal0009
     * @tc.desc      : testCanvasScaleNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasScaleNormal0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasScaleNormal0009';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.scale(2, 2);
        canvas.scale(0.5, 0.5);
        canvas.scale(-10, -10);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1000
     * @tc.name      : testCanvasScaleNull0010
     * @tc.desc      : testCanvasScaleNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasScaleNull0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasScaleNull0010';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.scale(undefined, 2);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.scale(0.5, undefined);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.scale(null, 0.5);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.scale(2, null);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1100
     * @tc.name      : testCanvasScaleMultipleCalls0011
     * @tc.desc      : testCanvasScaleMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasScaleMultipleCalls0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasScaleMultipleCalls0011';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.scale(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })


    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1200
     * @tc.name      : testCanvasSkewNormal0012
     * @tc.desc      : testCanvasSkewNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasSkewNormal0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasSkewNormal0012';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.skew(2, 2);
        canvas.skew(0.5, 0.5);
        canvas.skew(-10, -10);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1300
     * @tc.name      : testCanvasSkewNull0013
     * @tc.desc      : testCanvasSkewNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSkewNull0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSkewNull0013';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.skew(undefined, 2);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.skew(0.5, undefined);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.skew(null, 0.5);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.skew(2, null);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1400
     * @tc.name      : testCanvasSkewMultipleCalls0014
     * @tc.desc      : testCanvasSkewMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSkewMultipleCalls0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSkewMultipleCalls0014';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.skew(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })


    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1500
     * @tc.name      : testCanvasRotateNormal0015
     * @tc.desc      : testCanvasRotateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasRotateNormal0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasRotateNormal0015';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.rotate(30, 100, 100);
        canvas.rotate(30.1, 100.1, 100.1);
        canvas.rotate(0, 100, 100);
        canvas.rotate(360, 100, 100);
        canvas.rotate(-90, 100, 100);
        canvas.rotate(400, 100, 100);
        canvas.rotate(30, -100, -100);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1600
     * @tc.name      : testCanvasRotateNull0016
     * @tc.desc      : testCanvasRotateNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRotateNull0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRotateNull0016';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.rotate(undefined, 100, 100);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.rotate(30, undefined, 100);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.rotate(30, 100, undefined);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.rotate(null, 100, 100);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.rotate(30, null, 100);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.rotate(30, 100, null);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1700
     * @tc.name      : testCanvasRotateMultipleCalls0017
     * @tc.desc      : testCanvasRotateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRotateMultipleCalls0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRotateMultipleCalls0017';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.rotate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })


    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1800
     * @tc.name      : testCanvasTranlateNormal0018
     * @tc.desc      : testCanvasTranlateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasTranlateNormal0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasTranlateNormal0018';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.translate(10, 10);
        canvas.translate(10.1, 10.1);
        canvas.translate(-10, -10);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1900
     * @tc.name      : testCanvasTranlateNull0019
     * @tc.desc      : testCanvasTranlateNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasTranlateNull0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasTranlateNull0019';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.translate(undefined, 2);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.translate(10, undefined);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.translate(null, 10);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.translate(2, null);
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2000
     * @tc.name      : testCanvasTranlateMultipleCalls0020
     * @tc.desc      : testCanvasTranlateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasTranlateMultipleCalls0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasTranlateMultipleCalls0020';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.translate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({
          left: 10,
          right: 500,
          top: 300,
          bottom: 900
        });
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}