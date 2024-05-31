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

export default class Main2Ability extends Ability {
    onCreate(want, launchParam) {
        console.log("[Demo] Main2Ability onCreate")
        globalThis.abilityWant2 = want;
    }

    onDestroy() {
        console.log("[Demo] Main2Ability onDestroy")
    }

    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main2Ability onWindowStageCreate")
        globalThis.ability2 = this.context;
        // windowStage.setUIContent(this.context, "pages/index2", null)
        windowStage.loadContent('pages/index2', (err, data) => {
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
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main2Ability onForeground")
        setTimeout(function () {
            globalThis.ability2.terminateSelf()
                .then((data) => {
                    console.info('[Demo] Main2Ability terminateself succeeded: ' + data);
                }).catch((error) => {
                console.error('[Demo] Main2Ability terminateself failed. Cause: ' + error);
            })
        }, 1500);
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main2Ability onBackground")
    }
};
