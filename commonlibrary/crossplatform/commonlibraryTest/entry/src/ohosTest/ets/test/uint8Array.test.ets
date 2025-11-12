/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from '@ohos/hypium';
import { collections } from '@kit.ArkTS';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function uint8ArrayTest() {
  describe('uint8ArrayTest', () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async() => {
      await sleep(100);
      console.info("beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.");
    });
    afterEach(() => {
      console.info("afterEach: Test case-level clearance conditions, which are executed after each test case is executed.");
    });
    afterAll(async() => {
      await sleep(500);
      console.info("afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed");
    });
    console.info("start################################start");

    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT8ARRAY_BYTES_PER_ELEMENT_0100
     * @tc.name   : testBytesPerElement0001
     * @tc.desc   : Testing BYTES_PER_ELEMENT static property of collections.Uint8Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testBytesPerElement0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testBytesPerElement0001";
      try {
        let bytes = collections.Uint8Array.BYTES_PER_ELEMENT;
        expect(bytes).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT8ARRAY_BYTE_LENGTH_0200
     * @tc.name   : testByteLength0002
     * @tc.desc   : Testing byteLength property of collections.Uint8Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testByteLength0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testByteLength0002";
      try {
        let buffer = new collections.ArrayBuffer(32);
        let arrayOffSet0 = new collections.Uint8Array(buffer);
        expect(arrayOffSet0.byteLength).assertEqual(32);
        let arrayOffSet8 = new collections.Uint8Array(buffer, 8);
        expect(arrayOffSet8.byteLength).assertEqual(24);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT8ARRAY_BYTE_OFFSET_0300
     * @tc.name   : testByteOffset0003
     * @tc.desc   : Testing byteOffset property of collections.Uint8Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testByteOffset0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testByteOffset0003";
      try {
        let buffer = new collections.ArrayBuffer(32);
        let arrayOffSet0 = new collections.Uint8Array(buffer);
        expect(arrayOffSet0.byteOffset).assertEqual(0);
        let arrayOffSet8 = new collections.Uint8Array(buffer, 8);
        expect(arrayOffSet8.byteOffset).assertEqual(8);
        let arrayOffSet16 = new collections.Uint8Array(buffer, 16, 8);
        expect(arrayOffSet16.byteOffset).assertEqual(16);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT8ARRAY_SYMBOL_ITERATOR_0400
     * @tc.name   : testSymbolIterator0004
     * @tc.desc   : Testing [Symbol.iterator] property of collections.Uint8Array with empty array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0004";
      try {
        let array: collections.Uint8Array = collections.Uint8Array.from([]);
        let hasValues = false;
        for (let value of array) {
          hasValues = true;
        }
        expect(hasValues).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT8ARRAY_SYMBOL_ITERATOR_0500
     * @tc.name   : testSymbolIterator0005
     * @tc.desc   : Testing [Symbol.iterator] property of collections.Uint8Array with values using for...of
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0005";
      try {
        let array: collections.Uint8Array = collections.Uint8Array.from([10, 20, 30]);
        let result: number[] = [];
        for (let value of array) {
          result.push(value);
        }
        expect(result.length).assertEqual(3);
        expect(result[0]).assertEqual(10);
        expect(result[1]).assertEqual(20);
        expect(result[2]).assertEqual(30);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT8ARRAY_SYMBOL_ITERATOR_0600
     * @tc.name   : testSymbolIterator0006
     * @tc.desc   : Testing [Symbol.iterator] property with spread operator
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0006";
      try {
        let array: collections.Uint8Array = collections.Uint8Array.from([255, 128, 64]);
        let result = [...array];
        expect(result.length).assertEqual(3);
        expect(result[0]).assertEqual(255);
        expect(result[1]).assertEqual(128);
        expect(result[2]).assertEqual(64);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
  });
}