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

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

let writeSuccess = false;

class Resettable {
  constructor() {
    writeSuccess = false;
  }
}

class TestWritable extends stream.Writable {
  constructor() {
    super();
  }

  doWrite(chunk: string | Uint8Array, encoding: string, callback: Function) {
    writeSuccess = true;
    console.log(`result: Writable chunk is ` + chunk);
    callback();
  }
}

export default function WritableEndTest() {
  describe('WritableEndTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0100
     * @tc.name       : testStreamWritableEnd0001
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0001';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('finish');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0200
     * @tc.name       : testStreamWritableEnd0002
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0002';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end();
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0300
     * @tc.name       : testStreamWritableEnd0003
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0003';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end(undefined);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0400
     * @tc.name       : testStreamWritableEnd0004
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0004';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end(null);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0500
     * @tc.name       : testStreamWritableEnd0005
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0005';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0600
     * @tc.name       : testStreamWritableEnd0006
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0006';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end(' ');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0700
     * @tc.name       : testStreamWritableEnd0007
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0007';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('0');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0800
     * @tc.name       : testStreamWritableEnd0008
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0008';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test/');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_0900
     * @tc.name       : testStreamWritableEnd0009
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0009';
      try {
        let stringA = 'test';
        for (let i = 0; i < 9999; i++) {
          stringA += 'test';
        }
        let writableStream = new TestWritable();
        let res = writableStream.end(stringA);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1000
     * @tc.name       : testStreamWritableEnd0010
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0010';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('😊');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1100
     * @tc.name       : testStreamWritableEnd0011
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End 'utf-8'
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0011';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'utf-8');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1200
     * @tc.name       : testStreamWritableEnd0012
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End 'gb18030'
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0012';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb18030');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1300
     * @tc.name       : testStreamWritableEnd0013
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End 'gbk'
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0013';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gbk');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1400
     * @tc.name       : testStreamWritableEnd0014
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End 'gb2312'
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0014';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb2312');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1500
     * @tc.name       : testStreamWritableEnd0015
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0015';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', '1111');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1600
     * @tc.name       : testStreamWritableEnd0016
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0016';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', undefined);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1700
     * @tc.name       : testStreamWritableEnd0017
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0017';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', null);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1800
     * @tc.name       : testStreamWritableEnd0018
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0018';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', '');
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_1900
     * @tc.name       : testStreamWritableEnd0019
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0019';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'utf-8', () => {
          return true
        });
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2000
     * @tc.name       : testStreamWritableEnd0020
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0020';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb18030', () => {
          return true
        });
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2100
     * @tc.name       : testStreamWritableEnd0021
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0021';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gbk', () => {
          return true
        });
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2200
     * @tc.name       : testStreamWritableEnd0022
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0022';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb2312', () => {
          return true
        });
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2300
     * @tc.name       : testStreamWritableEnd0023
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0023';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'utf-8', undefined);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2400
     * @tc.name       : testStreamWritableEnd0024
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0024';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb18030', undefined);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2500
     * @tc.name       : testStreamWritableEnd0025
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0025';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gbk', undefined);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2600
     * @tc.name       : testStreamWritableEnd0026
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0026';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb2312', undefined);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2700
     * @tc.name       : testStreamWritableEnd0027
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0027';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'utf-8', null);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2800
     * @tc.name       : testStreamWritableEnd0028
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0028';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb18030', null);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_2900
     * @tc.name       : testStreamWritableEnd0029
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0029';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gbk', null);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_3000
     * @tc.name       : testStreamWritableEnd0030
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0030';
      try {
        let writableStream = new TestWritable();
        let res = writableStream.end('test', 'gb2312', null);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_END_3100
     * @tc.name       : testStreamWritableEnd0031
     * @tc.desc       : Test the function of the interface In the Stream_Writable_End
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testStreamWritableEnd0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testStreamWritableEnd0031';
      try {
        let arr = new Uint8Array([21, 31]);
        let writableStream = new TestWritable();
        let res = writableStream.end(arr);
        expect(res.writable).assertEqual(false);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}