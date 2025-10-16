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

export default function WritableCorkedTest() {
  describe('WritableCorkedTest', () => {
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
    })
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