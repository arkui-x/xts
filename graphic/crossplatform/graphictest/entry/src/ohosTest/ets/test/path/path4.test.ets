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
import drawing from '@ohos.graphics.drawing';
import { getEnumCount } from './utils';
import common2D from '@ohos.graphics.common2D';

export default function drawingTsPath4Test() {
  describe('DrawingTsPath4Test', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {

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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0100
     * @tc.name      : testPathrLinetoNormal0001
     * @tc.desc      : testPathrLinetoNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrLinetoNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrLinetoNormal0001';
      let path = new drawing.Path();

      try {
        path.rLineTo(10, 10);
        path.rLineTo(10.1, 10.1);
        path.rLineTo(-1, -1);
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0200
     * @tc.name      : testPathrLinetoNull0002
     * @tc.desc      : testPathrLinetoNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrLinetoNull0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrLinetoNull0002';
      let path = new drawing.Path();

      try {
        path.rLineTo(undefined, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rLineTo(10, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rLineTo(null, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rLineTo(10, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0300
     * @tc.name      : testPathrLinetoMultipleCalls0003
     * @tc.desc      : testPathrLinetoMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrLinetoMultipleCalls0003', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrLinetoMultipleCalls0003';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          path.rLineTo(Math.random(), Math.random());
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0400
     * @tc.name      : testPathrQuadToNormal0004
     * @tc.desc      : testPathrQuadToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathrQuadToNormal0004', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathrQuadToNormal0004';
      let path = new drawing.Path();

      try {
        path.rQuadTo(10, 15, 10, 10);
        path.rQuadTo(10.2, 15.3, 10.4, 10.5);
        path.rQuadTo(-10, -15, 10, 10);
        path.rQuadTo(10, 15, -10, -10)
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0500
     * @tc.name      : testPathrQuadToNull0005
     * @tc.desc      : testPathrQuadToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrQuadToNull0005', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrQuadToNull0005';
      let path = new drawing.Path();

      try {
        path.rQuadTo(undefined, 15, 10, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rQuadTo(10, undefined, 10, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rQuadTo(10, 15, undefined, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rQuadTo(10, 15, 10, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rQuadTo(null, 15, 10, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rQuadTo(10, null, 10, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rQuadTo(10, 15, null, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rQuadTo(10, 15, 10, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0600
     * @tc.name      : testPathrQuadToMultipleCalls0006
     * @tc.desc      : testPathrQuadToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrQuadToMultipleCalls0006', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrQuadToMultipleCalls0006';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          path.rQuadTo(Math.random(), Math.random(), Math.random(), Math.random());
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0700
     * @tc.name      : testPathrCubicToNormal0007
     * @tc.desc      : testPathrCubicToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrCubicToNormal0007', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrCubicToNormal0007';
      let path = new drawing.Path();

      try {
        path.rCubicTo(10, 15, 10, 10, 10, 10);
        path.rCubicTo(10.2, 15.3, 10.4, 10.5, 10.3, 60.3);
        path.rCubicTo(-10, -15, 10, 10, 90, 180);
        path.rCubicTo(10, 15, -10, -10, 90, 180);
        path.rCubicTo(10, 15, 10, 10, -10, -10);
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0800
     * @tc.name      : testPathrCubicToNull0008
     * @tc.desc      : testPathrCubicToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrCubicToNull0008', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrCubicToNull0008';
      let path = new drawing.Path();

      try {
        path.rCubicTo(undefined, 15, 10, 10, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, undefined, 10, 10, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, undefined, 10, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, 10, undefined, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, 10, 10, undefined, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, 10, 10, 10, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(null, 15, 10, 10, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, null, 10, 10, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, null, 10, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, 10, null, 10, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, 10, 10, null, 60);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.rCubicTo(10, 15, 10, 10, 10, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_0900
     * @tc.name      : testPathrCubicToMultipleCalls0009
     * @tc.desc      : testPathrCubicToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathrCubicToMultipleCalls0009', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathrCubicToMultipleCalls0009';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          path.rCubicTo(Math.random(), Math.random(), Math.random(), Math.random(), Math.random(), Math.random());
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1000
     * @tc.name      : testPathAddPolygonNormal0010
     * @tc.desc      : testPathAddPolygonNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddPolygonNormal0010', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddPolygonNormal0010';
      let path1 = new drawing.Path();

      try {
        path1.addPolygon([{
          x: 200, y: 200
        }, {
          x: 400, y: 200
        }, {
          x: 100, y: 400
        }], false);
        path1.addPolygon([{
          x: 200.1, y: 200.1
        }, {
          x: 400, y: 200
        }, {
          x: 100, y: 400
        }], true);
        path1.addPolygon([{
          x: 200, y: 200
        }, {
          x: 400, y: 200
        }, {
          x: 100, y: 400
        }], false);
        path1.addPolygon([{
          x: 200, y: 200
        }, {
          x: 400, y: 200
        }, {
          x: 100, y: 400
        }], false);
        path1.addPolygon([],false);
        path1.addPolygon([{
          x: -200, y: 200
        }, {
          x: -400, y: -200
        }, {
          x: 100, y: -400
        }], false);
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1100
     * @tc.name      : testPathAddPolygonMultipleCalls0011
     * @tc.desc      : testPathAddPolygonMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddPolygonMultipleCalls0011', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddPolygonMultipleCalls0011';
      let path1 = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let len = Math.floor(10 * Math.random())
          let points: common2D.Point[] = []
          for (let j = 0; j < len; j += 1) {
            points.push({
              x: Math.random(),
              y: Math.random(),
            })
          }
          path1.addPolygon(points, false)
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1200
     * @tc.name      : testPathOpNormal0012
     * @tc.desc      : testPathOpNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathOpNormal0012', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathOpNormal0012';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < getEnumCount(drawing.PathOp); i += 1) {
          path.op(path, i)
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1300
     * @tc.name      : testPathOpToNull0013
     * @tc.desc      : testPathOpToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathOpToNull0013', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathOpToNull0013';
      let path = new drawing.Path();
      try {
        path.op(null, drawing.PathOp.DIFFERENCE);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(null, drawing.PathOp.INTERSECT);
        console.info(msg + `test INTERSECT error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test INTERSECT successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(null, drawing.PathOp.UNION);
        console.info(msg + `test UNION error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test UNION successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(null, drawing.PathOp.XOR);
        console.info(msg + `test XOR error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test XOR successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(null, drawing.PathOp.REVERSE_DIFFERENCE);
        console.info(msg + `test REVERSE_DIFFERENCE error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test REVERSE_DIFFERENCE successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.op(path, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.op(undefined, drawing.PathOp.DIFFERENCE);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(undefined, drawing.PathOp.INTERSECT);
        console.info(msg + `test INTERSECT error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test INTERSECT successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(undefined, drawing.PathOp.UNION);
        console.info(msg + `test UNION	error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test UNION successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(undefined, drawing.PathOp.XOR);
        console.info(msg + `test XOR	error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test XOR successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.op(undefined, drawing.PathOp.REVERSE_DIFFERENCE);
        console.info(msg + `test REVERSE_DIFFERENCE	error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test REVERSE_DIFFERENCE successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.op(path, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1400
     * @tc.name      : testPathOpMultipleCalls0014
     * @tc.desc      : testPathOpMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathOpMultipleCalls0014', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathOpMultipleCalls0014';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let dst = new drawing.Path();
          let e = Math.floor(Math.random() * getEnumCount(drawing.PathOp))
          path.op(dst, e);
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1500
     * @tc.name      : testPathOpAbnormal0015
     * @tc.desc      : testPathOpAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathOpAbnormal0015', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathOpAbnormal0015';
      let path = new drawing.Path();

      try {
        path.op(path, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1600
     * @tc.name      : testPathSetToNull0016
     * @tc.desc      : testPathSetToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathSetToNull0016', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathSetToNull0016';
      let path = new drawing.Path();
      try {
        path.set(null);
        console.info(msg + `path set null success `);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `path set null error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.set(undefined);
        console.info(msg + `path set undefined success `);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `path set undefined error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1700
     * @tc.name      : testPathSetLastPointNormal0017
     * @tc.desc      : testPathSetLastPointNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathSetLastPointNormal0017', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathSetLastPointNormal0017';
      let path = new drawing.Path();
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      path.rQuadTo(5000, 5000, 10000, 5000);
      try {
        path.setLastPoint(50, 50);
        console.info(msg + `path 1 setLastPoint  success`);
      } catch (e) {
        console.info(msg + `path 1 setLastPoint error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.arcTo(300, 850, 400, 900, 0, 90);
      try {
        path.setLastPoint(600.25, 450.258);
        console.info(msg + `path 2 setLastPoint success`);
      } catch (e) {
        console.info(msg + `path 2 setLastPoint error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setLastPoint(0, 0);
        console.info(msg + `path 3 setLastPoint success`);
      } catch (e) {
        console.info(msg + `path 3 setLastPoint error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setLastPoint(-100, -50.23522);
        console.info(msg + `path 4 setLastPoint success`);
      } catch (e) {
        console.info(msg + `path 4 setLastPoint error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setLastPoint(700, 500);
        console.info(msg + `path 5 setLastPoint success`);
      } catch (e) {
        console.info(msg + `path 5 setLastPoint error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setLastPoint(Number.MAX_VALUE, Number.MAX_VALUE);
        console.info(msg + `path 6 setLastPoint success`);
      } catch (e) {
        console.info(msg + `path 6 setLastPoint error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1800
     * @tc.name      : testPathSetLastPointMultipleCalls0018
     * @tc.desc      : testPathSetLastPointMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathSetLastPointMultipleCalls0018', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathSetLastPointMultipleCalls0018';
      let path = new drawing.Path();
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      for (let i = 0; i < 20; i += 1) {
        try {
          path.setLastPoint(Math.random() *100, Math.random() *300)
          console.info(msg + `path setLastPoint success step: ` + i);
        } catch (e) {
          console.info(msg + `path setLastPoint error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_1900
     * @tc.name      : testPathSetLastPointToNull0019
     * @tc.desc      : testPathSetLastPointToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathSetLastPointToNull0019', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathSetLastPointToNull0019';
      let path = new drawing.Path();
      try {
        path.setLastPoint(null,100);
        console.info(msg + `path setLastPoint null success `);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `path setLastPoint null error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.set(undefined);
        console.info(msg + `path setLastPoint undefined success `);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `path setLastPoint undefined error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.setLastPoint(300, null)
        console.info(msg + `path setLastPoint null 2 success `);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `path setLastPoint null 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.setLastPoint(300, undefined);
        console.info(msg + `path setLastPoint undefined 2 success `);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `path setLastPoint undefined 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_2000
     * @tc.name      : testPathGetFillTypeNormal0020
     * @tc.desc      : testPathGetFillTypeNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathGetFillTypeNormal0020', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathGetFillTypeNormal0020';
      let path = new drawing.Path();
      try {
        let getFillType = path.getFillType();
        console.info(msg + `path 1 getFillType  success`);
        expect(getFillType).assertEqual(drawing.PathFillType.WINDING);
      } catch (e) {
        console.info(msg + `path 1 getFillType error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setFillType(drawing.PathFillType.EVEN_ODD);
        console.info(msg + `path setFillType  EVEN_ODD success`);
      } catch (e) {
        console.info(msg + `path setFillType EVEN_ODD error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        let getFillType2 = path.getFillType();
        console.info(msg + `path 1 getFillType2  success`);
        expect(getFillType2).assertEqual(drawing.PathFillType.EVEN_ODD);
      } catch (e) {
        console.info(msg + `path 1 getFillType2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setFillType(drawing.PathFillType.WINDING);
        console.info(msg + `path setFillType  WINDING success`);
      } catch (e) {
        console.info(msg + `path setFillType WINDING error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        let getFillType3 = path.getFillType();
        console.info(msg + `path 1 getFillType3  success`);
        expect(getFillType3).assertEqual(drawing.PathFillType.WINDING);
      } catch (e) {
        console.info(msg + `path 1 getFillType3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setFillType(drawing.PathFillType.INVERSE_WINDING);
        console.info(msg + `path setFillType  INVERSE_WINDING success`);
      } catch (e) {
        console.info(msg + `path setFillType INVERSE_WINDING error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        let getFillType4 = path.getFillType();
        console.info(msg + `path 1 getFillType4  success`);
        expect(getFillType4).assertEqual(drawing.PathFillType.INVERSE_WINDING);
      } catch (e) {
        console.info(msg + `path 1 getFillType4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.setFillType(drawing.PathFillType.INVERSE_EVEN_ODD);
        console.info(msg + `path setFillType  INVERSE_EVEN_ODD success`);
      } catch (e) {
        console.info(msg + `path setFillType INVERSE_EVEN_ODD error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        let getFillType5 = path.getFillType();
        console.info(msg + `path 1 getFillType5  success`);
        expect(getFillType5).assertEqual(drawing.PathFillType.INVERSE_EVEN_ODD);
      } catch (e) {
        console.info(msg + `path 1 getFillType5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_2100
     * @tc.name      : testPathGetFillTypeMultipleCalls0021
     * @tc.desc      : testPathGetFillTypeMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetFillTypeMultipleCalls0021', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathGetFillTypeMultipleCalls0021';
      let path = new drawing.Path();
      for (let i = 0; i < 20; i += 1) {
        try {
          path.setFillType(drawing.PathFillType.INVERSE_EVEN_ODD);
          console.info(msg + `path setFillType  INVERSE_EVEN_ODD success step: ` + i);
        } catch (e) {
          console.info(msg + `path setFillType INVERSE_EVEN_ODD error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
        try {
          let getFillType5 = path.getFillType();
          console.info(msg + `path 1 getFillType5  success step: ` + i);
          expect(getFillType5).assertEqual(drawing.PathFillType.INVERSE_EVEN_ODD);
        } catch (e) {
          console.info(msg + `path 1 getFillType5 error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_2200
     * @tc.name      : testPathRewindNormal0022
     * @tc.desc      : testPathRewindNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathRewindNormal0022', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathRewindNormal0022';
      let path = new drawing.Path();
      try {
        path.rewind();
        console.info(msg + `path rewind  success`);
        let empty = path.isEmpty();
        console.info(msg + 'empty : ', empty);
        expect(empty).assertEqual(true);
      } catch (e) {
        console.info(msg + `path rewind 1 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      try {
        path.rewind();
        console.info(msg + `path 2 rewind  success`);
        let empty2 = path.isEmpty();
        console.info(msg + 'empty2 : ', empty2);
        expect(empty2).assertEqual(true);
      } catch (e) {
        console.info(msg + `path rewind 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_2300
     * @tc.name      : testPathRewindMultipleCalls0023
     * @tc.desc      : testPathRewindMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathRewindMultipleCalls0023', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathRewindMultipleCalls0023';
      let path = new drawing.Path();
      for (let i = 0; i < 20; i += 1) {
        try {
          path.rewind()
          console.info(msg + `path rewind success step: ` + i);
          let empty = path.isEmpty();
          console.info(msg + 'empty : ', empty + 'step: ' + i);
          expect(empty).assertEqual(true);
        } catch (e) {
          console.info(msg + `path rewind error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_2400
     * @tc.name      : testPathIsEmptyNormal0024
     * @tc.desc      : testPathIsEmptyNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathIsEmptyNormal0024', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathIsEmptyNormal0024';
      let path = new drawing.Path();
      try {
        let empty = path.isEmpty();
        console.info(msg + `path isEmpty success`);
        console.info(msg + 'empty : ', empty);
        expect(empty).assertEqual(true);
      } catch (e) {
        console.info(msg + `path isEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      try {
        let empty2 = path.isEmpty();
        console.info(msg + `path empty2 success`);
        console.info(msg + 'empty2 : ', empty2);
        expect(empty2).assertEqual(false);
      } catch (e) {
        console.info(msg + `path empty2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.rewind()
        let empty3 = path.isEmpty();
        console.info(msg + `path empty3 success`);
        console.info(msg + 'empty3 : ', empty3);
        expect(empty3).assertEqual(true);
      } catch (e) {
        console.info(msg + `path empty3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      path.close()
      try {
        let empty4 = path.isEmpty();
        console.info(msg + `path empty4 success`);
        console.info(msg + 'empty4 : ', empty4);
        expect(empty4).assertEqual(false);
      } catch (e) {
        console.info(msg + `path empty4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_2500
     * @tc.name      : testPathIsRectNormal0025
     * @tc.desc      : testPathIsRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathIsRectNormal0025', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathIsRectNormal0025';
      let path = new drawing.Path();
      try {
        let isRect = path.isRect(null);
        console.info(msg + `path isRect success`);
        expect(isRect).assertEqual(false);
      } catch (e) {
        console.info(msg + `path isRect error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let rect: common2D.Rect = { left : 0, top : 0, right : 100, bottom : 100 };
      //canvas.save()
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      try {
        let isRect2 = path.isRect(rect);
        console.info(msg + `path isRect2 success`);
        expect(isRect2).assertEqual(false);
      } catch (e) {
        console.info(msg + `path isRect2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.lineTo(300, 100);
      path.close();
      try {
        let isRect3 = path.isRect(rect);
        console.info(msg + `path isRect3 success`);
        expect(isRect3).assertEqual(true);
      } catch (e) {
        console.info(msg + `path isRect3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      rect = { left : 0, top : 125, right : 100, bottom : 225 };
      path.reset()
      let rect11: common2D.Rect = {
        left: 200,
        top: 500,
        right: 400,
        bottom: 700
      };
      let roundRec11: drawing.RoundRect = new drawing.RoundRect(rect11, 20, 20);
      path.addRoundRect(roundRec11);
      try {
        let isRect4 = path.isRect(rect);
        console.info(msg + `path isRect4 success`);
        expect(isRect4).assertEqual(false);
      } catch (e) {
        console.info(msg + `path isRect4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      rect = { left : 200, top : 125, right : 500, bottom : 425 };
      path.reset()
      roundRec11 = new drawing.RoundRect(rect11, 0, 0);
      path.addRoundRect(roundRec11);
      try {
        let isRect5 = path.isRect(rect);
        console.info(msg + `path isRect5 success`);
        expect(isRect5).assertEqual(true);
      } catch (e) {
        console.info(msg + `path isRect5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH4_STATIC_2600
     * @tc.name      : testPathOpNormalStatic0026
     * @tc.desc      : testPathOpNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathOpNormalStatic0026', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, (): void => {
      let msg = 'testPathOpNormalStatic0026';
      try {
        expect(drawing.PathOp.DIFFERENCE + '').assertEqual('0');
        expect(drawing.PathOp.INTERSECT + '').assertEqual('1');
        expect(drawing.PathOp.UNION + '').assertEqual('2');
        expect(drawing.PathOp.XOR + '').assertEqual('3');
        expect(drawing.PathOp.REVERSE_DIFFERENCE + '').assertEqual('4');
        console.info(msg + 'PathOp successes');
      } catch (e) {
        console.info(msg + `PathOp errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })
  })
}