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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType, Size, Level } from "@ohos/hypium";
import image from '@ohos.multimedia.image';
import drawing from '@ohos.graphics.drawing';

export default function drawingTsCanvasTest_() {
  describe('DrawingTsCanvasTest', () => {
    let pixel: image.PixelMap;
    const DEFAULT = 0;
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
      const color: ArrayBuffer = new ArrayBuffer(40000); // 96为需要创建的像素buffer大小，取值为：height * width *4
      let opts: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: {
          height: 100,
          width: 100
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_STATIC_0100
     * @tc.name      : testCanvasConstructorNormalStatic0001
     * @tc.desc      : testCanvasConstructorNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasConstructorNormalStatic0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, (): void => {
      let msg = 'testCanvasConstructorNormalStatic0001';
      try {
        new drawing.Canvas(pixel);
        console.info(msg + 'canvasConstructor successed');
      } catch (e) {
        console.info(msg + `canvasConstructor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_STATIC_0200
     * @tc.name      : testCanvasConstructorMultipleCallsStatic0002
     * @tc.desc      : testCanvasConstructorMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasConstructorMultipleCallsStatic0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (): void => {
      let msg = 'testCanvasConstructorMultipleCallsStatic0002';
      try {
        for (let index = 0; index < 20; index++) {
          new drawing.Canvas(pixel);
        }
        console.info(msg + 'canvasConstructor successed');
      } catch (e) {
        console.info(msg + `canvasConstructor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_STATIC_0300
     * @tc.name      : testCanvasDrawRectNormalStatic0003
     * @tc.desc      : testCanvasDrawRectNormalStatic
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawRectNormalStatic0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, (): void => {
      let msg = 'testCanvasDrawRectNormalStatic0003';
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
        // canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_STATIC_0400
     * @tc.name      : testCanvasDrawRect2NormalStatic0004
     * @tc.desc      : testCanvasDrawRect2NormalStatic
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawRect2NormalStatic0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, (): void => {
      let msg = 'testCanvasDrawRect2NormalStatic0004';
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
        canvas.drawRect(0, 0, 10, 10);
        canvas.detachPen();
        console.info(msg + '2 drawRect successed');
      } catch (e) {
        console.info(msg + `2 drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_STATIC_0500
     * @tc.name      : testCanvasDrawPixelMapMeshNormalStatic0005
     * @tc.desc      : testCanvasDrawPixelMapMeshNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPixelMapMeshNormalStatic0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, (): void => {
      let msg = 'testCanvasDrawPixelMapMeshNormalStatic0005';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2,
          [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0,
          [0xFFFFFFFF, 0xFFEFFFFF, 0xFFFFEFFF, 0xFFFFFFEF, 0xFFFFFF00, 0xFFEFFFF, 0xFFEFFFF, 0xFFEFFFF, 0xFFEFFFF], 0);
        canvas.drawPixelMapMesh(pixel, 1, 1, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1,
          [0xFFFFFFFF, 0xFFEFFFFF, 0xFFFFEFFF, 0xFFFFFFEF], 0);
        canvas.drawPixelMapMesh(pixel, 1, 1, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1,
          [0xFFFFFFFF, 0xFFEFFFFF, 0xFFFFEFFF, 0xFFFFFFEF, 0xFFFFFF00], 1);
        canvas.drawPixelMapMesh(pixel, 1, 1, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1,
          [0xFFFFFFFF, 0xFFEFFFFF, 0xFFFFEFFF, 0xFFFFFFEF], 0);
        canvas.drawPixelMapMesh(pixel, 1, 1, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1,
          [0xFFFFFFFF, 0xFFEFFFFF, 0xFFFFEFFF, 0xFFFFFFEF, 0xFFFFFF00], 1);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}