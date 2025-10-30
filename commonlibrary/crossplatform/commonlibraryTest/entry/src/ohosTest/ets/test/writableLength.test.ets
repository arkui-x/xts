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

export default function WritableLengthTest() {
  describe('WritableLengthTest', () => {
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
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0100
     * @tc.name: testStreamWritableLength0001
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let writableStream = new CustomWritable();
      writableStream.write('hello');
      expect(writableStream.writableLength).assertEqual(5);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0200
     * @tc.name: testStreamWritableLength0002
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let writableStream = new stream.Writable();
      expect(writableStream.writableLength).assertEqual(0);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0300
     * @tc.name: testStreamWritableLength0003
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let customWritable = new CustomWritable();
      customWritable.write('hello');
      expect(customWritable.writableLength).assertEqual(5);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0400
     * @tc.name: testStreamWritableLength0004
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let customWritable = new CustomWritable();
      customWritable.write('hello');
      customWritable.write('world');
      expect(customWritable.writableLength).assertEqual(10);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0500
     * @tc.name: testStreamWritableLength0005
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let customWritable = new CustomWritable();
      customWritable.write('hello');
      expect(customWritable.writableLength).assertEqual(5);
      customWritable.end();
      await customWritable.waitForFinish();
      expect(customWritable.writableLength).assertEqual(0);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0600
     * @tc.name: testStreamWritableLength0006
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let writableStream = new CustomWritable();
      let input = new Uint8Array([0xE4, 0xBD, 0xA0, 0xE5, 0xA5, 0xBD]);
      writableStream.write(input);
      expect(writableStream.writableLength).assertEqual(6);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0700
     * @tc.name: testStreamWritableLength0007
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let customWritable = new CustomWritable();
      let input = new Uint8Array([0xE4, 0xBD, 0xA0, 0xE5, 0xA5, 0xBD]);
      customWritable.write(input);
      expect(customWritable.writableLength).assertEqual(6);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0800
     * @tc.name: testStreamWritableLength0008
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let customWritable = new CustomWritable();
      let input = new Uint8Array([0xE4, 0xBD, 0xA0, 0xE5, 0xA5, 0xBD]);
      let input2 = new Uint8Array([0xE5, 0x92, 0x8d, 0xE8, 0xA7, 0x81]);
      customWritable.write(input);
      customWritable.write(input2);
      expect(customWritable.writableLength).assertEqual(12);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_WRITABLE_LENGTH_0900
     * @tc.name: testStreamWritableLength0009
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableLength0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let customWritable = new CustomWritable();
      let input = new Uint8Array([0xE4, 0xBD, 0xA0, 0xE5, 0xA5, 0xBD]);
      customWritable.write(input);
      expect(customWritable.writableLength).assertEqual(6);
      customWritable.end();
      await customWritable.waitForFinish();
      expect(customWritable.writableLength).assertEqual(0);
    });
  })
}

class CustomWritable extends stream.Writable {
  constructor() {
    super();
  }

  doWrite(chunk: string | Uint8Array, encoding: string, callback: (error?: Error | null) => void): void {
    setTimeout(() => {
      callback();
    }, 0);
  }

  async waitForFinish(): Promise<void> {
    return new Promise((resolve) => {
      this.on('finish', () => {
        resolve();
      });
    });
  }

  async waitForDrain(): Promise<void> {
    return new Promise((resolve) => {
      this.on('drain', () => {
        resolve();
      });
    });
  }
}
