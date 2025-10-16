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

export default function drawingTsCanvasPart2Test() {
  describe('DrawingTsCanvasPart2Test', () => {
    let pixel: image.PixelMap;
    beforeAll(async () => {
      let color: ArrayBuffer = new ArrayBuffer(40000);
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100
        }
      }
      pixel = await image.createPixelMap(color, opts);
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS2_0100
     * @tc.name      : testCanvasClipPathNormal0001
     * @tc.desc      : testCanvasClipPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasClipPathNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testCanvasClipPathNormal0001';
      try {
        let canvas = new drawing.Canvas(pixel);
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS2_0200
     * @tc.name      : testCanvasClipPathNull0002
     * @tc.desc      : testCanvasClipPathNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipPathNull0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasClipPathNull0002';
      let canvas = new drawing.Canvas(pixel);
      try {
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipPath(undefined, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
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
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
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
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipPath(null, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
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
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS2_0300
     * @tc.name      : testCanvasClipPathMultipleCalls0003
     * @tc.desc      : testCanvasClipPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipPathMultipleCalls0003', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasClipPathMultipleCalls0003';
      try {
        let canvas = new drawing.Canvas(pixel);
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          let path = new drawing.Path();
          path.moveTo(10, 10);
          path.cubicTo(Math.random() * Number.MAX_VALUE, 10, 10, 10, 15, 15);
          path.close();
          let randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.ClipOp)));
          canvas.clipPath(path, randomEnum, Math.random() == 1 ? true : false);
        }
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}