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

export default function ReadableOffTest() {
  describe('ReadableOffTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_OFF_0100
     * @tc.name       : testOff0001
     * @tc.desc       : Register event handling functions to listen for different events on readable streams.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOff0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = 'testOff0001';
      try {
        class TestReadable extends stream.Readable {
          constructor() {
            super();
          }

          doRead(size: number) {
            throw new Error('Simulated error');
          }
        }

        let readable = new TestReadable();
        let writeSuccess = false;
        readable.push('test');
        readable.on('close', () => {
          writeSuccess = true;
        });
        readable.off('close');
        setTimeout(() => {
          expect(writeSuccess).assertEqual(false);
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_OFF_0200
     * @tc.name       : testOff0002
     * @tc.desc       : Cancels event handlers registered with on.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOff0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = 'testOff0002';
      try {
        class TestReadable extends stream.Readable {
          constructor() {
            super();
          }

          doRead(size: number) {
            throw new Error('Simulated error');
          }
        }

        let readable = new TestReadable();
        let writeSuccess = false;
        readable.push('test');
        readable.on('data', () => {
          writeSuccess = true;
        })
        readable.off('data');
        setTimeout(() => {
          expect(writeSuccess).assertEqual(false);
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_OFF_0300
     * @tc.name       : testOff0003
     * @tc.desc       : Cancels event handlers registered with on.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOff0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = 'testOff0003';
      try {
        class TestReadable extends stream.Readable {
          constructor() {
            super();
          }

          doRead(size: number) {
            throw new Error('Simulated error');
          }
        }

        let readable = new TestReadable();
        let writeSuccess = false;
        readable.push(null);
        readable.on('end', () => {
          writeSuccess = true;
        })
        readable.off('end');
        setTimeout(() => {
          expect(writeSuccess).assertEqual(false);
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_OFF_0400
     * @tc.name       : testOff0004
     * @tc.desc       : Cancels event handlers registered with on.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOff0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = 'testOff0004';
      try {
        class TestReadable extends stream.Readable {
          constructor() {
            super();
          }

          doRead(size: number) {
            throw new Error('Simulated error');
          }
        }

        let readable = new TestReadable();
        let writeSuccess = false;
        readable.push(null);
        readable.on('error', () => {
          writeSuccess = true;
        })
        readable.off('error');
        setTimeout(() => {
          expect(writeSuccess).assertEqual(false);
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_OFF_0500
     * @tc.name       : testOff0005
     * @tc.desc       : Cancels event handlers registered with on.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOff0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = 'testOff0005';
      try {
        class TestReadable extends stream.Readable {
          constructor() {
            super();
          }

          doRead(size: number) {
            throw new Error('Simulated error');
          }
        }

        let readable = new TestReadable();
        let writeSuccess = false;
        readable.push('test');
        readable.on('readable', () => {
          writeSuccess = true;
        })
        readable.off('readable');
        setTimeout(() => {
          expect(writeSuccess).assertEqual(false);
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}