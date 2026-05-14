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
import { testRegCtrJs0006, testRegCtrJs0007 } from './RegExp.test';

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function RegExpTest001() {
  describe('RegExpTest001', () => {
    beforeAll(async () => {
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_300)
    })

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0100
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0100
     * @tc.desc   Verify RegExp can be created from a string pattern with flags
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const re: RegExp = new RegExp('abc', 'i');
      const result: boolean = re.test('ABC');
      expect(result).assertTrue();
      expect(re.source).assertEqual('abc');
      expect(re.flags).assertEqual('i');
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0200
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0200
     * @tc.desc   Verify RegExp constructed from another RegExp copies source and flags
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const re1: RegExp = /foo/gi;
      const re2: RegExp = new RegExp(re1);
      expect(re2.source).assertEqual('foo');
      expect(re2.flags).assertEqual('gi');
      expect(re2.test('FOO')).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0300
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0300
     * @tc.desc   Verify new flags override the original flags when reusing RegExp
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const re1: RegExp = /bar/i;
      const re2: RegExp = new RegExp(re1, 'g');
      expect(re2.flags).assertEqual('g');
      expect(re2.ignoreCase).assertFalse();
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0400
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0400
     * @tc.desc   Verify SyntaxError is thrown when invalid flag is provided
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let errorCaught: boolean = false;
      try {
        new RegExp('a', 'z');
      } catch (e) {
        errorCaught = e instanceof SyntaxError;
      }
      expect(errorCaught).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0500
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0500
     * @tc.desc   Verify escape characters in string pattern are correctly interpreted
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const re: RegExp = new RegExp('\\d+');
      expect(re.test('123')).assertTrue();
      expect(re.test('abc')).assertFalse();
      expect(re.source).assertEqual('\\d+');
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0600
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0600
     * @tc.desc   Verify default constructor behavior when called without arguments
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      expect(testRegCtrJs0006()).assertDeepEquals([true, true, true]);
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0700
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0700
     * @tc.desc   Verify RegExp constructed with undefined or null as pattern produces empty pattern
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      expect(testRegCtrJs0007()).assertDeepEquals([true, true]);
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0800
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0800
     * @tc.desc   Verify RegExp constructed from existing RegExp with undefined flag keeps original flags
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const re1: RegExp = /test/gi;
      const re2: RegExp = new RegExp(re1, undefined);
      expect(re2.flags).assertEqual('gi');
      expect(re2.source).assertEqual('test');
      expect(re2.test('TEST')).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_0900
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_0900
     * @tc.desc   Verify flags with different order (e.g. 'gi' and 'ig') are treated equivalently
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const re1: RegExp = new RegExp('abc', 'gi');
      const re2: RegExp = new RegExp('abc', 'ig');
      expect(re1.flags).assertEqual('gi');
      expect(re2.flags).assertEqual('gi'); // ECMAScript normalizes flag order
      expect(re1.test('ABC')).assertTrue();
      expect(re2.test('ABC')).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_REGEXPTEST_REGEXP001_1000
     * @tc.number ArkUIX_SUB_REGEXPTEST_REGEXP001_1000
     * @tc.desc   Verify Unicode flag 'u' enables proper emoji matching
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_REGEXPTEST_REGEXP001_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const re1: RegExp = new RegExp('.', 'u');
      const emoji: string = '😊';
      expect(re1.test(emoji)).assertTrue();
      const re2: RegExp = new RegExp('.', '');
      expect(re2.test(emoji)).assertTrue();
    });
  })
}
