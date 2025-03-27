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

import {
  describe,
  it,
  expect,
  beforeAll,
  beforeEach,
  afterEach,
  afterAll,
} from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import { startAbility, stopAbility, waitUiReadyMs, sleep } from '../utils/index';

export default function OnPageVisibleTest() {
  describe('OnPageVisibleTest', () => {
    /**
     * beforeAll: PreOnPageVisibleTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: OnPageVisibleTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto onPageVisible'));
      await TAB.click();
      await driver.delayMs(2000);
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(async () => {
      await sleep(1000)
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
     * @tc.number: SUB_Web_WebView_On_Page_Visible_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Page_Visible_Func_0100
     * @tc.desc  : test whether the onPageVisible attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Page_Visible_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ON_PAGE_VISIBLE_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const text: string = await ON_PAGE_VISIBLE_EVENT_URL.getText();
      console.log(`SUB_Web_WebView_On_Page_Visible_Func_0100 ON_PAGE_VISIBLE_EVENT_URL: ${text}`);
      expect(text).assertContain('onPageVisible');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0100 success');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_On_Page_Visible_Func_0200
     * @tc.name  : SUB_Web_WebView_On_Page_Visible_Func_0200
     * @tc.desc  : test whether the onPageVisible attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Page_Visible_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER_BUTTON: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const OK_BUTTON: Component = await driver.findComponent(ON.text('ok'));
      await OK_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const PAGE_VISIBLE_MSG: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      const msg: string = await PAGE_VISIBLE_MSG.getText();
      console.log(`SUB_Web_WebView_On_Page_Visible_Func_0200 PAGE_VISIBLE_MSG: ${msg}`);
      expect(msg).assertEqual('page_visible_alert_message');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0200 success');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_On_Page_Visible_Func_0300
     * @tc.name  : SUB_Web_WebView_On_Page_Visible_Func_0300
     * @tc.desc  : test whether the onPageVisible attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Page_Visible_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER_BUTTON: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const OK_BUTTON: Component = await driver.findComponent(ON.text('ok'));
      await OK_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const BUTTON_CLICKED: Component = await driver.findComponent(ON.id('ON_BUTTON_CLICK'));
      const BUTTON_CLICKED_TEXT = await BUTTON_CLICKED.getText();
      expect(BUTTON_CLICKED_TEXT).assertEqual('OK_CLICKED');
      const PAGE_VISIBLE_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await PAGE_VISIBLE_URL.getText();
      expect(url).assertContain('onPageVisible');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0300 success');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0300 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_On_Page_Visible_Func_0400
     * @tc.name  : SUB_Web_WebView_On_Page_Visible_Func_0400
     * @tc.desc  : test whether the onPageVisible attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Page_Visible_Func_0400', 0, async () => {
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0400 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER_BUTTON: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const OK_BUTTON: Component = await driver.findComponent(ON.text('ok'));
      await OK_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const PAGE_VISIBLE_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await PAGE_VISIBLE_URL.getText();
      expect(url).assertContain('onPageVisible');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0400 success');
      console.log('SUB_Web_WebView_On_Page_Visible_Func_0400 test end');
    });
  });
}
