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
export default function uint32ArrayTest() {
  describe('uint32ArrayTest', () => {
    beforeAll(() => {
      console.info('Uint32ArrayPropertiesTest beforeAll called');
    });
    beforeEach(() => {
      console.info('Uint32ArrayPropertiesTest beforeEach called');
    });
    afterEach(() => {
      console.info('Uint32ArrayPropertiesTest afterEach called');
    });
    afterAll(() => {
      console.info('Uint32ArrayPropertiesTest afterAll called');
    });
    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT32ARRAY_BYTES_PER_ELEMENT_0100
     * @tc.name   : testBytesPerElement0001
     * @tc.desc   : Testing BYTES_PER_ELEMENT static property of collections.Uint32Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testBytesPerElement0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testBytesPerElement0001";
      try {
        let bytes = collections.Uint32Array.BYTES_PER_ELEMENT;
        expect(bytes).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT32ARRAY_BYTELENGTH_0200
     * @tc.name   : testByteLength0002
     * @tc.desc   : Testing byteLength property of collections.Uint32Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testByteLength0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testByteLength0002";
      try {
        let buffer = new collections.ArrayBuffer(32);
        let arrayOffSet0 = new collections.Uint32Array(buffer);
        expect(arrayOffSet0.byteLength).assertEqual(32);
        let arrayOffSet8 = new collections.Uint32Array(buffer, 8);
        expect(arrayOffSet8.byteLength).assertEqual(24);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT32ARRAY_BYTE_OFFSET_0300
     * @tc.name   : testByteOffset0003
     * @tc.desc   : Testing byteOffset property of collections.Uint32Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testByteOffset0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testByteOffset0003";
      try {
        let buffer = new collections.ArrayBuffer(32);
        let arrayOffSet0 = new collections.Uint32Array(buffer);
        expect(arrayOffSet0.byteOffset).assertEqual(0);
        let arrayOffSet8 = new collections.Uint32Array(buffer, 8);
        expect(arrayOffSet8.byteOffset).assertEqual(8);
        let arrayOffSet16 = new collections.Uint32Array(buffer, 16, 3);
        expect(arrayOffSet16.byteOffset).assertEqual(16);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT32ARRAY_SYMBOL_ITERATOR_0400
     * @tc.name   : testSymbolIterator0004
     * @tc.desc   : Testing [Symbol.iterator] property of collections.Uint32Array with empty array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0004";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([]);
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
     * @tc.number : SUB_COMMONLIBRARY_UINT32ARRAY_SYMBOL_ITERATOR_0500
     * @tc.name   : testSymbolIterator0005
     * @tc.desc   : Testing [Symbol.iterator] property of collections.Uint32Array with values using for...of
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0005";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([100000, 200000, 300000]);
        let result: number[] = [];
        for (let value of array) {
          result.push(value);
        }
        expect(result.length).assertEqual(3);
        expect(result[0]).assertEqual(100000);
        expect(result[1]).assertEqual(200000);
        expect(result[2]).assertEqual(300000);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number : SUB_COMMONLIBRARY_UINT32ARRAY_SYMBOL_ITERATOR_0600
     * @tc.name   : testSymbolIterator0006
     * @tc.desc   : Testing [Symbol.iterator] property with spread operator
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0006";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([0, 2147483648, 4294967295]);
        let result = [...array];
        expect(result.length).assertEqual(3);
        expect(result[0]).assertEqual(0);
        expect(result[1]).assertEqual(2147483648);
        expect(result[2]).assertEqual(4294967295);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
  });
}