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
import { describe, beforeAll, beforeEach, afterEach, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { Driver} from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import { sleep, waitForComponentById, UiTestErrorInfo, UiTestErrorWithCode } from '../utils/CommonUtils';

const TAG = 'ArkUIX_UiTest_WaitForIdleTest';
const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_200 = 200;
const WAIT_PAGE_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_1500 = 1500;
const WAIT_PAGE_READY_MS_2000 = 2000;
const WAIT_PAGE_READY_MS_3000 = 3000;

const WAIT_IDLE_THRESH_MS_1000 = 1000;
const WAIT_IDLE_THRESH_MS_2000 = 2000;
const WAIT_IDLE_THRESH_MS_1100 = 1100;
const WAIT_IDLE_THRESH_MS_3000 = 3000;
const WAIT_IDLE_THRESH_MS_0 = 0;
const WAIT_IDLE_TIMEOUT_MS_1000 = 1000;
const WAIT_IDLE_TIMEOUT_MS_2000 = 2000;
const WAIT_IDLE_TIMEOUT_MS_3000 = 3000;
const WAIT_IDLE_TIMEOUT_MS_2500 = 2500;
const WAIT_IDLE_TIMEOUT_MS_4000 = 4000;

const DELAY_CATCH_SCROLL_EVENT_MS = 400;
const DELAY_CATCH_WINDOW_EVENT_MS = 300;

const PARAMETER_ERROR_CODE = 401;

async function ensureInPage(driver: Driver) {
  let backBtn = await waitForComponentById(driver, 'waitForIdleBackButton');
  if (!backBtn) {
    let indexBtn = await waitForComponentById(driver, 'indexWaitForIdleNavButton');
    if (indexBtn) {
      await indexBtn.click();
      await driver.delayMs(WAIT_PAGE_READY_MS_1500);
    }
  }
}

async function createWaitForIdleDriver(bundleName: string): Promise<Driver> {
  const want: Want = {
    bundleName: bundleName,
    abilityName: 'EntryAbility',
    moduleName: 'entry'
  };
  await delegator.startAbility(want);
  hilog.info(0x0000, TAG, 'start waitForIdle timeout tests success');
  await sleep(WAIT_PAGE_READY_MS_2000);
  const driver = await Driver.create();
  await sleep(WAIT_PAGE_READY_MS_1000);
  return driver;
}

function withTimeout<T>(promise: Promise<T>, timeoutMs: number, label: string): Promise<T> {
  return new Promise((resolve, reject) => {
    const timer = setTimeout(() => {
      reject(new Error(`${label} timed out after ${timeoutMs} ms`));
    }, timeoutMs);

    promise.then((value) => {
      resolve(value);
    }).catch((error: Object) => {
      reject(error instanceof Error ? error : new Error('withTimeout rejected'));
    }).finally(() => {
      clearTimeout(timer);
     });
  });
}

function extractErrorInfo(error: Object): UiTestErrorInfo {
  if (error instanceof Error) {
    const typedError = error as UiTestErrorWithCode;
    return {
      code: typedError.code,
      message: typedError.message
    };
  }

  return {
    code: undefined,
    message: 'non-Error thrown'
  };
}

export default function WaitForIdleTest() {
  describe('WaitForIdleTest', () => {
    let driver: Driver;
    let bundleName = '';
    let shouldRestartApp = false;

    const runWaitForIdleCase = async (action: () => Promise<void>): Promise<void> => {
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
      hilog.info(0x0000, TAG, 'beforeAll start waitForIdle timeout tests');
      bundleName = abilityDelegatorRegistry.getArguments().bundleName;
      driver = await createWaitForIdleDriver(bundleName);
    });

    beforeEach(async () => {
      if (!shouldRestartApp) {
        return;
      }
      hilog.info(0x0000, TAG, 'beforeEach restart waitForIdle timeout tests after previous failure');
      driver = await createWaitForIdleDriver(bundleName);
      shouldRestartApp = false;
    });

    afterEach(async () => {
      try {
        await driver.delayMs(WAIT_PAGE_READY_MS_2000);
      } catch (error) {
        shouldRestartApp = true;
        const errorInfo = extractErrorInfo(error as Object);
        console.log(`[${TAG}] afterEach threw errorCode: ${errorInfo.code} errMsg: ${errorInfo.message}`);
      }
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0100
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0100
     * @tc.desc waitForIdle returns true immediately when idle
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await sleep(WAIT_PAGE_READY_MS_2000);
        let startTime = Date.now();
        let idle = await driver.waitForIdle(WAIT_IDLE_TIMEOUT_MS_2000, WAIT_IDLE_TIMEOUT_MS_4000);
        let endTime = Date.now();
        console.log(`[${TAG}] waitForIdle actually waited for ${endTime - startTime} ms`);
        expect(idle).assertTrue();
        expect(endTime - startTime).assertLess(WAIT_PAGE_READY_MS_1000);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0200
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0200
     * @tc.desc waitForIdle returns true immediately when idle threshold is 0
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        let btn = await waitForComponentById(driver, 'waitForIdleContinuousScrollButton');
        await btn?.click();
        await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        let startTime = Date.now();
        let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_0, WAIT_IDLE_TIMEOUT_MS_2000);
        let costTime = Date.now() - startTime;
        console.log(`[${TAG}] testBoundary_ZeroIdleThreshold waitForIdle returned: ${idled}, cost: ${costTime}ms`);
        expect(idled).assertTrue();
        expect(costTime).assertLess(WAIT_PAGE_READY_MS_1000);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0300
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0300
     * @tc.desc When a continuous scroll event occurs, waitForIdle should return false after timeout
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        try {
          let btn = await waitForComponentById(driver, 'waitForIdleContinuousScrollButton');
          await btn?.click();
          await driver.delayMs(WAIT_PAGE_READY_MS_500);
          let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_1000, WAIT_IDLE_TIMEOUT_MS_2500);
          console.log(`[${TAG}] testTimeout_ScrolledEvent waitForIdle returned: ${idled}`);
          expect(idled).assertFalse();
        } catch (error) {
          console.error(`[${TAG}] testTimeout_ScrolledEvent failed with error:`, error);
          expect().assertFail();
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0400
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0400
     * @tc.desc When a continuous window update event occurs, waitForIdle should return false after timeout
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        let btn = await waitForComponentById(driver, 'waitForIdleContinuousWindowButton');
        await btn?.click();
        await driver.delayMs(WAIT_PAGE_READY_MS_500);

        let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_1000, WAIT_IDLE_TIMEOUT_MS_2500);
        console.log(`[${TAG}] testTimeout_WindowUpdateEvent waitForIdle returned: ${idled}`);
        expect(idled).assertFalse();
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0500
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0500
     * @tc.desc waitForIdle returns true after a short scroll event and idle threshold is met
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        let btn = await waitForComponentById(driver, 'waitForIdleShortScrollButton');
        await btn?.click();
        await sleep(DELAY_CATCH_SCROLL_EVENT_MS);
        let startTime = Date.now();
        let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_1000, WAIT_IDLE_TIMEOUT_MS_3000);
        let costTime = Date.now() - startTime;
        console.log(`[${TAG}] testIdle_ShortScrolledEvent waitForIdle returned: ${idled}, cost: ${costTime}ms`);
        expect(idled).assertTrue();
        expect(costTime).assertLarger(WAIT_IDLE_THRESH_MS_1100);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0600
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0600
     * @tc.desc waitForIdle returns true after a short window update event and idle threshold is met
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        let btn = await waitForComponentById(driver, 'waitForIdleShortWindowButton');
        await btn?.click();
        await sleep(DELAY_CATCH_WINDOW_EVENT_MS);
        let startTime = Date.now();
        let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_1000, WAIT_IDLE_TIMEOUT_MS_3000);
        let costTime = Date.now() - startTime;
        console.log(`[${TAG}] testIdle_ShortWindowUpdateEvent waitForIdle returned: ${idled}, cost: ${costTime}ms`);
        expect(idled).assertTrue();
        expect(costTime).assertLarger(WAIT_IDLE_THRESH_MS_1100);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0700
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0700
     * @tc.desc waitForIdle returns true after continuous animation event
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        let btn = await waitForComponentById(driver, 'waitForIdleContinuousAnimationButton');
        await btn?.click();
        await driver.delayMs(WAIT_PAGE_READY_MS_500);
        let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_1000, WAIT_IDLE_TIMEOUT_MS_2500);
        console.log(`[${TAG}] testTimeout_AnimationEvent waitForIdle returned: ${idled}`);
        expect(idled).assertTrue();
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0800
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0800
     * @tc.desc waitForIdle returns true when idle threshold is greater than timeout
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        try {
          await sleep(WAIT_PAGE_READY_MS_3000);
          let startTime = Date.now();
          let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_3000, WAIT_IDLE_TIMEOUT_MS_1000);
          let costTime = Date.now() - startTime;
          console.log(`[${TAG}] testAbnormal_ThresholdGreaterTimeout returned: ${idled}, cost: ${costTime}ms`);
          expect(idled).assertTrue();
        } catch (error) {
          const errorInfo = extractErrorInfo(error as Object);
          console.log(`[${TAG}] testAbnormal_ThresholdGreaterTimeout threw errorCode: ${errorInfo.code} errMsg: ${errorInfo.message}`);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_0900
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_0900
     * @tc.desc waitForIdle throws parameter error when idle time is negative
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        try {
          let idled = await driver.waitForIdle(-100, WAIT_IDLE_TIMEOUT_MS_2000);
          console.log(`[${TAG}] testAbnormal_NegativeIdleTime returned: ${idled}`);
        } catch (error) {
          const errorInfo = extractErrorInfo(error as Object);
          console.log(`[${TAG}] testAbnormal_NegativeIdleTime threw errorCode: ${errorInfo.code} errMsg: ${errorInfo.message}`);
          expect(errorInfo.code).assertEqual(PARAMETER_ERROR_CODE);
          return;
        }
        expect().assertFail();
        await driver.delayMs(WAIT_PAGE_READY_MS_500);
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_1000
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_1000
     * @tc.desc waitForIdle throws parameter error when timeout is negative
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);
        try {
          let idled = await driver.waitForIdle(WAIT_IDLE_THRESH_MS_1000, -2000);
          console.log(`[${TAG}] testAbnormal_NegativeTimeout returned: ${idled}`);
        } catch (error) {
          const errorInfo = extractErrorInfo(error as Object);
          console.log(`[${TAG}] testAbnormal_NegativeTimeout threw errorCode: ${errorInfo.code} errMsg: ${errorInfo.message}`);
          expect(errorInfo.code).assertEqual(PARAMETER_ERROR_CODE);
          return;
        }
        expect().assertFail();
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_waitForIdle_1100
     * @tc.name ArkUIX_ArkTS_UiTest_waitForIdle_1100
     * @tc.desc waitForIdle throws 17000002 error when called concurrently
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_waitForIdle_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runWaitForIdleCase(async () => {
        await ensureInPage(driver);

        const scrollBtn = await waitForComponentById(driver, 'waitForIdleContinuousScrollButton');
        if (scrollBtn) {
          await scrollBtn.click();
          await driver.delayMs(WAIT_PAGE_READY_MS_500);
        }

        const firstWaitForIdle = driver.waitForIdle(WAIT_IDLE_THRESH_MS_2000, WAIT_IDLE_THRESH_MS_2000);
        await sleep(WAIT_PAGE_READY_MS_200);

        let secondCallReturned = false;
        let secondCallErrorCode: number | undefined = undefined;
        let secondCallErrorMessage = '';

        try {
          const secondCallResult = await withTimeout(
            driver.waitForIdle(WAIT_IDLE_THRESH_MS_2000, WAIT_IDLE_THRESH_MS_2000),
            WAIT_IDLE_TIMEOUT_MS_2000,
            'second waitForIdle'
          );
          secondCallReturned = true;
          console.log(`[${TAG}] testAbnormal_17000002 unexpectedly returned: ${secondCallResult}`);
        } catch (error) {
          const errorInfo = extractErrorInfo(error);
          secondCallErrorCode = errorInfo.code;
          secondCallErrorMessage = errorInfo.message;
          console.log(`[${TAG}] testAbnormal_17000002 threw errorCode: ${errorInfo.code} errMsg: ${errorInfo.message}`);
        } finally {
          try {
            const cleanupResult = await withTimeout(
              firstWaitForIdle,
              WAIT_IDLE_TIMEOUT_MS_4000,
              'first waitForIdle cleanup'
            );
            console.log(`[${TAG}] testAbnormal_17000002 cleanup first waitForIdle returned: ${cleanupResult}`);
          } catch (cleanupError) {
            const cleanupErrorInfo = extractErrorInfo(cleanupError);
            console.log(`[${TAG}] testAbnormal_17000002 cleanup first waitForIdle failed: ${cleanupErrorInfo.message}`);
          }
        }

        expect(secondCallReturned).assertFalse();
        expect(secondCallErrorCode).assertEqual(17000002);
        console.log(`[${TAG}] testAbnormal_17000002 final error message: ${secondCallErrorMessage}`);
      });
    });
  });
}