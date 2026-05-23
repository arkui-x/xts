/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { util, xml } from '@kit.ArkTS';

export default function specialchartest() {
  describe('specialchartest', () => {
    beforeAll(() => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0100
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0100
     * @tc.desc   Test the function of the Interface escape \t
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0100";
        try {
          const escape = encodeURI('\t');
          const re = new RegExp(escape, 'u');
          console.log(`${TAG} success: ${re}`);
          let result = re.unicode
          expect(result).assertTrue();
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0200
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0200
     * @tc.desc   Test the function of the Interface escape \v
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0200";
        try {
          const escape = encodeURI('\v');
          const re = new RegExp(escape, 'u');
          console.log(`${TAG} success: ${re}`);
          let result = re.unicode
          expect(result).assertTrue();
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0300
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0300
     * @tc.desc   Test the function of the Interface escape \x24
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0300";
        try {
          const escape = encodeURI('\x24');
          const re = new RegExp(escape, 'u');
          console.log(`${TAG} success: ${re}`);
          let result = re.unicode
          expect(result).assertTrue();
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0400
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0400
     * @tc.desc   Test the function of the Interface escape \开
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0400";
        try {
          const escape = encodeURI('\开');
          const re = new RegExp(escape, 'u');
          console.log(`${TAG} success: ${re}`);
          let result = re.unicode
          expect(result).assertTrue();
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0500
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0500
     * @tc.desc   Test the function of the Interface escape \😊
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0500";
        try {
          const escape = encodeURI('\😊');
          const re = new RegExp(escape, 'u');
          console.log(`${TAG} success: ${re}`);
          let result = re.unicode
          expect(result).assertTrue();
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0600
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0600
     * @tc.desc   Test the function of the Interface escape \0
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0600";
        try {
          const escape = encodeURI('\0');
          const re = new RegExp(escape, 'u');
          console.log(`${TAG} success: ${re}`);
          let result = re.unicode
          expect(result).assertTrue();
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0700
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0700
     * @tc.desc   Test the function of the Interface escape \\b
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0700";
        try {
          const escape = encodeURI('\\b');
          const re = new RegExp(escape, 'u');
          console.log(`${TAG} success: ${re}`);
          let result = re.unicode
          expect(result).assertTrue();
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0800
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0800
     * @tc.desc   Test the function of the Interface escape \x24
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0800";
        try {
          const escape = '\x24';
          console.log(`${TAG} success: ${escape}`);
          let result = escape.lastIndexOf('\x24')
          expect(result).assertEqual(0);
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0900
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0900
     * @tc.desc   Test the function of the Interface escape \开
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_0900";
        try {
          const escape = '\开';
          console.log(`${TAG} success: ${escape}`);
          let result = escape.lastIndexOf('\开')
          expect(result).assertEqual(0);
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_1000
     * @tc.name   ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_1000
     * @tc.desc   Test the function of the Interface escape \😊
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it("ArkUIX_SUB_SPECIALCHARTEST_SPECIALCHARTEST_1000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      () => {
        const TAG = "ArkUIX_SUB_COMMONLIBRARY_REGEXP_BASE_UNICODE_Escape_1000";
        try {
          const escape = '\😊';
          console.log(`${TAG} success: ${escape}`);
          let result = escape.lastIndexOf('\😊')
          expect(result).assertEqual(0);
        } catch (error) {
          console.error(`${TAG} failed,error: ${error.message}`);
          expect().assertFail();
        }
      });
  })
}
