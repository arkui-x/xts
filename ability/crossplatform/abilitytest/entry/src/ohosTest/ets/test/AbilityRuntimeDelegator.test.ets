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
import { describe, it, expect, Level,  TestType, Size } from "@ohos/hypium";
import AbilityDelegatorRegistry from "@ohos.app.ability.abilityDelegatorRegistry";

export default function AbilityDelegatorTest() {
  describe("AbilityDelegatorTest", () => {
    /**
     * @tc.number : SUB_ABILITY_AbilityDelegatorRegistry_TestCaseNames_0100
     * @tc.name   : testAbilityAbilityDelegatorRegistryTestCaseNames0100
     * @tc.desc   : test testCaseNames property
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("testAbilityAbilityDelegatorRegistryTestCaseNames0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (): Promise<void> => {
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let abilityDelegatorArguments = AbilityDelegatorRegistry.getArguments();
      let testCaseNames: string = abilityDelegatorArguments.testCaseNames;
      expect(testCaseNames).assertEqual("");
      abilityDelegator.printSync("GET_ARGUMENTS_0100 pass");
    });
  });
}
