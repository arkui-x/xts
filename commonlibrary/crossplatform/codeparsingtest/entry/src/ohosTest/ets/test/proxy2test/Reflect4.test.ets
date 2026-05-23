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
import {
  test_deleteProperty_1,
  test_deleteProperty_10,
  test_deleteProperty_2,
  test_deleteProperty_3,
  test_deleteProperty_4,
  test_deleteProperty_5,
  test_deleteProperty_6,
  test_deleteProperty_7,
  test_deleteProperty_8,
  test_deleteProperty_9
} from './Reflect4';

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function reflect4Test() {
  describe('reflect4Test', () => {
    beforeAll(async () => {
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_300)
    })

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0100
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0100
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_1();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0200
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0200
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_2();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0300
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0300
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_3();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0400
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0400
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_4();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0500
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0500
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_5();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0600
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0600
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_6();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0700
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0700
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_7();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0800
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0800
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_8();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_0900
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_0900
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_9();
      expect(result).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXY2TEST_REFLECT4_1000
     * @tc.number ArkUIX_SUB_PROXY2TEST_REFLECT4_1000
     * @tc.desc   test reflect deleteProperty
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXY2TEST_REFLECT4_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = test_deleteProperty_10();
      expect(result).assertTrue();
    });
  })
}
