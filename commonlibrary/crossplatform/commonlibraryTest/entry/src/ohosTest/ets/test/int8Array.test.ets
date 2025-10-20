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
export default function int8ArrayTest() {
  describe('int8ArrayTest', () => {
    beforeAll(() => {
      console.info('Int8ArrayPropertiesTest beforeAll called');
    });
    beforeEach(() => {
      console.info('Int8ArrayPropertiesTest beforeEach called');
    });
    afterEach(() => {
      console.info('Int8ArrayPropertiesTest afterEach called');
    });
    afterAll(() => {
      console.info('Int8ArrayPropertiesTest afterAll called');
    });
    /**
     * @tc.number : SUB_COMMONLIBRARY_INT8ARRAY_BYTES_PER_ELEMENT_0100
     * @tc.name   : testBytesPerElement0001
     * @tc.desc   : Testing BYTES_PER_ELEMENT static property of collections.Int8Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testBytesPerElement0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testBytesPerElement0001";
      try {
        let bytes = collections.Int8Array.BYTES_PER_ELEMENT;
        expect(bytes).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_INT8ARRAY_BUFFER_0200
     * @tc.name   : testBuffer0002
     * @tc.desc   : Testing buffer property of collections.Int8Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testBuffer0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testBuffer0002";
      try {
        let buffer = new collections.ArrayBuffer(32);
        let array = new collections.Int8Array(buffer);
        expect(array.buffer.byteLength).assertEqual(32);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_INT8ARRAY_BYTE_LENGTH_0300
     * @tc.name   : testByteLength0003
     * @tc.desc   : Testing byteLength property of collections.Int8Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testByteLength0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testByteLength0003";
      try {
        let buffer = new collections.ArrayBuffer(32);
        let arrayOffSet0 = new collections.Int8Array(buffer);
        expect(arrayOffSet0.byteLength).assertEqual(32);
        let arrayOffSet8 = new collections.Int8Array(buffer, 8);
        expect(arrayOffSet8.byteLength).assertEqual(24);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_INT8ARRAY_BYTE_OFFSET_0400
     * @tc.name   : testByteOffset0004
     * @tc.desc   : Testing byteOffset property of collections.Int8Array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testByteOffset0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testByteOffset0004";
      try {
        let buffer = new collections.ArrayBuffer(32);
        let arrayOffSet0 = new collections.Int8Array(buffer);
        expect(arrayOffSet0.byteOffset).assertEqual(0);
        let arrayOffSet8 = new collections.Int8Array(buffer, 8);
        expect(arrayOffSet8.byteOffset).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_INT8ARRAY_SYMBOL_ITERATOR_0500
     * @tc.name   : testSymbolIterator0005
     * @tc.desc   : Testing [Symbol.iterator] property of collections.Int8Array with empty array
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0005";
      try {
        let array: collections.Int8Array = collections.Int8Array.from([]);
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
     * @tc.number : SUB_COMMONLIBRARY_INT8ARRAY_SYMBOL_ITERATOR_0600
     * @tc.name   : testSymbolIterator0006
     * @tc.desc   : Testing [Symbol.iterator] property of collections.Int8Array with values using for...of
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0006";
      try {
        let array: collections.Int8Array = collections.Int8Array.from([1, 2, 3]);
        let result: number[] = [];
        for (let value of array) {
          result.push(value);
        }

        expect(result.length).assertEqual(3);
        expect(result[0]).assertEqual(1);
        expect(result[1]).assertEqual(2);
        expect(result[2]).assertEqual(3);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_INT8ARRAY_SYMBOL_ITERATOR_0700
     * @tc.name   : testSymbolIterator0007
     * @tc.desc   : Testing [Symbol.iterator] property with spread operator
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testSymbolIterator0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = "testSymbolIterator0007";
      try {
        let array: collections.Int8Array = collections.Int8Array.from([1, 2, 3]);
        let result = [...array];
        expect(result.toString()).assertEqual('1,2,3');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
  });
}