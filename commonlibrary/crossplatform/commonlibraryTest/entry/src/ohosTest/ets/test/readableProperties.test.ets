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

class MyReadable extends stream.Readable {
  constructor() {
    super();
  }

  doRead(_size: number): void {
  }
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

class StringDecoderReadable extends stream.Readable {
  constructor(opt?: stream.ReadableOptions) {
    super(opt);
  }

  doRead(_size: number) {
  }
}

class Encoding028_34 extends stream.Readable {
  constructor() {
    super();
  }

  doRead(_size: number) {
  }
}

export default function ReadablePropertiesTest() {
  describe('ReadablePropertiesTest', () => {
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
      await sleep(200);
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_OBJECT_MODE_0100
     * @tc.name testStreamReadableObjectMode0001
     * @tc.desc Readable properties.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableObjectMode0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new stream.Readable();
      expect(readable.readableObjectMode).assertEqual(false);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_HIGH_WATERMARK_0200
     * @tc.name testStreamReadableHighWatermark0002
     * @tc.desc Readable properties.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableHighWatermark0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new stream.Readable();
      expect(readable.readableHighWatermark).assertEqual(16 * 1024);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_LENGTH_0300
     * @tc.name testStreamReadableLength0003
     * @tc.desc Readable properties.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableLength0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new stream.Readable();
      expect(readable.readableLength).assertEqual(0);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_LENGTH_0400
     * @tc.name testStreamReadableLength0004
     * @tc.desc Readable properties.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableLength0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new MyReadable();
      let testData = 'Hello world';
      readable.push(testData);
      expect(readable.readableLength).assertEqual(testData.length);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_LENGTH_0500
     * @tc.name testStreamReadableLength0005
     * @tc.desc Readable properties.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableLength0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new MyReadable();
      let testData = 'Hello world!';
      readable.push(testData);
      let chunk = readable.read(Math.floor(testData.length / 2));
      expect(chunk !== null).assertTrue();
      expect((chunk as string)!.length).assertEqual(testData.length / 2);
      expect(readable.readableLength).assertEqual(testData.length / 2);
      let remainingChunk = readable.read(Math.floor(testData.length / 2));
      expect(remainingChunk !== null).assertTrue();
      expect((remainingChunk as string)!.length).assertEqual(testData.length / 2);
      expect(readable.readableLength).assertEqual(0);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_LENGTH_0600
     * @tc.name testStreamReadableLength0006
     * @tc.desc Readable properties.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableLength0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new MyReadable();
      readable.push('Some data');
      readable.push(null);
      readable.on('data', () => {
      });
      readable.on('end', () => {
        expect(readable.readableLength).assertEqual(0);
      });
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_LENGTH_0700
     * @tc.name testStreamReadableLength0007
     * @tc.desc Readable properties.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableLength0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new MyReadable();
      let testData1 = 'First part';
      let testData2 = 'Second part';
      readable.push(testData1);
      expect(readable.readableLength).assertEqual(testData1.length);
      readable.push(testData2);
      expect(readable.readableLength).assertEqual(testData1.length + testData2.length);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_0800
     * @tc.name testStreamReadableEncoding0008
     * @tc.desc Set encoding for Readable.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new stream.Readable();
      readable.setEncoding();
      expect(readable.readableEncoding).assertEqual('utf-8');
    });
    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_0900
     * @tc.name testStreamReadableEncoding0009
     * @tc.desc Reads a buffer of a specified size from the buffer.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let enc: stream.ReadableOptions = {
        encoding: "windows-1250"
      };
      let stringdecoder = new StringDecoderReadable(enc);
      let res = stringdecoder.readableEncoding;
      expect(res).assertEqual('windows-1250');
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_1000
     * @tc.name testStreamReadableEncoding0010
     * @tc.desc SetEncoding method encoding.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new stream.Readable();
      let result = readable.setEncoding('gb18030');
      expect(readable.readableEncoding).assertEqual('gb18030');
      expect(result).assertEqual(true);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_1100
     * @tc.name testStreamReadableEncoding0011
     * @tc.desc SetEncoding method encoding.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new stream.Readable();
      let result = readable.setEncoding('gbk');
      expect(readable.readableEncoding).assertEqual('gbk');
      expect(result).assertEqual(true);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_1200
     * @tc.name testStreamReadableEncoding0012
     * @tc.desc SetEncoding method encoding.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new stream.Readable();
      let result = readable.setEncoding('gb2312');
      expect(readable.readableEncoding).assertEqual('gb2312');
      expect(result).assertEqual(true);
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_1300
     * @tc.name testStreamReadableEncoding0013
     * @tc.desc DoTransform method encoding.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new Encoding028_34()
      let encoding = readable.setEncoding('gb2312');
      readable.push('test');
      expect(readable.readableEncoding).assertEqual('gb2312');
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_1400
     * @tc.name testStreamReadableEncoding0014
     * @tc.desc DoTransform method encoding.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new Encoding028_34()
      let encoding = readable.setEncoding('gbk');
      readable.push('test');
      expect(readable.readableEncoding).assertEqual('gbk');
    });

    /**
     * @tc.number SUB_COMMONLIBRARY_READABLE_ENCODING_1500
     * @tc.name testStreamReadableEncoding0015
     * @tc.desc DoTransform method encoding.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testStreamReadableEncoding0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let readable = new Encoding028_34()
      let encoding = readable.setEncoding('gb18030');
      readable.push('test');
      expect(readable.readableEncoding).assertEqual('gb18030');
    });
  })
}