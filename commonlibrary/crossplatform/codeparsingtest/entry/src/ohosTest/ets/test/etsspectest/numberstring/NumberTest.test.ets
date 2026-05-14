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

export default function numberTest() {
  describe('NumberTest', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0100
     * @tc.desc   Verify that the default type of numbers is double-precision floating-point
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const verifyNumberType = (num: number): string => typeof num;
      const result = verifyNumberType(123);
      expect('number').assertEqual(result);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0200
     * @tc.desc   Verify the maximum representable value range
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const getMaxValue = (): number => Number.MAX_VALUE;
      const maxValid = getMaxValue();
      const overMax = maxValid * 2;
      expect(true).assertEqual(!isNaN(maxValid));
      expect(Infinity).assertEqual(overMax);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0300
     * @tc.desc   Verify the minimum representable value range
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const getMinValue = (): number => Number.MIN_VALUE;
      const minValid = getMinValue();
      const underMin = minValid / 2;
      expect(true).assertEqual(!isNaN(minValid));
      expect(0).assertEqual(underMin);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0400
     * @tc.desc   Verify integer precise representation range
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0400', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const getMaxSafeInteger = (): number => 2**53 - 1;
      const preciseInt = getMaxSafeInteger();
      expect(9007199254740991).assertEqual(preciseInt);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0500
     * @tc.desc   Verify decimal precision issues
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const addDecimals = (): number => 0.1 + 0.2;
      const result = addDecimals();
      expect(false).assertEqual(result === 0.3);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0600
     * @tc.desc   Verify negative number representation
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0600', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const checkNegative = (): [number, string] => {
        const num = -123;
        return [num, typeof num];
      };
      const arr = checkNegative();
      expect(-123).assertEqual(arr[0]);
      expect('number').assertEqual(arr[1]);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0700
     * @tc.desc   Verify zero representation comparison
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const compareZeros = (): [boolean, boolean] => [0 === -0, 0 === +0];
      const arr = compareZeros();
      expect(true).assertEqual(arr[0]);
      expect(true).assertEqual(arr[1]);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0800
     * @tc.desc   Verify empty string conversion to number
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0800', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const convertEmptyString = (): number => Number('');
      expect(0).assertEqual(convertEmptyString());
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0900
     * @tc.desc   Verify boolean conversion to number
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_0900', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const convertBooleans = (): [number, number] => [Number(true), Number(false)];
      const arr = convertBooleans();
      expect(1).assertEqual(arr[0]);
      expect(0).assertEqual(arr[1]);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_1000
     * @tc.desc   Verify null conversion to number
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_NUMBERSTRING_NUMBERTEST_1000', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const convertNull = (): number => Number(null);
      expect(0).assertEqual(convertNull());
    });
  })
}