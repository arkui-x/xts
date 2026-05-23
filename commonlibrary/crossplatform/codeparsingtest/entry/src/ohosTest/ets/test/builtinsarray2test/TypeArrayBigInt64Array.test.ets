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
import { sleep } from '../..//testability/pages/Utils'

export default function typeArrayBigInt64ArrayTest() {
  describe('TypeArrayBigInt64ArrayTest', () => {
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
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0100
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0100
     * @tc.desc   Verify BigInt64Array and DataView share ArrayBuffer (bidirectional sync)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(8);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf);
      const dv: DataView = new DataView(buf);
      const testVal: bigint = 9223372036854775807n;
      bigInt64Arr[0] = testVal;
      expect(dv.getBigInt64(0, true)).assertEqual(testVal);
      const newVal: bigint = -9223372036854775808n;
      dv.setBigInt64(0, newVal, true);
      expect(bigInt64Arr[0]).assertEqual(newVal);
      expect(bigInt64Arr.length).assertEqual(1);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0200
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0200
     * @tc.desc   Verify BigInt64Array (non-zero offset) and DataView share ArrayBuffer
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(24);
      const offset: number = 8;
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf, offset, 2);
      const dv: DataView = new DataView(buf);
      const val1: bigint = 1234567890123456789n;
      const val2: bigint = -8570200862721897295n;
      bigInt64Arr[0] = val1;
      bigInt64Arr[1] = val2;
      expect(dv.getBigInt64(offset, true)).assertEqual(val1);
      expect(dv.getBigInt64(offset + 8, true)).assertEqual(val2);
      const newVal: bigint = 4567890123456789012n;
      dv.setBigInt64(offset + 4, newVal, true);
      expect(bigInt64Arr[0].toString()).assertEqual('-7662810906284687083');
      expect(bigInt64Arr[1].toString()).assertEqual('-8570200865478776867');
      expect(bigInt64Arr.length).assertEqual(2);
  })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0300
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0300
     * @tc.desc   Verify SharedArrayBuffer sync between BigInt64Array and DataView (single thread)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const sab: SharedArrayBuffer = new SharedArrayBuffer(16);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(sab);
      const dv: DataView = new DataView(sab);
      const val1: bigint = 1n;
      const val2: bigint = -1n;
      bigInt64Arr[0] = val1;
      bigInt64Arr[1] = val2;
      expect(dv.getBigInt64(0, true)).assertEqual(val1);
      expect(dv.getBigInt64(8, true)).assertEqual(val2);
      const newVal1: bigint = 100n;
      const newVal2: bigint = -200n;
      dv.setBigInt64(0, newVal1, true);
      dv.setBigInt64(8, newVal2, true);
      expect(bigInt64Arr[0]).assertEqual(newVal1);
      expect(bigInt64Arr[1]).assertEqual(newVal2);
      expect(bigInt64Arr.length).assertEqual(2);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0400
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0400
     * @tc.desc   Verify BigInt64Array handles value overflow (clamped to min/max)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0400', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(8);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf);
      const dv: DataView = new DataView(buf);
      const overflowVal: bigint = 9223372036854775808n;
      const underflowVal: bigint = -9223372036854775809n;
      const expectedOverflow: bigint = -9223372036854775808n;
      const expectedUnderflow: bigint = 9223372036854775807n;
      bigInt64Arr[0] = overflowVal;
      expect(bigInt64Arr[0]).assertEqual(expectedOverflow);
      expect(dv.getBigInt64(0, true)).assertEqual(expectedOverflow);
      bigInt64Arr[0] = underflowVal
      expect(bigInt64Arr.length).assertEqual(1);
      expect(bigInt64Arr[0]).assertEqual(expectedUnderflow);
      expect(dv.getBigInt64(0, true)).assertEqual(expectedUnderflow);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0500
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0500
     * @tc.desc   Verify BigInt64Array constructor with plain BigInt array
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const source: bigint[] = [10n, 20n, 30n];
      const bigInt64Arr: BigInt64Array = new BigInt64Array(source);
      const dv: DataView = new DataView(bigInt64Arr.buffer);
      expect(bigInt64Arr.length).assertEqual(source.length);
      expect(bigInt64Arr[0]).assertEqual(10n);
      expect(bigInt64Arr[1]).assertEqual(20n);
      expect(bigInt64Arr[2]).assertEqual(30n);
      expect(bigInt64Arr.byteLength).assertEqual(source.length * 8);
      for (let i = 0; i < source.length; i++) {
        expect(dv.getBigInt64(i * 8, true)).assertEqual(source[i]);
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0600
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0600
     * @tc.desc   Verify BigInt64Array constructor with ArrayBuffer (offset=0, length=0)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0600', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const buf: ArrayBuffer = new ArrayBuffer(16);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf, 0, 0);
      const dv: DataView = new DataView(buf);
      expect(bigInt64Arr.length).assertEqual(0);
      expect(bigInt64Arr.byteLength).assertEqual(0);
      expect(bigInt64Arr.buffer).assertEqual(buf);
      dv.setBigInt64(0, 100n, true);
      expect(dv.getBigInt64(0, true)).assertEqual(100n);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0700
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0700
     * @tc.desc   Verify BigInt64Array subarray and DataView share parent ArrayBuffer
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(24);
      const parentArr: BigInt64Array = new BigInt64Array(buf);
      parentArr.set([1n, 2n, 3n]);
      const subArr: BigInt64Array = parentArr.subarray(1, 3);
      const dv: DataView = new DataView(buf);
      subArr[0] = 20n;
      subArr[1] = 30n;
      expect(parentArr[1]).assertEqual(20n);
      expect(parentArr[2]).assertEqual(30n);
      expect(dv.getBigInt64(8, true)).assertEqual(20n);
      expect(dv.getBigInt64(16, true)).assertEqual(30n);
      dv.setBigInt64(0, 10n, true);
      expect(parentArr[0]).assertEqual(10n);
      expect(parentArr.length).assertEqual(3);
      expect(subArr[0]).assertEqual(20n);
      expect(subArr[1]).assertEqual(30n);
      expect(subArr.length).assertEqual(2);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0800
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0800
     * @tc.desc   Verify BigInt64Array slice (new buffer) does NOT sync with original DataView
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0800', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(16);
      const originalArr: BigInt64Array = new BigInt64Array(buf);
      originalArr.set([10n, 20n]);
      const slicedArr: BigInt64Array = originalArr.slice(0, 1);
      const dv: DataView = new DataView(buf);
      slicedArr[0] = 100n;
      expect(originalArr[0]).assertEqual(10n);
      expect(dv.getBigInt64(0, true)).assertEqual(10n);
      dv.setBigInt64(0, 200n, true);
      expect(originalArr[0]).assertEqual(200n);
      expect(originalArr[1]).assertEqual(20n);
      expect(slicedArr[0]).assertEqual(100n);
      expect(slicedArr.length).assertEqual(1);
      expect(originalArr.length).assertEqual(2);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0900
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0900
     * @tc.desc   Verify DataView out-of-bounds BigInt64 read throws RangeError
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_0900', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(8);
      const dv: DataView = new DataView(buf);
      let isRangeError: boolean = false;
      try {
        dv.getBigInt64(1, true);
      } catch (e) {
        isRangeError = (e as Error).name === 'RangeError';
      }
      expect(isRangeError).assertEqual(true);
      try {
        dv.setBigInt64(8, 10n, true);
      } catch (e) {
        isRangeError = (e as Error).name === 'RangeError';
      }
      expect(isRangeError).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1000
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1000
     * @tc.desc   Verify BigInt64Array set method with BigInt64Array source
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1000', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(24);
      const targetArr: BigInt64Array = new BigInt64Array(buf);
      const sourceArr: BigInt64Array = new BigInt64Array([100n, 200n]);
      const dv: DataView = new DataView(buf);
      targetArr.set(sourceArr, 1);
      expect(targetArr[0]).assertEqual(0n);
      expect(targetArr[1]).assertEqual(100n);
      expect(targetArr[2]).assertEqual(200n);
      expect(targetArr.length).assertEqual(3);
      expect(dv.getBigInt64(8, true)).assertEqual(100n);
      expect(dv.getBigInt64(16, true)).assertEqual(200n);
      sourceArr[0] = 150n;
      targetArr.set(sourceArr, 1);
      expect(dv.getBigInt64(8, true)).assertEqual(150n);
    })
    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1100
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1100
     * @tc.desc   Verify BigInt64Array fill method with BigInt value (sync with DataView)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(24);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf);
      const fillVal: bigint = 500n;
      const dv: DataView = new DataView(buf);
      bigInt64Arr.fill(fillVal);
      for (let i = 0; i < bigInt64Arr.length; i++) {
        expect(bigInt64Arr[i]).assertEqual(fillVal);
        expect(dv.getBigInt64(i * 8, true)).assertEqual(fillVal);
      }
      const newFillVal: bigint = 600n;
      bigInt64Arr.fill(newFillVal, 1, 3);
      expect(bigInt64Arr[0]).assertEqual(fillVal);
      expect(bigInt64Arr[1]).assertEqual(newFillVal);
      expect(bigInt64Arr[2]).assertEqual(newFillVal);
      expect(dv.getBigInt64(8, true)).assertEqual(newFillVal);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1200
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1200
     * @tc.desc   Verify BigInt64Array fill with negative range (sync with DataView)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(32);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf);
      bigInt64Arr.set([10n, 20n, 30n, 40n]);
      const fillVal: bigint = 99n;
      const dv: DataView = new DataView(buf);
      bigInt64Arr.fill(fillVal, -3, -1);
      expect(bigInt64Arr[0]).assertEqual(10n);
      expect(bigInt64Arr[1]).assertEqual(fillVal);
      expect(bigInt64Arr[2]).assertEqual(fillVal);
      expect(bigInt64Arr[3]).assertEqual(40n);
      expect(bigInt64Arr.length).assertEqual(4)
      expect(dv.getBigInt64(8, true)).assertEqual(fillVal);
      expect(dv.getBigInt64(16, true)).assertEqual(fillVal);
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1300
     * @tc.number ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1300
     * @tc.desc   Verify BigInt64Array copyWithin method (sync with DataView)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_BUILTINSARRAY2TEST_TYPEARRAYBIGINT64ARRAY_1300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(32);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf);
      bigInt64Arr.set([1n, 2n, 3n, 4n]);
      const dv: DataView = new DataView(buf);
      bigInt64Arr.copyWithin(0, 2);
      expect(bigInt64Arr[0]).assertEqual(3n);
      expect(bigInt64Arr[1]).assertEqual(4n);
      expect(bigInt64Arr[2]).assertEqual(3n);
      expect(bigInt64Arr[3]).assertEqual(4n);
      expect(bigInt64Arr.length).assertEqual(4)
      expect(dv.getBigInt64(0, true)).assertEqual(3n);
      expect(dv.getBigInt64(8, true)).assertEqual(4n);
      expect(dv.getBigInt64(16, true)).assertEqual(3n);
      bigInt64Arr.copyWithin(-2, 0, 2);
      expect(bigInt64Arr[2]).assertEqual(3n);
      expect(bigInt64Arr[3]).assertEqual(4n);
    })
  })
}