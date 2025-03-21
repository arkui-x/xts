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
import { AbilityConstant, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

let abilityName:string = "";
function recordLife(ownList:Array<string>, abilityName:string, lifeName:string) {
    ownList.push(abilityName + ' ' + lifeName);
}

export default class Main2Ability extends Ability {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log("[Demo] Main2Ability onCreate")
        abilityName = want.abilityName as string
        globalThis.list2 = [];
        recordLife(globalThis.list2, abilityName, 'onCreate');
    }

    onDestroy() {
        console.log("[Demo] Main2Ability onDestroy")
        recordLife(globalThis.list2, abilityName, 'onDestroy');
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main2Ability onWindowStageCreate")
        globalThis.ability2context = this.context;
        recordLife(globalThis.list2, abilityName, 'onWindowStageCreate');

        windowStage.loadContent('pages/Index2', (err, data) => {
            if (err.code) {
                console.log('Main2Ability loadContent error');
                return;
            }
            console.log('Main2Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main2Ability onWindowStageDestroy")
        recordLife(globalThis.list2, abilityName, 'onWindowStageDestroy');
    }

    onForeground() {
        console.log("[Demo] Main2Ability onForeground")
        recordLife(globalThis.list2, abilityName, 'onForeground');
        setTimeout( () => {
            console.log("[Demo] Main2Ability onForeground after 1500ms")
            globalThis.ability2context.terminateSelf()
                .then((data:ESObject) => {
                    console.info('[Demo] Main2Ability terminateself succeeded: ' + data);
                }).catch((error:BusinessError) => {
                console.error('[Demo] Main2Ability terminateself failed. Cause: ' + error);
            })
        }, 1500);
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main2Ability onBackground")
        recordLife(globalThis.list2, abilityName, 'onBackground');
    }
};
