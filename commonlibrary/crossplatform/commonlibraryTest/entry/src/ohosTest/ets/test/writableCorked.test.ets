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

export default function WritableCorkedTest() {
  describe('WritableCorkedTest', () => {
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
     * @tc.number: SUB_COMMONLIBRARY_UTILS_STREAM_WRITABLECORED_0100
     * @tc.name: testStreamWritableCorked0001
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableCorked0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let writableStream = new stream.Writable();
      expect(writableStream.writableCorked).assertEqual(0);
      writableStream.uncork();
      expect(writableStream.writableCorked).assertEqual(0);
      writableStream.cork();
      expect(writableStream.writableCorked).assertEqual(1);
      writableStream.cork();
      expect(writableStream.writableCorked).assertEqual(2);
      writableStream.uncork();
      expect(writableStream.writableCorked).assertEqual(1);
      writableStream.uncork();
      expect(writableStream.writableCorked).assertEqual(0);
      writableStream.uncork();
      expect(writableStream.writableCorked).assertEqual(0);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_UTILS_STREAM_WRITABLECORED_0200
     * @tc.name: testStreamWritableCorked0002
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableCorked0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let writableStream = new CustomWritable();
      expect(writableStream.writableCorked).assertEqual(0);
      writableStream.cork();
      expect(writableStream.writableCorked).assertEqual(1);
      writableStream.write('Hello ');
      writableStream.write('World!');
      writableStream.uncork();
      expect(writableStream.writableCorked).assertEqual(0);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_UTILS_STREAM_WRITABLECORED_0300
     * @tc.name: testStreamWritableCorked0003
     * @tc.desc: Writable Properties.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamWritableCorked0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let writableStream = new CustomWritable();
      let input = new Uint8Array([0xE4, 0xBD, 0xA0, 0xE5, 0xA5, 0xBD]);
      let input2 = new Uint8Array([0xE5, 0x86, 0x8D, 0xE8, 0xA7, 0x81]);
      expect(writableStream.writableCorked).assertEqual(0);
      writableStream.cork();
      expect(writableStream.writableCorked).assertEqual(1);
      writableStream.write(input);
      writableStream.write(input2);
      writableStream.uncork();
      expect(writableStream.writableCorked).assertEqual(0);
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