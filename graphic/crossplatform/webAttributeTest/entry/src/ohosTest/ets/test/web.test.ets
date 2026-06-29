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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { Want } from '@kit.AbilityKit';
import deviceInfo from '@ohos.deviceInfo';

const delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1500 = 1500;

const osFullNameInfo: string = deviceInfo.osFullName ?? '';
const platform = osFullNameInfo.split(' ')[0] ?? '';

async function navigateToPage(driver: Driver, buttonId: string) {
  const button = await driver.findComponent(ON.id(buttonId));
  if (!button) {
    console.error(`Button not found: ${buttonId}`);
    expect().assertFail();
    return;
  }
  await button.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1500);
  if (await driver.findComponent(ON.id("btn_back")) === undefined) {
    await driver.delayMs(WAIT_PAGE_READY_MS_1500);
  }
}

async function clickButton(driver: Driver, buttonId: string) {
  const button = await driver.findComponent(ON.id(buttonId));
  if (!button) {
    console.error(`Button not found: ${buttonId}`);
    expect().assertFail();
    return;
  }
  await button.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_500);
}

async function assertWebLoaded(driver: Driver) {
  const result = await driver.findComponent(ON.id('web_display_result_text'));
  expect(await result.getText()).assertEqual('网页加载成功');
}

export default function webTest() {
  describe('webTest', () => {
    let driver: Driver;

    beforeAll(async() => {
      try {
        const bundleName = abilityDelegatorRegistry.getArguments().bundleName;
        const want: Want = {
          bundleName: bundleName,
          abilityName: 'EntryAbility',
          moduleName: "entry"
        }
        await delegator.startAbility(want);
        driver = await Driver.create();
        await driver.delayMs(WAIT_PAGE_READY_MS_1500);
      } catch (error) {
        console.error(`beforeAll Error occurred: ${error}`);
      }
    })

    afterEach(async() => {
      await navigateToPage(driver, 'btn_back');
      await navigateToPage(driver, 'btn_back');
    })

    /**
     * @tc.number ArkUIX_Web_Web_OverviewModeAccess_0100
     * @tc.name ArkUIX_Web_Web_OverviewModeAccess_0100
     * @tc.desc Test web attribute overviewModeAccess, attribute is false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_Web_Web_OverviewModeAccess_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      await navigateToPage(driver, 'index_btn_overview_mode_access');
      await clickButton(driver, 'overview_mode_page_btn_false');
      await navigateToPage(driver, 'overview_mode_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_OverviewModeAccess_0200
     * @tc.name ArkUIX_Web_Web_OverviewModeAccess_0200
     * @tc.desc Test web attribute overviewModeAccess, attribute is true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_Web_Web_OverviewModeAccess_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      await navigateToPage(driver, 'index_btn_overview_mode_access');
      await clickButton(driver, 'overview_mode_page_btn_true');
      await navigateToPage(driver, 'overview_mode_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_OverviewModeAccess_0300
     * @tc.name ArkUIX_Web_Web_OverviewModeAccess_0300
     * @tc.desc Test web attribute overviewModeAccess, attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_Web_Web_OverviewModeAccess_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      await navigateToPage(driver, 'index_btn_overview_mode_access');
      await clickButton(driver, 'overview_mode_page_btn_unset');
      await navigateToPage(driver, 'overview_mode_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_OverviewModeAccess_0400
     * @tc.name ArkUIX_Web_Web_OverviewModeAccess_0400
     * @tc.desc Test web attribute overviewModeAccess, attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_OverviewModeAccess_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_overview_mode_access');
      await clickButton(driver, 'overview_mode_page_btn_null');
      await navigateToPage(driver, 'overview_mode_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_OverviewModeAccess_0500
     * @tc.name ArkUIX_Web_Web_OverviewModeAccess_0500
     * @tc.desc Test web attribute overviewModeAccess, attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_OverviewModeAccess_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_overview_mode_access');
      await clickButton(driver, 'overview_mode_page_btn_undefined');
      await navigateToPage(driver, 'overview_mode_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_LayoutMode_0100
     * @tc.name ArkUIX_Web_Web_LayoutMode_0100
     * @tc.desc Test web attribute layoutMode, attribute is WebLayoutMode.NONE
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_LayoutMode_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_layout_mode');
      await clickButton(driver, 'layout_mode_page_btn_none');
      await navigateToPage(driver, 'layout_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      const heightText = await driver.findComponent(ON.id('web_display_layout_web_height_text'));
      const height = Number((await heightText.getText()).replace(/[^0-9.]/g, ''));
      expect(height).assertEqual(300);
    });

    /**
     * @tc.number ArkUIX_Web_Web_LayoutMode_0200
     * @tc.name ArkUIX_Web_Web_LayoutMode_0200
     * @tc.desc Test web attribute layoutMode, attribute is WebLayoutMode.FIT
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_LayoutMode_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_layout_mode');
      await clickButton(driver, 'layout_mode_page_btn_fit_content');
      await navigateToPage(driver, 'layout_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      const heightText = await driver.findComponent(ON.id('web_display_layout_web_height_text'));
      const height = Number((await heightText.getText()).replace(/[^0-9.]/g, ''));
      expect(height > 300).assertEqual(true);
    });

    /**
     * @tc.number ArkUIX_Web_Web_LayoutMode_0300
     * @tc.name ArkUIX_Web_Web_LayoutMode_0300
     * @tc.desc Test web attribute layoutMode, attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_LayoutMode_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_layout_mode');
      await clickButton(driver, 'layout_mode_page_btn_unset');
      await navigateToPage(driver, 'layout_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      const heightText = await driver.findComponent(ON.id('web_display_layout_web_height_text'));
      const height = Number((await heightText.getText()).replace(/[^0-9.]/g, ''));
      expect(height).assertEqual(300);
    });

    /**
     * @tc.number ArkUIX_Web_Web_LayoutMode_0400
     * @tc.name ArkUIX_Web_Web_LayoutMode_0400
     * @tc.desc Test web attribute layoutMode, attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_LayoutMode_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_layout_mode');
      await clickButton(driver, 'layout_mode_page_btn_null');
      await navigateToPage(driver, 'layout_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      const heightText = await driver.findComponent(ON.id('web_display_layout_web_height_text'));
      const height = Number((await heightText.getText()).replace(/[^0-9.]/g, ''));
      expect(height).assertEqual(300);
    });

    /**
     * @tc.number ArkUIX_Web_Web_LayoutMode_0500
     * @tc.name ArkUIX_Web_Web_LayoutMode_0500
     * @tc.desc Test web attribute layoutMode, attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_LayoutMode_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_layout_mode');
      await clickButton(driver, 'layout_mode_page_btn_undefined');
      await navigateToPage(driver, 'layout_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      const heightText = await driver.findComponent(ON.id('web_display_layout_web_height_text'));
      const height = Number((await heightText.getText()).replace(/[^0-9.]/g, ''));
      expect(height).assertEqual(300);
    });

    /**
     * @tc.number ArkUIX_Web_Web_DarkMode_0100
     * @tc.name ArkUIX_Web_Web_DarkMode_0100
     * @tc.desc Test web attribute darkMode, attribute is WebDarkMode.Off
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_DarkMode_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_dark_mode');
      await clickButton(driver, 'dark_mode_page_btn_off');
      await navigateToPage(driver, 'dark_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_dark_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_dark_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DarkMode_0200
     * @tc.name ArkUIX_Web_Web_DarkMode_0200
     * @tc.desc Test web attribute darkMode, attribute is WebDarkMode.On
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_DarkMode_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_dark_mode');
      await clickButton(driver, 'dark_mode_page_btn_on');
      await navigateToPage(driver, 'dark_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_dark_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_dark_color_text'));
        expect(await colorText.getText()).assertContain('media=dark');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DarkMode_0300
     * @tc.name ArkUIX_Web_Web_DarkMode_0300
     * @tc.desc Test web attribute darkMode, attribute is WebDarkMode.Auto
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_DarkMode_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_dark_mode');
      await clickButton(driver, 'dark_mode_page_btn_auto');
      await navigateToPage(driver, 'dark_mode_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_DarkMode_0400
     * @tc.name ArkUIX_Web_Web_DarkMode_0400
     * @tc.desc Test web attribute darkMode, attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_DarkMode_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_dark_mode');
      await clickButton(driver, 'dark_mode_page_btn_unset');
      await navigateToPage(driver, 'dark_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_dark_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_dark_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DarkMode_0500
     * @tc.name ArkUIX_Web_Web_DarkMode_0500
     * @tc.desc Test web attribute darkMode, attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_DarkMode_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_dark_mode');
      await clickButton(driver, 'dark_mode_page_btn_null');
      await navigateToPage(driver, 'dark_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_dark_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_dark_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DarkMode_0600
     * @tc.name ArkUIX_Web_Web_DarkMode_0600
     * @tc.desc Test web attribute darkMode, attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_DarkMode_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_dark_mode');
      await clickButton(driver, 'dark_mode_page_btn_undefined');
      await navigateToPage(driver, 'dark_mode_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_dark_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_dark_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0100
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0100
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Off, forceDarkAccess attribute is false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_off');
      await clickButton(driver, 'force_dark_page_btn_force_false');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0200
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0200
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Off, forceDarkAccess attribute is true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_off');
      await clickButton(driver, 'force_dark_page_btn_force_true');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0300
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0300
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Off, forceDarkAccess attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_off');
      await clickButton(driver, 'force_dark_page_btn_force_unset');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0400
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0400
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Off, forceDarkAccess attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_off');
      await clickButton(driver, 'force_dark_page_btn_force_null');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0500
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0500
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Off, forceDarkAccess attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_off');
      await clickButton(driver, 'force_dark_page_btn_force_undefined');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0600
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0600
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.On, forceDarkAccess attribute is false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_on');
      await clickButton(driver, 'force_dark_page_btn_force_false');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=dark');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0700
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0700
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.On, forceDarkAccess attribute is true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_on');
      await clickButton(driver, 'force_dark_page_btn_force_true');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=dark');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0800
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0800
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.On, forceDarkAccess attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_on');
      await clickButton(driver, 'force_dark_page_btn_force_unset');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=dark');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_0900
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_0900
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.On, forceDarkAccess attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_on');
      await clickButton(driver, 'force_dark_page_btn_force_null');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=dark');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1000
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1000
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.On, forceDarkAccess attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_on');
      await clickButton(driver, 'force_dark_page_btn_force_undefined');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=dark');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1100
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1100
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Auto, forceDarkAccess attribute is false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_auto');
      await clickButton(driver, 'force_dark_page_btn_force_false');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1200
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1200
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Auto, forceDarkAccess attribute is true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_auto');
      await clickButton(driver, 'force_dark_page_btn_force_true');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1300
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1300
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Auto, forceDarkAccess attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_auto');
      await clickButton(driver, 'force_dark_page_btn_force_unset');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1400
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1400
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Auto, forceDarkAccess attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_auto');
      await clickButton(driver, 'force_dark_page_btn_force_null');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1500
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1500
     * @tc.desc Test web attribute forceDarkAccess, darkMode is WebDarkMode.Auto, forceDarkAccess attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_auto');
      await clickButton(driver, 'force_dark_page_btn_force_undefined');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1600
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1600
     * @tc.desc Test web attribute forceDarkAccess, darkMode is unset, forceDarkAccess attribute is false
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_unset');
      await clickButton(driver, 'force_dark_page_btn_force_false');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1700
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1700
     * @tc.desc Test web attribute forceDarkAccess, darkMode is unset, forceDarkAccess attribute is true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_unset');
      await clickButton(driver, 'force_dark_page_btn_force_true');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1800
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1800
     * @tc.desc Test web attribute forceDarkAccess, darkMode is unset, forceDarkAccess attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_unset');
      await clickButton(driver, 'force_dark_page_btn_force_unset');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_1900
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_1900
     * @tc.desc Test web attribute forceDarkAccess, darkMode is unset, forceDarkAccess attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_unset');
      await clickButton(driver, 'force_dark_page_btn_force_null');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_ForceDarkAccess_2000
     * @tc.name ArkUIX_Web_Web_ForceDarkAccess_2000
     * @tc.desc Test web attribute forceDarkAccess, darkMode is unset, forceDarkAccess attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_ForceDarkAccess_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_force_dark_access');
      await clickButton(driver, 'force_dark_page_btn_dark_unset');
      await clickButton(driver, 'force_dark_page_btn_force_undefined');
      await navigateToPage(driver, 'force_dark_page_btn_show_web');
      await assertWebLoaded(driver);
      if (platform !== 'Android') {
        await clickButton(driver, 'web_display_force_color_btn');
        const colorText = await driver.findComponent(ON.id('web_display_force_color_text'));
        expect(await colorText.getText()).assertContain('media=light');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0100
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0100
     * @tc.desc Test web attribute defaultFontSize, attribute is 16
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_16');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      expect(await fontSizeText.getText()).assertContain('16px');
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0200
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0200
     * @tc.desc Test web attribute defaultFontSize, attribute is 24
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_dynamic');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      expect(await fontSizeText.getText()).assertContain('24px');
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0300
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0300
     * @tc.desc Test web attribute defaultFontSize, attribute is unset
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_unset');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      expect(await fontSizeText.getText()).assertContain('16px');
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0400
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0400
     * @tc.desc Test web attribute defaultFontSize, attribute is 2147483647
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_max');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      expect(await fontSizeText.getText()).assertContain('72px');
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0500
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0500
     * @tc.desc Test web attribute defaultFontSize, attribute is -2147483648
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_min');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      if (platform === 'iOS') {
        expect(await fontSizeText.getText()).assertContain('1px');
      } else {
        expect(await fontSizeText.getText()).assertContain('8px');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0600
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0600
     * @tc.desc Test web attribute defaultFontSize, attribute is 2147483648
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_over_max');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      if (platform === 'iOS') {
        expect(await fontSizeText.getText()).assertContain('1px');
      } else {
        expect(await fontSizeText.getText()).assertContain('8px');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0700
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0700
     * @tc.desc Test web attribute defaultFontSize, attribute is -2147483649
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level4
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_under_min');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      expect(await fontSizeText.getText()).assertContain('72px');
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0800
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0800
     * @tc.desc Test web attribute defaultFontSize, attribute is null
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_null');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      if (platform === 'iOS') {
        expect(await fontSizeText.getText()).assertContain('1px');
      } else {
        expect(await fontSizeText.getText()).assertContain('8px');
      }
    });

    /**
     * @tc.number ArkUIX_Web_Web_DefaultFontSize_0900
     * @tc.name ArkUIX_Web_Web_DefaultFontSize_0900
     * @tc.desc Test web attribute defaultFontSize, attribute is undefined
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_Web_Web_DefaultFontSize_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      await navigateToPage(driver, 'index_btn_default_font_size');
      await clickButton(driver, 'default_font_size_page_btn_undefined');
      await navigateToPage(driver, 'default_font_size_page_btn_show_web');
      await assertWebLoaded(driver);
      await clickButton(driver, 'web_display_font_btn_get_size');
      const fontSizeText = await driver.findComponent(ON.id('web_display_font_size_text'));
      if (platform === 'iOS') {
        expect(await fontSizeText.getText()).assertContain('1px');
      } else {
        expect(await fontSizeText.getText()).assertContain('8px');
      }
    });
  })
}
