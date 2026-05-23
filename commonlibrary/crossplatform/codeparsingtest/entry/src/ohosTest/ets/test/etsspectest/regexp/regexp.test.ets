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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, TestType, Size } from '@ohos/hypium'
import { sleep } from '../../../testability/pages/Utils'

export default function RegExpTest() {
  describe('RegExpTest', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0100
     * @tc.desc   The regular equivalence between literals and constructors
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const literalReg = /ab+c/;
      const constructorReg = new RegExp("ab+c");
      expect(literalReg.test("abbc")).assertEqual(constructorReg.test("abbc"));
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0200
     * @tc.desc   The constructor dynamically generates regular expressions
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const simpleReg = /abc/;
      expect(simpleReg.test("abc")).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0300
     * @tc.desc   Simple pattern matches the exact characters that exist
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const simpleReg = /abc/;
      expect(simpleReg.test("abc")).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0400
     * @tc.desc   The simple mode does not match characters containing Spaces
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const simpleReg = /abc/;
      expect(simpleReg.test("ab c")).assertEqual(false);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0500
     * @tc.desc   After escaping *, match a*b
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const escapeReg = /a\*b/;
      expect(escapeReg.test("a*b")).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0600
     * @tc.desc   After escaping *, it does not match ab
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const escapeReg = /a\*b/;
      expect(escapeReg.test("ab")).assertEqual(false);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0700
     * @tc.desc   After escaping the backslash, match C:\
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const escapeReg = /C:\\/;
      expect(escapeReg.test("C:\\")).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0800
     * @tc.desc   Escaping the backslash does not match C:/
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const escapeReg = /C:\\/;
      expect(escapeReg.test("C:/")).assertEqual(false);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0900
     * @tc.desc   The previous element is allowed to appear 0 times
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const starReg = /ab*c/;
      expect(starReg.test("ac")).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_1000
     * @tc.desc   *The previous element is allowed to appear once
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_REGEXP_REGEXP_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const starReg = /ab*c/;
      expect(starReg.test("abc")).assertEqual(true);
    })
  })
}
