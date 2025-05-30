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
import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

export default class Hap1Main2Ability extends Ability {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
        console.log("[Demo] Hap1Main2Ability onCreate")
        globalThis.ability2Hap1Want = want;
        setTimeout(() => {
            this.context.terminateSelf().then((data) => {
                console.log("Hap1Main2Ability EventTest terminateSelf data: " + JSON.stringify(data));
            }).catch((error:BusinessError) => {
                console.log("Hap1Main2Ability EventTest terminateSelf error: " + JSON.stringify(error));
            })
        }, 2000)
    }

    onDestroy() {
        console.log("[Demo] Hap1Main2Ability onDestroy")
    }

    onWindowStageCreate(windowStage: window.WindowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Hap1Main2Ability onWindowStageCreate")

        // windowStage.setUIContent(this.context, "pages/indexh1a2", null)

        windowStage.loadContent('pages/indexh1a2', (err, data) => {
            if (err.code) {
                console.log('Hap1Main2Ability loadContent error');
                return;
            }
            console.log('Hap1Main2Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Hap1Main2Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Hap1Main2Ability onForeground")
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Hap1Main2Ability onBackground")
    }
};