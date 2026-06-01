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
import { describe, beforeAll, beforeEach, it, expect, Level, TestType, Size, afterEach } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import deviceInfo from '@ohos.deviceInfo';
import { sleep, waitForComponentById } from '../utils/CommonUtils';

const TAG = 'ArkUIX_UiTest_ScreenCaptureTest';
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_2000 = 2000;
const WAIT_PAGE_READY_MS_3000 = 3000;
const SCREEN_CAPTURE_INTERVAL_MS = 1000;
const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

function buildScreenCapturePath(platform: string, fileName: string): string {
  if (platform.includes('Android')) {
    return `/files/files/${fileName}`;
  }
  if (platform.includes('OpenHarmony')) {
    return `/data/storage/el2/base/haps/entry/files/${fileName}`;
  }
  return `/Documents/files/${fileName}`;
}

async function openScreenCapturePage(driver: Driver): Promise<void> {
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  const inButton = await waitForComponentById(driver, 'indexScreenCaptureNavButton');
  if (!inButton) {
    throw new Error(TAG + 'not find screenCapture button');
  }
  await inButton.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_2000);
}

async function closeScreenCapturePage(driver: Driver): Promise<void> {
  const backButton = await waitForComponentById(driver, 'screenCaptureBackButton');
  if (!backButton) {
    throw new Error(TAG + 'not find back button');
  }
  await backButton.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
}

async function clickScreenCaptureBackButtonIfPresent(driver: Driver): Promise<void> {
  await sleep(WAIT_PAGE_READY_MS_500);
  const backButton = await waitForComponentById(driver, 'screenCaptureBackButton', WAIT_PAGE_READY_MS_500);
  if (!backButton) {
    return;
  }
  await backButton.click();
  await sleep(WAIT_PAGE_READY_MS_1000);
}

async function createScreenCaptureDriver(bundleName: string): Promise<Driver> {
  const want: Want = {
    bundleName: bundleName,
    abilityName: 'EntryAbility',
    moduleName: 'entry'
  };
  await delegator.startAbility(want);
  hilog.info(0x0000, TAG, 'start screenCaptureTest APP success');
  const driver = await Driver.create();
  await driver.delayMs(SCREEN_CAPTURE_INTERVAL_MS);
  return driver;
}

export default function screenCaptureTest() {
  describe('screenCaptureTest', () => {
    let driver: Driver;
    let bundleName = '';
    let platform: string = '';
    let shouldRestartApp = false;

    const runScreenCaptureCase = async (action: () => Promise<void>): Promise<void> => {
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
      hilog.info(0x0000, TAG, 'beforeAll start screenCaptureTest APP');
      platform = deviceInfo.osFullName.split(' ')[0];
      bundleName = abilityDelegatorRegistry.getArguments().bundleName;
      hilog.info(0x0000, TAG, 'beforeAll start screenCaptureTest APP success');
      driver = await createScreenCaptureDriver(bundleName);
    });

    beforeEach(async () => {
      if (!shouldRestartApp) {
        return;
      }
      hilog.info(0x0000, TAG, 'beforeEach restart screenCaptureTest APP after previous failure');
      driver = await createScreenCaptureDriver(bundleName);
      shouldRestartApp = false;
    });

    afterEach(async () => {
      try {
        await clickScreenCaptureBackButtonIfPresent(driver);
      } catch (error) {
        shouldRestartApp = true;
        console.log(`${TAG} afterEach cleanup ignored: ${JSON.stringify(error)}`);
      }
      await sleep(WAIT_PAGE_READY_MS_500);
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0100
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0100
     * @tc.desc Capture full screen and partial screen, verify success
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await runScreenCaptureCase(async () => {
          await openScreenCapturePage(driver);
          const fullScreenPath = buildScreenCapturePath(platform, 'fullScreen.png');
          let result1 = await driver.screenCapture(fullScreenPath);
          if (result1) {
            let fullScreenOk = await driver.findComponent(ON.id('screenCaptureFullScreenCheckbox'))
            if (fullScreenOk) {
              await fullScreenOk.click();
            }
          }
          expect(result1).assertTrue();

          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          const partScreenPath = buildScreenCapturePath(platform, 'partScreen.png');
          let result2 = await driver.screenCapture(partScreenPath, {
            left: 1,
            top: 1,
            right: 500,
            bottom: 1000,
          });
          if (result2) {
            let partScreenOk = await driver.findComponent(ON.id('screenCapturePartScreenCheckbox'))
            if (partScreenOk) {
              await partScreenOk.click();
            }
          }
          expect(result2).assertTrue();
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          await closeScreenCapturePage(driver);
        });
      } catch (error) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0200
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0200
     * @tc.desc Verify parameter error when screenCapture path is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          await driver.screenCapture(null);
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(401);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0300
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0300
     * @tc.desc Verify parameter error when screenCapture path is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          await driver.screenCapture(undefined);
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(401);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0400
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0400
     * @tc.desc Verify parameter error when screenCapture rect is invalid
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          const path = buildScreenCapturePath(platform, 'partScreen_invalid.png');
          await driver.screenCapture(path, {
            left: -1,
            top: -1,
            right: -1,
            bottom: -1,
          });
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(401);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0500
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0500
     * @tc.desc Verify screenCapture returns false when rect is out of display bounds
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await runScreenCaptureCase(async () => {
        try {
          const size = await driver.getDisplaySize();
          const screenCapturePath = buildScreenCapturePath(platform, 'partScreen_over.png');
          const result = await driver.screenCapture(screenCapturePath, {
            left: 1,
            top: 1,
            right: size.x + 100,
            bottom: size.y + 100,
          });
          expect(result).assertFalse();
        } catch (err) {
          expect().assertFail();
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0600
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0600
     * @tc.desc Verify error when screenCapture path directory does not exist
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          await driver.screenCapture('non_exist_dir/nonexist.png');
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(401);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0700
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0700
     * @tc.desc Verify error when screenCapture path contains special characters that cause directory creation to fail
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          // Only try restricted system paths to avoid extreme inputs that may trigger native crashes
          let restrictedPath: string;
          if (platform.includes('Android')) {
            restrictedPath = '/system/nonexist_dir/nonexist.png';
          } else if (platform.includes('OpenHarmony')) {
            restrictedPath = '/data/system/nonexist_dir/nonexist.png';
          } else {
            restrictedPath = '/root/nonexist_dir/nonexist.png';
          }
          await driver.screenCapture(restrictedPath);
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(401);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0800
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0800
     * @tc.desc Verify error when screenCapture path is null and rect provided
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          await driver.screenCapture(null, {
            left: 1,
            top: 1,
            right: 10,
            bottom: 10
          });
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(401);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_0900
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_0900
     * @tc.desc Verify error when screenCapture path is undefined and rect provided
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          await driver.screenCapture(undefined, {
            left: 1,
            top: 1,
            right: 10,
            bottom: 10
          });
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(401);
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_1000
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_1000
     * @tc.desc Verify screenCapture succeeds when path has non-png extension (.jpg)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          const path = buildScreenCapturePath(platform, 'capture.jpg');
          const result = await driver.screenCapture(path);
          expect(result).assertTrue();
        } catch (err) {
          expect().assertFail();
        }
      });
    });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_screenCapture_1100
     * @tc.name ArkUIX_ArkTS_UiTest_screenCapture_1100
     * @tc.desc Verify screenCapture succeeds when path has unsupported extension (.txt)
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_screenCapture_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await runScreenCaptureCase(async () => {
        try {
          const path = buildScreenCapturePath(platform, 'capture.txt');
          const result = await driver.screenCapture(path);
          expect(result).assertTrue();
        } catch (err) {
          expect().assertFail();
        }
      });
    });

  })
}