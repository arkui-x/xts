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
import { AbilityConstant, AbilityLifecycleCallback, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class Main6Ability extends Ability {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log("[Demo] Main6Ability onCreate")
        globalThis.abilityWant6 = want;
    }

    onDestroy() {
        console.log("[Demo] Main6Ability onDestroy")
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main6Ability onWindowStageCreate")
        globalThis.ability6 = this.context;
        // windowStage.setUIContent(this.context, "pages/index6", null)

        windowStage.loadContent('pages/index6', (err, data) => {
            if (err.code) {
                console.log('Main6Ability loadContent error');
                return;
            }
            console.log('Main6Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main6Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main6Ability onForeground")

        let listKey6:Array<string> = [];
        let abilityLifecycleCallback:AbilityLifecycleCallback = {
            onAbilityCreate(ability) {
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityCreate");
                listKey6.push(abilityname + " onAbilityCreate");
                console.log("[Demo] 1listKey6:" + JSON.stringify(listKey6));
            },
            onWindowStageCreate(ability, windowStage) {
                console.log("[Demo] AbilityLifecycleCallback6 onWindowStageCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback6 onWindowStageCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageCreate");
                listKey6.push(abilityname + " onWindowStageCreate");
                console.log("[Demo] 2listKey6:" + JSON.stringify(listKey6));
            },
            onWindowStageActive(ability, windowStage) {
                let abilityname = ability.context.abilityInfo.name;
                console.log(abilityname + " onWindowStageActive")
            },
            onWindowStageInactive(ability, windowStage) {
                let abilityname = ability.context.abilityInfo.name;
                console.log(abilityname + " onWindowStageInactive")
            },
            onWindowStageDestroy(ability, windowStage) {
                console.log("[Demo] AbilityLifecycleCallback6 onWindowStageDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback6 onWindowStageDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageDestroy");
                listKey6.push(abilityname + " onWindowStageDestroy");
                console.log("[Demo] 3listKey6:" + JSON.stringify(listKey6));
            },
            onAbilityDestroy(ability) {
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityDestroy");
                listKey6.push(abilityname + " onAbilityDestroy");
                console.log("[Demo] 4listKey6:" + JSON.stringify(listKey6));
            },
            onAbilityForeground(ability) {
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityForeground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityForeground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityForeground");
                listKey6.push(abilityname + " onAbilityForeground");
                console.log("[Demo] 5listKey6:" + JSON.stringify(listKey6));
            },
            onAbilityBackground(ability) {
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityBackground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityBackground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityBackground");
                listKey6.push(abilityname + " onAbilityBackground");
                console.log("[Demo] 6listKey6:" + JSON.stringify(listKey6));
            },
            onAbilityContinue(ability) {
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityContinue ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback6 onAbilityContinue abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityContinue");
                listKey6.push(abilityname + " onAbilityContinue");
                console.log("[Demo] 7listKey6:" + JSON.stringify(listKey6));
            }
        }
        globalThis.applicationContext6 = this.context.getApplicationContext();
        // let lifecycleid = globalThis.applicationContext6.registerAbilityLifecycleCallback(AbilityLifecycleCallback);
        let lifecycleid:number = globalThis.applicationContext6.on('abilityLifecycle', abilityLifecycleCallback);
        console.log("[Demo] registerAbilityLifecycleCallback6 number: " + JSON.stringify(lifecycleid));
        setTimeout(() => {
            console.log("[Demo] registerAbilityLifecycleCallback6 listKey: " + JSON.stringify(listKey6));
            globalThis.list6 = listKey6;
            globalThis.callbackid6 = lifecycleid;
        }, 1500);
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main6Ability onBackground")
    }
};
