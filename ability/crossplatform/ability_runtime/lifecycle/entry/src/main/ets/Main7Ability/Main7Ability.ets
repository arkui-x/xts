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

export default class Main7Ability extends Ability {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log("[Demo] Main7Ability onCreate")
        globalThis.abilityWant7 = want;
    }

    onDestroy() {
        console.log("[Demo] Main7Ability onDestroy")
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main7Ability onWindowStageCreate")
        globalThis.ability7 = this.context;
        // windowStage.setUIContent(this.context, "pages/index7", null)

        windowStage.loadContent('pages/index7', (err, data) => {
            if (err.code) {
                console.log('Main7Ability loadContent error');
                return;
            }
            console.log('Main7Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main7Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main7Ability onForeground")

        let listKey7:Array<string> = [];
        let abilityLifecycleCallback:AbilityLifecycleCallback = {
            onAbilityCreate(ability) {
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityCreate");
                listKey7.push(abilityname + " onAbilityCreate");
                console.log("[Demo] 1listKey7:" + JSON.stringify(listKey7));
            },
            onWindowStageCreate(ability, windowStage) {
                console.log("[Demo] AbilityLifecycleCallback7 onWindowStageCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback7 onWindowStageCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageCreate");
                listKey7.push(abilityname + " onWindowStageCreate");
                console.log("[Demo] 2listKey7:" + JSON.stringify(listKey7));
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
                console.log("[Demo] AbilityLifecycleCallback7 onWindowStageDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback7 onWindowStageDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageDestroy");
                listKey7.push(abilityname + " onWindowStageDestroy");
                console.log("[Demo] 3listKey7:" + JSON.stringify(listKey7));
            },
            onAbilityDestroy(ability) {
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityDestroy");
                listKey7.push(abilityname + " onAbilityDestroy");
                console.log("[Demo] 4listKey7:" + JSON.stringify(listKey7));
            },
            onAbilityForeground(ability) {
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityForeground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityForeground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityForeground");
                listKey7.push(abilityname + " onAbilityForeground");
                console.log("[Demo] 5listKey7:" + JSON.stringify(listKey7));
            },
            onAbilityBackground(ability) {
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityBackground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityBackground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityBackground");
                listKey7.push(abilityname + " onAbilityBackground");
                console.log("[Demo] 6listKey7:" + JSON.stringify(listKey7));
            },
            onAbilityContinue(ability) {
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityContinue ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback7 onAbilityContinue abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityContinue");
                listKey7.push(abilityname + " onAbilityContinue");
                console.log("[Demo] 7listKey7:" + JSON.stringify(listKey7));
            }
        }
        globalThis.applicationContext7 = this.context.getApplicationContext();
        // let lifecycleid = globalThis.applicationContext7.registerAbilityLifecycleCallback(AbilityLifecycleCallback);
        let lifecycleid:number = globalThis.applicationContext7.on('abilityLifecycle', abilityLifecycleCallback);
        console.log("[Demo] AbilityLifecycleCallback7 number: " + JSON.stringify(lifecycleid));
        setTimeout(() => {
            console.log("[Demo] AbilityLifecycleCallback7 listKey: " + JSON.stringify(listKey7));
            globalThis.list7 = listKey7;
            globalThis.callbackid7 = lifecycleid;
        }, 1500);
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main7Ability onBackground")
    }
};
