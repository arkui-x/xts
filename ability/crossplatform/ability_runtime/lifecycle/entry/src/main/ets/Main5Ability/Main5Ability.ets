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

export default class Main5Ability extends Ability {
    onCreate(want, launchParam) {
        console.log("[Demo] Main5Ability onCreate")
        globalThis.abilityWant5 = want;
    }

    onDestroy() {
        console.log("[Demo] Main5Ability onDestroy")
    }

    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main5Ability onWindowStageCreate")
        globalThis.ability5 = this.context;
        // windowStage.setUIContent(this.context, "pages/index5", null)

        windowStage.loadContent('pages/index5', (err, data) => {
            if (err.code) {
                console.log('Main5Ability loadContent error');
                return;
            }
            console.log('Main5Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main5Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main5Ability onForeground")
        setTimeout(function () {
            globalThis.ability5.terminateSelf()
                .then((data) => {
                    console.info('[Demo] Main5Ability terminateself succeeded: ' + data);
                }).catch((error) => {
                console.error('[Demo] Main5Ability terminateself failed. Cause: ' + error);
            })
        }, 500);
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main5Ability onBackground")
    }
};
