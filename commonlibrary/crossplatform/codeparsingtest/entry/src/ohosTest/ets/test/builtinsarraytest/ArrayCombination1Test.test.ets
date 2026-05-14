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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';
import { hilog } from '@kit.PerformanceAnalysisKit';
import * as Array1 from './ArrayCombination1';

function sleep(time: number): Promise<void> {
  return new Promise((re, je) => {
    setTimeout(() => {
      re();
    }, time);
  });
}

export default function ArrayConstructor1Test() {
  describe('ArrayConstructor1Test', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(async () => {
       await sleep(30);
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
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0100
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0100
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [];
      const typedArr = new Int32Array([]);
      expect(arr.map(x => x).sort()).assertDeepEquals([]);
      expect(Array.from(typedArr.map(x => x)).sort()).assertDeepEquals([]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0200
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0200
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3];
      const typedArr = new Int32Array([1, 2, 3]);
      expect(arr.filter(x => x > 10).reverse()).assertDeepEquals([]);
      expect(Array.from(typedArr.filter(x => x > 10)).reverse()).assertDeepEquals([]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0300
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0300
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [[1]];
      const typedArr = [new Float64Array([5])];
      const r1 = arr.flatMap(x => x).fill(99);
      const r2 = Array.from(typedArr.flatMap(x => Array.from(x))).fill(99);
      expect(r1).assertDeepEquals([99]);
      expect(r2).assertDeepEquals([99]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0400
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0400
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2];
      const typedArr = new Int32Array([1, 2]);
      const r1 = arr.map(x => x).copyWithin(10, 0);
      const r2 = Array.from(typedArr.map(x => x)).copyWithin(10, 0);
      expect(r1).assertDeepEquals([1, 2]);
      expect(r2).assertDeepEquals([1, 2]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0500
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0500
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [NaN, 2, 1];
      const typedArr = new Float64Array([NaN, 2, 1]);
      const r1 = arr.filter(x => true).sort();
      const r2 = Array.from(typedArr.filter(x => true)).sort((a, b) => {
        if (Number.isNaN(a) && Number.isNaN(b)) return 0;
        if (Number.isNaN(a)) return 1;
        if (Number.isNaN(b)) return -1;
        return a - b;
      });
      expect(r1[0]).assertEqual(1);
      expect(r1[1]).assertEqual(2);
      expect(Number.isNaN(r1[2])).assertTrue();
      expect(JSON.stringify(r2)).assertDeepEquals(JSON.stringify([1, 2, NaN]));
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0600
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0600
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [[], [1], []];
      const typedArr = [new Int32Array([]), new Int32Array([1]), new Int32Array([])];
      const r1 = arr.flatMap(x => x).reverse();
      const r2 = Array.from(typedArr.flatMap(x => Array.from(x))).reverse();
      expect(r1).assertDeepEquals([1]);
      expect(r2).assertDeepEquals([1]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0700
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0700
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(Array1.ArrayConstructor1Test007()).assertDeepEquals([true, true]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0800
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0800
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [10, 20, 30, 40];
      const typedArr = new Int32Array([10, 20, 30, 40]);
      const r1 = arr.filter(x => x >= 20).copyWithin(-1, 0, 1);
      const r2 = Array.from(typedArr.filter(x => x >= 20)).copyWithin(-1, 0, 1);
      expect(r1).assertDeepEquals([20, 30, 20]);
      expect(r2).assertDeepEquals([20, 30, 20]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0900
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0900
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [42];
      const typedArr = new Int32Array([42]);
      expect(arr.map(x => x).reverse()).assertDeepEquals([42]);
      expect(Array.from(typedArr.map(x => x)).reverse()).assertDeepEquals([42]);

    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1000
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1000
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [[Infinity], [-Infinity], [0]];
      const typedArr = [new Float64Array([Infinity]), new Float64Array([-Infinity]), new Float64Array([0])];
      const r1 = arr.flatMap(x => x).sort((a, b) => a - b);
      const r2 = Array.from(typedArr.flatMap(x => Array.from(x))).sort((a, b) => a - b);
      expect(r1).assertDeepEquals([-Infinity, 0, Infinity]);
      expect(r2).assertDeepEquals([-Infinity, 0, Infinity]);

    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1100
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1100
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3];
      const typedArr = new Int32Array([1, 2, 3]);
      const r1 = arr.filter(x => true).fill(999, 2, 2);
      const r2 = Array.from(typedArr.filter(x => true)).fill(999, 2, 2);
      expect(r1).assertDeepEquals([1, 2, 3]);
      expect(r2).assertDeepEquals([1, 2, 3]);

    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1200
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1200
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1, 2, 3];
      const typedArr = new Int32Array([1, 2, 3]);
      const r1 = arr.map(x => x).copyWithin(0, 2, 1);
      const r2 = Array.from(typedArr.map(x => x)).copyWithin(0, 2, 1);
      expect(r1).assertDeepEquals([1, 2, 3]);
      expect(r2).assertDeepEquals([1, 2, 3]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1300
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1300
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [[[1]], [[2]]];
      const r1 = arr.flatMap(x => x).reverse();
      expect(r1).assertDeepEquals([[2], [1]]);
      const typedSim = [new Int32Array([1]), new Int32Array([2])];
      const r2 = Array.from(typedSim.flatMap(x => [Array.from(x)])).reverse();
      expect(r2).assertDeepEquals([[2], [1]]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1400
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1400
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [5, 5, 5];
      const typedArr = new Int32Array([5, 5, 5]);
      const r1 = arr.filter(x => true).sort();
      const r2 = Array.from(typedArr.filter(x => true)).sort();
      expect(r1).assertDeepEquals([5, 5, 5]);
      expect(r2).assertDeepEquals([5, 5, 5]);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1500
     * @tc.number ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1500
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAYTEST_ARRAYCOMBINATION1TEST_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const arr = [1];
      const typedArr = new Int32Array([1]);
      const r1 = arr.map(x => x).fill(88, 0, 10);
      const r2 = Array.from(typedArr.map(x => x)).fill(88, 0, 10);
      expect(r1).assertDeepEquals([88]);
      expect(r2).assertDeepEquals([88]);
    });
  })
}