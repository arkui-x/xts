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
import { sleep } from '../../../testability/pages/Utils';

export default function expressionTest1() {
  describe('ExpressionTest1', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0100
     * @tc.desc   Test addition operator with numbers
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let a: number = 5;
      let b: number = 3;
      let result: number = a + b;
      let expected: number = 8;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0200
     * @tc.desc   Test subtraction operator with numbers
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let a: number = 10;
      let b: number = 4;
      let result: number = a - b;
      let expected: number = 6;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0300
     * @tc.desc   Test multiplication operator with numbers
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let a: number = 7;
      let b: number = 6;
      let result: number = a * b;
      let expected: number = 42;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0400
     * @tc.desc   Test division operator with numbers
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let a: number = 24;
      let b: number = 4;
      let result: number = a / b;
      let expected: number = 6;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0500
     * @tc.desc   Test modulus operator with positive numbers
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let a: number = 17;
      let b: number = 5;
      let result: number = a % b;
      let expected: number = 2;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0600
     * @tc.desc   Test exponentiation operator
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let a: number = 2;
      let b: number = 5;
      let result: number = a**b;
      let expected: number = 32;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0700
     * @tc.desc   Test prefix increment operator
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let num: number = 5;
      let result: number = ++num;
      let expected: number = 6;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0800
     * @tc.desc   Test postfix increment operator
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let num: number = 5;
      let result: number = num++;
      let expected: number = 5;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0900
     * @tc.desc   Test prefix decrement operator
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let num: number = 5;
      let result: number = --num;
      let expected: number = 4;
      expect(result).assertEqual(expected);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_1000
     * @tc.desc   Test postfix decrement operator
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_EXPRESSION_EXPRESSIONTEST1_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let num: number = 5;
      let result: number = num--;
      let expected: number = 5;
      expect(result).assertEqual(expected);
    });
  })
}