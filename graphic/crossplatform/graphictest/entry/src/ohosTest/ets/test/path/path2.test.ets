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

export default function drawingTsPath2Test() {
  describe('DrawingTsPath2Test', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0100
     * @tc.name      : testPathAddArcNormal0001
     * @tc.desc      : testPathAddArcNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathAddArcNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathAddArcNormal0001';
      let path = new drawing.Path();
      let maxVal = Number.MAX_VALUE;

      try {
        path.addArc({
          left: 10, right: 400, top: 100, bottom: 300
        }, 90, 180);
        path.addArc({
          left: 10.1, right: 400.1, top: 100.1, bottom: 300.1
        }, 90.1, 180.1);
        path.addArc({
          left: -10.1, right: 400.1, top: -100.1, bottom: 300.1
        }, -90, -180);
        path.addArc({
          left: 10, right: -400, top: 100, bottom: -300
        }, 450, 361);
        path.addArc({
          left: 100, right: 100, top: 100, bottom: 300
        }, 45, 36);
        path.addArc({
          left: 100, right: 100, top: 100, bottom: 100
        }, 100, -200);
        path.addArc({
          left: maxVal, right: maxVal, top: maxVal, bottom: maxVal
        }, maxVal, maxVal);
        path.close()
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0200
     * @tc.name      : testPathAddArcMultipleCalls0002
     * @tc.desc      : testPathAddArcMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddArcMultipleCalls0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddArcMultipleCalls0002';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          path.addArc({
            left: Math.random(),
            right: Math.random(),
            top: Math.random(),
            bottom: Math.random(),
          }, Math.random(), Math.random());
        }
        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0300
     * @tc.name      : testPathAddArcToNull0003
     * @tc.desc      : testPathAddArcToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddArcToNull0003', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddArcToNull0003';
      let path = new drawing.Path();

      try {
        path.addArc(null, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: 100, bottom: 300
        }, null, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: 100, bottom: 300
        }, 90, null);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc(undefined, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: 100, bottom: 300
        }, undefined, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: 100, bottom: 300
        }, 90, undefined);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: null, right: 400, top: 100, bottom: 300
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: null, top: 100, bottom: 300
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: null, bottom: 300
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: 100, bottom: null
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: undefined, right: 400, top: 100, bottom: 300
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: undefined, top: 100, bottom: 300
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: undefined, bottom: 300
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addArc({
          left: 10, right: 400, top: 100, bottom: undefined
        }, 90, 180);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test addArc is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0400
     * @tc.name      : testPathAddCircleNormal0004
     * @tc.desc      : testPathAddCircleNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathAddCircleNormal0004', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathAddCircleNormal0004';
      let path = new drawing.Path();
      let maxVal = Number.MAX_VALUE

      try {
        path.addCircle(100, 200, 50, drawing.PathDirection.CLOCKWISE);
        path.addCircle(100.1, 300.1, 50.1, drawing.PathDirection.COUNTER_CLOCKWISE);
        path.addCircle(200, 200, 50);
        path.addCircle(maxVal, maxVal, maxVal);
        path.addCircle(-200, -200, 200);

        path.addCircle(100, 200, -1, drawing.PathDirection.CLOCKWISE);
        path.addCircle(100, 200, 0);

        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0500
     * @tc.name      : testPathAddCircleMultipleCalls0005
     * @tc.desc      : testPathAddCircleMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddCircleMultipleCalls0005', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddCircleMultipleCalls0005';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let randomEnum = Math.floor(Math.random() * getEnumCount(drawing.PathDirection))
          path.addCircle(Math.random(), Math.random(), Math.random(), randomEnum)
        }
        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0600
     * @tc.name      : testPathAddCircleToNull0006
     * @tc.desc      : testPathAddCircleToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddCircleToNull0006', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddCircleToNull0006';
      let path = new drawing.Path();
      try {
        path.addCircle(null, 200, 50, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addCircle(100, null, 50, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addCircle(100, 200, null, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addCircle(100, 200, 50, null);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addCircle(undefined, 200, 50, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addCircle(100, undefined, 50, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addCircle(100, 200, undefined, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addCircle(100, 200, 50, undefined);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0700
     * @tc.name      : testPathAddCircleAbnormal0007
     * @tc.desc      : testPathAddCircleAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddCircleAbnormal0007', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddCircleAbnormal0007';
      let path = new drawing.Path();

      try {
        path.addCircle(100, 200, 50, 10);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0800
     * @tc.name      : testPathAddOvalNormal0008
     * @tc.desc      : testPathAddOvalNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathAddOvalNormal0008', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathAddOvalNormal0008';
      let path = new drawing.Path();
      let maxVal = Number.MAX_VALUE;

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, 4, drawing.PathDirection.CLOCKWISE);
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, 5, drawing.PathDirection.CLOCKWISE);
        path.addOval({
          left: 10.1, right: 400.1, top: 100.1, bottom: 300.1
        }, 4.1);
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, 5, drawing.PathDirection.COUNTER_CLOCKWISE);
        path.addOval({
          left: 10.1, right: 400.1, top: 100.1, bottom: 300.1
        }, 5.1);
        path.addOval({
          left: -10, right: 400, top: -10, bottom: 300
        }, 1);
        path.addOval({
          left: 10, right: -400, top: 100, bottom: -300
        }, 5, drawing.PathDirection.CLOCKWISE);
        path.addOval({
          left: maxVal, right: maxVal, top: maxVal, bottom: maxVal
        }, 0);
        path.addOval({
          left: 100, right: 100, top: 100, bottom: 200
        }, 1);
        path.addOval({
          left: 100, right: 100, top: 100, bottom: 200
        }, 3);
        path.addOval({
          left: 100, right: 100, top: 100, bottom: 100
        }, 10);

        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_0900
     * @tc.name      : testPathAddOvalMultipleCalls0009
     * @tc.desc      : testPathAddOvalMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddOvalMultipleCalls0009', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddOvalMultipleCalls0009';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let randomEnum = Math.floor(Math.random() * getEnumCount(drawing.PathDirection));
          path.addOval({
            left: Math.random(), right: Math.random(), top: Math.random(), bottom: Math.random()
          }, Math.random(), randomEnum);
        }
        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1000
     * @tc.name      : testPathAddOvalToNull0010
     * @tc.desc      : testPathAddOvalToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddOvalToNull0010', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddOvalToNull0010';
      let path = new drawing.Path();

      try {
        path.addOval(null, 5, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, null, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, 5, null);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval(undefined, 5, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, undefined, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: null, right: 400, top: 100, bottom: 300
        }, 5, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: null, top: 100, bottom: 300
        }, 5, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: null, bottom: 300
        }, 5, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: null
        }, 5, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: undefined, right: 400, top: 100, bottom: 300
        }, 5, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: undefined, top: 100, bottom: 300
        }, 5, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: undefined, bottom: 300
        }, 5, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: undefined
        }, 5, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1100
     * @tc.name      : testPathAddOvalAbnormal0011
     * @tc.desc      : testPathAddOvalAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddOvalAbnormal0011', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddOvalAbnormal0011';
      let path = new drawing.Path();

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, -1, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, 4, 10);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1200
     * @tc.name      : testPathAddRectNormal0012
     * @tc.desc      : testPathAddRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathAddRectNormal0012', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathAddRectNormal0012';
      let path = new drawing.Path();
      let maxVal = Number.MAX_VALUE;

      try {
        path.addRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, drawing.PathDirection.CLOCKWISE);
        path.addRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, drawing.PathDirection.COUNTER_CLOCKWISE);
        path.addRect({
          left: 10.1, right: 400.1, top: 100.1, bottom: 300.1
        });
        path.addOval({
          left: -10, right: 400, top: -10, bottom: 300
        }, 300);
        path.addRect({
          left: 10, right: -400, top: 100, bottom: -300
        }, drawing.PathDirection.CLOCKWISE);
        path.addRect({
          left: maxVal, right: maxVal, top: maxVal, bottom: maxVal
        });
        path.addRect({
          left: 100, right: 100, top: 100, bottom: 200
        });
        path.addRect({
          left: 100, right: 100, top: 100, bottom: 100
        });
        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1300
     * @tc.name      : testPathAddRectMultipleCalls0013
     * @tc.desc      : testPathAddRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddRectMultipleCalls0013', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddRectMultipleCalls0013';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let randomEnum = Math.floor(Math.random() * getEnumCount(drawing.PathDirection))
          path.addRect({
            left: Math.random(), right: Math.random(), top: Math.random(), bottom: Math.random()
          }, randomEnum)
        }
        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1400
     * @tc.name      : testPathAddRectToNull0014
     * @tc.desc      : testPathAddRectToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddRectToNull0014', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddRectToNull0014';
      let path = new drawing.Path();

      try {
        path.addRect(null, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, null);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect(undefined, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, undefined);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: null, right: 400, top: 100, bottom: 300
        }, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: null, top: 100, bottom: 300
        }, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: 400, top: null, bottom: 300
        }, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: 400, top: 100, bottom: null
        }, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: undefined, right: 400, top: 100, bottom: 300
        }, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: undefined, top: 100, bottom: 300
        }, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: 400, top: undefined, bottom: 300
        }, drawing.PathDirection.COUNTER_CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRect({
          left: 10, right: 400, top: 100, bottom: undefined
        }, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1500
     * @tc.name      : testPathAddRectAbnormal0015
     * @tc.desc      : testPathAddRectAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddRectAbnormal0015', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddRectAbnormal0015';
      let path = new drawing.Path();

      try {
        path.addRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, 10);
        path.close();
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1600
     * @tc.name      : testPathAddRoundRectNormal0016
     * @tc.desc      : testPathAddRoundRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathAddRoundRectNormal0016', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathAddRoundRectNormal0016';

      try {
        let path = new drawing.Path();
        let roundRect = new drawing.RoundRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, 50, 50);
        path.addRoundRect(roundRect, drawing.PathDirection.CLOCKWISE);
        path.addRoundRect(roundRect, drawing.PathDirection.COUNTER_CLOCKWISE);
        path.addRoundRect(roundRect);
        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1700
     * @tc.name      : testPathAddRoundRectMultipleCalls0017
     * @tc.desc      : testPathAddRoundRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddRoundRectMultipleCalls0017', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddRoundRectMultipleCalls0017';
      let path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let roundRect = new drawing.RoundRect({
            left: 10, right: 400, top: 100, bottom: 300
          }, 50, 50);
          let randomEnum = Math.floor(Math.random() * getEnumCount(drawing.PathDirection))
          path.addRoundRect(roundRect, randomEnum);
        }
        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1800
     * @tc.name      : testPathAddRoundRectToNull0018
     * @tc.desc      : testPathAddRoundRectToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddRoundRectToNull0018', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddRoundRectToNull0018';
      let path = new drawing.Path();
      let roundRect = new drawing.RoundRect({
        left: 10, right: 400, top: 100, bottom: 300
      }, 50, 50);

      try {
        path.addRoundRect(null, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRoundRect(roundRect, null);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRoundRect(undefined, drawing.PathDirection.CLOCKWISE);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.addRoundRect(roundRect, undefined);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_1900
     * @tc.name      : testPathAddRoundRectAbnormal0019
     * @tc.desc      : testPathAddRoundRectAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddRoundRectAbnormal0019', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddRoundRectAbnormal0019';
      let path = new drawing.Path();

      try {
        let roundRect = new drawing.RoundRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, 50, 50);
        path.addRoundRect(roundRect, 10);
        console.info(msg + 'reset error');
        expect().assertFail();
      } catch (e) {
        console.info(msg + `reset successes. errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2000
     * @tc.name      : testPathAddPathNormal0020
     * @tc.desc      : testPathAddPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathAddPathNormal0020', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathAddPathNormal0020';

      try {
        let path = new drawing.Path();
        let matrix = new drawing.Matrix();
        let dstPath = new drawing.Path();
        dstPath.addPath(path, matrix);
        path.addOval({
          left: 10, right: 400, top: 100, bottom: 300
        }, 5, drawing.PathDirection.CLOCKWISE);
        dstPath.addPath(path);
        matrix.setMatrix([5, 0, 0, 0, 1, 2, 0, 0, 1]);
        path.addCircle(100, 200, 50, drawing.PathDirection.COUNTER_CLOCKWISE);
        dstPath.addPath(path, matrix);

        dstPath .addPath(path, null);

        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2100
     * @tc.name      : testPathAddPathMultipleCalls0021
     * @tc.desc      : testPathAddPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddPathMultipleCalls0021', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddPathMultipleCalls0021';

      try {
        let dstPath = new drawing.Path()
        for (let i = 0; i < 20; i += 1) {
          let path = new drawing.Path();
          let matrix = new drawing.Matrix();
          dstPath.addPath(path, matrix);
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2200
     * @tc.name      : testPathAddPathToNull0022
     * @tc.desc      : testPathAddPathToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathAddPathToNull0022', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathAddPathToNull0022';

      try {
        let dstPath = new drawing.Path();
        let matrix = new drawing.Matrix();
        dstPath.addPath(null, matrix);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let dstPath = new drawing.Path();
        let matrix = new drawing.Matrix();
        dstPath.addPath(undefined, matrix);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let dstPath = new drawing.Path();
        let path = new drawing.Path();
        dstPath.addPath(path, undefined);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2300
     * @tc.name      : testPathTransformNormal0023
     * @tc.desc      : testPathTransformNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathTransformNormal0023', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathTransformNormal0023';

      try {
        let path = new drawing.Path();
        let matrix = new drawing.Matrix();
        path.transform(matrix);

        let roundRect = new drawing.RoundRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, 50, 50);
        path.addRoundRect(roundRect, drawing.PathDirection.CLOCKWISE);
        path.transform(matrix);

        path.close();
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2400
     * @tc.name      : testPathTransformMultipleCalls0024
     * @tc.desc      : testPathTransformMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathTransformMultipleCalls0024', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathTransformMultipleCalls0024';

      try {
        for (let i = 0; i < 20; i += 1) {
          let path = new drawing.Path();
          let matrix = new drawing.Matrix();

          path.transform(matrix);
          path.close();
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2500
     * @tc.name      : testPathTransformToNull0025
     * @tc.desc      : testPathTransformToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathTransformToNull0025', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathTransformToNull0025';

      try {
        let path = new drawing.Path();
        path.transform(null);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let path = new drawing.Path();
        path.transform(undefined);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2600
     * @tc.name      : testPathContainsNormal0026
     * @tc.desc      : testPathContainsNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathContainsNormal0026', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathContainsNormal0026';

      try {
        let path = new drawing.Path();
        let rect: common2D.Rect = {
          left: 50, top: 50, right: 250, bottom: 250
        };
        path.addRect(rect, drawing.PathDirection.CLOCKWISE);
        expect(path.contains(0, 0)).assertEqual(false);
        expect(path.contains(50, 50)).assertEqual(true);
        expect(path.contains(60.1, 60.1)).assertEqual(true);
        expect(path.contains(-10, -10)).assertEqual(false);
        console.info(msg + 'reset successes.');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2700
     * @tc.name      : testPathContainsMultipleCalls0027
     * @tc.desc      : testPathContainsMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathContainsMultipleCalls0027', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathContainsMultipleCalls0027';

      try {
        let path = new drawing.Path();
        for (let i = 0; i < 20; i += 1) {
          let rect: common2D.Rect = {
            left: 50, top: 50, right: 250, bottom: 250
          };
          path.addRect(rect, drawing.PathDirection.CLOCKWISE);
          let val = path.contains(Math.random() * 200 + 50, Math.random() * 200 + 50);
          expect(val).assertEqual(true);
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH2_2800
     * @tc.name      : testPathContainsToNull0028
     * @tc.desc      : testPathContainsToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathContainsToNull0028', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathContainsToNull0028';
      let path = new drawing.Path();

      try {
        path.contains(null, 100);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.contains(100, null);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.contains(undefined, 100);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.contains(100, undefined);
        console.info(msg + `reset error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })
  })
}