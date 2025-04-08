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
import { startAbility, stopAbility, waitUiReadyMs } from '../utils/index';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function StopTest() {
  describe('StopTest', () => {

    /**
     * beforeAll: PrePageControlTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest2', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PrePageControlTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto HTMLControl'));
      await TAB.click();
      await driver.delayMs(waitUiReadyMs);
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
    it('SUB_Web_WebView_Stop_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Stop_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const STOP: Component = await driver.findComponent(ON.text('10毫秒后Stop'));
      await STOP.click();
      await driver.delayMs(waitUiReadyMs);
      const ALERT_DIALOG_OK: Component = await driver.findComponent(ON.text('ok'));
      await ALERT_DIALOG_OK.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const text: string = await MY_VALUE.getText();
      const MY_TIPS: Component = await driver.findComponent(ON.id('MY_TIPS'));
      const tips: string = await MY_TIPS.getText();
      expect(text).assertEqual('停止加载Confirm页面');
      expect(tips).assertEqual('newProgress: 100');
      console.log('SUB_Web_WebView_Stop_Func_0100 success');
      console.log('SUB_Web_WebView_Stop_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Stop_Func_0200
     * @tc.name  : SUB_Web_WebView_Stop_Func_0200
     * @tc.desc  : test whether the stop function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Stop_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Stop_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const NOT_STOP: Component = await driver.findComponent(ON.text('不调用Stop'));
      await NOT_STOP.click();
      await driver.delayMs(waitUiReadyMs * 2);
      const MY_TO_STRING: Component = await driver.findComponent(ON.id('MY_TO_STRING'));
      const text: string = await MY_TO_STRING.getText();
      expect(text).assertEqual('pageConfirm loaded');
      console.log('SUB_Web_WebView_Stop_Func_0200 success');
      console.log('SUB_Web_WebView_Stop_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0100
     * @tc.name  : SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0100
     * @tc.desc  : test whether the horizontalScrollBarAccess attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLLABLE: Component = await driver.findComponent(ON.text('scrollable'));
      await SCROLLABLE.click();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_HORIZONTAL: Component = await driver.findComponent(ON.text('显示横轴滚动条'));
      await SHOW_HORIZONTAL.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertEqual('horizontal scrollbar is show,vertical scrollbar is hide');
      console.log('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0100 success');
      console.log('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0200
     * @tc.name  : SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0200
     * @tc.desc  : test whether the horizontalScrollBarAccess attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLLABLE: Component = await driver.findComponent(ON.text('scrollable'));
      await SCROLLABLE.click();
      await driver.delayMs(waitUiReadyMs);
      const HIDE_HORIZONTAL: Component = await driver.findComponent(ON.text('隐藏横轴滚动条'));
      await HIDE_HORIZONTAL.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertEqual('horizontal scrollbar is hide,vertical scrollbar is hide');
      console.log('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0200 success');
      console.log('SUB_Web_WebView_Horizontal_ScrollBar_Access_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0100
     * @tc.name  : SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0100
     * @tc.desc  : test whether the verticalScrollBarAccess attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLLABLE: Component = await driver.findComponent(ON.text('scrollable'));
      await SCROLLABLE.click();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_VERTICAL: Component = await driver.findComponent(ON.text('显示纵轴滚动条'));
      await SHOW_VERTICAL.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertEqual('horizontal scrollbar is hide,vertical scrollbar is show');
      console.log('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0100 success');
      console.log('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0200
     * @tc.name  : SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0200
     * @tc.desc  : test whether the verticalScrollBarAccess attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLLABLE: Component = await driver.findComponent(ON.text('scrollable'));
      await SCROLLABLE.click();
      await driver.delayMs(waitUiReadyMs);
      const HIDE_VERTICAL: Component = await driver.findComponent(ON.text('隐藏纵轴滚动条'));
      await HIDE_VERTICAL.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertEqual('horizontal scrollbar is hide,vertical scrollbar is hide');
      console.log('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0200 success');
      console.log('SUB_Web_WebView_Vertical_ScrollBar_Access_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Get_Page_Height_Func_0200
     * @tc.name  : SUB_Web_WebView_Get_Page_Height_Func_0200
     * @tc.desc  : test whether the getPageHeight function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Page_Height_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Get_Page_Height_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const GET_BUTTON: Component = await driver.findComponent(ON.text('GET_HEIGHT'));
      await GET_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_COUNT: Component = await driver.findComponent(ON.id('MY_COUNT'));
      const heightStr: string = await MY_COUNT.getText();
      const height: number = Number(heightStr.trim().split(':')[1]);
      expect(height).assertLarger(1000);
      console.log('SUB_Web_WebView_Get_Page_Height_Func_0200 success');
      console.log('SUB_Web_WebView_Get_Page_Height_Func_0200 test end');
    });
  });
}
