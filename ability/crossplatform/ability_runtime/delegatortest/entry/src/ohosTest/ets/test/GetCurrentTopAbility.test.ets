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
import {
  afterAll,
  afterEach,
  beforeAll,
  beforeEach,
  describe,
  expect,
  it,
} from "@ohos/hypium";
import AbilityDelegatorRegistry from "@ohos.app.ability.abilityDelegatorRegistry";
import Want from "@ohos.app.ability.Want";
import { BusinessError } from "@kit.BasicServicesKit";

let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
const START_ABILITY_TIMEOUT_TWO_THOUSAND = 2000;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function GetCurrentTopAbilityTest() {
  describe("GetCurrentTopAbilityTest", () => {
    beforeAll(() => {
      let want: Want = {
        abilityName: "MainAbility",
        bundleName: "com.example.delegatortest",
        moduleName: "entry",
      };
      abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      abilityDelegator.startAbility(want);
    });

    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number: ACTS_GET_CURRENT_TOP_ABILITY_CALL_BACK_0001
     * @tc.name  : actsGetCurrentTopAbilityCallback0001
     * @tc.desc  : Test the api "abilityDelegator.getCurrentTopAbility", return the uiAbility state result.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("ACTS_GET_CURRENT_TOP_ABILITY_CALL_BACK_0001", 0, async (done: Function) => {
      let abilityDelegator:AbilityDelegatorRegistry.AbilityDelegator;
      abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let want: Want = {
        abilityName: "Main4Ability",
        bundleName: "com.example.delegatortest",
        moduleName: "entry",
      };
      setTimeout(() => {
        abilityDelegator.startAbility(want, () => {
          setTimeout(() => {
            abilityDelegator.getCurrentTopAbility((err, ability2) => {
              if (ability2 != null) {
                abilityDelegator.printSync(
                  "ACTS_GetCurrentTopAbility_CALLBACK_0001 getCurrentTopAbility2: " +
                    ability2.context.abilityInfo.name
                );
                expect(ability2.context.abilityInfo.name).assertEqual(
                  "Main4Ability"
                );
                done();
              } else {
                abilityDelegator.printSync(
                  "ACTS_GetCurrentTopAbility_CALLBACK_0001 getCurrentTopAbility2 not found."
                );
                expect().assertFail();
                done();
              }
            });
          }, START_ABILITY_TIMEOUT_TWO_THOUSAND);
        });
      }, START_ABILITY_TIMEOUT_TWO_THOUSAND);
    });

    /**
     * @tc.number: ACTS_GET_CURRENT_TOP_ABILITY_PROMISE_0002
     * @tc.name  : actsGetCurrentTopAbilityCallback0002
     * @tc.desc  : Test the api "abilityDelegator.getCurrentTopAbility", return the uiAbility state result.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it("ACTS_GET_CURRENT_TOP_ABILITY_PROMISE_0002", 0, async (done: Function) => {
      let abilityDelegator:AbilityDelegatorRegistry.AbilityDelegator;
      abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let want: Want = {
        abilityName: "Main3Ability",
        bundleName: "com.example.delegatortest",
        moduleName: "entry",
      };
      abilityDelegator.printSync(
        "ACTS_GET_CURRENT_TOP_ABILITY_PROMISE_0002 getCurrentTopAbility start"
      );
      abilityDelegator.startAbility(want);
      setTimeout(() => {
        abilityDelegator
          .getCurrentTopAbility()
          .then((ability) => {
            if (ability != null) {
              abilityDelegator.printSync(
                "ACTS_GET_CURRENT_TOP_ABILITY_PROMISE_0002 getCurrentTopAbility1: " +
                  ability.context.abilityInfo.name
              );
              expect(ability.context.abilityInfo.name).assertEqual(
                "Main3Ability"
              );
              done();
            } else {
              abilityDelegator.printSync(
                "ACTS_GET_CURRENT_TOP_ABILITY_PROMISE_0002 getCurrentTopAbility1 not found ability1."
              );
              expect().assertFail();
              done();
            }
          })
          .catch((error:BusinessError) => {
            abilityDelegator.printSync(
              "ACTS_GET_CURRENT_TOP_ABILITY_PROMISE_0002 catch error: " + error
            );
          });
      }, START_ABILITY_TIMEOUT_TWO_THOUSAND);
    });
  });
}
