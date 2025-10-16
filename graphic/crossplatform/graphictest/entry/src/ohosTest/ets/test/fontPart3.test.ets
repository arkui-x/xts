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

import {
  afterAll,
  afterEach,
  beforeAll,
  beforeEach,
  describe,
  expect,
  it,
  TestType,
  Size,
  Level
} from '@ohos/hypium';
import drawing from '@ohos.graphics.drawing';
import { getRandomNumber } from './utils';
import common2D from '@ohos.graphics.common2D';

export default function fontPart3Test() {
  describe('DrawingTsFontPart3Test', () => {
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
     * @tc.name      : testFontTextToGlyphsNormal0001
     * @tc.desc      : Test for testFontTextToGlyphsNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontTextToGlyphsNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testFontTextToGlyphsNormal0001';
      let font = new drawing.Font();

      try {
        let glyphs: number[] = font.textToGlyphs('奇8龍@Fly#龘2023!*你好');
        expect(glyphs.length == 17).assertTrue();
        console.info(msg + ' textToGlyphs1 successed,glyphs:' + glyphs.length);
      } catch (e) {
        console.info(msg + ` textToGlyphs1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let glyphs: number[] = font.textToGlyphs('奇8龍@Fly#龘2023!*你好', 17);
        expect(glyphs.length == 17).assertTrue();
        console.info(msg + ' textToGlyphs2 successed,glyphs:' + glyphs.length);
      } catch (e) {
        console.info(msg + ` textToGlyphs2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let glyphs: number[] = font.textToGlyphs("", 0);
        console.info(msg + ' textToGlyphs5 successed,glyphs:' + glyphs);
      } catch (e) {
        console.info(msg + ` textToGlyphs5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0200
     * @tc.name      : testFontTextToGlyphsNull0002
     * @tc.desc      : Test for testFontTextToGlyphsNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontTextToGlyphsNull0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testFontTextToGlyphsNull0002';
      let font = new drawing.Font();

      try {
        font.textToGlyphs(null, 2);
        console.info(msg + ' textToGlyphs successed');
      } catch (e) {
        console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.textToGlyphs('奇8龍@Fly#龘2023!*你好', null);
        console.info(msg + ' textToGlyphs succeeded');
      } catch (e) {
        console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.textToGlyphs(null, 2);
        console.info(msg + ' textToGlyphs successed');
      } catch (e) {
        console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.textToGlyphs('奇8龍@Fly#龘2023!*你好', undefined);
        console.info(msg + ' textToGlyphs succeeded');
      } catch (e) {
        console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0300
     * @tc.name      : testFontTextToGlyphsMultipleCalls0003
     * @tc.desc      : Test for testFontTextToGlyphsMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontTextToGlyphsMultipleCalls0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontTextToGlyphsMultipleCalls0003';
      let font = new drawing.Font();
      const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

      for (let i = 0; i < 20; i++) {
        let randomString = ''
        for (let j = 0; j < 10; j++) {
          randomString += characters.charAt(Math.floor(Math.random() * characters.length));
        }
        try {
          let glyphs: number[] = font.textToGlyphs(randomString, 10);
          expect(glyphs.length == 10).assertTrue();
          console.info(msg + ' textToGlyphs successed,glyphs:' + glyphs.length);
        } catch (e) {
          console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0400
     * @tc.name      : testFontTextToGlyphsAbnormal0004
     * @tc.desc      : Test for testFontTextToGlyphsAbnormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontTextToGlyphsAbnormal0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontTextToGlyphsAbnormal0004';
      let font = new drawing.Font();

      try {
        let glyphs: number[] = font.textToGlyphs('奇8龍@Fly#龘2023!*你好', 15);
        console.info(msg + ' textToGlyphs succeeded');
      } catch (e) {
        console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let glyphs: number[] = font.textToGlyphs('奇8龍@Fly#龘2023!*你好', 20);
        console.info(msg + ' textToGlyphs succeeded');
      } catch (e) {
        console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let glyphs: number[] = font.textToGlyphs("", -1);
        console.info(msg + ' textToGlyphs succeeded');
      } catch (e) {
        console.info(msg + ` textToGlyphs errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0500
     * @tc.name      : testFontGetWidthsNormal0005
     * @tc.desc      : Test for testFontGetWidthsNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetWidthsNormal0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testFontGetWidthsNormal0005';
      let font = new drawing.Font();

      try {
        let widths: number[] = font.getWidths([0]);
        expect(widths.length == 1).assertTrue();
        console.info(msg + ' getWidths successed,widths:' + widths.length);
      } catch (e) {
        console.info(msg + ` getWidths errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let widths: number[] = font.getWidths([]);
        expect(widths == undefined).assertTrue();
        console.info(msg + ' getWidths successed,widths:' + widths);
      } catch (e) {
        console.info(msg + ` getWidths errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0600
     * @tc.name      : testFontGetWidthsNull0006
     * @tc.desc      : Test for testFontGetWidthsNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontGetWidthsNull0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontGetWidthsNull0006';
      let font = new drawing.Font();

      try {
        font.getWidths(null);
        console.info(msg + ' getWidths successed');
      } catch (e) {
        console.info(msg + ` getWidths errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.getWidths(undefined);
        console.info(msg + ' getWidths succeeded');
      } catch (e) {
        console.info(msg + ` getWidths errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0700
     * @tc.name      : testFontGetWidthsMultipleCalls0007
     * @tc.desc      : Test for testFontGetWidthsMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontGetWidthsMultipleCalls0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontGetWidthsMultipleCalls0007';
      let font = new drawing.Font();

      for (let i = 0; i < 20; i++) {
        try {
          font.getWidths([getRandomNumber(1, 100)]);
          console.info(msg + ' getWidths successed');
        } catch (e) {
          console.info(msg + ` getWidths errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0800
     * @tc.name      : testFontGetBoundsNormal0008
     * @tc.desc      : Test for testFontGetBoundsNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetBoundsNormal0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testFontGetWidthsNormal0008';
      let font = new drawing.Font();

      try {
        let bounds: common2D.Rect[] = font.getBounds([0]);
        expect(bounds.length == 1).assertTrue();
        console.info(msg + ' getBounds successed,bounds:' + bounds.length);
      } catch (e) {
        console.info(msg + ` getBounds errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let bounds: common2D.Rect[] = font.getBounds([Number.MAX_VALUE]);
        expect(bounds.length == 1).assertTrue();
        console.info(msg + ' getBounds successed,bounds:' + bounds.length);
      } catch (e) {
        console.info(msg + ` getBounds errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let bounds: common2D.Rect[] = font.getBounds([Number.MIN_VALUE]);
        expect(bounds.length == 1).assertTrue();
        console.info(msg + ' getBounds successed,bounds:' + bounds.length);
      } catch (e) {
        console.info(msg + ` getBounds errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      try {
        let bounds: common2D.Rect[] = font.getBounds([]);
      } catch (e) {
        console.info(msg + ` getBounds errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0900
     * @tc.name      : testFontGetBoundsNull0009
     * @tc.desc      : Test for testFontGetBoundsNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontGetBoundsNull0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontGetBoundsNull0009';
      let font = new drawing.Font();

      try {
        font.getBounds(null);
        console.info(msg + ' getBounds successed');
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` getBounds errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.getBounds(undefined);
        console.info(msg + ' getBounds succeeded');
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` getBounds errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1000
     * @tc.name      : testFontGetBoundsMultipleCalls0010
     * @tc.desc      : Test for testFontGetBoundsMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontGetBoundsMultipleCalls0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontGetBoundsMultipleCalls0010';
      let font = new drawing.Font();

      for (let i = 0; i < 20; i++) {
        try {
          let bounds: common2D.Rect[] = font.getBounds([getRandomNumber(1, 100)]);
          expect(bounds.length == 1).assertTrue();
          console.info(msg + ' getBounds successed');
        } catch (e) {
          console.info(msg + ` getBounds errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1100
     * @tc.name      : testFontSetAndIsThemeFontFollowedMultipleCalls0011
     * @tc.desc      : Test for testFontSetAndIsThemeFontFollowedMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsThemeFontFollowedNormal0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontSetAndIsThemeFontFollowedNormal0015';
      let font = new drawing.Font();
      let initialFollowed: boolean = font.isThemeFontFollowed()
      console.info(msg + "Initial value font is theme font followed: " + initialFollowed);
      expect(initialFollowed).assertEqual(false);
      font.setThemeFontFollowed(true);
      let followed: boolean = font.isThemeFontFollowed()
      console.info(msg + "followed is: " + followed);
      expect(followed).assertEqual(true);
      font.setThemeFontFollowed(false);
      let followed2: boolean = font.isThemeFontFollowed()
      console.info(msg + "followed2 is: " + followed2);
      expect(followed2).assertEqual(false);
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1200
     * @tc.name      : testFontCreatePathForGlyphNull0012
     * @tc.desc      : Test for testFontCreatePathForGlyphNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontCreatePathForGlyphNull0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontCreatePathForGlyphNull0012';
      let font = new drawing.Font();

      try {
        font.createPathForGlyph(null);
        console.info(msg + ' createPathForGlyph successed');
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` createPathForGlyph errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.createPathForGlyph(undefined);
        console.info(msg + ' createPathForGlyph succeeded');
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` createPathForGlyph errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1300
     * @tc.name      : testFontSetAndIsThemeFontFollowedNull0013
     * @tc.desc      : Test for testFontSetAndIsThemeFontFollowedNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsThemeFontFollowedNull0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testFontSetAndIsThemeFontFollowedNull0016';
      let font = new drawing.Font();
      try {
        font.setThemeFontFollowed(null);
        console.info(msg + 'setThemeFontFollowed successed');
        expect().assertFail();
      } catch (e) {
        console.info(msg + `setThemeFontFollowed null errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        font.setThemeFontFollowed(undefined);
        console.info(msg + 'setThemeFontFollowed successed');
        expect().assertFail();
      } catch (e) {
        console.info(msg + `setThemeFontFollowed undefined errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })
  })
}
