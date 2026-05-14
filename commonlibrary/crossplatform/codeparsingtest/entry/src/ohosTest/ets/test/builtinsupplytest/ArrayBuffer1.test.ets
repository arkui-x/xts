/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}

export default function ArrayBuffer1Test() {
  describe('ArrayBuffer1Test', () => {
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
      await sleep(40);
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0100
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0100
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const basicBuffer = new ArrayBuffer(8);
      expect(basicBuffer.byteLength).assertEqual(8);
    });
    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0200
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0200
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const resizableBuffer = new ArrayBuffer(4);
      // const resizableBuffer = new ArrayBuffer(4, { maxByteLength: 12 });
      expect(resizableBuffer.byteLength).assertEqual(4);
    });
    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0300
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0300
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const zeroLengthBuffer = new ArrayBuffer(0);
      // const zeroLengthBuffer = new ArrayBuffer(0, { maxByteLength: 8 });
      expect(zeroLengthBuffer.byteLength).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0400
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0400
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        new ArrayBuffer(-4);
        expect().assertFail();
      } catch (error) {
        expect(error.name).assertEqual("RangeError");
        expect(error.message).assertContain("integerIndex < 0 or integerIndex > SAFE_NUMBER");
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0500
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0500
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const fiftyByteNegativeSliceBuffer = new ArrayBuffer(50);
      const fiftyByteNegativeSlice = fiftyByteNegativeSliceBuffer.slice(-20, -5);
      expect(fiftyByteNegativeSlice.byteLength).assertEqual(15);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0600
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0600
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        const overSafeLength = Number.MAX_SAFE_INTEGER + 1;
        new ArrayBuffer(overSafeLength);
        expect().assertFail();
      } catch (error) {
        expect(error.name).assertEqual("RangeError");
        expect(error.message).assertContain("");
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0700
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0700
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const initTestBuffer = new ArrayBuffer(3);
      const initView = new Uint8Array(initTestBuffer);
      expect(initView[0]).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0800
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0800
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const twoFiftySixByteFloat64Buffer = new ArrayBuffer(256);
      const twoFiftySixByteFloat64View = new Float64Array(twoFiftySixByteFloat64Buffer);
      expect(twoFiftySixByteFloat64View.length).assertEqual(32);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0900
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0900
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const floatIntLengthBuffer = new ArrayBuffer(8.0);
      expect(floatIntLengthBuffer.byteLength).assertEqual(8);
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_1000
     * @tc.number ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_1000
     * @tc.desc   test arraybuffer constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSUPPLYTEST_ARRAYBUFFER1_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const twoUint16Buffer = new ArrayBuffer(4);
      const twoUint16View = new Uint16Array(twoUint16Buffer);
      twoUint16View[0] = 0xABCD;
      twoUint16View[1] = 0xEF12;
      expect(twoUint16View[0]).assertEqual(0xABCD);
    });
  })
}

