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

import { describe, it, expect, beforeAll, beforeEach, afterEach, afterAll, } from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import { startAbility, stopAbility, waitUiReadyMs } from '../utils/index';

export default function CookieManage_ClearSessionCookieTest() {
  describe('CookieManage_ClearSessionCookieTest', () => {
    /**
     * beforeAll: PrePageControlTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest4', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PrePageControlTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const Page: Component = await driver.findComponent(ON.text('Cookie_Index'));
      await Page.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('CookieManage_ClearSessionCookie'));
      await TAB.click();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(() => {
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll(async () => {
      await stopAbility();
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * @tc.number: SUB_Web_WebView_Stop_Func_0100
     * @tc.name  : SUB_Web_WebView_Stop_Func_0100
     * @tc.desc  : test whether the stop function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('ClearSessionCookieId'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('clearSessionCookie_Text'));
      const clearText: string = await MY_TIPS.getText();
      expect(`${clearText}`).assertContain('已经清除完毕');
      console.log('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0100 success');
      console.log('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0100 test end');
    });

    it('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('getError'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('clearSessionCookie_errorCode'));
      const errorCode: string = await MY_TIPS.getText();
      expect(`${errorCode}`).assertContain('401');
      console.log('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0200 success');
      console.log('SUB_Web_WebView_CookieManage_ClearSessionCookie_Func_0200 test end');
    });
  });
}
