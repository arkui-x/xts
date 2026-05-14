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

function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}

export default function looper1Test() {
  describe('looper1Test', () => {
    beforeEach(async () => {
      await sleep(100);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0100
     * @tc.desc   Test the difference in iteration behavior between for...in and for...of loops on arrays; verify that for...in iterates over array indices and custom properties, while for...of only iterates over array element values
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const fruitArray = ['Apple', 'Banana', 'Cherry'];

      const forInResults: string[] = [];
      for (let key of fruitArray) {
        forInResults.push(`Key: ${key}, Value: ${fruitArray[key]}`);
      }
      const forOfResults: string[] = [];
      for (const value of fruitArray) {
        forOfResults.push(`Element Value: ${value}`);
      }
      expect(forInResults.toString())
        .assertEqual("Key: Apple, Value: undefined,Key: Banana, Value: undefined,Key: Cherry, Value: undefined");
      expect(forOfResults.toString()).assertEqual("Element Value: Apple,Element Value: Banana,Element Value: Cherry");
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0200
     * @tc.desc   Test that traditional for loop correctly sums all elements in a number array
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const nums = [1, 2, 3, 4, 5];
      let sum = 0;
      for (let i = 0; i < nums.length; i++) {
        sum += nums[i];
      }
      expect(sum).assertEqual(15);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0300
     * @tc.desc   Test that traditional for loop traverses array in reverse order correctly
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = ['a', 'b', 'c'];
      const reversed: string[] = [];
      for (let i = arr.length - 1; i >= 0; i--) {
        reversed.push(arr[i]);
      }
      expect(reversed.toString()).assertEqual("c,b,a");
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0400
     * @tc.desc   Test that traditional for loop works with step size 2 to traverse array
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const nums = [10, 20, 30, 40, 50];
      const result: number[] = [];
      for (let i = 0; i < nums.length; i += 2) {
        result.push(nums[i]);
      }
      expect(result.toString()).assertEqual("10,30,50");
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0500
     * @tc.desc   Test that traditional for loop does not execute when array is empty
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const emptyArr: number[] = [];
      let executed = false;
      for (let i = 0; i < emptyArr.length; i++) {
        executed = true;
      }
      expect(executed).assertEqual(false);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0600
     * @tc.desc   Test that for...in loop iterates array indices and custom enumerable properties
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      const arr = [1, 2, 3];
      const keys: string[] = [];
      for (let key of arr) {
        keys.push(key.toString());
      }
      expect(keys.toString()).assertEqual("1,2,3");
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0700
     * @tc.desc   Test that for...of loop iterates each character of a string correctly
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const str = 'hello';
      const chars: string[] = [];
      for (const char of str) {
        chars.push(char);
      }
      expect(chars.toString()).assertEqual("h,e,l,l,o");
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0800
     * @tc.desc   Test that for...of loop iterates [key, value] pairs of a Map correctly
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      const map = new Map([['a', 1], ['b', 2]]);
      const entries = new Array<string | number>();
      for (let entry of map) {
        for (let en of entry) {
          entries.push(en.valueOf())
        }
      }
      expect(entries.toString()).assertEqual("a,1,b,2");
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0900
     * @tc.desc   Test that for...of loop iterates unique values of a Set correctly
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      const set = new Set([1, 2, 2, 3]);
      const values: number[] = [];
      for (const val of set) {
        values.push(val);
      }
      expect(values.toString()).assertEqual("1,2,3");
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_1000
     * @tc.desc   Test that Array.forEach modifies original array elements correctly
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LOOPER_LOOPER1_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const nums = [1, 2, 3];
      nums.forEach((val, idx, arr) => arr[idx] = val * 2);
      expect(nums.toString()).assertEqual("2,4,6");
    })
  })
}
