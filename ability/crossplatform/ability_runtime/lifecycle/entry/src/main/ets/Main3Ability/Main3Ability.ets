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

export default class Main3Ability extends Ability {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log("[Demo] Main3Ability onCreate")
        globalThis.abilityWant3 = want;

        console.log("[Demo] Main3Ability context: " + JSON.stringify(this.context));
        let listKey3:Array<string> = [];
        let abilityLifecycleCallback:AbilityLifecycleCallback = {
            onAbilityCreate(ability) {
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityCreate");
                listKey3.push(abilityname + " onAbilityCreate");
                console.log("[Demo] 1listKey3:" + JSON.stringify(listKey3));
            },
            onWindowStageCreate(ability, windowStage) {
                console.log("[Demo] AbilityLifecycleCallback3 onWindowStageCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback3 onWindowStageCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageCreate");
                listKey3.push(abilityname + " onWindowStageCreate");
                console.log("[Demo] 2listKey3:" + JSON.stringify(listKey3));
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
                console.log("[Demo] AbilityLifecycleCallback3 onWindowStageDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback3 onWindowStageDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageDestroy");
                listKey3.push(abilityname + " onWindowStageDestroy");
                console.log("[Demo] 3listKey3:" + JSON.stringify(listKey3));
            },
            onAbilityDestroy(ability) {
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityDestroy");
                listKey3.push(abilityname + " onAbilityDestroy");
                console.log("[Demo] 4listKey3:" + JSON.stringify(listKey3));
            },
            onAbilityForeground(ability) {
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityForeground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityForeground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityForeground");
                listKey3.push(abilityname + " onAbilityForeground");
                console.log("[Demo] 5listKey3:" + JSON.stringify(listKey3));
            },
            onAbilityBackground(ability) {
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityBackground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityBackground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityBackground");
                listKey3.push(abilityname + " onAbilityBackground");
                console.log("[Demo] 6listKey3:" + JSON.stringify(listKey3));
            },
            onAbilityContinue(ability) {
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityContinue ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback3 onAbilityContinue abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityContinue");
                listKey3.push(abilityname + " onAbilityContinue");
                console.log("[Demo] 7listKey3:" + JSON.stringify(listKey3));
            }
        }
        globalThis.applicationContext3 = this.context.getApplicationContext();
        // let lifecycleid = globalThis.applicationContext3.registerAbilityLifecycleCallback(AbilityLifecycleCallback);
        let lifecycleid:number = globalThis.applicationContext3.on('abilityLifecycle', abilityLifecycleCallback);
        console.log("[Demo] registerAbilityLifecycleCallback3 number: " + JSON.stringify(lifecycleid));
        setTimeout(() => {
            console.log("[Demo] registerAbilityLifecycleCallback3 listKey : " + JSON.stringify(listKey3));
            globalThis.list3 = listKey3;
            globalThis.callbackid3 = lifecycleid;
        }, 2000);
    }

    onDestroy() {
        console.log("[Demo] Main3Ability onDestroy")
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main3Ability onWindowStageCreate")
        globalThis.ability3 = this.context
        // windowStage.setUIContent(this.context, "pages/index3", null)

        windowStage.loadContent('pages/index3', (err, data) => {
            if (err.code) {
                console.log('Main3Ability loadContent error');
                return;
            }
            console.log('Main3Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main3Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] MainAbility onForeground")
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] MainAbility onBackground")
    }
};
