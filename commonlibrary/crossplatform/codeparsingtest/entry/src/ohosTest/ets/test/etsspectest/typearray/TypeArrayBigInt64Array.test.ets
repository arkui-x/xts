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

export default function typeArrayBigInt64Array() {
  describe('TypeArrayBigInt64Array', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0100
     * @tc.desc   Verify BigInt64Array and DataView share ArrayBuffer (bidirectional sync)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(8); // BigInt64Array element size = 8 bytes
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf);
      const dv: DataView = new DataView(buf);
      const testVal: bigint = 9223372036854775807n; // Max BigInt64 value

      // BigInt64Array → DataView: Modify BigInt64Array, DataView reads sync (little-endian)
      bigInt64Arr[0] = testVal;
      expect(dv.getBigInt64(0, true)).assertEqual(testVal);

      // DataView → BigInt64Array: Modify DataView, BigInt64Array reads sync
      const newVal: bigint = -9223372036854775808n; // Min BigInt64 value
      dv.setBigInt64(0, newVal, true);
      expect(bigInt64Arr[0]).assertEqual(newVal);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0200
     * @tc.desc   Verify BigInt64Array (non-zero offset) and DataView share ArrayBuffer
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(24); // 3 BigInt64 elements (3×8=24 bytes)
      const offset: number = 8; // Skip first BigInt64 element
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf, offset, 2); // Covers buf[8-15], buf[16-23]
      const dv: DataView = new DataView(buf);
      const val1: bigint = 1234567890123456789n;
      const val2: bigint = -8570200862721897295n;

      // Modify BigInt64Array
      bigInt64Arr[0] = val1;
      bigInt64Arr[1] = val2;

      // Verify DataView reads
      expect(dv.getBigInt64(offset, true)).assertEqual(val1);
      expect(dv.getBigInt64(offset + 8, true)).assertEqual(val2);

      // Modify DataView
      const newVal: bigint = 4567890123456789012n;
      dv.setBigInt64(offset + 4, newVal, true); // Overlaps partial bytes (no sync to full element)
      expect(bigInt64Arr[0]).not().assertEqual(newVal); // BigInt64Array reads full 8-byte element
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0300
     * @tc.desc   Verify SharedArrayBuffer sync between BigInt64Array and DataView (single thread)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const sab: SharedArrayBuffer = new SharedArrayBuffer(16); // 2 BigInt64 elements
      const bigInt64Arr: BigInt64Array = new BigInt64Array(sab);
      const dv: DataView = new DataView(sab);
      const val1: bigint = 1n;
      const val2: bigint = -1n;

      // BigInt64Array writes
      bigInt64Arr[0] = val1;
      bigInt64Arr[1] = val2;

      // DataView reads sync
      expect(dv.getBigInt64(0, true)).assertEqual(val1);
      expect(dv.getBigInt64(8, true)).assertEqual(val2);

      // DataView writes
      const newVal1: bigint = 100n;
      const newVal2: bigint = -200n;
      dv.setBigInt64(0, newVal1, true);
      dv.setBigInt64(8, newVal2, true);

      // BigInt64Array reads sync
      expect(bigInt64Arr[0]).assertEqual(newVal1);
      expect(bigInt64Arr[1]).assertEqual(newVal2);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0400
     * @tc.desc   Verify BigInt64Array handles value overflow (clamped to min/max)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0400', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(8);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf);
      const dv: DataView = new DataView(buf);
      const overflowVal: bigint = 9223372036854775808n; // Exceeds max (9223372036854775807n)
      const underflowVal: bigint = -9223372036854775809n; // Exceeds min (-9223372036854775808n)
      const expectedOverflow: bigint = -9223372036854775808n; // Overflow clamps to min
      const expectedUnderflow: bigint = 9223372036854775807n; // Underflow clamps to max

      // Test overflow
      bigInt64Arr[0] = overflowVal;
      expect(bigInt64Arr[0]).assertEqual(expectedOverflow);
      expect(dv.getBigInt64(0, true)).assertEqual(expectedOverflow);

      // Test underflow
      bigInt64Arr[0] = underflowVal;
      expect(bigInt64Arr[0]).assertEqual(expectedUnderflow);
      expect(dv.getBigInt64(0, true)).assertEqual(expectedUnderflow);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0500
     * @tc.desc   Verify BigInt64Array constructor with plain BigInt array
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1,()=> {
      const source: bigint[] = [10n, 20n, 30n];
      const bigInt64Arr: BigInt64Array = new BigInt64Array(source);
      const dv: DataView = new DataView(bigInt64Arr.buffer);

      expect(bigInt64Arr.length).assertEqual(source.length);
      expect(bigInt64Arr.byteLength).assertEqual(source.length * 8);

      // Verify each element via DataView
      for (let i = 0; i < source.length; i++) {
        expect(dv.getBigInt64(i * 8, true)).assertEqual(source[i]);
      }
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0600
     * @tc.desc   Verify BigInt64Array constructor with ArrayBuffer (offset=0, length=0)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0600', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1,()=> {
      const buf: ArrayBuffer = new ArrayBuffer(16);
      const bigInt64Arr: BigInt64Array = new BigInt64Array(buf, 0, 0); // Empty view
      const dv: DataView = new DataView(buf);

      expect(bigInt64Arr.length).assertEqual(0);
      expect(bigInt64Arr.byteLength).assertEqual(0);
      expect(bigInt64Arr.buffer).assertEqual(buf);

      // DataView can still modify buffer (unrelated to empty BigInt64Array)
      dv.setBigInt64(0, 100n, true);
      expect(dv.getBigInt64(0, true)).assertEqual(100n);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0700
     * @tc.desc   Verify BigInt64Array subarray and DataView share parent ArrayBuffer
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(24); // 3 BigInt64 elements
      const parentArr: BigInt64Array = new BigInt64Array(buf);
      parentArr.set([1n, 2n, 3n]);
      const subArr: BigInt64Array = parentArr.subarray(1, 3); // Covers elements 1 and 2 (buf[8-23])
      const dv: DataView = new DataView(buf);

      // Modify subarray
      subArr[0] = 20n;
      subArr[1] = 30n;

      // Verify parent and DataView sync
      expect(parentArr[1]).assertEqual(20n);
      expect(parentArr[2]).assertEqual(30n);
      expect(dv.getBigInt64(8, true)).assertEqual(20n);
      expect(dv.getBigInt64(16, true)).assertEqual(30n);

      // Modify DataView (parent element 0)
      dv.setBigInt64(0, 10n, true);
      expect(parentArr[0]).assertEqual(10n);
      expect(subArr[0]).assertEqual(20n); // Subarray unchanged
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0800
     * @tc.desc   Verify BigInt64Array slice (new buffer) does NOT sync with original DataView
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0800', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(16); // 2 BigInt64 elements
      const originalArr: BigInt64Array = new BigInt64Array(buf);
      originalArr.set([10n, 20n]);
      const slicedArr: BigInt64Array = originalArr.slice(0, 1); // New buffer (1 element)
      const dv: DataView = new DataView(buf);

      // Modify slicedArr (new buffer)
      slicedArr[0] = 100n;
      expect(originalArr[0]).assertEqual(10n); // Original unchanged
      expect(dv.getBigInt64(0, true)).assertEqual(10n); // DataView unchanged

      // Modify original via DataView
      dv.setBigInt64(0, 200n, true);
      expect(originalArr[0]).assertEqual(200n);
      expect(slicedArr[0]).assertEqual(100n); // Sliced unchanged
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0900
     * @tc.desc   Verify DataView out-of-bounds BigInt64 read throws RangeError
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_0900', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(8); // 1 BigInt64 element
      const dv: DataView = new DataView(buf);
      let isRangeError: boolean = false;

      try {
        dv.getBigInt64(1, true); // Offset 1: only 7 bytes left (needs 8)
      } catch (e) {
        isRangeError = (e as Error).name === 'RangeError';
      }

      expect(isRangeError).assertEqual(true);

      try {
        dv.setBigInt64(8, 10n, true); // Offset 8: exceeds buffer length (8)
      } catch (e) {
        isRangeError = (e as Error).name === 'RangeError';
      }
      expect(isRangeError).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_1000
     * @tc.desc   Verify BigInt64Array set method with BigInt64Array source
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL2
     */
    it('ArkUIX_SUB_ETSSPECTEST_TYPEARRAY_TYPEARRAYBIGINT64ARRAY_1000', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      const buf: ArrayBuffer = new ArrayBuffer(24); // 3 BigInt64 elements
      const targetArr: BigInt64Array = new BigInt64Array(buf);
      const sourceArr: BigInt64Array = new BigInt64Array([100n, 200n]);
      const dv: DataView = new DataView(buf);

      // Set source to target (offset 1)
      targetArr.set(sourceArr, 1);
      expect(targetArr[0]).assertEqual(0n); // Unset element
      expect(targetArr[1]).assertEqual(100n);
      expect(targetArr[2]).assertEqual(200n);

      // Verify via DataView
      expect(dv.getBigInt64(8, true)).assertEqual(100n);
      expect(dv.getBigInt64(16, true)).assertEqual(200n);

      // Modify source and set again
      sourceArr[0] = 150n;
      targetArr.set(sourceArr, 1);
      expect(dv.getBigInt64(8, true)).assertEqual(150n);
    })
  })
}