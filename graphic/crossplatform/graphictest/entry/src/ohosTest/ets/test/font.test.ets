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

export default function fontTest() {
  describe('DrawingTsFontTest', () => {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0100
     * @tc.name      : testFontMeasureTextNormal0001
     * @tc.desc      : Test for testFontMeasureTextNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontMeasureTextNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testFontMeasureTextNormal0001';

      let font = new drawing.Font();
      try {
        font.measureText("drawing", drawing.TextEncoding.TEXT_ENCODING_UTF8);
        font.measureText("drawing", drawing.TextEncoding.TEXT_ENCODING_UTF16);
        font.measureText("drawing", drawing.TextEncoding.TEXT_ENCODING_UTF32);
        font.measureText("drawing", drawing.TextEncoding.TEXT_ENCODING_GLYPH_ID);
        console.info(msg + ' measureText successed');
      } catch (e) {
        console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        font.measureText("中文魑認識", drawing.TextEncoding.TEXT_ENCODING_UTF8);
        font.measureText("中文魑認識", drawing.TextEncoding.TEXT_ENCODING_UTF16);
        font.measureText("中文魑認識", drawing.TextEncoding.TEXT_ENCODING_UTF32);
        font.measureText("中文魑認識", drawing.TextEncoding.TEXT_ENCODING_GLYPH_ID);
        console.info(msg + ' measureText successed');
      } catch (e) {
        console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        font.measureText("", drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' measureText successed');
      } catch (e) {
        console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0200
     * @tc.name      : testFontMeasureTextNull0002
     * @tc.desc      : Test for testFontMeasureTextNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontMeasureTextNull0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontMeasureTextNull0002';
      let font = new drawing.Font();

      try {
        font.measureText(undefined, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' measureText succeeded');
      } catch (e) {
        console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.measureText("drawing", undefined);
        console.info(msg + ' measureText succeeded');
      } catch (e) {
        console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.measureText(null, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' measureText succeeded');
      } catch (e) {
        console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.measureText("drawing", null);
        console.info(msg + ' measureText succeeded');
      } catch (e) {
        console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0300
     * @tc.name      : testFontMeasureTextMultipleCalls0003
     * @tc.desc      : Test for testFontMeasureTextMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontMeasureTextMultipleCalls0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontMeasureTextMultipleCalls0003';
      let font = new drawing.Font();

      for (let i = 0; i < 20; i++) {
        const randomString = Math.random().toString(36).substring(2, 12);
        const randomEnum = Math.floor(Math.random() * getEnumCount(drawing.TextEncoding));
        try {
          let width = font.measureText(randomString, randomEnum);
          expect(width > 0).assertTrue();
          console.info(msg + ' measureText succeeded');
        } catch (e) {
          console.info(msg + ` measureText errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })
  })
}