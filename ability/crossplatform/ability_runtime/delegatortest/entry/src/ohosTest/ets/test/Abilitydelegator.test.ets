/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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
import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, } from "@ohos/hypium";
import AbilityDelegatorRegistry from "@ohos.app.ability.abilityDelegatorRegistry";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function AbilityDelegatorTest() {
  describe("AbilityDelegatorTest", () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number GET_ABILITY_DELEGATOR_0001
     * @tc.name getAbilityDelegator0001
     * @tc.desc test getAbilityDelegator
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("GET_ABILITY_DELEGATOR_0001", 0, async (done: Function) => {
      const abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      expect(abilityDelegator != null).assertTrue();
      abilityDelegator.printSync("GET_ABILITY_DELEGATOR_0001 pass");
      done();
    });

    /**
     * @tc.number GET_ARGUMENTS_0001
     * @tc.name getArguments0001
     * @tc.desc test getArguments
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("GET_ARGUMENTS_0001", 0, async (done: Function) => {
      const abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      const abilityDelegatorArguments = AbilityDelegatorRegistry.getArguments();
      let bundleName = abilityDelegatorArguments.bundleName;
      let testRunnerClassName = abilityDelegatorArguments.testRunnerClassName;
      let parameters = abilityDelegatorArguments.parameters;
      let moduleName = parameters["moduleName"];
      abilityDelegator.printSync(
        "GET_ARGUMENTS_0001 bundleName: " + bundleName
      );
      abilityDelegator.printSync(
        "GET_ARGUMENTS_0001 testRunnerClassName: " + testRunnerClassName
      );
      abilityDelegator.printSync(
        "GET_ARGUMENTS_0001 moduleName: " + moduleName
      );
      expect(bundleName).assertEqual("com.example.delegatortest");
      expect(testRunnerClassName).assertContain("OpenHarmonyTestRunner");
      expect(moduleName == null).assertFalse();
      abilityDelegator.printSync("GET_ARGUMENTS_0001 pass");
      done();
    });
  });
}
