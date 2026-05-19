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
import { Driver, ON } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import { sleep, waitForComponentById } from '../utils/CommonUtils';

const TAG = 'ArkUIX_UiTest_GetDisplaySizeTest';
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_3000 = 3000;
const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

async function createGetDisplaySizeDriver(bundleName: string): Promise<Driver> {
  const want: Want = {
    bundleName: bundleName,
    abilityName: 'EntryAbility',
    moduleName: 'entry'
  };
  await delegator.startAbility(want);
  hilog.info(0x0000, TAG, 'start getDisplaySizeTest APP success');
  const driver = await Driver.create();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  return driver;
}

export default function getDisplaySizeTest() {
  describe('getDisplaySizeTest', () => {
    let driver: Driver;
    let bundleName = '';
    let shouldRestartApp = false;

    const runGetDisplaySizeCase = async (action: () => Promise<void>): Promise<void> => {
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
      hilog.info(0x0000, TAG, 'beforeAll start getDisplaySizeTest APP');
      bundleName = abilityDelegatorRegistry.getArguments().bundleName;
      hilog.info(0x0000, TAG, `beforeAll bundleName: ${bundleName}`);
      driver = await createGetDisplaySizeDriver(bundleName);
    });

    beforeEach(async () => {
      if (!shouldRestartApp) {
        return;
      }
      hilog.info(0x0000, TAG, 'beforeEach restart getDisplaySizeTest APP after previous failure');
      driver = await createGetDisplaySizeDriver(bundleName);
      shouldRestartApp = false;
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_getDisplaySize_0100
     * @tc.name ArkUIX_ArkTS_UiTest_getDisplaySize_0100
     * @tc.desc Call getDisplaySize() and check x/y > 0
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_getDisplaySize_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      try {
        await runGetDisplaySizeCase(async () => {
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          let inButton = await waitForComponentById(driver, 'indexGetDisplaySizeNavButton');
          if (!inButton) {
            throw new Error('[UiTest_ETS] not find getDisplaySize button');
          }
          await inButton.click();
          let backButton = await waitForComponentById(driver, 'getDisplaySizeBackButton');
          if (!backButton) {
            throw new Error('[UiTest_ETS] getDisplaySize page not ready after click');
          }
          const size = await driver.getDisplaySize();
          console.info(`GetDisplaySizeTest size: ${size.x} x ${size.y}`);
          expect(size.x > 0).assertTrue();
          expect(size.y > 0).assertTrue();
        });
      } catch (error) {
        console.error('getDisplaySize failed: ' + JSON.stringify(error));
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_getDisplaySize_0200
     * @tc.name ArkUIX_ArkTS_UiTest_getDisplaySize_0200
     * @tc.desc Call getDisplaySize(0) and check x/y > 0
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_getDisplaySize_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await runGetDisplaySizeCase(async () => {
          const size = await driver.getDisplaySize(0);
          console.info(`GetDisplaySizeTest size: ${size.x} x ${size.y}`);
          expect(size.x > 0).assertTrue();
          expect(size.y > 0).assertTrue();
        });
      } catch (error) {
        console.error('getDisplaySize failed: ' + JSON.stringify(error));
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_getDisplaySize_0300
     * @tc.name ArkUIX_ArkTS_UiTest_getDisplaySize_0300
     * @tc.desc Call getDisplaySize(1000), expect error 17000007
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_getDisplaySize_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await runGetDisplaySizeCase(async () => {
          let errorCaught: boolean = false;
          let errorMsg: string = '';
          let errorCode: number | undefined = undefined;

          interface ErrorWithCode {
            code?: number;
            message?: string;
          }

          try {
            await driver.getDisplaySize(1000);
          } catch (error) {
            errorCaught = true;
            if (error && typeof error === 'object' && error !== null) {
              const keys = Object.keys(error);
              if (keys.indexOf('message') !== -1) {
                errorMsg = (error as ErrorWithCode).message || '';
              }
              if (keys.indexOf('code') !== -1) {
                errorCode = (error as ErrorWithCode).code;
              }

              console.info('getDisplaySize error object:', JSON.stringify(error));
            }
          }
          console.info('getDisplaySize errorMsg:', errorMsg);
          expect(errorCaught).assertTrue();
          expect(errorCode === 17000007).assertTrue();

          await driver.delayMs(WAIT_PAGE_READY_MS_3000);
          let backButton = await waitForComponentById(driver, 'getDisplaySizeBackButton');
          if (!backButton) {
            throw new Error('[UiTest_ETS] not find back button');
          }
          await backButton.click();
        });
      } catch (error) {
        console.error('getDisplaySize failed: ' + JSON.stringify(error));
        expect().assertFail();
      }
    });
  })
}