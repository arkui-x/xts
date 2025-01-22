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

import TestRunner from '@ohos.application.testRunner';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import { BusinessError } from '@ohos.base';

async function onAbilityCreateCallback(): Promise<void> {
    console.log('onAbilityCreateCallback');
}

async function addAbilityMonitorCallback(err: BusinessError): Promise<void> {
    console.log('addAbilityMonitorCallback');
}

export default class OpenHarmonyTestRunner implements TestRunner {
    constructor() {
    }

    onPrepare(): void {
        console.log('onPrepare');
    }

    async onRun(): Promise<void> {
        console.log('onRun');
        const abilityDelegator: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
        const abilityDelegatorArguments: AbilityDelegatorRegistry.AbilityDelegatorArgs = AbilityDelegatorRegistry.getArguments();
        const bundleName: string = abilityDelegatorArguments.bundleName;
        const parameters: Record<string, string> = abilityDelegatorArguments.parameters;
        const moduleName: string = parameters["moduleName"];
        const lMonitor: AbilityDelegatorRegistry.AbilityMonitor = {
            abilityName: "TestAbility",
            onAbilityCreate: onAbilityCreateCallback,
        };
        abilityDelegator.addAbilityMonitor(lMonitor, addAbilityMonitorCallback);
        let want: Want = {
            abilityName: "TestAbility",
            bundleName: bundleName,
            moduleName: moduleName
        };
        abilityDelegator.startAbility(want, (err: BusinessError) => {
            console.log('startAbility' + err);
        });
    }
}