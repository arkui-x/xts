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
import common2D from '@ohos.graphics.common2D';

export default function drawingTsCanvasPart7Test() {
  describe('DrawingTsCanvasPart7Test', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS7_0100
     * @tc.name      : testCanvasDrawQuickRejectPathNormal0001
     * @tc.desc      : testCanvasDrawQuickRejectPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCanvasDrawQuickRejectPathNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL2, () => {
      let msg = 'testCanvasDrawQuickRejectPathNormal0001';
      let path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      path.moveTo(-100,-100);
      path.lineTo(-50, -50);
      try {
        let isSuccess1 = canvas.quickRejectPath(path);
        expect(isSuccess1).assertEqual(true);
      } catch (e) {
        console.info(msg + `quickRejectPath 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.moveTo(0, 100);
      path.lineTo(-100, -100);
      try {
        let isSuccess2 = canvas.quickRejectPath(path);
        expect(isSuccess2).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.reset();
      path.moveTo(-100,-100);
      path.lineTo(0, 0);
      try {
        let isSuccess3 = canvas.quickRejectPath(path);
        expect(isSuccess3).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.reset();
      path.moveTo(-100,0);
      path.lineTo(0, 100);
      path.lineTo(-100, 200);
      try {
        let isSuccess4 = canvas.quickRejectPath(path);
        expect(isSuccess4).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let isSuccess = true;
      path.lineTo(200, 200);
      try {
        isSuccess = canvas.quickRejectPath(path);
        expect(isSuccess).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.reset();
      isSuccess = true;
      let rect0:common2D.Rect = {
        left: 200,
        top: 200,
        right: 400,
        bottom: 400
      };
      path.addArc(rect0, 10, 50);
      path.conicTo(200, 400, 100, 200, 0);
      try {
        isSuccess = canvas.quickRejectPath(path);
        expect(isSuccess).assertEqual(true);
      } catch (e) {
        console.info(msg + `quickRejectPath 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS7_0200
     * @tc.name      : testCanvasDrawQuickRejectPathMultipleCalls0002
     * @tc.desc      : testCanvasDrawQuickRejectPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCanvasDrawQuickRejectPathMultipleCalls0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawQuickRejectPathMultipleCalls0002';
      let path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      for(let i = 0; i < 20; i++) {
        path.moveTo(100 + i * 0.01, 100 + i * 0.01);
        path.lineTo(150 + i * 0.01, 50 + i * 0.01);
        try {
          let isSuccess = canvas.quickRejectPath(path);
          expect(isSuccess).assertEqual(false);
        } catch (e) {
          console.info(msg + `quickRejectPath ${i} errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })
  })
}