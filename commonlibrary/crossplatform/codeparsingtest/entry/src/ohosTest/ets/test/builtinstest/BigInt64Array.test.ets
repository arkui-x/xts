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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from '@ohos/hypium';
import { Constants } from './BigInt64ArrayData.test';

function sleep(time: number) {
  return new Promise<void>((resolve, reject) => {
    setTimeout(() => {
    resolve()
    }, time)
  }).then(() => {
    console.info( `sleep ${time} over...`)
  })
}

export default function BigInt64ArrayTest() {
  describe('BigInt64ArrayTest', () => {
    let value: string;
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
    afterEach(async (done:Function) => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
      console.info('TypeArray after each called');
      value = '';
      await sleep(10);
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0100
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0100
     * @tc.desc   Testing Constructor of BigInt64Array without param.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      const TAG = "testBigInt64Constructor0001";
      try {
        let array = new BigInt64Array();
        expect(array.length).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0200
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0200
     * @tc.desc   Testing Constructor of BigInt64Array with length 0,and set index 0 with 3.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      const TAG = "testBigInt64Constructor0002";
      try {
        let array = new BigInt64Array(0);
        array[0] = BigInt(3);
        expect(array[0]).assertEqual(undefined);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0300
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0300
     * @tc.desc   Testing Constructor of BigInt64Array with length 10,and set index 0 with 3.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      const TAG = "testBigInt64Constructor0003";
      try {
        let array = new BigInt64Array(10);
        array[0] = BigInt(3);
        expect(array[0]).assertEqual(BigInt(3));
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0400
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0400
     * @tc.desc   Testing Constructor of BigInt64Array with length 10,and set index 0 with 3.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      const TAG = "testBigInt64Constructor0004";
      try {
        let array = new BigInt64Array(10);
        array[10] = BigInt(3);
        expect(array[10]).assertEqual(undefined);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0500
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0500
     * @tc.desc   Testing Constructor of BigInt64Array with length 10,and get value of index 1.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      const TAG = "testBigInt64Constructor0005";
      try {
        let array = new BigInt64Array(10);
        expect(array[1]).assertEqual(BigInt(0));
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0600
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0600
     * @tc.desc   Testing Constructor of BigInt64Array with 'q',and get value of index 0.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const TAG = "testBigInt64Constructor0006";
      try {
        const array = Constants.bigInt64ConstructTestArray1;
        expect(array[0]).assertEqual(113n);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0700
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0700
     * @tc.desc   Testing Constructor of BigInt64Array with '56',and get value of index 1.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const TAG = "testBigInt64Constructor0007";
      try {
        const array = Constants.bigInt64ConstructTestArray2;
        expect(array[0]).assertEqual(56n);
        expect(array.length).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0800
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0800
     * @tc.desc   Testing Constructor of BigInt64Array with array[21,31],and get value of index 0.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const TAG = "testBigInt64Constructor0008";
      try {
        let array = new BigInt64Array([BigInt(21), BigInt(31)]);
        expect(array[0]).assertEqual(BigInt(21));
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0900
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0900
     * @tc.desc   Testing Constructor of BigInt64Array with array[21,31],and get value of index 1.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const TAG = "testBigInt64Constructor0009";
      try {
        let array = new BigInt64Array([BigInt(21), BigInt(31)]);
        expect(array[1]).assertEqual(BigInt(31));
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_1000
     * @tc.number ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_1000
     * @tc.desc   Testing Constructor of BigInt64Array with array[21,31],and get value of index 3.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_BUILTINSTEST_BIGINT64ARRAY_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const TAG = "testBigInt64Constructor0010";
      try {
        let array = new BigInt64Array([BigInt(21), BigInt(31)]);
        expect(array[3]).assertEqual(undefined);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
  })
}