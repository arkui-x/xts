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
 
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { collections } from '@kit.ArkTS';

export default function ArrayBufferTest() {
  describe('ArrayBufferTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0100
     * @tc.name       : testCollectionsArrayBuffer0001
     * @tc.desc       : Testing Collections of ArrayBuffer, constructor -1.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0001', 0, () => {
      const TAG = "testCollectionsArrayBuffer0001";
      try {
          let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(-1);
          console.info("byteLength: " + arrayBuffer.byteLength);
          expect().assertFail();
      } catch (err) {
       console.error(`${TAG} failed, error: ${err.message}`);
       expect(`${err.message}`).assertEqual('integerIndex < 0 or integerIndex > SAFE_NUMBER');
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0200
     * @tc.name       : testCollectionsArrayBuffer0002
     * @tc.desc       : Testing Collections of ArrayBuffer, constructor 0.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0002', 0, () => {
      const TAG = "testCollectionsArrayBuffer0002";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(0);
        console.info("byteLength: " + arrayBuffer.byteLength);
        expect(arrayBuffer.byteLength).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0300
     * @tc.name       : testCollectionsArrayBuffer0003
     * @tc.desc       : Testing Collections of ArrayBuffer, constructor 1.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
      it('testCollectionsArrayBuffer0003', 0, () => {
      const TAG = "testCollectionsArrayBuffer0003";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(1);
        console.info("byteLength: " + arrayBuffer.byteLength);
        expect(arrayBuffer.byteLength).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0400
     * @tc.name       : testCollectionsArrayBuffer0004
     * @tc.desc       : Testing Collections of ArrayBuffer, slice(0).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0004', 0, () => {
      const TAG = "testCollectionsArrayBuffer0004";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(5);
        let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(0);
        console.info("slicedBuffer Length: " + slicedBuffer.byteLength);
        expect(slicedBuffer.byteLength).assertEqual(5);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0500
     * @tc.name       : testCollectionsArrayBuffer0005
     * @tc.desc       : Testing Collections of ArrayBuffer, slice(-1).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0005', 0, () => {
      const TAG = "testCollectionsArrayBuffer0005";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(5);
        let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(-1);
        console.info("slicedBuffer Length: " + slicedBuffer.byteLength);
        expect(slicedBuffer.byteLength).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0600
     * @tc.name       : testCollectionsArrayBuffer0006
     * @tc.desc       : Testing Collections of ArrayBuffer, slice(2).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0006', 0, () => {
      const TAG = "testCollectionsArrayBuffer0006";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(5);
        let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(2);
        console.info("slicedBuffer Length: " + slicedBuffer.byteLength);
        expect(slicedBuffer.byteLength).assertEqual(3);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0700
     * @tc.name       : testCollectionsArrayBuffer0007
     * @tc.desc       : Testing Collections of ArrayBuffer, slice(10).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0007', 0, () => {
      const TAG = "testCollectionsArrayBuffer0007";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(5);
        let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(10);
        console.info("slicedBuffer Length: " + slicedBuffer.byteLength);
        expect(slicedBuffer.byteLength).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0800
     * @tc.name       : testCollectionsArrayBuffer0008
     * @tc.desc       : Testing Collections of ArrayBuffer, slice(2,4).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0008', 0, () => {
      const TAG = "testCollectionsArrayBuffer0008";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(5);
        let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(2,4);
        console.info("slicedBuffer Length: " + slicedBuffer.byteLength);
        expect(slicedBuffer.byteLength).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_0900
     * @tc.name       : testCollectionsArrayBuffer0009
     * @tc.desc       : Testing Collections of ArrayBuffer, slice(2,2).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0009', 0, () => {
      const TAG = "testCollectionsArrayBuffer0009";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(5);
        let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(2,2);
        console.info("slicedBuffer Length: " + slicedBuffer.byteLength);
        expect(slicedBuffer.byteLength).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_BASE_COLLECTIONS_ARRAYBUFFER_1000
     * @tc.name       : testCollectionsArrayBuffer0010
     * @tc.desc       : Testing Collections of ArrayBuffer, slice(2,0).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCollectionsArrayBuffer0010', 0, () => {
      const TAG = "testCollectionsArrayBuffer0010";
      try {
        let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(5);
        let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(2,0);
        console.info("slicedBuffer Length: " + slicedBuffer.byteLength);
        expect(slicedBuffer.byteLength).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}