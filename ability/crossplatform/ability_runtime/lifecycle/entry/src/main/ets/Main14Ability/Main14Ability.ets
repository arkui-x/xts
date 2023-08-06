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

export default class Main14Ability extends Ability {
    onCreate(want, launchParam) {
        console.log("[Demo] Main14Ability onCreate")
        globalThis.abilityWant14 = want;
    }

    onDestroy() {
        console.log("[Demo] Main14Ability onDestroy")
    }

    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] Main14Ability onWindowStageCreate")
        globalThis.ability14 = this.context;
        // windowStage.setUIContent(this.context, "pages/index2", null)
        windowStage.loadContent('pages/index2', (err, data) => {
            if (err.code) {
                console.log('Main14Ability loadContent error');
                return;
            }
            console.log('Main14Ability loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] Main14Ability onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] Main14Ability onForeground")
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] Main14Ability onBackground")
    }
};
