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

export default function drawingTsPathTest() {
  describe('DrawingTsPathTest', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0100
     * @tc.name      : testPathMoveToNormal0001
     * @tc.desc      : testPathMoveToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathMoveToNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathMoveToNormal0001';
      try {
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.moveTo(10.1, 10.1);
        path.moveTo(-1, -1);
        console.info(msg + 'moveTo successed');
      } catch (e) {
        console.info(msg + `moveTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0200
     * @tc.name      : testPathMoveToNull0002
     * @tc.desc      : testPathMoveToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathMoveToNull0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathMoveToNull0002';
      let path = new drawing.Path();
      try {
        path.moveTo(undefined, 10);
        console.info(msg + 'moveTo successed');
      } catch (e) {
        console.info(msg + `moveTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.moveTo(10, undefined);
        console.info(msg + 'moveTo successed');
      } catch (e) {
        console.info(msg + `moveTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.moveTo(null, 10);
        console.info(msg + 'moveTo successed');
      } catch (e) {
        console.info(msg + `moveTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.moveTo(10, null);
        console.info(msg + 'moveTo successed');
      } catch (e) {
        console.info(msg + `moveTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0300
     * @tc.name      : testPathMoveToMultipleCalls0003
     * @tc.desc      : testPathMoveToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathMoveToMultipleCalls0003', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathMoveToMultipleCalls0003';
      try {
        let path = new drawing.Path();
        for (let index = 0; index < 20; index++) {
          path.moveTo(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + 'moveTo successed');
      } catch (e) {
        console.info(msg + `moveTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0400
     * @tc.name      : testPathLineToNormal0004
     * @tc.desc      : testPathLineToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathLineToNormal0004', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathLineToNormal0004';
      try {
        let path = new drawing.Path();
        path.lineTo(10, 10);
        path.lineTo(10.1, 10.1);
        path.lineTo(-1, -1);
        console.info(msg + 'lineTo successed');
      } catch (e) {
        console.info(msg + `lineTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0500
     * @tc.name      : testPathLineToNull0005
     * @tc.desc      : testPathLineToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathLineToNull0005', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathLineToNull0005';
      let path = new drawing.Path();
      try {
        path.lineTo(undefined, 10);
        console.info(msg + 'lineTo successed');
      } catch (e) {
        console.info(msg + `lineTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.lineTo(10, undefined);
        console.info(msg + 'lineTo successed');
      } catch (e) {
        console.info(msg + `lineTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.lineTo(null, 10);
        console.info(msg + 'lineTo successed');
      } catch (e) {
        console.info(msg + `lineTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.lineTo(10, null);
        console.info(msg + 'lineTo successed');
      } catch (e) {
        console.info(msg + `lineTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0600
     * @tc.name      : testPathLineToMultipleCalls0006
     * @tc.desc      : testPathLineToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathLineToMultipleCalls0006', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathLineToMultipleCalls0006';
      try {
        let path = new drawing.Path();
        for (let index = 0; index < 20; index++) {
          path.lineTo(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + 'lineTo successed');
      } catch (e) {
        console.info(msg + `lineTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0700
     * @tc.name      : testPathArcToNormal0007
     * @tc.desc      : testPathArcToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathArcToNormal0007', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathArcToNormal0007';
      try {
        let path = new drawing.Path();
        path.arcTo(10, 15, 10, 10, 0, 360);
        path.arcTo(10.2, 15.3, 10.4, 10.5, 10.3, 60.3);
        path.arcTo(-10, -15, 10, 10, 90, 180);
        path.arcTo(10, 15, -10, -10, 90, 180);
        path.arcTo(10, 15, 10, 10, -90, 180);
        path.arcTo(10, 15, 10, 10, 90, -180);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0800
     * @tc.name      : testPathArcToNull0008
     * @tc.desc      : testPathArcToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathArcToNull0008', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathArcToNull0008';
      let path = new drawing.Path();
      try {
        path.arcTo(undefined, 15, 10, 10, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, undefined, 10, 10, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, undefined, 10, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, 10, undefined, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, 10, 10, undefined, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, 10, 10, 10, undefined);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(null, 15, 10, 10, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, null, 10, 10, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, null, 10, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, 10, null, 10, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, 10, 10, null, 60);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.arcTo(10, 15, 10, 10, 10, null);
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0900
     * @tc.name      : testPathArcToMultipleCalls0009
     * @tc.desc      : testPathArcToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathArcToMultipleCalls0009', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathArcToMultipleCalls0009';
      try {
        let path = new drawing.Path();
        for (let index = 0; index < 20; index++) {
          path.arcTo(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + 'arcTo successed');
      } catch (e) {
        console.info(msg + `arcTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1000
     * @tc.name      : testPathQuadToNormal0010
     * @tc.desc      : testPathQuadToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathQuadToNormal0010', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathQuadToNormal0010';
      try {
        let path = new drawing.Path();
        path.quadTo(10, 15, 10, 10);
        path.quadTo(10.2, 15.3, 10.4, 10.5);
        path.quadTo(-10, -15, 10, 10);
        path.quadTo(10, 15, -10, -10);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1100
     * @tc.name      : testPathQuadToNull0011
     * @tc.desc      : testPathQuadToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathQuadToNull0011', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathQuadToNull0011';
      let path = new drawing.Path();
      try {
        path.quadTo(undefined, 15, 10, 10);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.quadTo(10, undefined, 10, 10);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.quadTo(10, 15, undefined, 10);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.quadTo(10, 15, 10, undefined);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.quadTo(null, 15, 10, 10);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.quadTo(10, null, 10, 10);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.quadTo(10, 15, null, 10);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.quadTo(10, 15, 10, null);
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1200
     * @tc.name      : testPathQuadToMultipleCalls0012
     * @tc.desc      : testPathQuadToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathQuadToMultipleCalls0012', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathQuadToMultipleCalls0012';
      try {
        let path = new drawing.Path();
        for (let index = 0; index < 20; index++) {
          path.quadTo(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + 'quadTo successed');
      } catch (e) {
        console.info(msg + `quadTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1300
     * @tc.name      : testPathCubicToNormal0013
     * @tc.desc      : testPathCubicToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathCubicToNormal0013', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathCubicToNormal0013';
      let path = new drawing.Path();
      try {
        path.cubicTo(10, 15, 10, 10, 10, 10);
        path.cubicTo(10.2, 15.3, 10.4, 10.5, 10.3, 60.3);
        path.cubicTo(-10, -15, 10, 10, 90, 180);
        path.cubicTo(10, 15, -10, -10, 90, 180);
        path.cubicTo(10, 15, 10, 10, -10, -10);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1400
     * @tc.name      : testPathCubicToNull0014
     * @tc.desc      : testPathCubicToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathCubicToNull0014', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathCubicToNull0014';
      let path = new drawing.Path();
      try {
        path.cubicTo(undefined, 15, 10, 10, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, undefined, 10, 10, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, undefined, 10, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, 10, undefined, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, 10, 10, undefined, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, 10, 10, 10, undefined);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(null, 15, 10, 10, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, null, 10, 10, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, null, 10, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, 10, null, 10, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, 10, 10, null, 60);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }

      try {
        path.cubicTo(10, 15, 10, 10, 10, null);
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1500
     * @tc.name      : testPathCubicToMultipleCalls0015
     * @tc.desc      : testPathCubicToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathCubicToMultipleCalls0015', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathCubicToMultipleCalls0015';
      try {
        let path = new drawing.Path();
        for (let index = 0; index < 20; index++) {
          path.cubicTo(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + 'cubicTo successed');
      } catch (e) {
        console.info(msg + `cubicTo errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1600
     * @tc.name      : testPathPathMultipleCalls0016
     * @tc.desc      : testPathPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathPathMultipleCalls0016', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathPathMultipleCalls0016';
      try {
        let path = new drawing.Path();
        for (let index = 0; index < 20; index++) {
          path.cubicTo(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        path.close();
        console.info(msg + 'close successed');
      } catch (e) {
        console.info(msg + `close errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1700
     * @tc.name      : testPathResetMultipleCalls0017
     * @tc.desc      : testPathResetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathResetMultipleCalls0017', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathResetMultipleCalls0017';
      let path = new drawing.Path();
      try {
        for (let index = 0; index < 20; index++) {
          path.cubicTo(10, 10, 10, 10, 15, 15);
          path.reset();
        }
        path.close()
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        path.cubicTo(10, 10, 10, 10, 15, 15);
        for (let index = 0; index < 20; index++) {
          path.reset();
        }
        path.close()
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_STATIC_1800
     * @tc.name      : testPathArcToNormalStatic0018
     * @tc.desc      : testPathArcToNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathArcToNormalStatic0018', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, (): void => {
      let msg = 'testPathArcToNormalStatic0018';
      try {
        let path = new drawing.Path();
        path.arcTo(10, 15, 10, 10, 0, 360);
        path.arcTo(10.2, 15.3, 10.4, 10.5, 10.3, 60.3);
        path.arcTo(-10, -15, 10, 10, 90, 180);
        path.arcTo(10, 15, -10, -10, 90, 180);
        path.arcTo(10, 15, 10, 10, -90, 180);
        path.arcTo(10, 15, 10, 10, 90, -180);
        console.info(msg + 'arcTo successed');
      } catch (error) {
        console.info(msg + `arcTo errorCode is:  ${error.code} + errormsg is: ${error.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_STATIC_1900
     * @tc.name      : testPathArcToMultipleCallsStatic0019
     * @tc.desc      : testPathArcToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathArcToMultipleCallsStatic0019', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, (): void => {
      let msg = 'testPathArcToMultipleCallsStatic0019';
      try {
        let path = new drawing.Path();
        for (let index = 0; index < 20; index++) {
          path.arcTo(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + 'arcTo successed');
      } catch (error) {
        console.info(msg + `arcTo errorCode is:  ${error.code} + errormsg is: ${error.message}`);
        expect().assertFail()
      }
    })
  })
}