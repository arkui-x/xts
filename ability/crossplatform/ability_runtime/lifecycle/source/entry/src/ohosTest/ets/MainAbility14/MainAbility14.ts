/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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

export default class MainAbility14 extends Ability {
    onCreate(want, launchParam) {
        console.log("[Demo] MainAbility14 onCreate")
        globalThis.abilityWant14 = want;
    }

    onDestroy() {
        console.log("[Demo] MainAbility14 onDestroy")
    }

    onWindowStageCreate(windowStage) {
        // Main window is created, set main page for this ability
        console.log("[Demo] MainAbility14 onWindowStageCreate")
        globalThis.ability14 = this.context;
        // windowStage.setUIContent(this.context, "testability/pages/index2", null)
        windowStage.loadContent('testability/pages/index2', (err, data) => {
            if (err.code) {
                console.log('MainAbility14 loadContent error');
                return;
            }
            console.log('MainAbility14 loadContent success');
        });
    }

    onWindowStageDestroy() {
        // Main window is destroyed, release UI related resources
        console.log("[Demo] MainAbility14 onWindowStageDestroy")
    }

    onForeground() {
        // Ability has brought to foreground
        console.log("[Demo] MainAbility14 onForeground")
    }

    onBackground() {
        // Ability has back to background
        console.log("[Demo] MainAbility14 onBackground")
    }
};
