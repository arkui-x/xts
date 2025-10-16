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

export default function ReadableSetEncodingTest() {
  describe('ReadableSetEncodingTest', () => {
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
     * @tc.number: SUB_COMMONLIBRARY_UTILS_STREAM_SETENCODING_0100
     * @tc.name: testStreamReadableSetEncoding0001
     * @tc.desc: Set encoding for Readable.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamReadableSetEncoding0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let readable = new stream.Readable();
      readable.setEncoding(null);
      expect(readable.readableEncoding).assertEqual('utf-8');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_UTILS_STREAM_SETENCODING_0200
     * @tc.name: testStreamReadableSetEncoding0002
     * @tc.desc: SetEncoding method encoding.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamReadableSetEncoding0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let readable = new stream.Readable();
      let result = readable.setEncoding('gb18030');
      expect(readable.readableEncoding).assertEqual('gb18030');
      expect(result).assertEqual(true);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_UTILS_STREAM_SETENCODING_0300
     * @tc.name: testStreamReadableSetEncoding0003
     * @tc.desc: SetEncoding method encoding.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamReadableSetEncoding0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let readable = new stream.Readable();
      let result = readable.setEncoding('gbk');
      expect(readable.readableEncoding).assertEqual('gbk');
      expect(result).assertEqual(true);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_UTILS_STREAM_SETENCODING_0400
     * @tc.name: testStreamReadableSetEncoding0004
     * @tc.desc: SetEncoding method encoding.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testStreamReadableSetEncoding0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let readable = new stream.Readable();
      let result = readable.setEncoding('gb2312');
      expect(readable.readableEncoding).assertEqual('gb2312');
      expect(result).assertEqual(true);
    });
  })
}