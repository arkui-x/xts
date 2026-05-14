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

import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';

import { FinalizationRegistryRegisterUtils } from './finalizationRegistryRegisterUtils.js';

function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}

export default function symbol1test() {
  describe('symbol1test', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(async () => {
      await sleep(50);
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
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0100
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0100
     * @tc.desc      Verify valid registration: target is object, heldValue is string (no unregisterToken)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test001_ValidRegisterObjectTarget();
        expect(result).assertEqual("Test Passed: ValidRegisterObjectTargetTest001");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0200
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0200
     * @tc.desc      Verify valid registration: target is non-registered Symbol
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test002_ValidRegisterSymbolTarget();
        expect(result).assertEqual("Test Passed: ValidRegisterSymbolTargetTest002");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0300
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0300
     * @tc.desc      Verify invalid registration: heldValue equals target (throws TypeError)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test003_InvalidRegisterHeldValueEqualsTarget();
        expect(result).assertEqual("Test Passed: InvalidRegisterHeldValueEqualsTargetTest003");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0400
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0400
     * @tc.desc      Verify valid registration: unregisterToken is object
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test004_ValidRegisterWithObjectToken();
        expect(result).assertEqual("Test Passed: ValidRegisterWithObjectTokenTest004");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0500
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0500
     * @tc.desc      Verify valid registration: unregisterToken is non-registered Symbol
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test005_ValidRegisterWithSymbolToken();
        expect(result).assertEqual("Test Passed: ValidRegisterWithSymbolTokenTest005");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0600
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0600
     * @tc.desc      Verify invalid registration: target is primitive type (throws TypeError)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test006_InvalidRegisterPrimitiveTarget();
        expect(result).assertEqual("Test Passed: InvalidRegisterPrimitiveTargetTest006");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0700
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0700
     * @tc.desc      Verify invalid registration: unregisterToken is primitive type (throws TypeError)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test007_InvalidRegisterPrimitiveToken();
        expect(result).assertEqual("Test Passed: InvalidRegisterPrimitiveTokenTest007");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0800
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0800
     * @tc.desc      Verify valid registration: no unregisterToken (returns undefined)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test008_ValidRegisterWithoutToken();
        expect(result).assertEqual("Test Passed: ValidRegisterWithoutTokenTest008");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0900
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0900
     * @tc.desc      Verify valid registration: heldValue is object (not target)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test009_ValidRegisterHeldValueAsObject();
        expect(result).assertEqual("Test Passed: ValidRegisterHeldValueAsObjectTest009");
      });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_1000
     * @tc.name      ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_1000
     * @tc.desc      Verify valid registration: same target registered multiple times
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL1TEST_SYMBOL1TEST_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        const result = FinalizationRegistryRegisterUtils.test010_ValidRegisterSameTargetMultipleTimes();
        expect(result).assertEqual("Test Passed: ValidRegisterSameTargetMultipleTimesTest010");
      });

  })
}