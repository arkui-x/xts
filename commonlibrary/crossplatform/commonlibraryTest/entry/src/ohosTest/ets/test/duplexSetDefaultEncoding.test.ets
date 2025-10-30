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

class TestDuplex extends stream.Duplex {
  constructor() {
    super();
  }

  doRead(size: number) {
  }

  doWrite(chunk: string | Uint8Array, encoding: string, callback: Function) {
    writeSuccess = true;
    console.info("duplexStream chunk is", chunk);
    callback();
  }
}

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function DuplexSetDefaultEncodingTest() {
  describe('DuplexSetDefaultEncodingTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0100
     * @tc.name       : testDuplexSetDefaultEncoding_0001
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0001';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding();
        expect(res).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0200
     * @tc.name       : testDuplexSetDefaultEncoding_0002
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0002';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding('');
        expect(res).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0300
     * @tc.name       : testDuplexSetDefaultEncoding_0003
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0003';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding(' ');
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect(err.message).assertEqual('Unknown encoding:  ');
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0400
     * @tc.name       : testDuplexSetDefaultEncoding_0004
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0004';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding('11');
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect(err.message).assertEqual('Unknown encoding: 11');
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0500
     * @tc.name       : testDuplexSetDefaultEncoding_0005
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0005';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding('utf-8');
        expect(res).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0600
     * @tc.name       : testDuplexSetDefaultEncoding_0006
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0006';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding('gb18030');
        expect(res).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0700
     * @tc.name       : testDuplexSetDefaultEncoding_0007
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0007';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding('gbk');
        expect(res).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_SETDEFAULTENCODING_0800
     * @tc.name       : testDuplexSetDefaultEncoding_0008
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexSetDefaultEncoding_0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexSetDefaultEncoding_0008';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.setDefaultEncoding('gb2312');
        expect(res).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}