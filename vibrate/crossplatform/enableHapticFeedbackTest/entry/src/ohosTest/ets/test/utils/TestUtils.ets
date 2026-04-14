/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { ON, Driver } from '@ohos.UiTest';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';

export const WAIT_PAGE_READY_MS_500 = 500;
export const WAIT_PAGE_READY_MS_1000 = 1000;
export const WAIT_PAGE_READY_MS_1500 = 1500;
export const WAIT_PAGE_READY_MS_2000 = 2000;

const delegator = abilityDelegatorRegistry.getAbilityDelegator();

function validateRequiredStringParam(paramName: string, paramValue: string) {
  if (paramValue === null || paramValue === undefined || paramValue.trim().length === 0) {
    console.error(`Invalid parameter: ${paramName} cannot be null, undefined, or empty`);
    return false;
  }
  return true;
}

export const driver = Driver.create();

export async function startAbility(bundleName: string, abilityName: string) {
  if (!validateRequiredStringParam('bundleName', bundleName) || !validateRequiredStringParam('abilityName', abilityName)) {
    return;
  }

  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: 'entry'
  };

  await delegator.startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`);
  }).catch((err: object) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`);
  });
  await driver.delayMs(WAIT_PAGE_READY_MS_2000);
}

export async function openTestPage(pageId: string) {
  if (!validateRequiredStringParam('pageId', pageId)) {
    return;
  }

  let goPage = await driver.findComponent(ON.id(pageId));
  await goPage.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1500);
}

export async function terminateTopAbility() {
  let topAbility = await delegator.getCurrentTopAbility();
  await topAbility.context.terminateSelf();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
}

export async function clickButton(buttonId: string) {
  if (!validateRequiredStringParam('buttonId', buttonId)) {
    return;
  }

  let button = await driver.findComponent(ON.id(buttonId));
  await button.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_500);
}

export async function sendClickEvent(key: string) {
  if (!validateRequiredStringParam('key', key)) {
    return;
  }

  sendEventByKey(key, 10, '');
  await driver.delayMs(WAIT_PAGE_READY_MS_500);
}
