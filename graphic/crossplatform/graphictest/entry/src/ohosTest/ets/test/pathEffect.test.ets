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
import { getRandomNumber } from './utils';

export default function pathEffectTest() {
  describe('DrawingTsPathEffectTest', () => {
    const DEFAULT = 0;
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATHEFFECT_0100
     * @tc.name      : testCreateDashPathEffectNormal0001
     * @tc.desc      : Test for testCreateDashPathEffectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testCreateDashPathEffectNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testCreateDashPathEffectNormal0001';

      try {
        drawing.PathEffect.createDashPathEffect([10, 5], 5);
        console.info(msg + ' createDashPathEffect with [10, 5], 5 successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        drawing.PathEffect.createDashPathEffect([10, 5], 5.52);
        console.info(msg + ' createDashPathEffect with [10, 5], 5.52 successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        drawing.PathEffect.createDashPathEffect([10, 5], 0);
        console.info(msg + ' createDashPathEffect with [10, 5], 0 successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        drawing.PathEffect.createDashPathEffect([10.52, 5.522], 0);
        console.info(msg + ' createDashPathEffect with [10.52, 5.522], 0 successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATHEFFECT_0200
     * @tc.name      : testCreateDashPathEffectNull0002
     * @tc.desc      : Test for testCreateDashPathEffectNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCreateDashPathEffectNull0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCreateDashPathEffectNull0002';

      try {
        drawing.PathEffect.createDashPathEffect(undefined, 5);
        console.info(msg + ' createDashPathEffect with undefined, 5 successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.PathEffect.createDashPathEffect([10, 5], undefined);
        console.info(msg + ' createDashPathEffect with [10, 5], undefined successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.PathEffect.createDashPathEffect(null, 5);
        console.info(msg + ' createDashPathEffect with null, 5 successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.PathEffect.createDashPathEffect([10, 5], null);
        console.info(msg + ' createDashPathEffect with [10, 5], null successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        if (0) {
          // todo: case block
          drawing.PathEffect.createDashPathEffect([], 5);
        }
        console.info(msg + ' createDashPathEffect with [], 5 successed');
      } catch (e) {
        console.info(msg + ` createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATHEFFECT_0300
     * @tc.name      : testCreateDashPathEffectMultipleCalls0003
     * @tc.desc      : Test for testCreateDashPathEffectMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCreateDashPathEffectMultipleCalls0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testCreateDashPathEffectMultipleCalls0003';

      for (let i = 0; i < 20; i++) {
        const randomValues = [Math.random() * 10, Math.random() * 10];
        const randomValue = Math.random() * 10;

        try {
          drawing.PathEffect.createDashPathEffect(randomValues, randomValue);
          console.info(`${msg} createDashPathEffect with [${randomValues}], ${randomValue} succeeded`);
        } catch (e) {
          console.info(`${msg} createDashPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATHEFFECT_0400
     * @tc.name      : testcreateCornerPathEffectNormal0004
     * @tc.desc      : Test for testcreateCornerPathEffectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testcreateCornerPathEffectNormal0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testcreateCornerPathEffectNormal0004';

      try {
        drawing.PathEffect.createCornerPathEffect(1);
        console.info(msg + ' createCornerPathEffect with [10, 5], 5 successed');
      } catch (e) {
        console.info(msg + ` createCornerPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        drawing.PathEffect.createCornerPathEffect(30.1);
        console.info(msg + ' createCornerPathEffect with [10, 5], 5.52 successed');
      } catch (e) {
        console.info(msg + ` createCornerPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATHEFFECT_0500
     * @tc.name      : testcreateCornerPathEffectNull0005
     * @tc.desc      : Test for testcreateCornerPathEffectNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testcreateCornerPathEffectNull0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testcreateCornerPathEffectNull0005';

      try {
        drawing.PathEffect.createCornerPathEffect(undefined);
        console.info(msg + ' createCornerPathEffect with undefined, 5 successed');
      } catch (e) {
        console.info(msg + ` createCornerPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.PathEffect.createCornerPathEffect(null);
        console.info(msg + ' createCornerPathEffect with [10, 5], undefined successed');
      } catch (e) {
        console.info(msg + ` createCornerPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATHEFFECT_0600
     * @tc.name      : testcreateCornerPathEffectMultipleCalls0006
     * @tc.desc      : Test for testcreateCornerPathEffectMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testcreateCornerPathEffectMultipleCalls0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testcreateCornerPathEffectMultipleCalls0006';

      try {
        drawing.PathEffect.createCornerPathEffect(0);
        console.info(msg + ' createCornerPathEffect with [10, 5, 10, 5], 5, 5 successed');
      } catch (e) {
        console.info(msg + ` createCornerPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.PathEffect.createCornerPathEffect(-1);
        console.info(msg + ' createCornerPathEffect with [10, 5, 10, 5] successed');
      } catch (e) {
        console.info(msg + ` createCornerPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATHEFFECT_0700
     * @tc.name      : testcreateCornerPathEffectMultipleCalls0007
     * @tc.desc      : Test for testcreateCornerPathEffectMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testcreateCornerPathEffectMultipleCalls0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testcreateCornerPathEffectMultipleCalls0007';

      for (let i = 0; i < 20; i++) {
        try {
          drawing.PathEffect.createCornerPathEffect(getRandomNumber(0, Number.MAX_SAFE_INTEGER));
          console.info(`${msg} createCornerPathEffect succeeded`);
        } catch (e) {
          console.info(`${msg} createCornerPathEffect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })
  })
}