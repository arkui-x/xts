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

export default class Main11Ability extends Ability {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log("[Demo] Main11Ability onCreate")
        globalThis.abilityWant11 = want;
        globalThis.ability11 = this.context;
        let listKey11:Array<string> = [];
        let abilityLifecycleCallback:AbilityLifecycleCallback = {
            onAbilityCreate(ability) {
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback11 onAbilityCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityCreate");
                listKey11.push(abilityname + " onAbilityCreate");
            },
            onWindowStageCreate(ability, windowStage) {
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback11 onWindowStageCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageCreate");
                listKey11.push(abilityname + " onWindowStageCreate");
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
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback11 onWindowStageDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageDestroy");
                listKey11.push(abilityname + " onWindowStageDestroy");
            },
            onAbilityDestroy(ability) {
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback11 onAbilityDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityDestroy");
                listKey11.push(abilityname + " onAbilityDestroy");
            },
            onAbilityForeground(ability) {
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback11 onAbilityForeground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityForeground");
                listKey11.push(abilityname + " onAbilityForeground");
            },
            onAbilityBackground(ability) {
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback11 onAbilityBackground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityBackground");
                listKey11.push(abilityname + " onAbilityBackground");
            },
            onAbilityContinue(ability) {
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback11 onAbilityContinue abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityContinue");
                listKey11.push(abilityname + " onAbilityContinue");
            }
        }
        globalThis.applicationContext11 = this.context.getApplicationContext();
        // let lifecycleid = globalThis.applicationContext11.registerAbilityLifecycleCallback(AbilityLifecycleCallback);
        let lifecycleid:number = globalThis.applicationContext11.on('abilityLifecycle', abilityLifecycleCallback);
        console.log("[Demo] registerAbilityLifecycleCallback11 number: " + JSON.stringify(lifecycleid));
        setTimeout(() => {
            console.log("[Demo] registerAbilityLifecycleCallback11 listKey: " + JSON.stringify(listKey11));
            globalThis.list11 = listKey11;
            globalThis.callbackid11 = lifecycleid;
        }, 2000);
    }

    onDestroy() {
        console.log("[Demo] Main11Ability onDestroy")
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main11Ability onWindowStageCreate")

        // windowStage.setUIContent(this.context, "pages/index11", null)

        windowStage.loadContent('pages/index11', (err, data) => {
            if (err.code) {
                console.log('Main11Ability loadContent error');
                return;
            }
            console.log('Main11Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main11Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main11Ability onForeground")
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] MainAbility onBackground")
    }
};
