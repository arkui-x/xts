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
import {
  addTwoNum,
  calcSquare,
  checkExprNoHoist,
  factorialHoisted,
  getFixedNum,
  mulTwoNum,
  numFactorial,
  pushArrElem,
  strConcat,
  sumWithApply
} from './functionutils1';

interface GeneratedTypeLiteralInterface_8 {
  name: string;
  age: number;
}

export default function functionTest1() {
  describe('FunctionTest', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0100
     * @tc.desc   Function declaration - number square calculation (parameters passed by value)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const input: number = 6;
      const result: number = calcSquare(input);
      const isInputValid: boolean = typeof input === 'number' && Number.isFinite(input);
      expect(isInputValid).assertTrue();
      expect(result).assertEqual(36);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0200
     * @tc.desc   Anonymous function expression - addition of two numbers (explicit parameter types)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const a: number = 4, b: number = 7;
      const result: number = addTwoNum(a, b);
      const isParamsValid: boolean = typeof a === 'number' && typeof b === 'number';
      expect(isParamsValid).assertTrue();
      expect(result).assertEqual(11);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0300
     * @tc.desc   Named function expression - multiplication of two numbers (internal name not accessible externally)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const a: number = 5, b: number = 8;
      const result: number = mulTwoNum(a, b);
      const isOuterCallInvalid: boolean = (() => {
        try {
          globalThis.mul(2, 3);
          return false;
        } catch {
          return true;
        }
      })();

      expect(isOuterCallInvalid).assertTrue();
      expect(result).assertEqual(40);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0400
     * @tc.desc   Array parameter - adding elements (reference passing verification)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const inputArr: number[] = [1, 3, 5];
      const addVal: number = 7;
      const updatedArr: number[] = pushArrElem(inputArr, addVal);
      expect(Array.isArray(updatedArr)).assertTrue();
      expect(updatedArr).assertContain(7);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0500
     * @tc.desc   Function declaration - return fixed number without parameters (type verification)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const result: number = getFixedNum();
      const isResultValid: boolean = typeof result === 'number';
      expect(isResultValid).assertTrue();
      expect(result).assertEqual(99);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0600
     * @tc.desc   Anonymous function expression - string concatenation (result verification)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const str1: string = 'Hello', str2: string = 'ArkTS';
      const result: string = strConcat(str1, str2);
      expect(typeof result === 'string').assertTrue();
      expect(result).assertContain('HelloArkTS');
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0700
     * @tc.desc   Named function expression - factorial calculation (non-negative parameter verification)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const input: number = 5;
      const result: number = numFactorial(input);
      const isInputValid: boolean = typeof input === 'number' && input >= 0;
      expect(isInputValid).assertTrue();
      expect(result).assertEqual(120);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0800
     * @tc.desc   Function declaration hoisting - call before declaration (factorial result)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const input: number = 6;
      const result: number = factorialHoisted(input);
      expect(typeof result === 'number').assertTrue();
      expect(result).assertEqual(720);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0900
     * @tc.desc   Function expression - no hoisting feature (error when called first)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const isCallFailed: boolean = checkExprNoHoist();
      expect(isCallFailed).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_1000
     * @tc.desc   apply method - sum with array parameters (result verification)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_FUNCTION_FUNCTIONTEST1_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const inputArr: number[] = [10, 20, 30];
      const result: number = sumWithApply(inputArr);
      expect(Array.isArray(inputArr)).assertTrue();
      expect(result).assertEqual(60);
    });
  })
}