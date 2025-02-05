/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@ohos.base';
import UIAbility from '@ohos.app.ability.UIAbility';

export const waitUiReadyMs: number = 1500;

export function sleep(delay: number = 1000): Promise<void> {
  return new Promise((resolve: Function) => {
    setTimeout(() => {
      resolve();
    }, delay);
  });
}

interface want {
  bundleName: string,
  abilityName: string,
  moduleName: string
}

const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

export async function startAbility(bundleName: string, abilityName: string): Promise<void> {
  let want: want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await delegator.startAbility(want).then((result: void) => {
    console.info(`WebViewTestCase, start abilityFinished: ${result}`);
  }).catch((err: BusinessError) => {
    console.error(`WebViewTestCase, start abilityFailed: ${err}`);
  })
}

export async function stopAbility(): Promise<void> {
  let topAbility: UIAbility = await delegator.getCurrentTopAbility();
  await topAbility.context.terminateSelf();
}