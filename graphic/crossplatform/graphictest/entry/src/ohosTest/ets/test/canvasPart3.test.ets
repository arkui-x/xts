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

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function drawingTsCanvasTest() {
  describe('DrawingTsCanvasPart3Test', () => {
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
     * @tc.name      : testCanvasDrawRectNormal0001
     * @tc.desc      : testCanvasDrawRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawRectNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawRectNormal0001';
      try {
        let canvas = new drawing.Canvas(pixel);
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
        canvas.drawRect({
          left: 100.32,
          right: 100.5,
          top: 400.2,
          bottom: 400.3
        });
        canvas.drawRect({
          left: 0,
          right: 0,
          top: 0,
          bottom: 100
        });
        canvas.drawRect({
          left: 0,
          right: 100,
          top: 100,
          bottom: 100
        });
        canvas.drawRect({
          left: 100,
          right: 100,
          top: 100,
          bottom: 100
        });
        canvas.drawRect({
          left: -100,
          right: 100,
          top: -100,
          bottom: 100
        });
        canvas.drawRect({
          left: 100,
          right: -100,
          top: 100,
          bottom: -100
        });
        canvas.drawRect({
          left: 200,
          right: 100,
          top: 200,
          bottom: 100
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0200
     * @tc.name      : testCanvasDrawRectNull0002
     * @tc.desc      : testCanvasDrawRectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawRectNull0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawRectNull0002';
      let canvas = new drawing.Canvas(pixel);
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
        canvas.drawRect(null);
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawRect(undefined);
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
          left: null,
          right: 0,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
          right: null,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
          top: null,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
          left: undefined,
          right: 0,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
          right: undefined,
          top: 10,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
          top: undefined,
          bottom: 10
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
          bottom: undefined
        });
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0300
     * @tc.name      : testCanvasDrawRectMultipleCalls0003
     * @tc.desc      : testCanvasDrawRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawRectMultipleCalls0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawRectMultipleCalls0003';
      try {
        let canvas = new drawing.Canvas(pixel);
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
          canvas.drawRect({
            left: Math.random() * Number.MAX_VALUE,
            right: Math.random() * Number.MAX_VALUE,
            top: Math.random() * Number.MAX_VALUE,
            bottom: Math.random() * Number.MAX_VALUE
          });
        }
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0400
     * @tc.name      : testCanvasDrawCircleNormal0004
     * @tc.desc      : testCanvasDrawCircleNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawCircleNormal0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawCircleNormal0004';
      let canvas = new drawing.Canvas(pixel);
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
        canvas.drawCircle(10, 10, 100);
        canvas.drawCircle(10.1, 10.1, 100.1);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0500
     * @tc.name      : testCanvasDrawCircleNull0005
     * @tc.desc      : testCanvasDrawCircleNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawCircleNull0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawCircleNull0005';
      let canvas = new drawing.Canvas(pixel);
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
        canvas.drawCircle(null, 10, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        pixel
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(10, null, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawCircle(10, 10, null);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawCircle(undefined, 10, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawCircle(10, undefined, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawCircle(10, 10, undefined);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0600
     * @tc.name      : testCanvasDrawCircleMultipleCalls0006
     * @tc.desc      : testCanvasDrawCircleMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawCircleMultipleCalls0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawCircleMultipleCalls0006';
      try {
        let canvas = new drawing.Canvas(pixel);
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
          canvas.drawCircle(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0700
     * @tc.name      : testCanvasDrawPointNormal0007
     * @tc.desc      : testCanvasDrawPointNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPointNormal0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawPointNormal0007';
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
        canvas.drawPoint(10, 10);
        canvas.drawPoint(10.1, 10.1);
        canvas.drawPoint(-10, -10);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0800
     * @tc.name      : testCanvasDrawPointNull0008
     * @tc.desc      : testCanvasDrawPointNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointNull0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointNull0008';
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
        canvas.drawPoint(undefined, 10);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawPoint(10, undefined);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawPoint(null, 10);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawPoint(10, null);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0900
     * @tc.name      : testCanvasDrawPointMultipleCalls0009
     * @tc.desc      : testCanvasDrawPointMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointMultipleCalls0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointMultipleCalls0009';
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
          canvas.drawPoint(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })


    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1000
     * @tc.name      : testCanvasDrawPathNormal0010
     * @tc.desc      : testCanvasDrawPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPathNormal0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawPathNormal0010';
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
        canvas.drawPath(path);
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1100
     * @tc.name      : testCanvasDrawPathNull0011
     * @tc.desc      : testCanvasDrawPathNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPathNull0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPathNull0011';
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
        canvas.drawPath(undefined);
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawPath(null);
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1200
     * @tc.name      : testCanvasDrawPathMultipleCalls0012
     * @tc.desc      : testCanvasDrawPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPathMultipleCalls0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPathMultipleCalls0012';
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
        for (let index = 0; index < 20; index++) {
          canvas.drawPath(path);
        }
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })


    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1300
     * @tc.name      : testCanvasDrawLineNormal0013
     * @tc.desc      : testCanvasDrawLineNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawLineNormal0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawLineNormal0013';
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
        canvas.drawLine(10, 15, 10, 10);
        canvas.drawLine(10.2, 15.3, 10.4, 10.5);
        canvas.drawLine(-10, -15, 10, 10);
        canvas.drawLine(10, 15, -10, -10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1400
     * @tc.name      : testCanvasDrawLineNull0014
     * @tc.desc      : testCanvasDrawLineNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawLineNull0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawLineNull0014';
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
        canvas.drawLine(undefined, 15, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawLine(10, undefined, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawLine(10, 15, undefined, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawLine(10, 15, 10, undefined);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawLine(null, 15, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawLine(10, null, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawLine(10, 15, null, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
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
        canvas.drawLine(10, 15, 10, null);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1500
     * @tc.name      : testCanvasDrawLineMultipleCalls0015
     * @tc.desc      : testCanvasDrawLineMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawLineMultipleCalls0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawLineMultipleCalls0015';
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
          canvas.drawLine(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}