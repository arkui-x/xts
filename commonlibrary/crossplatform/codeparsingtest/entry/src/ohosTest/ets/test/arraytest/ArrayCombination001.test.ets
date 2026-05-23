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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size} from '@ohos/hypium';

function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}

export default function ArrayCombinationTest1() {
  describe('ArrayCombinationTest1', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(async () => {
      await sleep(20);
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
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0100
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0100
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0001';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const mapped = arr.map(x => x * 2);
      let sum = 0;
      mapped.forEach(x => sum += x);
      expect(sum).assertEqual(12);

      const ta = new Int8Array([1, 2, 3]);
      const taMapped = Array.from(ta).map(x => x * 2);
      let taSum = 0;
      taMapped.forEach(x => taSum += x);
      expect(taSum).assertEqual(12);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0200
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0200
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0002';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const res = arr.map(x => x + 1).map(x => x * 2);
      expect(res).assertDeepEquals([4, 6, 8]);

      const ta = new Int8Array([1, 2, 3]);
      const taRes = Array.from(ta).map(x => x + 1).map(x => x * 2);
      expect(taRes).assertDeepEquals([4, 6, 8]);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0300
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0300
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0003';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3, 4];
      const res = arr.map(x => x * 3).filter(x => x > 6);
      expect(res).assertDeepEquals([9, 12]);

      const ta = new Int8Array([1, 2, 3, 4]);
      const taRes = Array.from(ta).map(x => x * 3).filter(x => x > 6);
      expect(taRes).assertDeepEquals([9, 12]);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0400
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0400
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0004';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const res = arr.map(x => x + 1).reduce((a, b) => a + b, 0);
      expect(res).assertEqual(9);

      const ta = new Int8Array([1, 2, 3]);
      const taRes = Array.from(ta).map(x => x + 1).reduce((a, b) => a + b, 0);
      expect(taRes).assertEqual(9);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0500
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0500
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0005';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const res = arr.map(x => x * 2).reduceRight((a, b) => a - b);
      expect(res).assertEqual(0);

      const ta = new Int8Array([1, 2, 3]);
      const taRes = Array.from(ta).map(x => x * 2).reduceRight((a, b) => a - b);
      expect(taRes).assertEqual(0);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0600
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0600
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0006';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const res = arr.map(x => x * 3).some(x => x > 8);
      expect(res).assertEqual(true);

      const ta = new Int8Array([1, 2, 3]);
      const taRes = Array.from(ta).map(x => x * 3).some(x => x > 8);
      expect(taRes).assertEqual(true);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0700
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0700
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0007';
      console.info(`${caseName}, test start`);
      const arr = [2, 4, 6];
      const res = arr.map(x => x / 2).every(x => x >= 1);
      expect(res).assertEqual(true);

      const ta = new Int8Array([2, 4, 6]);
      const taRes = Array.from(ta).map(x => x / 2).every(x => x >= 1);
      expect(taRes).assertEqual(true);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0800
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0800
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0008';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const res = arr.map(x => x + 5).find(x => x === 7);
      expect(res).assertEqual(7);

      const ta = new Int8Array([1, 2, 3]);
      const taRes = Array.from(ta).map(x => x + 5).find(x => x === 7);
      expect(taRes).assertEqual(7);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0900
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0900
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0009';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const res = arr.map(x => x * 2).findIndex(x => x === 4);
      expect(res).assertEqual(1);

      const ta = new Int8Array([1, 2, 3]);
      const taRes = Array.from(ta).map(x => x * 2).findIndex(x => x === 4);
      expect(taRes).assertEqual(1);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1000
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1000
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0012';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3];
      const res = arr.map(x => [x, x + 1]).flatMap(x => x);
      expect(res).assertDeepEquals([1, 2, 2, 3, 3, 4]);

      const ta = new Int8Array([1, 2, 3]);
      const taRes = Array.from(ta).map(x => [x, x + 1]).flatMap(x => x);
      expect(taRes).assertDeepEquals([1, 2, 2, 3, 3, 4]);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1100
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1100
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0013';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3, 4];
      const filtered = arr.filter(x => x % 2 === 0);
      let sum = 0;
      filtered.forEach(x => sum += x);
      expect(sum).assertEqual(6);

      const ta = new Int8Array([1, 2, 3, 4]);
      const taFiltered = Array.from(ta).filter(x => x % 2 === 0);
      let taSum = 0;
      taFiltered.forEach(x => taSum += x);
      expect(taSum).assertEqual(6);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1200
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1200
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0014';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3, 4];
      const res = arr.filter(x => x > 2).map(x => x * 2);
      expect(res).assertDeepEquals([6, 8]);

      const ta = new Int8Array([1, 2, 3, 4]);
      const taRes = Array.from(ta).filter(x => x > 2).map(x => x * 2);
      expect(taRes).assertDeepEquals([6, 8]);
      console.info(`${caseName}, test end`);
    });
    /**
     * @tc.name   ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1300
     * @tc.number ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1300
     * @tc.desc   Test Method Combination in Array/TypedArray
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ARRAYTEST_ARRAYCOMBINATION001_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const caseName = 'ArrayCombinationTest0015';
      console.info(`${caseName}, test start`);
      const arr = [1, 2, 3, 4];
      const res = arr.filter(x => x > 1).filter(x => x < 4);
      expect(res).assertDeepEquals([2, 3]);

      const ta = new Int8Array([1, 2, 3, 4]);
      const taRes = Array.from(ta).filter(x => x > 1).filter(x => x < 4);
      expect(taRes).assertDeepEquals([2, 3]);
      console.info(`${caseName}, test end`);
    });
  });
}