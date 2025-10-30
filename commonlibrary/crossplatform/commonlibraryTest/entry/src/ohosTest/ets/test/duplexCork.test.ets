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

export default function DuplexCorkTest() {
  describe('DuplexCorkTest', () => {
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