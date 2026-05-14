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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from '@ohos/hypium';

function sleep(time: number): Promise<void> {
  return new Promise((re) => {
    setTimeout(() => {
      re();
    }, time);
  });
}

export default function StringBasicTest() {
  describe('StringBasicTest', () => {
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
    })

    beforeEach(async () => {
      await sleep(50);
      // Presets an action, which is performed before each unit test case starts.
    })

    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
    })

    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
    })

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0100
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0100
     * @tc.desc   String equality with === operator
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let str1: string = 'hello';
      let str2: string = 'hello';
      let result: boolean = str1 === str2;
      expect(result).assertEqual(true);
    });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0200
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0200
     * @tc.desc   String inequality with === operator
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let str1: string = 'hello';
      let str2: string = 'world';
      let result: boolean = str1 === str2;
      expect(result).assertEqual(false);
    });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0300
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0300
     * @tc.desc   Case-sensitive string comparison
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let str1: string = 'Hello';
      let str2: string = 'hello';
      let result: boolean = str1 === str2;
      expect(result).assertEqual(false);
    });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0400
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0400
     * @tc.desc   String less than comparison
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0400', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let str1: string = 'apple';
      let str2: string = 'banana';
      let result: boolean = str1 < str2;
      expect(result).assertEqual(true);
    });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0500
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0500
     * @tc.desc   String greater than comparison
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0,
      async () => {
        let str1: string = 'banana';
        let str2: string = 'apple';
        let result: boolean = str1 > str2;
        expect(result).assertEqual(true);
      });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0600
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0600
     * @tc.desc   Unicode code point comparison
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0600', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2,
      async () => {
        let str1: string = 'A';
        let str2: string = 'a';
        expect(str1 < str2).assertEqual(true); // 'A' (65) < 'a' (97)
      });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0700
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0700
     * @tc.desc   Chinese character comparison by code point
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2,
      async () => {
        let str1: string = '一';
        let str2: string = '二';
        expect(str1 < str2).assertEqual(true);
      });


    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0800
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0800
     * @tc.desc   NFKD normalization form
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0800', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, async () => {
      let str: string = 'café';
      let normalized: string = str.normalize('NFKD');
      expect(normalized.length).assertLarger(0);
    });


    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0900
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0900
     * @tc.desc   NFC normalization form
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_0900', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, async () => {
      let str: string = 'café';
      let normalized: string = str.normalize('NFC');
      expect(normalized.length).assertLarger(0);
    });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_1000
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_1000
     * @tc.desc   NFD normalization form
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_1000', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, async () => {
      let str: string = 'café';
      let normalized: string = str.normalize('NFD');
      expect(normalized.length).assertLarger(0);
    });

    /**
     * @tc.number ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_1100
     * @tc.name   ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_1100
     * @tc.desc   NFKC normalization form
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_STRINGTEST_STRINGBASICTEST_1100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, async () => {
      let str: string = 'café';
      let normalized: string = str.normalize('NFKC');
      expect(normalized.length).assertLarger(0);
    });
  });
}
