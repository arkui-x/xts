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

import { Driver, ON } from '@ohos.UiTest';

export interface UiTestErrorInfo {
  code?: number;
  message: string;
}

export interface UiTestErrorWithCode extends Error {
  code?: number;
}

export function sleep(ms: number): Promise<void>{
  return new Promise((resolve) => setTimeout(resolve, ms));
}

export async function waitForComponentById(driver: Driver, id: string, timeoutMs: number = 3000, intervalMs: number = 200) {
    const endTime = Date.now() + timeoutMs;
    while (Date.now() < endTime) {
      const component = await driver.findComponent(ON.id(id));
      if (component) {
        return component;
      }
      if (typeof driver.delayMs === 'function') {
        await driver.delayMs(intervalMs);
      } else {
        await sleep(intervalMs);
      }
    }
    return null;
}