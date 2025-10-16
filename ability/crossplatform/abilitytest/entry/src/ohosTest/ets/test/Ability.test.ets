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
import { describe, it, expect, Level, TestType, Size } from '@ohos/hypium';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import common from '@ohos.app.ability.common';
import { AbilityLifecycleCallback } from '@kit.AbilityKit';
import commonEventManager from '@ohos.commonEventManager';

function sleep(time: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, time));
}

export default function abilityTest() {
  let TAG = "";
  let lifeCallback: AbilityLifecycleCallback = {
    onAbilityCreate: (ability) => {
    },
    onAbilityWillCreate: (ability) => {
    },
    onWindowStageCreate: (ability, window) => {
    },
    onWindowStageWillCreate: (ability, window) => {
    },
    onWillNewWant: (ability) => {
    },
    onNewWant: (ability) => {
    },
    onWindowStageActive: (ability, window) => {
    },
    onWindowStageInactive: (ability, window) => {
    },
    onWindowStageDestroy: (ability, window) => {
    },
    onWindowStageWillDestroy: (ability, window) => {
    },
    onAbilityDestroy: (ability) => {
    },
    onAbilityWillDestroy: (ability) => {
    },
    onAbilityForeground: (ability) => {
    },
    onAbilityWillForeground: (ability) => {
    },
    onAbilityBackground: (ability) => {
    },
    onAbilityWillBackground: (ability) => {
    },
    onAbilityContinue: (ability) => {
    },
    onAbilityWillContinue: (ability) => {
    },
    onWindowStageWillRestore: (ability, window) => {
    },
    onWindowStageRestore: (ability, window) => {
    },
    onAbilityWillSaveState: (ability) => {
    },
    onAbilitySaveState: (ability) => {
    }
  }

  describe('ActsChainApplicationContext', () => {
    /**
     * @tc.number : SUB_ABILITY_AbilityRuntime_ApplicationContext_0100
     * @tc.name   : testAbilityAbilityRuntimeApplicationContext0100
     * @tc.desc   : Test ApplicationContext off method
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testAbilityAbilityRuntimeApplicationContext0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      TAG = "SUB_Ability_AbilityRuntime_ApplicationContext_0100 ";
      console.log(TAG + " start");
      let appContext: common.ApplicationContext =
        abilityDelegatorRegistry.getAbilityDelegator().getAppContext().getApplicationContext().getApplicationContext();
      let id: number = appContext.on('abilityLifecycle', lifeCallback);
      console.log(TAG + "id=" + id);
      await sleep(1000);
      console.log(TAG + " start off");
      appContext.off('abilityLifecycle', id, (error, data) => {
        if (error) {
          console.log(TAG + " error " + JSON.stringify(error));
          expect().assertFail();
        } else {
          console.log(TAG + " off success");
          expect(error).assertNull();
        }
      })
    })
  })
}