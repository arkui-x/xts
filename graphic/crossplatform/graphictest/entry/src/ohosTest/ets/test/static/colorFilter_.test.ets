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
import common2D from '@ohos.graphics.common2D';

export default function colorFilterTest_() {
  describe('DrawingTsColorFilterTest', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_COLORFILTER_STATIC_0100
     * @tc.name      : testColorFilterCreateBlendModeColorFilterNormalStatic0001
     * @tc.desc      : Test for testColorFilterCreateBlendModeColorFilterNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testColorFilterCreateBlendModeColorFilterNormalStatic0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      (): void => {
        let msg = 'testColorFilterCreateBlendModeColorFilterNormalStatic0001';
        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.CLEAR);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SRC);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.DST);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SRC_OVER);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.DST_OVER);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SRC_IN);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.DST_IN);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SRC_OUT);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.DST_OUT);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SRC_ATOP);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.DST_ATOP);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.XOR);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.PLUS);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.MODULATE);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SCREEN);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.OVERLAY);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.DARKEN);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.LIGHTEN);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.COLOR_DODGE);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.COLOR_BURN);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.HARD_LIGHT);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SOFT_LIGHT);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.DIFFERENCE);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.EXCLUSION);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.MULTIPLY);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.HUE);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.SATURATION);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.COLOR);
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }, drawing.BlendMode.LUMINOSITY);
          console.info(msg + ' createBlendModeColorFilter successed');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_COLORFILTER_STATIC_0200
     * @tc.name      : testColorFilterCreateBlendModeColorFilterMultipleCallsStatic0002
     * @tc.desc      : Test for testColorFilterCreateBlendModeColorFilterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testColorFilterCreateBlendModeColorFilterMultipleCallsStatic0002',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (): void => {
        let msg = 'testColorFilterCreateBlendModeColorFilterMultipleCallsStatic0002';

        for (let i = 0; i < 20; i++) {
          const randomColor: common2D.Color = {
            alpha: 100 + i,
            red: 50 + i,
            green: 100 + i,
            blue: 50 + i
          };
          try {
            drawing.ColorFilter.createBlendModeColorFilter(randomColor, drawing.BlendMode.SRC);
            console.info(msg + ' createBlendModeColorFilter succeeded');
          } catch (e) {
            console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
            expect().assertFail();
          }
        }
      })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_COLORFILTER_STATIC_0300
     * @tc.name      : testColorFilterCreateBlendModeColorFilterBoundaryValueStatic0003
     * @tc.desc      : Test for testColorFilterCreateBlendModeColorFilterBoundaryValue.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testColorFilterCreateBlendModeColorFilterBoundaryValueStatic0003',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, (): void => {
        let msg = 'testColorFilterCreateBlendModeColorFilterBoundaryValueStatic0003';
        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: -1,
            red: 255,
            green: 0,
            blue: 255
          }, drawing.BlendMode.SRC);
          console.info(msg + ' createBlendModeColorFilter succeeded');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }

        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 256,
            green: 0,
            blue: 255
          }, drawing.BlendMode.SRC);
          console.info(msg + ' createBlendModeColorFilter succeeded');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }

        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: -1,
            green: 0,
            blue: 255
          }, drawing.BlendMode.SRC);
          console.info(msg + ' createBlendModeColorFilter succeeded');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }

        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 256,
            blue: 255
          }, drawing.BlendMode.SRC);
          console.info(msg + ' createBlendModeColorFilter succeeded');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }

        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: -1,
            blue: 255
          }, drawing.BlendMode.SRC);
          console.info(msg + ' createBlendModeColorFilter succeeded');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }

        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 256
          }, drawing.BlendMode.SRC);
          console.info(msg + ' createBlendModeColorFilter succeeded');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }

        try {
          drawing.ColorFilter.createBlendModeColorFilter({
            alpha: 255,
            red: 255,
            green: 0,
            blue: -1
          }, drawing.BlendMode.SRC);
          console.info(msg + ' createBlendModeColorFilter succeeded');
        } catch (e) {
          console.info(msg + ` createBlendModeColorFilter errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect(e.code).assertEqual(401);
        }
      })
  })
}