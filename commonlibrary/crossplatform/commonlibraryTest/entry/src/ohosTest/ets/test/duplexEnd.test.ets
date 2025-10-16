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

class Resettable {
  constructor() {
    writeSuccess = false;
  }
}

function sleep(ms: number) {
  return new Promise<void>((resolve, reject) => setTimeout(resolve, ms));
}

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

export default function DuplexEndTest() {
  describe('DuplexEndTest', () => {
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
    afterEach(async () => {
      new Resettable();
      await sleep(50);
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0100
     * @tc.name       : testDuplexEnd0001
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0001';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end();
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0200
     * @tc.name       : testDuplexEnd0002
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0002';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end(undefined);
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0300
     * @tc.name       : testDuplexEnd0003
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0003';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end(null);
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0400
     * @tc.name       : testDuplexEnd0004
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0004';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('');
        expect(writeSuccess).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0500
     * @tc.name       : testDuplexEnd0005
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0005';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end(' ');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0600
     * @tc.name       : testDuplexEnd0006
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0006';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('0');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0700
     * @tc.name       : testDuplexEnd0007
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0007';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test/');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0800
     * @tc.name       : testDuplexEnd0008
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0008';
      try {
        let duplexStream = new TestDuplex();
        let stringA = 'test';
        for (let i = 0; i < 9999; i++) {
          stringA += 'test';
        }
        let res = duplexStream.end(stringA);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_0900
     * @tc.name       : testDuplexEnd0009
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0009';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('😀😀');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1000
     * @tc.name       : testDuplexEnd0010
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0010';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'utf-8');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1100
     * @tc.name       : testDuplexEnd0011
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0011';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb18030');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1200
     * @tc.name       : testDuplexEnd0012
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0012';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gbk');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1300
     * @tc.name       : testDuplexEnd0013
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0013';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb2312');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1400
     * @tc.name       : testDuplexEnd0014
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0014';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', '1111');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1500
     * @tc.name       : testDuplexEnd0015
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0015';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', undefined);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1600
     * @tc.name       : testDuplexEnd0016
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0016';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', null);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1700
     * @tc.name       : testDuplexEnd0017
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0017';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', '');
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1800
     * @tc.name       : testDuplexEnd0018
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0018';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'utf-8', () => {
          return true;
        })
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_1900
     * @tc.name       : testDuplexEnd0019
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0019';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb18030', () => {
          return true;
        })
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2000
     * @tc.name       : testDuplexEnd0020
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0020';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gbk', () => {
          return true;
        })
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2100
     * @tc.name       : testDuplexEnd0021
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0021';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb2312', () => {
          return true;
        })
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2200
     * @tc.name       : testDuplexEnd0022
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0022';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'utf-8', undefined);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2300
     * @tc.name       : testDuplexEnd0023
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0023';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb18030', undefined);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2400
     * @tc.name       : testDuplexEnd0024
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0024';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gbk', undefined);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2500
     * @tc.name       : testDuplexEnd0025
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0025';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb2312', undefined);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2600
     * @tc.name       : testDuplexEnd0026
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0026';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'utf-8', null);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2700
     * @tc.name       : testDuplexEnd0027
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0027';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb18030', null);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2800
     * @tc.name       : testDuplexEnd0028
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0028';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gbk', null);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_2900
     * @tc.name       : testDuplexEnd0029
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0029';
      try {
        let duplexStream = new TestDuplex();
        let res = duplexStream.end('test', 'gb2312', null);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_STREAM_DUPLEX_END_3000
     * @tc.name       : testDuplexEnd0030
     * @tc.desc       : Test the function of the interface Duplex.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testDuplexEnd0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testDuplexEnd0030';
      try {
        let duplexStream = new TestDuplex();
        let uint8Array = new Uint8Array([10, 20, 30, 40, 50]);
        let res = duplexStream.end(uint8Array);
        expect(writeSuccess).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}