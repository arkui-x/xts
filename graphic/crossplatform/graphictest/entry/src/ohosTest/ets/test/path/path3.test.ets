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
import drawing from '@ohos.graphics.drawing';
import common2D from '@ohos.graphics.common2D';

export default function drawingTsPath3Test() {
  describe('DrawingTsPath3Test', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0100
     * @tc.name      : testPathSetFillTypeNormal0001
     * @tc.desc      : testPathSetFillTypeNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathSetFillTypeNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathSetFillTypeNormal0001';
      let path = new drawing.Path();

      try {
        path.setFillType(drawing.PathFillType.WINDING);
        path.setFillType(drawing.PathFillType.EVEN_ODD);
        path.setFillType(drawing.PathFillType.INVERSE_WINDING);
        path.setFillType(drawing.PathFillType.INVERSE_EVEN_ODD);
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0200
     * @tc.name      : testPathGetBoundsNormal0002
     * @tc.desc      : testPathGetBoundsNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathGetBoundsNormal0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathGetBoundsNormal0002';

      try {
        let rect: common2D.Rect = {
          left: 0, top: 0, right: 0, bottom: 0
        };

        let path = new drawing.Path();
        path.lineTo(50, 40)
        rect = path.getBounds();

        path.addRect({
          left: 10, right: 400, top: 100, bottom: 300
        }, drawing.PathDirection.CLOCKWISE);
        rect = path.getBounds();

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0300
     * @tc.name      : testPathGetBoundsMultipleCalls0003
     * @tc.desc      : testPathGetBoundsMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetBoundsMultipleCalls0003', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathGetBoundsMultipleCalls0003';

      try {
        let path = new drawing.Path();
        for (let i = 0; i < 20; i += 1) {
          let rect = path.getBounds()
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0400
     * @tc.name      : testPathGetLengthNormal0004
     * @tc.desc      : testPathGetLengthNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathGetLengthNormal0004', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathGetLengthNormal0004';

      try {
        let path = new drawing.Path();
        let len = path.getLength(false);
        expect(len).assertEqual(0);

        path.moveTo(0, 0);
        path.arcTo(20, 20, 180, 180, 180, 90);
        len = path.getLength(false);
        expect(len).assertEqual(227.4411163330078);

        len = path.getLength(true);
        expect(len).assertEqual(329.4215087890625);

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0500
     * @tc.name      : testPathGetPositionAndTangentNormal0005
     * @tc.desc      : testPathGetPositionAndTangentNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetPositionAndTangentNormal0005', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathGetPositionAndTangentNormal0005';

      try {
        let path = new drawing.Path();
        let distance = path.getPositionAndTangent(false, 100, {
          x: 20, y: 20
        }, {
          x: 200, y: 200
        });
        expect(distance).assertEqual(false);
        path.moveTo(0, 0);
        path.lineTo(100, 100);
        distance = path.getPositionAndTangent(true, 30.1, {
          x: 20.1, y: 20.1
        }, {
          x: 200.1, y: 200.1
        });
        expect(distance).assertEqual(true);
        distance = path.getPositionAndTangent(true, 80, {
          x: -20.1, y: -20.1
        }, {
          x: 200.1, y: 200.1
        });
        expect(distance).assertEqual(true);
        distance = path.getPositionAndTangent(true, 100, {
          x: 200.1, y: 200.1
        }, {
          x: -200.1, y: -200.1
        })
        expect(distance).assertEqual(true);
        distance = path.getPositionAndTangent(true, -1, {
          x: 200.1, y: 200.1
        }, {
          x: 600.1, y: 600.1
        })
        expect(distance).assertEqual(true);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0600
     * @tc.name      : testPathConstructorNormal0006
     * @tc.desc      : testPathConstructorNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathConstructorNormal0006', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathConstructorNormal0006';

      try {
        let path: drawing.Path = new drawing.Path();
        let newPath = new drawing.Path(path);

        path.arcTo(0, 0, 100, 100, 0, 180);
        path.close();
        newPath = new drawing.Path(path);

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0700
     * @tc.name      : testPathIsClosedNormal0007
     * @tc.desc      : testPathIsClosedNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathIsClosedNormal0007', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathIsClosedNormal0007';

      try {
        let path: drawing.Path = new drawing.Path();
        let close = path.isClosed();
        expect(close).assertEqual(false);

        path.moveTo(0, 0);
        path.lineTo(0, 100);
        path.lineTo(200, 350);
        close = path.isClosed();
        expect(close).assertEqual(false);

        path.close();
        close = path.isClosed();
        expect(close).assertEqual(true);

      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0800
     * @tc.name      : testPathGetSegmentNormal0008
     * @tc.desc      : testPathGetSegmentNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathGetSegmentNormal0008', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPathGetSegmentNormal0008';
      let path = new drawing.Path();
      try {
        path.moveTo(0, 0);
        path.lineTo(0, 700);
        path.lineTo(700, 0);
        console.info(msg + 'lineTo successes');
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
      let dstPath: drawing.Path = new drawing.Path();
      try {
        let result: boolean;
        result = path.getSegment(true, 10.0, 20.0, true, dstPath)
        console.info(msg + " getSegment-----result:  "+ path.getSegment(true, 10.0, 20.0, true, dstPath));
        expect(result).assertEqual(true);
      } catch (e) {
        console.info(msg + `test getSegment . errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_0900
     * @tc.name      : testPathGetSegmentAbnormal0009
     * @tc.desc      : testPathGetSegmentAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetSegmentAbnormal0009', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPathGetSegmentAbnormal0009';
      let path = new drawing.Path();
      try {
        path.moveTo(0, 0);
        path.lineTo(0, 700);
        path.lineTo(700, 0);
        console.info(msg + 'lineTo successes');
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
      let dstPath: drawing.Path = new drawing.Path();
      try {
        path.getSegment(true, 10.0, 20.0, true, undefined)
        console.info(msg + `test getSegment error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test getSegment . errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH3_STATIC_1000
     * @tc.name      : testPathConstructorNormalStatic0010
     * @tc.desc      : testPathConstructorNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathConstructorNormalStatic0010', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, (): void => {
      let msg = 'testPathConstructorNormalStatic0010';
      try {
        let path: drawing.Path = new drawing.Path();
        let newPath = new drawing.Path(path);

        path.arcTo(0, 0, 100, 100, 0, 180);
        newPath = new drawing.Path(path);

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })
  })
}