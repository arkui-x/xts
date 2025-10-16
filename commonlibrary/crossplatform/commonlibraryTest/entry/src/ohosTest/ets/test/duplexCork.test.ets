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

export default function DuplexCorkTest() {
  describe('DuplexCorkTest', () => {
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
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_CORK_0100
     * @tc.name       : testDuplexCork0001
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexCork0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexCork0001';
      try {
        let duplexStream = new stream.Duplex();
        let result = duplexStream.cork();
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_CORK_0200
     * @tc.name       : testDuplexCork0002
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexCork0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (done: Function) => {
      let TAG = 'testDuplexCork0002';
      try {
        let writeSuccess = false;

        class TestDuplex extends stream.Duplex {
          constructor() {
            super();
          }

          doRead(size: number) {
          }

          doWrite(chunk: string | Uint8Array, encoding: string, callback: Function) {
            callback();
          }

          doWritev(chunks: string[] | Uint8Array[], callback: Function) {
            writeSuccess = true;
            callback();
          }
        }

        let duplexStream = new TestDuplex();
        duplexStream.cork();
        duplexStream.write('test1');
        duplexStream.write('test2');
        duplexStream.uncork();
        duplexStream.end();
        setTimeout(() => {
          expect(writeSuccess).assertEqual(true);
          done();
        });
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_UNCORK_0300
     * @tc.name       : testDuplexUncork0003
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexUncork0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexUncork0003';
      try {
        class TestDuplex extends stream.Duplex {
          constructor() {
            super();
          }

          doRead(size: number) {
          }

          doWrite(chunk: string | Uint8Array, encoding: string, callback: Function) {
            dataWritten += chunk;
            callback();
          }
        }

        let dataWritten = '';
        let duplexStream = new TestDuplex();
        duplexStream.cork();
        duplexStream.write('a');
        duplexStream.write('b');
        let result = duplexStream.uncork();
        expect(result).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}