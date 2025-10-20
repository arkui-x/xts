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

export default function drawingTsCanvasTest() {
  describe('DrawingTsCanvasTest', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0100
     * @tc.name      : testCanvasDrawPathMultipleCalls0001
     * @tc.desc      : testCanvasDrawPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCanvasDrawPathMultipleCalls0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPathMultipleCalls0001';
      try {
        let canvas = new drawing.Canvas(pixel);
        let pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        let path = new drawing.Path();
        path.moveTo(10,10);
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
  })
}