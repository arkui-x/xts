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

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function CookieManagerTest() {
  describe('CookieManagerTest', () => {

    /**
     * beforeAll: PreCookieManagerTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest2', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreCookieManagerTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto operation'));
      await TAB.click();
      await driver.delayMs(2000);
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * @tc.number: SUB_Web_WebView_On_Load_Intercept_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Load_Intercept_Func_0100
     * @tc.desc  : test whether the OnLoadIntercept attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Load_Intercept_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Load_Intercept_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto load'));
      await TAB.click();
      await driver.delayMs(2000);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await ON_EVENT_URL.getText();
      if (url.includes('alert')) {
        expect(url).assertEqual('index_alert.html');
      } else {
        const BOF: Component = await driver.findComponent(ON.text('BOF'));
        await BOF.click();
        await driver.delayMs(waitUiReadyMs);
        const choice: Component = await driver.findComponent(ON.text('-1'));
        await choice.click();
        await driver.delayMs(waitUiReadyMs);
      }
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('阻止此次加载');
      console.log('SUB_Web_WebView_On_Load_Intercept_Func_0100 success');
      console.log('SUB_Web_WebView_On_Load_Intercept_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Config_Cookie_Func_0100
     * @tc.name  : SUB_Web_WebView_Config_Cookie_Func_0100
     * @tc.desc  : test whether the configCookie function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Config_Cookie_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Config_Cookie_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CONFIG_BUTTON: Component = await driver.findComponent(ON.text('CONFIG'));
      await CONFIG_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const FUNC_TYPE: Component = await driver.findComponent(ON.text('callback'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertContain('config cookie success');
      expect(value).assertContain('test=123');
      console.log('SUB_Web_WebView_Config_Cookie_Func_0100 success');
      console.log('SUB_Web_WebView_Config_Cookie_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Config_Cookie_Func_0200
     * @tc.name  : SUB_Web_WebView_Config_Cookie_Func_0200
     * @tc.desc  : test whether the configCookie、clearAllCookies function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Config_Cookie_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Config_Cookie_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let CONFIG_BUTTON: Component = await driver.findComponent(ON.text('CONFIG'));
      await CONFIG_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      let FUNC_TYPE: Component = await driver.findComponent(ON.text('promise'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertContain('config cookie success');
      expect(value).assertContain('test=123');
      const CLEAR_BUTTON: Component = await driver.findComponent(ON.text('CLEAR_ALL'));
      await CLEAR_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      FUNC_TYPE = await driver.findComponent(ON.text('promise'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertEqual('clear all');
      console.log('SUB_Web_WebView_Config_Cookie_Func_0200 success');
      console.log('SUB_Web_WebView_Config_Cookie_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Fetch_Cookie_Func_0100
     * @tc.name  : SUB_Web_WebView_Fetch_Cookie_Func_0100
     * @tc.desc  : test whether the fetchCookie function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Fetch_Cookie_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let CONFIG_BUTTON: Component = await driver.findComponent(ON.text('CONFIG'));
      await CONFIG_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      let FUNC_TYPE: Component = await driver.findComponent(ON.text('callback'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      const FETCH_BUTTON: Component = await driver.findComponent(ON.text('FETCH'));
      await FETCH_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      FUNC_TYPE = await driver.findComponent(ON.text('callback'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertEqual('test=123');
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0100 success');
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Fetch_Cookie_Func_0200
     * @tc.name  : SUB_Web_WebView_Fetch_Cookie_Func_0200
     * @tc.desc  : test whether the fetchCookie function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Fetch_Cookie_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let CONFIG_BUTTON: Component = await driver.findComponent(ON.text('CONFIG'));
      await CONFIG_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      let FUNC_TYPE: Component = await driver.findComponent(ON.text('promise'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      const FETCH_BUTTON: Component = await driver.findComponent(ON.text('FETCH'));
      await FETCH_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      FUNC_TYPE = await driver.findComponent(ON.text('promise'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('test=123');
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0200 success');
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Fetch_Cookie_Func_0300
     * @tc.name  : SUB_Web_WebView_Fetch_Cookie_Func_0300
     * @tc.desc  : test whether the fetchCookie、clearAllCookie function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Fetch_Cookie_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let CONFIG_BUTTON: Component = await driver.findComponent(ON.text('CONFIG'));
      await CONFIG_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      let FUNC_TYPE: Component = await driver.findComponent(ON.text('promise'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      const FETCH_BUTTON: Component = await driver.findComponent(ON.text('FETCH'));
      await FETCH_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      FUNC_TYPE = await driver.findComponent(ON.text('promise'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('test=123');
      const CLEAR_BUTTON: Component = await driver.findComponent(ON.text('CLEAR_ALL'));
      await CLEAR_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      FUNC_TYPE = await driver.findComponent(ON.text('promise'));
      await FUNC_TYPE.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertEqual('clear all');
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0300 success');
      console.log('SUB_Web_WebView_Fetch_Cookie_Func_0300 test end');
    });
  });
}
