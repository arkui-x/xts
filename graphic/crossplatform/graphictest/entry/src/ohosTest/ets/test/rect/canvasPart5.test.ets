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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType, Size, Level} from '@ohos/hypium';
import image from '@ohos.multimedia.image';
import drawing from '@ohos.graphics.drawing';
import common2D from '@ohos.graphics.common2D';
import { getEnumCount } from './utils';

export default function drawingTsCanvasPart5Test() {
  describe('DrawingTsCanvasPart5Test', () => {
    let pixel: image.PixelMap;
    let pixelMap: image.PixelMap;

    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
      let color: ArrayBuffer = new ArrayBuffer(40000); // 96为需要创建的像素buffer大小，取值为：height * width *4
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100
        }
      }
      pixel = await image.createPixelMap(color, opts);
      pixelMap = await image.createPixelMap(color, opts);
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
     * @tc.name      : testCanvasDrawImageRectNormal0001
     * @tc.desc      : testCanvasDrawImageRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectNormal0001';
      let canvas = new drawing.Canvas(pixel);
      let maxVal = Number.MAX_VALUE;

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        canvas.drawImageRect(pixelMap, {
          left: 100.1, top: 10.10, right: 900.1, bottom: 900.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST));
        canvas.drawImageRect(pixelMap, {
          left: -200, top: -200, right: 1000, bottom: 1000
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_LINEAR));
        canvas.drawImageRect(pixelMap, {
          left: 200, top: 200, right: -1000, bottom: -1000
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_LINEAR));
        canvas.drawImageRect(pixelMap, {
          left: maxVal, top: maxVal, right: maxVal, bottom: maxVal
        });
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0200
     * @tc.name      : testCanvasDrawImageRectMultipleCalls0002
     * @tc.desc      : testCanvasDrawImageRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectMultipleCalls0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectMultipleCalls0002';
      let canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          let randomEnum = Math.floor(getEnumCount(drawing.FilterMode) * Math.random())
          canvas.drawImageRect(pixelMap, {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          }, new drawing.SamplingOptions(randomEnum));
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0300
     * @tc.name      : testCanvasDrawImageRectToNull0003
     * @tc.desc      : testCanvasDrawImageRectToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectToNull0003', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectToNull0003';
      let canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRect(null, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(undefined, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0400
     * @tc.name      : testCanvasDrawImageRectAbnormal0004
     * @tc.desc      : testCanvasDrawImageRectAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectAbnormal0004', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectAbnormal0004';
      let canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0500
     * @tc.name      : testCanvasClipRoundRectNormal0005
     * @tc.desc      : testCanvasClipRoundRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasClipRoundRectNormal0005', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testCanvasClipRoundRectNormal0005';
      let canvas = new drawing.Canvas(pixel);
      try {
        let rectOne: common2D.Rect = {
          left: 10, top: 100, right: 200, bottom: 300
        };
        let roundRectOne = new drawing.RoundRect(rectOne, 10, 10);
        canvas.clipRoundRect(roundRectOne);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.INTERSECT);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, true);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, false);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.INTERSECT, true);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.INTERSECT, false);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0600
     * @tc.name      : testCanvasClipRoundRectMultipleCalls0006
     * @tc.desc      : testCanvasClipRoundRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRoundRectMultipleCalls0006', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasClipRoundRectMultipleCalls0006';
      let canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          let randomEnum = Math.floor(Math.random() * getEnumCount(drawing.ClipOp))
          let rectOne: common2D.Rect = {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          };
          let roundRectOne = new drawing.RoundRect(rectOne, Math.random(), Math.random());
          canvas.clipRoundRect(roundRectOne, randomEnum, true);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0700
     * @tc.name      : testCanvasClipRoundRectToNull0007
     * @tc.desc      : testCanvasClipRoundRectToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRoundRectToNull0007', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasClipRoundRectToNull0007';
      let canvas = new drawing.Canvas(pixel);
      let rectOne: common2D.Rect = {
        left: 10, top: 100, right: 200, bottom: 300
      };
      let roundRectOne = new drawing.RoundRect(rectOne, 10, 10);


      try {
        canvas.clipRoundRect(null, drawing.ClipOp.DIFFERENCE, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, null, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(null, drawing.ClipOp.DIFFERENCE, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, null, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0800
     * @tc.name      : testCanvasClipRoundRectAbnormal0008
     * @tc.desc      : testCanvasClipRoundRectAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRoundRectAbnormal0008', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasClipRoundRectAbnormal0008';
      let canvas = new drawing.Canvas(pixel);
      let rectOne: common2D.Rect = {
        left: 10, top: 100, right: 200, bottom: 300
      };
      let roundRectOne = new drawing.RoundRect(rectOne, 10, 10);

      try {
        canvas.clipRoundRect(roundRectOne, 10, true);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0900
     * @tc.name      : testCanvasDrawImageRectWithSrcNormal0009
     * @tc.desc      : testCanvasDrawImageRectWithSrcNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawImageRectWithSrcNormal0009', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testCanvasDrawImageRectWithSrcNormal0009';
      let canvas = new drawing.Canvas(pixel);
      let maxVal = Number.MAX_VALUE;
      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100.1, top: 100.2, right: 700.1, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST));

        for (let i = 0; i < getEnumCount(drawing.FilterMode); i += 1) {
          for (let j = 0; j < getEnumCount(drawing.SrcRectConstraint); j += 1) {
            canvas.drawImageRectWithSrc(pixelMap, {
              left: 100, top: 100.2, right: 700, bottom: 700.2
            }, {
              left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
            }, new drawing.SamplingOptions(i), j);
          }
        }
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 0, top: 0, right: -600, bottom: -600
        }, {
          left: -100, top: -100, right: 600, bottom: 600
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100, right: 100, bottom: 600
        }, {
          left: -100, top: -100, right: -100, bottom: 700
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100, right: 100, bottom: 100
        }, {
          left: 700, top: 700, right: 700, bottom: 700
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: maxVal, top: maxVal, right: maxVal, bottom: maxVal
        }, {
          left: maxVal, top: maxVal, right: maxVal, bottom: maxVal
        });

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1000
     * @tc.name      : testCanvasDrawImageRectWithSrcMultipleCalls0010
     * @tc.desc      : testCanvasDrawImageRectWithSrcMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectWithSrcMultipleCalls0010', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectWithSrcMultipleCalls0010';
      let canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          let e1 = Math.floor(Math.random() * getEnumCount(drawing.SamplingOptions))
          let e2 = Math.floor(Math.random() * getEnumCount(drawing.SrcRectConstraint))
          canvas.drawImageRectWithSrc(pixelMap, {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          }, {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          }, new drawing.SamplingOptions(e1), e2);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1100
     * @tc.name      : testCanvasDrawImageRectWithSrcToNull0011
     * @tc.desc      : testCanvasDrawImageRectWithSrcToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectWithSrcToNull0011', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectWithSrcToNull0011';
      let canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRectWithSrc(null, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(null, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, null, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(pixelMap, null, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, null, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, null, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, null, drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, null, drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(undefined, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, undefined, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, undefined, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, undefined, drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1200
     * @tc.name      : testCanvasDrawImageRectWithSrcAbnormal0012
     * @tc.desc      : testCanvasDrawImageRectWithSrcAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectWithSrcAbnormal0012', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectWithSrcAbnormal0012';
      let canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1300
     * @tc.name      : testCanvasDrawRoundRectNormal0013
     * @tc.desc      : testCanvasDrawRoundRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawRoundRectNormal0013', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testCanvasDrawRoundRectNormal0013';
      let canvas = new drawing.Canvas(pixel);

      try {
        let rectOne: common2D.Rect = {
          left: 10, top: 100, right: 200, bottom: 300
        };
        let roundRect = new drawing.RoundRect(rectOne, 10, 10);
        canvas.drawRoundRect(roundRect);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1400
     * @tc.name      : testCanvasDrawRoundRectMultipleCalls0014
     * @tc.desc      : testCanvasDrawRoundRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawRoundRectMultipleCalls0014', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasDrawRoundRectMultipleCalls0014';
      let canvas = new drawing.Canvas(pixel);

      try {
        for (let i = 0; i < 20; i += 1) {
          let rectOne: common2D.Rect = {
            left: 10 * Math.random(), top: 100 * Math.random(), right: 200 * Math.random(), bottom: 300 * Math.random()
          };
          let roundRect = new drawing.RoundRect(rectOne, 10, 10);
          canvas.drawRoundRect(roundRect);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1500
     * @tc.name      : testCanvasGetLocalClipBoundsNormal0015
     * @tc.desc      : testCanvasGetLocalClipBoundsNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasGetLocalClipBoundsNormal0015', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testCanvasGetLocalClipBoundsNormal0015';
      let canvas = new drawing.Canvas(pixel);

      try {
        let rect: common2D.Rect = canvas.getLocalClipBounds();
        expect(rect.left).assertEqual(-1)
        expect(rect.right).assertEqual(101)
        expect(rect.top).assertEqual(-1)
        expect(rect.bottom).assertEqual(101)

        canvas.clipRect({
          left: 10, right: 50, top: 30, bottom: 90
        }, drawing.ClipOp.DIFFERENCE, true);
        rect = canvas.getLocalClipBounds();

        expect(rect.left).assertEqual(-1)
        expect(rect.right).assertEqual(101)
        expect(rect.top).assertEqual(-1)
        expect(rect.bottom).assertEqual(101)
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1600
     * @tc.name      : testCanvasGetLocalClipBoundsMultipleCalls0016
     * @tc.desc      : testCanvasGetLocalClipBoundsMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasGetLocalClipBoundsMultipleCalls0016', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testCanvasGetLocalClipBoundsMultipleCalls0016';
      let canvas = new drawing.Canvas(pixel);

      try {
        for (let i = 0; i < 20; i += 1) {
          let rect: common2D.Rect = canvas.getLocalClipBounds();
          expect(rect.left).assertEqual(-1)
          expect(rect.right).assertEqual(101)
          expect(rect.top).assertEqual(-1)
          expect(rect.bottom).assertEqual(101)
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}