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
import { describe, beforeAll, afterEach, it, expect, Level, TestType, Size, afterAll } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import { sleep, waitForComponentById } from '../utils/CommonUtils';

const TAG = 'ArkUIX_UiTest_IsComponentPresentWhenLongClickTest';
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_3000 = 3000;
const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();

const TEST_TAG = 'UiTest_TAG';

async function enterLongClickTestPage(driver: Driver): Promise<void> {
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  let inButton = await waitForComponentById(driver, 'indexLongClickNavButton');
  if (!inButton) {
    throw new Error('[UiTest_ETS] not find isComponentPresentWhenLongClick button');
  }
  await inButton.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
}

async function exitLongClickTestPage(driver: Driver): Promise<void> {
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
  let backButton = await waitForComponentById(driver, 'longClickBackButton');
  if (!backButton) {
    throw new Error('[UiTest_ETS] not find back button');
  }
  await backButton.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1000);
}

export default function isComponentPresentWhenLongClickTest() {
  describe('isComponentPresentWhenLongClickTest', () => {
    let driver: Driver;

    beforeAll(async () => {
      hilog.info(0x0000, TAG, 'beforeAll start isComponentPresentWhenLongClickTest APP');
      const bundleName = abilityDelegatorRegistry.getArguments().bundleName;
      const want: Want = {
        bundleName: bundleName,
        abilityName: 'EntryAbility',
        moduleName: "entry"
      }
      await delegator.startAbility(want);
      hilog.info(0x0000, TAG, 'beforeAll start isComponentPresentWhenLongClickTest APP success');
      driver = await Driver.create();
      await driver.delayMs(WAIT_PAGE_READY_MS_1000);
    });

    afterEach(async () => {
      await sleep(WAIT_PAGE_READY_MS_500);
    })

    afterAll(async () => {
      await sleep(WAIT_PAGE_READY_MS_3000);
    })

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0100
     * @tc.name ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0100
     * @tc.desc Long click and check component present: verify indicator appears during long click
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        console.log(`${TEST_TAG}, testIsComponentPresentWhenLongClickTrue start`);
        await enterLongClickTestPage(driver);

        let longClickBtn = await waitForComponentById(driver, 'longClickTriggerText');
        if (!longClickBtn) {
          throw new Error('[UiTest_ETS] not find longClickTriggerText');
        }
        await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        let center = await longClickBtn.getBoundsCenter();
        await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        let result = await driver.isComponentPresentWhenLongClick(ON.id('longClickVisibleIndicatorText'), center)
        expect(result).assertTrue();
        await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        let longClickTextResultBtn = await waitForComponentById(driver, 'longClickResultText');
        if (!longClickTextResultBtn) {
          throw new Error('[UiTest_ETS] not find longClickResultText');
        }
        let longClickText = await longClickTextResultBtn.getText();
        expect(longClickText).assertEqual('longClickEvent');
        await exitLongClickTestPage(driver);

        console.log(`${TEST_TAG}, testIsComponentPresentWhenLongClickTrue end`);
      })

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0200
     * @tc.name ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0200
     * @tc.desc Long click and check component NOT present: verify non-existent indicator returns false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        console.log(`${TEST_TAG}, tesIsComponentPresentWhenLongClickNotCom start`);
        await enterLongClickTestPage(driver);

        let longClickBtn = await waitForComponentById(driver, 'longClickTriggerText');
        if (!longClickBtn) {
          throw new Error('[UiTest_ETS] not find longClickTriggerText');
        }
        await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        let center = await longClickBtn.getBoundsCenter();
        await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        let result = await driver.isComponentPresentWhenLongClick(ON.id('notExistWaitID'), center)
        expect(result).assertFalse();
        await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        let longClickTextResultBtn = await waitForComponentById(driver, 'longClickResultText');
        if (!longClickTextResultBtn) {
          throw new Error('[UiTest_ETS] not find longClickResultText');
        }
        let longClickText = await longClickTextResultBtn.getText();
        expect(longClickText).assertEqual('longClickEvent');
        await exitLongClickTestPage(driver);
      })

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0300
     * @tc.name ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0300
     * @tc.desc Long click with short duration: verify error 17000007 when duration < 1500ms
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        try {
          await enterLongClickTestPage(driver);
          let longClickBtn = await waitForComponentById(driver, 'longClickTriggerText');
          if (!longClickBtn) {
            throw new Error('[UiTest_ETS] not find longClickTriggerText');
          }
          let center = await longClickBtn.getBoundsCenter();
          await driver.isComponentPresentWhenLongClick(ON.id('longClickVisibleIndicatorText'), center, 1000);
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(17000007);
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
        } finally {
          await exitLongClickTestPage(driver);
        }
      });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0400
     * @tc.name ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0400
     * @tc.desc Long click with null duration: verify default duration logic
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        await enterLongClickTestPage(driver);
        try {
          let longClickBtn = await waitForComponentById(driver, 'longClickTriggerText');
          if (!longClickBtn) {
            throw new Error('[UiTest_ETS] not find longClickTriggerText');
          }
          let center = await longClickBtn.getBoundsCenter();
          let result =
            await driver.isComponentPresentWhenLongClick(ON.id('longClickVisibleIndicatorText'), center, null);
          expect(result).assertTrue();
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          let longClickTextResultBtn = await waitForComponentById(driver, 'longClickResultText');
          if (!longClickTextResultBtn) {
            throw new Error('[UiTest_ETS] not find longClickResultText');
          }
          let longClickText = await longClickTextResultBtn.getText();
          expect(longClickText).assertEqual('longClickEvent');
        } finally {
          await exitLongClickTestPage(driver);
        }
      });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0500
     * @tc.name ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0500
     * @tc.desc Long click with undefined duration: verify default duration logic
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        await enterLongClickTestPage(driver);
        try {
          let longClickBtn = await waitForComponentById(driver, 'longClickTriggerText');
          if (!longClickBtn) {
            throw new Error('[UiTest_ETS] not find longClickTriggerText');
          }
          let center = await longClickBtn.getBoundsCenter();
          let result =
            await driver.isComponentPresentWhenLongClick(ON.id('longClickVisibleIndicatorText'), center, undefined);
          expect(result).assertTrue();
          await driver.delayMs(WAIT_PAGE_READY_MS_1000);
          let longClickTextResultBtn = await waitForComponentById(driver, 'longClickResultText');
          if (!longClickTextResultBtn) {
            throw new Error('[UiTest_ETS] not find longClickResultText');
          }
          let longClickText = await longClickTextResultBtn.getText();
          expect(longClickText).assertEqual('longClickEvent');
        } finally {
          await exitLongClickTestPage(driver);
        }
      });

    /**
     * @tc.number ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0600
     * @tc.name ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0600
     * @tc.desc Long click with negative point: verify error 17000007 for invalid coordinates
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_ArkTS_UiTest_isComponentPresentWhenLongClick_0600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        await enterLongClickTestPage(driver);
        try {
          await driver.isComponentPresentWhenLongClick(ON.id('longClickVisibleIndicatorText'), { x: -1, y: -1 });
          expect().assertFail();
        } catch (err) {
          expect(err?.code).assertEqual(17000007);
        } finally {
          await exitLongClickTestPage(driver);
        }
      });
  })
}