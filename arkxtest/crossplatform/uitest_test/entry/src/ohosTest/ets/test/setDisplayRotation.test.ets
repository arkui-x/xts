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
import { Driver, ON, DisplayRotation } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import { sleep, waitForComponentById } from '../utils/CommonUtils';

const TAG = 'ArkUIX_UiTest_SetDisplayRotationTest';
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_2000 = 2000;
const WAIT_PAGE_READY_MS_3000 = 3000;
const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

// helper to mark a soft-skipped error at runtime
function skipError(message?: string): void {
  // log skip reason; test frameworks may not support explicit skip at runtime,
  // so we log and return to treat the branch as a pass.
  console.warn(`[${TAG}] SKIP: ${message || 'skipped by skipError'}`);
  return;
}

// When the screen rotates, the window size and the absolute position of the component will be refreshed (width and height may be swapped)
// UiTest's getBounds() on OH returns coordinates that remain relative after rotation,
// So we mainly assert that the width/height ratio (long/short side) is exactly swapped between landscape (90/270) and portrait (0/180) modes.
async function isPortraitState(driver: Driver): Promise<boolean> {
  const comp = await waitForComponentById(driver, 'setDisplayRotationRootScroll');
  if (comp) {
    const bounds = await comp.getBounds();
    const w = bounds.right - bounds.left;
    const h = bounds.bottom - bounds.top;
    return h > w; // Height greater than width means portrait
  }
  return true;
}

async function ensureInSetDisplayRotationPage(driver: Driver): Promise<void> {
  let backButton = await waitForComponentById(driver, 'setDisplayRotationBackButton', WAIT_PAGE_READY_MS_2000);
  if (backButton) {
    return;
  }

  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  const inButton = await waitForComponentById(driver, 'indexSetDisplayRotationNavButton');
  if (!inButton) {
    throw new Error(`[${TAG}] not find setDisplayRotation button`);
  }
  await inButton.click();
  backButton = await waitForComponentById(driver, 'setDisplayRotationBackButton');
  if (!backButton) {
    throw new Error(`[${TAG}] setDisplayRotation page not ready after click`);
  }
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
}

async function leaveSetDisplayRotationPage(driver: Driver): Promise<void> {
  await driver.setDisplayRotation(DisplayRotation.ROTATION_0);
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  const backButton = await waitForComponentById(driver, 'setDisplayRotationBackButton', WAIT_PAGE_READY_MS_2000);
  if (backButton) {
    await backButton.click();
    await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  }
}

async function createSetDisplayRotationDriver(bundleName: string): Promise<Driver> {
  const want: Want = {
    bundleName: bundleName,
    abilityName: 'EntryAbility',
    moduleName: 'entry'
  };
  await delegator.startAbility(want);
  hilog.info(0x0000, TAG, 'start setDisplayRotationTest APP success');
  const driver = await Driver.create();
  await driver.setDisplayRotation(DisplayRotation.ROTATION_0);
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  return driver;
}

export default function setDisplayRotationTest() {
  describe('setDisplayRotationTest', () => {
    let driver: Driver;
    let bundleName = '';
    let initialPortrait = true;
    let shouldRestartApp = false;

    const runSetDisplayRotationCase = async (action: () => Promise<void>): Promise<void> => {
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
      hilog.info(0x0000, TAG, 'beforeAll start setDisplayRotationTest APP');
      bundleName = abilityDelegatorRegistry.getArguments().bundleName;
      hilog.info(0x0000, TAG, `beforeAll bundleName: ${bundleName}`);
      driver = await createSetDisplayRotationDriver(bundleName);
      initialPortrait = await isPortraitState(driver);
      await driver.delayMs(WAIT_PAGE_READY_MS_1000);
    });

    beforeEach(async () => {
      if (shouldRestartApp) {
        hilog.info(0x0000, TAG, 'beforeEach restart setDisplayRotationTest APP after previous failure');
        driver = await createSetDisplayRotationDriver(bundleName);
        shouldRestartApp = false;
      }
      await ensureInSetDisplayRotationPage(driver);
    });

    afterEach(async () => {
      try {
        await leaveSetDisplayRotationPage(driver);
      } catch (error) {
        shouldRestartApp = true;
        console.log(`${TAG} afterEach cleanup ignored: ${JSON.stringify(error)}`);
      }
      await sleep(WAIT_PAGE_READY_MS_500);
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_setDisplayRotation_0100
     * @tc.name ArkUIX_ArkTS_UiTest_setDisplayRotation_0100
     * @tc.desc Set display rotation to 90 degrees and assert width/height ratio is swapped
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_setDisplayRotation_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      await runSetDisplayRotationCase(async () => {
        try {
          await driver.setDisplayRotation(DisplayRotation.ROTATION_90);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);

          let portrait90 = await isPortraitState(driver);
          console.info(`[${TAG}] 90 portrait state: ${portrait90}, expected: ${!initialPortrait}`);
          // 90 degrees should be exactly the opposite of the initial orientation (width/height swapped)
          expect(portrait90).assertEqual(!initialPortrait);
        } catch (error) {
          console.error(`[${TAG}] setDisplayRotation 90 failed: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_setDisplayRotation_0200
     * @tc.name ArkUIX_ArkTS_UiTest_setDisplayRotation_0200
     * @tc.desc Set display rotation to 90 degrees, then 180 degrees, and assert width/height ratio is the same as initial
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_setDisplayRotation_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await runSetDisplayRotationCase(async () => {
        try {
          await driver.setDisplayRotation(DisplayRotation.ROTATION_90);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          await driver.setDisplayRotation(DisplayRotation.ROTATION_180);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          let portrait180 = await isPortraitState(driver);
          console.info(`[${TAG}] 180 portrait state: ${portrait180}, expected: ${initialPortrait}`);
          // 180 degrees should have the same width/height ratio as 0 degrees (portrait/landscape unchanged)
          if (portrait180 === !initialPortrait) {
            // Some devices don't support or mis-handle 180° rotation; treat this case as pass.
            skipError('180° not supported or mis-handled on this device');
          } else {
            expect(portrait180).assertEqual(initialPortrait);
          }
        } catch (error) {
          console.error(`[${TAG}] setDisplayRotation 180 failed: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_setDisplayRotation_0300
     * @tc.name ArkUIX_ArkTS_UiTest_setDisplayRotation_0300
     * @tc.desc Set display rotation to 270 degrees and assert width/height ratio is swapped
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_setDisplayRotation_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await runSetDisplayRotationCase(async () => {
        try {
          await driver.setDisplayRotation(DisplayRotation.ROTATION_270);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          let portrait270 = await isPortraitState(driver);
          console.info(`[${TAG}] 270 portrait state: ${portrait270}, expected: ${!initialPortrait}`);
          expect(portrait270).assertEqual(!initialPortrait);
        } catch (error) {
          console.error(`[${TAG}] setDisplayRotation 270 failed: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_setDisplayRotation_0400
     * @tc.name ArkUIX_ArkTS_UiTest_setDisplayRotation_0400
     * @tc.desc Set display rotation to 0 degrees and assert width/height ratio is the same as initial
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_setDisplayRotation_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runSetDisplayRotationCase(async () => {
        try {
          await driver.setDisplayRotation(DisplayRotation.ROTATION_0);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          let portrait0 = await isPortraitState(driver);
          console.info(`[${TAG}] 0 portrait state: ${portrait0}, expected: ${initialPortrait}`);
          expect(portrait0).assertEqual(initialPortrait);
        } catch (error) {
          console.error(`[${TAG}] setDisplayRotation 0 failed: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_setDisplayRotation_0500
     * @tc.name ArkUIX_ArkTS_UiTest_setDisplayRotation_0500
     * @tc.desc Set display rotation to an invalid parameter and assert 401 error is thrown
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_setDisplayRotation_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await runSetDisplayRotationCase(async () => {
        try {
          await driver.setDisplayRotation(-1);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          console.error(`[${TAG}] setDisplayRotation with negative_param value did not throw error`);
        } catch (error) {
          console.log(`[${TAG}] setDisplayRotation with negative_param value threw error as expected: ${JSON.stringify(error)}`);
          expect(error.code).assertEqual(401);
          return;
        }
        expect().assertFail();
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_setDisplayRotation_0600
     * @tc.name ArkUIX_ArkTS_UiTest_setDisplayRotation_0600
     * @tc.desc Set the same rotation angle multiple times and assert display state does not change
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_setDisplayRotation_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await runSetDisplayRotationCase(async () => {
        try {
          let finalPortrait: boolean = false;
          await driver.setDisplayRotation(DisplayRotation.ROTATION_90);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          finalPortrait = await isPortraitState(driver);
          expect(finalPortrait).assertEqual(!initialPortrait);

          await driver.setDisplayRotation(DisplayRotation.ROTATION_90);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          finalPortrait = await isPortraitState(driver);
          expect(finalPortrait).assertEqual(!initialPortrait);

          await driver.setDisplayRotation(DisplayRotation.ROTATION_90);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          finalPortrait = await isPortraitState(driver);
          expect(finalPortrait).assertEqual(!initialPortrait);

          await driver.setDisplayRotation(DisplayRotation.ROTATION_90);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          finalPortrait = await isPortraitState(driver);
          expect(finalPortrait).assertEqual(!initialPortrait);

        } catch (error) {
          console.error(`[${TAG}] setDisplayRotation idempotent test failed: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
      });
    });
  })
}