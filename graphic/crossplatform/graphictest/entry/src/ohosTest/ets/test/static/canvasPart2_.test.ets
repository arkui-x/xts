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

export default function drawingTsCanvasPart2Test_() {
  describe('DrawingTsCanvasPart2Test', () => {
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
     * @tc.name      : testCanvasRotateNormalStatic0001
     * @tc.desc      : testCanvasRotateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasRotateNormalStatic0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, (): void => {
      let msg = 'testCanvasRotateNormalStatic0001';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        // pen.setStrokeWidth(5);
        // pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        // canvas.attachPen(pen);
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
        // canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_STATIC_0200
     * @tc.name      : testCanvasRotateMultipleCallsStatic0002
     * @tc.desc      : testCanvasRotateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRotateMultipleCallsStatic0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (): void => {
      let msg = 'testCanvasRotateMultipleCallsStatic0002';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        // pen.setStrokeWidth(5);
        // pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        // canvas.attachPen(pen);
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
        // canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}