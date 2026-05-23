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

import { FinalizationRegistryComprehensiveUtils } from './finalizationRegistryComprehensiveUtils.js';

function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}

export default function symbol2test() {
  describe('symbol2test', () => {
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
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0100
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0100
     * @tc.desc      Comprehensive: Constructor + register + GC (callback triggers with heldValue)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test001_ConstructorRegisterGCCallback();
      expect(result).assertEqual("Test Passed: ConstructorRegisterGCCallbackTest001");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0200
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0200
     * @tc.desc      Comprehensive: Register + unregister + GC (callback not triggered after unregister)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test002_RegisterUnregisterGC();
      expect(result).assertEqual("Test Passed: RegisterUnregisterGCTest002");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0300
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0300
     * @tc.desc      Comprehensive: Strong reference to heldValue (accessible after GC)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test003_StrongReferenceHeldValueGC();
      expect(result).assertEqual("Test Passed: StrongReferenceHeldValueGCTest003");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0400
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0400
     * @tc.desc      Comprehensive: Multiple register same target + GC (last heldValue effective)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test004_MultipleRegisterSameTargetGC();
      expect(result).assertEqual("Test Passed: MultipleRegisterSameTargetGCTest004");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0500
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0500
     * @tc.desc      Comprehensive: Symbol target + Symbol token + unregister + GC
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test005_SymbolTargetTokenUnregisterGC();
      expect(result).assertEqual("Test Passed: SymbolTargetTokenUnregisterGCTest005");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0600
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0600
     * @tc.desc      Comprehensive: Register without token + GC (callback triggers, cannot unregister)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test006_NoTokenRegisterGC();
      expect(result).assertEqual("Test Passed: NoTokenRegisterGCTest006");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0700
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0700
     * @tc.desc      Comprehensive: Circular reference target + GC (target recyclable)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test007_CircularReferenceTargetGC();
      expect(result).assertEqual("Test Passed: CircularReferenceTargetGCTest007");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0800
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0800
     * @tc.desc      Comprehensive: Multiple instances + register + GC (independent callbacks)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test008_MultipleInstancesGC();
      expect(result).assertEqual("Test Passed: MultipleInstancesGCTest008");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0900
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0900
     * @tc.desc      Comprehensive: Target lifecycle end + GC (original target recycled)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test009_TargetLifecycleEndGC();
      expect(result).assertEqual("Test Passed: TargetLifecycleEndGCTest009");
    });

    /**
     * @tc.number    ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_1000
     * @tc.name      ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_1000
     * @tc.desc      Comprehensive: Frozen object target + register + GC (callback triggers)
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level 2
     */
    it('ArkUIX_SUB_SYMBOL2TEST_SYMBOL2TEST_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const result = await FinalizationRegistryComprehensiveUtils.test010_FrozenTargetRegisterGC();
      expect(result).assertEqual("Test Passed: FrozenTargetRegisterGCTest010");
    });


  })
}