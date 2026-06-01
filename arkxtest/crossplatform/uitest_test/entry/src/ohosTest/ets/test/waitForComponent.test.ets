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

import hilog from '@ohos.hilog';
import { describe, beforeAll, beforeEach, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest';
import type { On } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import { sleep, UiTestErrorInfo, UiTestErrorWithCode } from '../utils/CommonUtils';

const TAG = 'ArkUIX_UiTest_WaitForComponentTest';
const WAIT_TIMEOUT = 10000;
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_3000 = 3000;
const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

type WaitForComponentAction = () => Promise<void>;

function getUiTestErrorInfo(error: Object | null | undefined): UiTestErrorInfo {
  let errorCode: number | undefined = undefined;
  let errorMsg = '';
  if (error && typeof error === 'object') {
    const keys = Object.keys(error);
    if (keys.indexOf('code') !== -1) {
      errorCode = (error as UiTestErrorWithCode).code;
    }
    if (keys.indexOf('message') !== -1) {
      errorMsg = (error as Error).message || '';
    }
  }
  return { code: errorCode, message: errorMsg };
}

async function withWaitForComponentPage(driver: Driver, action: WaitForComponentAction): Promise<void> {
  await enterWaitForComponentPage(driver);
  try {
    await action();
  } finally {
    await exitWaitForComponentPage(driver);
  }
}

async function captureWaitForComponentError(driver: Driver, on: On,
  time: number): Promise<UiTestErrorInfo | null> {
  try {
    await driver.waitForComponent(on, time);
    return null;
  } catch (error) {
    return getUiTestErrorInfo(error as Object | null | undefined);
  }
}

async function captureWaitForComponentNullError(driver: Driver, time: number): Promise<UiTestErrorInfo | null> {
  try {
    await driver.waitForComponent(null, time);
    return null;
  } catch (error) {
    return getUiTestErrorInfo(error as Object | null | undefined);
  }
}

async function captureWaitForComponentUndefinedError(driver: Driver, time: number): Promise<UiTestErrorInfo | null> {
  try {
    await driver.waitForComponent(undefined, time);
    return null;
  } catch (error) {
    return getUiTestErrorInfo(error as Object | null | undefined);
  }
}

async function enterWaitForComponentPage(driver: Driver): Promise<void> {
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  const readyComponent = await driver.findComponent(ON.id('waitForComponentButtonA'));
  if (readyComponent) {
    return;
  }

  const inButton = await driver.findComponent(ON.id('indexWaitForComponentNavButton'));
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  if (!inButton) {
    throw new Error('[UiTest_ETS] not find waitForComponent button');
  }
  await inButton.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
}

async function exitWaitForComponentPage(driver: Driver): Promise<void> {
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  const backButton = await driver.findComponent(ON.id('waitForComponentBackButton'));
  if (backButton) {
    await backButton.click();
    await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  }
}

async function createWaitForComponentDriver(bundleName: string): Promise<Driver> {
  const want: Want = {
    bundleName: bundleName,
    abilityName: 'EntryAbility',
    moduleName: 'entry'
  };
  await delegator.startAbility(want);
  hilog.info(0x0000, TAG, 'start waitForComponentTest APP success');
  const driver = await Driver.create();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  return driver;
}

export default function waitForComponentTest() {
  describe('waitForComponentTest', () => {
    let driver: Driver;
    let bundleName = '';
    let shouldRestartApp = false;

    const runWaitForComponentCase = async (action: WaitForComponentAction): Promise<void> => {
      try {
        await action();
      } catch (error) {
        shouldRestartApp = true;
        if (error instanceof Error) {
          throw error;
        } else {
          throw new Error(typeof error === 'string' ? error : JSON.stringify(error));
        }
      }
    };

    beforeAll(async () => {
      // start app
      hilog.info(0x0000, TAG, 'beforeAll start waitForComponentTest APP');
      bundleName = abilityDelegatorRegistry.getArguments().bundleName;
      hilog.info(0x0000, TAG, `beforeAll bundleName: ${bundleName}`);
      driver = await createWaitForComponentDriver(bundleName);
    });

    beforeEach(async () => {
      if (!shouldRestartApp) {
        return;
      }
      hilog.info(0x0000, TAG, 'beforeEach restart waitForComponentTest APP after previous failure');
      driver = await createWaitForComponentDriver(bundleName);
      shouldRestartApp = false;
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForComponent_0100
     * @tc.name ArkUIX_ArkTS_UiTest_waitForComponent_0100
     * @tc.desc Basic wait for component: verify both present and absent components
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForComponent_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      try {
        await runWaitForComponentCase(async () => {
          await withWaitForComponentPage(driver, async () => {
          const component1 = await driver.waitForComponent(ON.id('waitForComponentButtonA'), WAIT_TIMEOUT);
          const found1: boolean = component1 !== undefined && component1 !== null;
          console.info(`[UiTest_ETS] found btnA=${found1}`);
          if (found1) {
            let btnACheckbox = await driver.findComponent(ON.id('waitForComponentFoundCheckbox'));
            if (btnACheckbox) {
              await btnACheckbox.click();
            } else {
              console.info(`[UiTest_ETS] not find btnACheckbox`);
            }
          }
          expect(found1).assertTrue();

          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          const component2 = await driver.waitForComponent(ON.id('waitForComponentButtonB'), WAIT_TIMEOUT);
          const found2: boolean = component2 !== undefined && component2 !== null;
          console.info(`[UiTest_ETS] found btnB=${found2}`);
          if (!found2) {
            let btnBCheckbox = await driver.findComponent(ON.id('waitForComponentMissingCheckbox'));
            if (btnBCheckbox) {
              await btnBCheckbox.click();
            } else {
              console.info(`[UiTest_ETS] not find btnBCheckbox`);
            }
          }
          expect(found2).assertFalse();
          await driver.delayMs(WAIT_PAGE_READY_MS_3000);
          });
        });

      } catch (error) {
        console.info("[UiTest_ETS] test_waitForComponent error")
        console.error(error)
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForComponent_0200
     * @tc.name ArkUIX_ArkTS_UiTest_waitForComponent_0200
     * @tc.desc when time=0, it should return normally or throw an parameter error
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForComponent_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForComponentCase(async () => {
        await withWaitForComponentPage(driver, async () => {
          // 1. When the control exists, it should return immediately Component
          let component: object | null = null;
          component = await driver.waitForComponent(ON.id('waitForComponentButtonA'), 0);
          expect(component !== null && component !== undefined).assertTrue();
        });
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForComponent_0300
     * @tc.name ArkUIX_ArkTS_UiTest_waitForComponent_0300
     * @tc.desc when time is a decimal, it throws a parameter error
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForComponent_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForComponentCase(async () => {
        await withWaitForComponentPage(driver, async () => {
          const errorInfo = await captureWaitForComponentError(driver, ON.id('waitForComponentButtonA'), 1000.5);
          const errorCode = errorInfo?.code;
          const errorMsg = errorInfo?.message || '';
          console.info('waitForComponent time=1000.5 errorCode:', JSON.stringify(errorCode));
          console.info('waitForComponent time=1000.5 errorMsg:', errorMsg);
          expect(errorInfo !== null).assertTrue();
          expect(errorCode === 401 ).assertTrue();
        });
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForComponent_0400
     * @tc.name ArkUIX_ArkTS_UiTest_waitForComponent_0400
     * @tc.desc when on is null/undefined, it throws a parameter error
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForComponent_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForComponentCase(async () => {
        await withWaitForComponentPage(driver, async () => {
          const errorInfo = await captureWaitForComponentNullError(driver, 1000);
          const errorCode = errorInfo?.code;
          const errorMsg = errorInfo?.message || '';
          console.info('waitForComponent on=null errorCode:', JSON.stringify(errorCode));
          console.info('waitForComponent on=null errorMsg:', errorMsg);
          expect(errorInfo !== null).assertTrue();
          expect(errorCode === 401).assertTrue();
        });
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForComponent_0500
     * @tc.name ArkUIX_ArkTS_UiTest_waitForComponent_0500
     * @tc.desc when on is undefined, it throws a parameter error
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForComponent_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForComponentCase(async () => {
        await withWaitForComponentPage(driver, async () => {
          const errorInfo = await captureWaitForComponentUndefinedError(driver, 1000);
          const errorCode = errorInfo?.code;
          const errorMsg = errorInfo?.message || '';
          console.info('waitForComponent on=undefined errorCode:', JSON.stringify(errorCode));
          console.info('waitForComponent on=undefined errorMsg:', errorMsg);
          expect(errorInfo !== null).assertTrue();
          expect(errorCode === 401 ).assertTrue();
        });
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForComponent_0600
     * @tc.name ArkUIX_ArkTS_UiTest_waitForComponent_0600
     * @tc.desc When time is negative, a parameter error should be thrown
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForComponent_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForComponentCase(async () => {
        await withWaitForComponentPage(driver, async () => {
          const errorInfo = await captureWaitForComponentError(driver, ON.id('waitForComponentButtonA'), -1);
          const errorCode = errorInfo?.code;
          const errorMsg = errorInfo?.message || '';
          console.info('waitForComponent time=-1 errorCode:', JSON.stringify(errorCode));
          console.info('waitForComponent time=-1 errorMsg:', errorMsg);
          expect(errorInfo !== null).assertTrue();
          expect(errorCode === 401 ).assertTrue();
        });
      });
    });
  })
}