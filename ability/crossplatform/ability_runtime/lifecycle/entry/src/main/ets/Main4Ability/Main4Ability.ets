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
import { BusinessError } from '@kit.BasicServicesKit';

export default class Main4Ability extends Ability {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log("[Demo] Main4Ability onCreate")
        globalThis.abilityWant4 = want;

        console.log("[Demo] Main4Ability context: " + JSON.stringify(this.context));
        let listKey4:Array<string> = [];
        let abilityLifecycleCallback:AbilityLifecycleCallback = {
            onAbilityCreate(ability) {
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityCreate");
                listKey4.push(abilityname + " onAbilityCreate");
                console.log("[Demo] 1listKey4:" + JSON.stringify(listKey4));
            },
            onWindowStageCreate(ability, windowStage) {
                console.log("[Demo] AbilityLifecycleCallback4 onWindowStageCreate ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback4 onWindowStageCreate abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageCreate");
                listKey4.push(abilityname + " onWindowStageCreate");
                console.log("[Demo] 2listKey4:" + JSON.stringify(listKey4));
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
                console.log("[Demo] AbilityLifecycleCallback4 onWindowStageDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback4 onWindowStageDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onWindowStageDestroy");
                listKey4.push(abilityname + " onWindowStageDestroy");
                console.log("[Demo] 3listKey4:" + JSON.stringify(listKey4));
            },
            onAbilityDestroy(ability) {
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityDestroy ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityDestroy abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityDestroy");
                listKey4.push(abilityname + " onAbilityDestroy");
                console.log("[Demo] 4listKey4:" + JSON.stringify(listKey4));
            },
            onAbilityForeground(ability) {
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityForeground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityForeground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityForeground");
                listKey4.push(abilityname + " onAbilityForeground");
                console.log("[Demo] 5listKey4:" + JSON.stringify(listKey4));
            },
            onAbilityBackground(ability) {
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityBackground ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityBackground abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityBackground");
                listKey4.push(abilityname + " onAbilityBackground");
                console.log("[Demo] 6listKey4:" + JSON.stringify(listKey4));
            },
            onAbilityContinue(ability) {
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityContinue ability:"
                + JSON.stringify(ability));
                let abilityname = ability.context.abilityInfo.name;
                console.log("[Demo] AbilityLifecycleCallback4 onAbilityContinue abilityname:"
                + JSON.stringify(abilityname));
                console.log("[Demo] " + abilityname + " onAbilityContinue");
                listKey4.push(abilityname + " onAbilityContinue");
                console.log("[Demo] 7listKey4:" + JSON.stringify(listKey4));
            }
        }
        globalThis.applicationContext4 = this.context.getApplicationContext();
        // let lifecycleid = globalThis.applicationContext4.registerAbilityLifecycleCallback(AbilityLifecycleCallback);
        let lifecycleid:number = globalThis.applicationContext4.on('abilityLifecycle', abilityLifecycleCallback);
        console.log("[Demo] registerAbilityLifecycleCallback4 number: " + JSON.stringify(lifecycleid));
        globalThis.callbackid4 = lifecycleid;
        setTimeout(() => {
            console.log("[Demo] registerAbilityLifecycleCallback4 listKey : " + JSON.stringify(listKey4));
            globalThis.list4 = listKey4;
        }, 1500);
    }

    onDestroy() {
        console.log("[Demo] Main4Ability onDestroy")
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main4Ability onWindowStageCreate")
        globalThis.ability4 = this.context;
        // windowStage.setUIContent(this.context, "pages/index4", null)

        windowStage.loadContent('pages/index4', (err, data) => {
            if (err.code) {
                console.log('Main4Ability loadContent error');
                return;
            }
            console.log('Main4Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main4Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main4Ability onForeground")
        setTimeout(() => {
            globalThis.ability4.terminateSelf()
                .then((data:ESObject) => {
                    console.info('[Demo] Main4Ability terminateself succeeded: ' + data);
                }).catch((error:BusinessError) => {
                console.error('[Demo] Main4Ability terminateself failed. Cause: ' + error);
            })
        }, 5000);
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main4Ability onBackground")
    }
};
