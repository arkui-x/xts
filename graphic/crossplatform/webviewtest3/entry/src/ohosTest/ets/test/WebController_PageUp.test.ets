/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

export default function WebController_PageUp() {
  describe('WebController_PageUp', () => {
    /**
     * beforeAll: PrePageControlTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest3', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PrePageControlTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const Page: Component = await driver.findComponent(ON.text('WebController_Index'));
      await Page.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('WebController_PageUp'));
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
     * @tc.desc  : 异常处理判断-17100001
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_PageUp_Func_0100', 0, async () => {
      // 点击异常按钮
      console.log('SUB_Web_WebView_WebController_GetOriginalUrl_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(2000);
      const PRECISE: Component = await driver.findComponent(ON.id('17100001'));
      await PRECISE.click();
      await driver.delayMs(2000);

      // 判断异常信息
      const callMsgComponent: Component = await driver.findComponent(ON.id('callMsg'));
      const callMsgText: string = await callMsgComponent.getText();
      expect(`${callMsgText}`).assertContain('17100001');
      console.log('SUB_Web_WebView_WebController_GetOriginalUrl_Func_0100 success');
      console.log('SUB_Web_WebView_WebController_GetOriginalUrl_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_WebController_PageUp_Func_0200
     * @tc.name  : SUB_Web_WebView_WebController_PageUp_Func_0200
     * @tc.desc  : 异常处理判断-401
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_PageUp_Func_0200', 0, async () => {
      // 点击异常按钮
      console.log('SUB_Web_WebView_WebController_PageUp_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(2000);
      const PRECISE: Component = await driver.findComponent(ON.id('401'));
      await PRECISE.click();
      await driver.delayMs(2000);

      // 判断异常信息
      const callMsgComponent: Component = await driver.findComponent(ON.id('callMsg'));
      const callMsgText: string = await callMsgComponent.getText();
      expect(`${callMsgText}`).assertContain('401');
      console.log('SUB_Web_WebView_WebController_PageUp_Func_0200 success');
      console.log('SUB_Web_WebView_WebController_PageUp_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_WebController_PageUp_Func_0300
     * @tc.name  : SUB_Web_WebView_WebController_PageUp_Func_0300
     * @tc.desc  : 正常点击按钮pageUp按钮，包括参数不同
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_PageUp_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_WebController_PageUp_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);

      // 向上滑动webview页面
      const PAGE_UP_SCROLL: Component = await driver.findComponent(ON.id('pageUp_scrollTo'));
      await PAGE_UP_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);

      // 点击pageUp，参数为true
      const PAGE_UP_TRUE: Component = await driver.findComponent(ON.id('pageUp_true'));
      await PAGE_UP_TRUE.click();
      await driver.delayMs(waitUiReadyMs);

      // 判断滚动的坐标点到 0
      const MY_TIPS_PAGE_UP_TRUE: Component = await driver.findComponent(ON.id('MY_VALUE_SCROLL'));
      const MY_VALUE_PAGE_UP_TRUE: string = await MY_TIPS_PAGE_UP_TRUE.getText();
      expect(`${MY_VALUE_PAGE_UP_TRUE}`).assertContain('0');

      // 向上滑动webview页面
      await driver.delayMs(waitUiReadyMs);
      await PAGE_UP_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);

      // 点击pageUp，参数为false
      const PAGE_UP_FALSE: Component = await driver.findComponent(ON.id('pageUp_false'));
      await PAGE_UP_FALSE.click();
      await driver.delayMs(waitUiReadyMs);

      // 判断滚动的类型是pageUp_false
      const MY_TIPS_PAGE_UP_FALSE: Component = await driver.findComponent(ON.id('MY_VALUE_SCROLL_type'));
      const MY_VALUE_PAGE_UP_FALSE: string = await MY_TIPS_PAGE_UP_FALSE.getText();
      expect(`${MY_VALUE_PAGE_UP_FALSE}`).assertContain('pageUp_false');
      console.log('SUB_Web_WebView_WebController_PageUp_Func_0300 success');
      console.log('SUB_Web_WebView_WebController_PageUp_Func_0300 test end');
    });
  });
}
