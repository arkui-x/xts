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
let writeSuccess = false;
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
class TestReadable extends stream.Readable {
  constructor() {
    super();
  }

  doRead(size: number) {
  }
}
export default function WritableOn_OffTest() {
  describe('WritableOn_OffTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
      writeSuccess = false;
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_ON_0100
     * @tc.name       : testOn0001
     * @tc.desc       : Test the function of the interface testOn.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOn0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testOn0001";
      try {
        class TestWritable extends stream.Writable {
          constructor() {
            super();
          }

          doWrite(chunk: string | Uint8Array, encoding: string, callback: Function) {
            callback(new Error());
          }
        }

        let callbackwriteSuccess = false;
        let writable = new TestWritable();
        writable.on('error', () => {
          console.info("Writable event test", callbackwriteSuccess.toString());
        })
        writable.write('hello', 'utf8', () => {
        })
        expect(writable.write('hello', 'utf8', () => {
        })).assertFalse();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_ON_0200
     * @tc.name       : testOn0002
     * @tc.desc       : Test the function of the interface testOn.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOn0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = "testOn0002";
      try {
        let writableStream = new TestWritable();
        let testListenerwriteSuccess = false;
        let testListener = () => {
          testListenerwriteSuccess = true;
        };
        writableStream.on('finish', testListener);
        writableStream.write('test');
        writableStream.end();
        setTimeout(() => {
          expect(testListenerwriteSuccess).assertEqual(true);
          console.info("Writable test", testListenerwriteSuccess.toString());
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_ON_0300
     * @tc.name       : testOn0003
     * @tc.desc       : Test the function of the interface testOn.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testOn0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = "testOn0003";
      try {
        let writableStream = new TestWritable();
        let testListenerwriteSuccess = false;
        let testListener = () => {
          testListenerwriteSuccess = true;
        };
        writableStream.on('close', testListener);
        writableStream.write('test');
        writableStream.end();
        setTimeout(() => {
          expect(testListenerwriteSuccess).assertEqual(true);
          console.info("Writable test", testListenerwriteSuccess.toString());
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}