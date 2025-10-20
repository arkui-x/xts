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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { stream } from '@kit.ArkTS';

class TestReadable extends stream.Readable {
  constructor() {
    super();
  }

  doRead(_size: number) {
  }
}

export default function ReadablePushTest() {
  describe('ReadablePushTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0100
     * @tc.name       : testPush0001
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0001';
      try {
        let readable = new TestReadable();
        let testData = undefined
        let result = readable.push(testData);
        expect(result).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0200
     * @tc.name       : testPush0002
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0002';
      try {
        let readable = new TestReadable();
        let testData = null
        let result = readable.push(testData);
        expect(result).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0300
     * @tc.name       : testPush0003
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0003';
      try {
        let readable = new TestReadable();
        let testData = ''
        let result = readable.push(testData);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect(err.message).assertEqual('src is not iterable');
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0400
     * @tc.name       : testPush0004
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0004';
      try {
        let readable = new TestReadable();
        let testData = ' '
        let result = readable.push(testData);
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0500
     * @tc.name       : testPush0005
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0005';
      try {
        let readable = new TestReadable();
        let testData = '0'
        let result = readable.push(testData);
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0600
     * @tc.name       : testPush0006
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0006';
      try {
        let stringA = 'test';
        for (let i = 0; i < 9999; i++) {
          stringA += 'test';
        }
        let readable = new TestReadable();
        let testData = stringA
        let result = readable.push(testData);
        expect(result).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0700
     * @tc.name       : testPush0007
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0007';
      try {
        let readable = new TestReadable();
        let testData = 'test/'
        let result = readable.push(testData);
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0800
     * @tc.name       : testPush0008
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0008';
      try {
        let readable = new TestReadable();
        let testData = '✌️'
        let result = readable.push(testData);
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_0900
     * @tc.name       : testPush0009
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0009';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', 'utf-8');
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1000
     * @tc.name       : testPush0010
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0010';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', 'gb18030');
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1100
     * @tc.name       : testPush0011
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0011';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', 'gbk');
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1200
     * @tc.name       : testPush0012
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0012';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', 'gb2312');
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1300
     * @tc.name       : testPush0013
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0013';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', '1111');
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect(err.message).assertEqual('Parameter error. The type of 1111 must be string.');
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1400
     * @tc.name       : testPush0014
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0014';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', undefined);
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1500
     * @tc.name       : testPush0015
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0015';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', null);
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1600
     * @tc.name       : testPush0016
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0016';
      try {
        let readable = new TestReadable();
        let result = readable.push('test', '');
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_PUSH_1700
     * @tc.name       : testPush0017
     * @tc.desc       : Push data into the readable stream buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testPush0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testPush0017';
      try {
        let readable = new TestReadable();
        let uint8Array = new Uint8Array(5);
        let result = readable.push(uint8Array);
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
  })
}