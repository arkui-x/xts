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
import drawing from '@ohos.graphics.drawing';

export default function penPart2Test_() {
  describe('DrawingTsPenPart2Test', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_STATIC_0100
     * @tc.name      : testPenConstructorNormalStatic0001
     * @tc.desc      : Test for testPenConstructorNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenConstructorNormalStatic0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, (): void => {
      let msg = 'testPenConstructorNormalStatic0001';
      const pen = new drawing.Pen();

      try {
        const pen = new drawing.Pen();
        console.info(msg + ' drawing.Pen() successed');
      } catch (e) {
        console.info(msg + ` drawing.Pen() errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        const newpen = new drawing.Pen(pen);
        console.info(msg + ' drawing.Pen(pen) successed');
      } catch (e) {
        console.info(msg + ` drawing.Pen(pen) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        // let penColor: common2D.Color = ({
        //   alpha : 0, red : 0, green : 0, blue : 0
        // });
        // pen.setColor(penColor);
        let newpen = new drawing.Pen(pen);
        console.info(msg + ' drawing.Pen(pen) successed');
      } catch (e) {
        console.info(msg + ` drawing.Pen(pen) errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_STATIC_0200
     * @tc.name      : testPenResetNormalStatic0002
     * @tc.desc      : Test for testPenResetNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenResetNormalStatic0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, (): void => {
      let msg = 'testPenResetNormalStatic0002';
      const pen = new drawing.Pen();

      try {
        pen.reset();
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        // const brush_color: common2D.Color = {
        //   alpha : 255, // Alpha 透明度，完全不透明
        //   red : 255, // 红色分量
        //   green : 0, // 绿色分量
        //   blue : 0     // 蓝色分量
        // };
        // pen.setColor(brush_color);
        pen.reset();
        console.info(msg + ' reset successed');
      } catch (e) {
        console.info(msg + ` reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}