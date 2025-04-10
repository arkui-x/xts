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

export default function ScrollTest() {
  describe('ScrollTest', () => {

    /**
     * beforeAll: PreScrollTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest2', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreScrollTest at the test case level, which are executed before each test case is executed.
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
     * @tc.number: SUB_Web_WebView_Scroll_To_Func_0100
     * @tc.name  : SUB_Web_WebView_Scroll_To_Func_0100
     * @tc.desc  : test whether the scrollTo function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Scroll_To_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Scroll_To_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLL_TO_PRECISE: Component = await driver.findComponent(ON.text('Scroll Precise'));
      await SCROLL_TO_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLL_TO: Component = await driver.findComponent(ON.text('滚动到指定位置'));
      await SCROLL_TO.click();
      await driver.delayMs(waitUiReadyMs);
      let precise: Component = await driver.findComponent(ON.text('100'));
      await precise.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 100,100');
      const MY_TIPS: Component = await driver.findComponent(ON.id('MY_TIPS'));
      const tips: string = await MY_TIPS.getText();
      expect(tips).assertEqual('onScroll -> 100,100');
      console.log('SUB_Web_WebView_Scroll_To_Func_0100 success');
      console.log('SUB_Web_WebView_Scroll_To_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Scroll_To_Func_0200
     * @tc.name  : SUB_Web_WebView_Scroll_To_Func_0200
     * @tc.desc  : test whether the scrollTo function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Scroll_To_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Scroll_To_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const RESTORE: Component = await driver.findComponent(ON.text('Restore'));
      await RESTORE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 0,0');
      const SCROLL_TO_PRECISE: Component = await driver.findComponent(ON.text('Scroll Precise'));
      await SCROLL_TO_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLL_TO: Component = await driver.findComponent(ON.text('滚动到指定位置'));
      await SCROLL_TO.click();
      await driver.delayMs(waitUiReadyMs);
      let precise: Component = await driver.findComponent(ON.text('200'));
      await precise.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('MY_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 200,200');
      let MY_TIPS: Component = await driver.findComponent(ON.id('MY_TIPS'));
      let tips: string = await MY_TIPS.getText();
      expect(tips).assertEqual('onScroll -> 200,200');
      console.log('SUB_Web_WebView_Scroll_To_Func_0200 success');
      console.log('SUB_Web_WebView_Scroll_To_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Scroll_To_Func_0300
     * @tc.name  : SUB_Web_WebView_Scroll_To_Func_0300
     * @tc.desc  : test whether the scrollTo function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Scroll_To_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_Scroll_To_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const RESTORE: Component = await driver.findComponent(ON.text('Restore'));
      await RESTORE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 0,0');
      const SCROLL_TO_PRECISE: Component = await driver.findComponent(ON.text('Scroll Precise'));
      await SCROLL_TO_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      let SCROLL_TO: Component = await driver.findComponent(ON.text('滚动到指定位置'));
      await SCROLL_TO.click();
      await driver.delayMs(waitUiReadyMs);
      const precise_100: Component = await driver.findComponent(ON.text('100'));
      await precise_100.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('MY_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 100,100');
      let MY_TIPS: Component = await driver.findComponent(ON.id('MY_TIPS'));
      let tips: string = await MY_TIPS.getText();
      expect(tips).assertEqual('onScroll -> 100,100');
      console.log('SUB_Web_WebView_Scroll_To_Func_0300 success');
      console.log('SUB_Web_WebView_Scroll_To_Func_0300 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Scroll_To_Func_0400
     * @tc.name  : SUB_Web_WebView_Scroll_To_Func_0400
     * @tc.desc  : test whether the scrollTo function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Scroll_To_Func_0400', 0, async () => {
      console.log('SUB_Web_WebView_Scroll_To_Func_0400 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const RESTORE: Component = await driver.findComponent(ON.text('Restore'));
      await RESTORE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 0,0');
      const SCROLL_TO_RANDOM: Component = await driver.findComponent(ON.text('ScrollRandom'));
      await SCROLL_TO_RANDOM.click();
      await driver.delayMs(waitUiReadyMs);
      let SCROLL_TO: Component = await driver.findComponent(ON.text('滚动到指定位置'));
      await SCROLL_TO.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('MY_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertContain('scroll to');
      const loc: string[] = value.trim().split(':')[1].split(',');
      expect(loc[0]).assertLessOrEqual(1000);
      expect(loc[0]).assertLargerOrEqual(0);
      expect(loc[1]).assertLessOrEqual(1000);
      expect(loc[1]).assertLargerOrEqual(0);
      console.log('SUB_Web_WebView_Scroll_To_Func_0400 success');
      console.log('SUB_Web_WebView_Scroll_To_Func_0400 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Scroll_By_Func_0100
     * @tc.name  : SUB_Web_WebView_Scroll_By_Func_0100
     * @tc.desc  : test whether the scrollBy function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Scroll_By_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Scroll_By_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const RESTORE: Component = await driver.findComponent(ON.text('Restore'));
      await RESTORE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 0,0');
      const SCROLL_BY_PRECISE: Component = await driver.findComponent(ON.text('Scroll Precise'));
      await SCROLL_BY_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLL_BY: Component = await driver.findComponent(ON.text('滚动指定偏移量'));
      await SCROLL_BY.click();
      await driver.delayMs(waitUiReadyMs);
      let precise: Component = await driver.findComponent(ON.text('100'));
      await precise.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('MY_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertEqual('水平偏移: 100, 垂直偏移: 100');
      console.log('SUB_Web_WebView_Scroll_By_Func_0100 success');
      console.log('SUB_Web_WebView_Scroll_By_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Scroll_By_Func_0200
     * @tc.name  : SUB_Web_WebView_Scroll_By_Func_0200
     * @tc.desc  : test whether the scrollBy function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Scroll_By_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Scroll_By_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const RESTORE: Component = await driver.findComponent(ON.text('Restore'));
      await RESTORE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 0,0');
      const SCROLL_BY_PRECISE: Component = await driver.findComponent(ON.text('Scroll Precise'));
      await SCROLL_BY_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLL_BY: Component = await driver.findComponent(ON.text('滚动指定偏移量'));
      await SCROLL_BY.click();
      await driver.delayMs(waitUiReadyMs);
      let precise: Component = await driver.findComponent(ON.text('200'));
      await precise.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('MY_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertEqual('水平偏移: 200, 垂直偏移: 200');
      console.log('SUB_Web_WebView_Scroll_By_Func_0200 success');
      console.log('SUB_Web_WebView_Scroll_By_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Scroll_By_Func_0300
     * @tc.name  : SUB_Web_WebView_Scroll_By_Func_0300
     * @tc.desc  : test whether the scrollBy function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Scroll_By_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_Scroll_By_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const RESTORE: Component = await driver.findComponent(ON.text('Restore'));
      await RESTORE.click();
      await driver.delayMs(waitUiReadyMs);
      let MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      let value: string = await MY_VALUE.getText();
      expect(value).assertEqual('scroll to: 0,0');
      const SCROLL_BY_RANDOM: Component = await driver.findComponent(ON.text('ScrollRandom'));
      await SCROLL_BY_RANDOM.click();
      await driver.delayMs(waitUiReadyMs);
      const SCROLL_BY: Component = await driver.findComponent(ON.text('滚动指定偏移量'));
      await SCROLL_BY.click();
      await driver.delayMs(waitUiReadyMs);
      MY_VALUE = await driver.findComponent(ON.id('MY_VALUE'));
      value = await MY_VALUE.getText();
      expect(value).assertContain('水平偏移');
      expect(value).assertContain('垂直偏移');
      const all: string[] = value.trim().split(',');
      const horizontal_offset: string = all[0].split(':')[1];
      const vertical_offset: string = all[1].split(':')[1];
      expect(horizontal_offset).assertLessOrEqual(1000);
      expect(horizontal_offset).assertLargerOrEqual(0);
      expect(vertical_offset).assertLessOrEqual(1000);
      expect(vertical_offset).assertLargerOrEqual(0);
      console.log('SUB_Web_WebView_Scroll_By_Func_0300 success');
      console.log('SUB_Web_WebView_Scroll_By_Func_0300 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Set_Custom_User_Agent_Func_0100
     * @tc.name  : SUB_Web_WebView_Set_Custom_User_Agent_Func_0100
     * @tc.desc  : test whether the setCustomUserAgent function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Set_Custom_User_Agent_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Set_Custom_User_Agent_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SET: Component = await driver.findComponent(ON.text('setUserAgent'));
      await SET.click();
      await driver.delayMs(waitUiReadyMs);
      const APPLE: Component = await driver.findComponent(ON.text('苹果'));
      await APPLE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertContain('设置');
      expect(value).assertContain('苹果');
      console.log('SUB_Web_WebView_Set_Custom_User_Agent_Func_0100 success');
      console.log('SUB_Web_WebView_Set_Custom_User_Agent_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Get_Custom_User_Agent_Func_0100
     * @tc.name  : SUB_Web_WebView_Get_Custom_User_Agent_Func_0100
     * @tc.desc  : test whether the getCustomUserAgent function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Custom_User_Agent_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Get_Custom_User_Agent_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SET: Component = await driver.findComponent(ON.text('setUserAgent'));
      await SET.click();
      await driver.delayMs(waitUiReadyMs);
      const APPLE: Component = await driver.findComponent(ON.text('苹果'));
      await APPLE.click();
      await driver.delayMs(waitUiReadyMs);
      const GET: Component = await driver.findComponent(ON.text('getUserAgent'));
      await GET.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertContain('获取');
      expect(value).assertContain('苹果');
      console.log('SUB_Web_WebView_Get_Custom_User_Agent_Func_0100 success');
      console.log('SUB_Web_WebView_Get_Custom_User_Agent_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Set_Custom_User_Agent_Func_0200
     * @tc.name  : SUB_Web_WebView_Set_Custom_User_Agent_Func_0200
     * @tc.desc  : test whether the setCustomUserAgent function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Set_Custom_User_Agent_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Set_Custom_User_Agent_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SET: Component = await driver.findComponent(ON.text('setUserAgent'));
      await SET.click();
      await driver.delayMs(waitUiReadyMs);
      const APPLE: Component = await driver.findComponent(ON.text('西瓜'));
      await APPLE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertContain('设置');
      expect(value).assertContain('西瓜');
      console.log('SUB_Web_WebView_Set_Custom_User_Agent_Func_0200 success');
      console.log('SUB_Web_WebView_Set_Custom_User_Agent_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Get_Custom_User_Agent_Func_0200
     * @tc.name  : SUB_Web_WebView_Get_Custom_User_Agent_Func_0200
     * @tc.desc  : test whether the getCustomUserAgent function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Custom_User_Agent_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Get_Custom_User_Agent_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SHOW_SCROLL: Component = await driver.findComponent(ON.text('scroll'));
      await SHOW_SCROLL.click();
      await driver.delayMs(waitUiReadyMs);
      const SET: Component = await driver.findComponent(ON.text('setUserAgent'));
      await SET.click();
      await driver.delayMs(waitUiReadyMs);
      const APPLE: Component = await driver.findComponent(ON.text('西瓜'));
      await APPLE.click();
      await driver.delayMs(waitUiReadyMs);
      const GET: Component = await driver.findComponent(ON.text('getUserAgent'));
      await GET.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertContain('获取');
      expect(value).assertContain('西瓜');
      console.log('SUB_Web_WebView_Get_Custom_User_Agent_Func_0200 success');
      console.log('SUB_Web_WebView_Get_Custom_User_Agent_Func_0200 test end');
    });
  });
}
