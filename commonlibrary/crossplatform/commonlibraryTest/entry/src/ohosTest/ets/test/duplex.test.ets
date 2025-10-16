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
function sleep(ms: number) {
  return new Promise<void>((resolve, reject) => setTimeout(resolve, ms));
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
class TestReadable extends stream.Readable {
  constructor() {
    super();
  }
  doRead(size: number) {
  }
}
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
export default function duplexTest() {
  describe('duplexTest', () => {
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
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_DUPLEX_WRITEABLE_HIGH_WATERMARK_0100
     * @tc.name   : testWritableHighWatermark0001
     * @tc.desc   : The constructor of Duplex.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWritableHighWatermark0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testWritableHighWatermark0001';
      try {
        let x = new stream.Duplex();
        console.error(`${TAG} catch error: ${x.writableHighWatermark}`);
        expect(x.writableHighWatermark).assertEqual(16384);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_DUPLEX_WRITEABLEOBJECTMODE_0200
     * @tc.name   : testWriteableObjectMode0002
     * @tc.desc   : The constructor of Duplex.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWriteableObjectMode0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testWriteableObjectMode0002';
      try {
        let x = new stream.Duplex();
        console.error(`${TAG} catch error: ${x.writableObjectMode}`);
        expect(x.writableObjectMode).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_DUPLEX_WRITEABLE_LENGTH_0300
     * @tc.name   : testWriteableLength0003
     * @tc.desc   : The constructor of Duplex.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWritableLength0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testWritableLength0003';
      try {
        let x = new stream.Duplex();
        console.error(`${TAG} catch error: ${x.writableLength}`);
        expect(x.writableLength).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_DUPLEX_WRITEABLE_0400
     * @tc.name   : testWriteable0004
     * @tc.desc   : The constructor of Duplex.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWriteable0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testWriteable0004';
      try {
        let x = new stream.Duplex();
        console.error(`${TAG} catch error: ${x.writable}`);
        expect(x.writable).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_DUPLEX_WRITEABLE_CORKED_0500
     * @tc.name   : testWriteableCorked0005
     * @tc.desc   : The constructor of Duplex.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWriteableCorked0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testWriteableCorked0005';
      try {
        let x = new stream.Duplex();
        console.error(`${TAG} catch error: ${x.writableCorked}`);
        expect(x.writableCorked).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_DUPLEX_WRITEABLE_ENDED_0600
     * @tc.name   : testWritableEnded0006
     * @tc.desc   : The constructor of Duplex.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWritableEnded0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testWritableEnded0006';
      try {
        let x = new stream.Duplex();
        console.error(`${TAG} catch error: ${x.writableEnded}`);
        expect(x.writableEnded).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number : SUB_COMMONLIBRARY_DUPLEX_WRITEABLE_FINISHED_0700
     * @tc.name   : testWriteableFinished0007
     * @tc.desc   : The constructor of Duplex.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testWriteableFinished0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testWriteableFinished0007';
      try {
        let x = new stream.Duplex();
        console.error(`${TAG} catch error: ${x.writableFinished}`);
        expect(x.writableFinished).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}