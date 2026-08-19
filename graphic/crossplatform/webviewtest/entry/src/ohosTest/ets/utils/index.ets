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
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';
import UIAbility from '@ohos.app.ability.UIAbility';
import { Component, Driver, ON } from '@ohos.UiTest';

export const waitUiReadyMs: number = 1500;
export const dialogWaitMs: number = 3000;
export const permissionWaitMs: number = 5000;

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

/**
 * 应用拉起后立即申请测试所需权限，系统权限弹窗在用例执行前出现并处理，
 * 避免弹窗出现在用例执行中途导致 UiTest 自动化失败。
 */
export async function requestPermissions(): Promise<void> {
  const topAbility: UIAbility = await delegator.getCurrentTopAbility();
  const atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
  try {
    await atManager.requestPermissionsFromUser(topAbility.context,
      ['ohos.permission.CAMERA', 'ohos.permission.MICROPHONE']);
  } catch (err) {
    console.error(`requestPermissionsFromUser failed: ${JSON.stringify(err)}`);
  }
}

export async function clickDialogButton(driver: Driver, label: string): Promise<void> {
  const variants: string[] = [label, label.toUpperCase()];
  const deadline: number = Date.now() + dialogWaitMs;
  while (Date.now() < deadline) {
    for (const text of variants) {
      const button: Component = await driver.findComponent(ON.text(text));
      if (button) {
        await button.click();
        return;
      }
    }
    await driver.delayMs(300);
  }
  throw new Error(`Dialog button not found: ${label}`);
}

export async function dismissDialog(driver: Driver): Promise<void> {
  await driver.pressBack();
  await driver.delayMs(waitUiReadyMs);
}

export async function waitForIdText(driver: Driver, id: string, matcher: (text: string) => boolean,
  timeoutMs: number = dialogWaitMs): Promise<string> {
  const deadline: number = Date.now() + timeoutMs;
  while (Date.now() < deadline) {
    const component: Component = await driver.findComponent(ON.id(id));
    if (component) {
      const text: string = await component.getText();
      if (matcher(text)) {
        return text;
      }
    }
    await driver.delayMs(300);
  }
  const component: Component = await driver.findComponent(ON.id(id));
  if (component) {
    return await component.getText();
  }
  return '';
}
