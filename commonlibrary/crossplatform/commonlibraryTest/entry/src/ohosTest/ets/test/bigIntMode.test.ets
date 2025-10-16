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
import { JSON } from '@kit.ArkTS';

export default function BigIntModeTest() {
  describe('BigIntModeTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_JSON_BIGINTMODE_0100
     * @tc.name       : testBIGINTMODE0001
     * @tc.desc       : Testing BIGINTMODE
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testBIGINTMODE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      console.info("testBIGINTMODE0001 START");
      let bigIntMode = JSON.BigIntMode.DEFAULT;
      console.info("bigIntMode :" + bigIntMode);
      expect(bigIntMode).assertEqual(0);
      bigIntMode = JSON.BigIntMode.PARSE_AS_BIGINT;
      console.info("bigIntMode :" + bigIntMode);
      expect(JSON.BigIntMode.PARSE_AS_BIGINT).assertEqual(1);
      bigIntMode = JSON.BigIntMode.ALWAYS_PARSE_AS_BIGINT;
      console.info("bigIntMode :" + bigIntMode);
      expect(JSON.BigIntMode.ALWAYS_PARSE_AS_BIGINT).assertEqual(2);
      console.info("testBIGINTMODE0001 END");
    });
  })
}