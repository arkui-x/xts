/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import Ability from '@ohos.app.ability.UIAbility'

export default class Main9Ability extends Ability {
    onCreate(want, launchParam) {
        console.log("[Demo] Main9Ability onCreate")
        globalThis.abilityWant9 = want;
    }

    onDestroy() {
        console.log("[Demo] Main9Ability onDestroy")
    }

    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main9Ability onWindowStageCreate")

        // windowStage.setUIContent(this.context, "pages/index9", null)

        windowStage.loadContent('pages/index9', (err, data) => {
            if (err.code) {
                console.log('Main9Ability loadContent error');
                return;
            }
            console.log('Main9Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main9Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main9Ability onForeground")

        var listKey9 = [];
        var abilityName = "";
        let AbilityLifecycleCallback = {
            onAbilityCreate(ability) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onAbilityCreate")
                listKey9.push(abilityName + " onAbilityCreate");
            },
            onWindowStageCreate(ability, windowStage) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onWindowStageCreate")
                listKey9.push(abilityName + " onWindowStageCreate");
            },
            onWindowStageActive(ability, windowStage) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onWindowStageActive")
            },
            onWindowStageInactive(ability, windowStage) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onWindowStageInactive")
            },
            onAbilityForeground(ability) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onAbilityForeground")
                listKey9.push(abilityName + " onAbilityForeground");
            },
            onAbilityBackground(ability) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onAbilityBackground")
                listKey9.push(abilityName + " onAbilityBackground");
            },
            onWindowStageDestroy(ability, windowStage) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onWindowStageDestroy")
                listKey9.push(abilityName + " onWindowStageDestroy");
            },
            onAbilityDestroy(ability) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onAbilityDestroy")
                listKey9.push(abilityName + " onAbilityDestroy");
            },
            onAbilityContinue(ability) {
                abilityName = ability.context.abilityInfo.name;
                console.log(abilityName + " onAbilityContinue")
                listKey9.push(abilityName + " onAbilityContinue");
            }
        }
        globalThis.applicationContext9 = this.context.getApplicationContext();
        // var callBackId = globalThis.applicationContext9
        //     .registerAbilityLifecycleCallback(AbilityLifecycleCallback);
        var callBackId = globalThis.applicationContext9.on('abilityLifecycle', AbilityLifecycleCallback);

        console.log("callBackId is aaa :" + callBackId);
        setTimeout(() => {
            globalThis.Main9AbilityListKey = listKey9
            globalThis.Main9AbilityCallBackId = callBackId
            console.log("listKey is :" + listKey9);
            console.log("callBackId is :" + callBackId);
        }, 3000)
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main9Ability onBackground")
    }
};
