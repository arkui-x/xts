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
import { describe, it, expect, TestType, Size, Level } from "@ohos/hypium";
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

export default function abilityTest() {
  describe('ActsGetAbilityStateStageTest', () => {
    /**
     * @tc.number : SUB_Ability_AbilityLifecycleState_ENUM_0100
     * @tc.name   : testAbilityAbilityLifecycleStateEnum0100
     * @tc.desc   : AbilityLifecycleState EnumValue
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testAbilityAbilityLifecycleStateEnum0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (): Promise<void> => {
        expect(abilityDelegatorRegistry.AbilityLifecycleState.UNINITIALIZED + '').assertEqual('0');
        expect(abilityDelegatorRegistry.AbilityLifecycleState.CREATE + '').assertEqual('1');
        expect(abilityDelegatorRegistry.AbilityLifecycleState.DESTROY + '').assertEqual('4');
      });
  })
}
