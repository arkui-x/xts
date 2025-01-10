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

export default function WebController_GetWebIdTest() {
  describe('WebController_PostUrlTest', () => {
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
      // 向上滑动屏幕，方便找到导航按钮
      await driver.fling({x: 500, y: 800}, {x: 450, y: 300}, 5, 600);
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('WebController_PostUrl'));
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
     * @tc.level : 0
     */
    it('SUB_Web_WebView_PostUrl_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_PostUrl_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const GET_PRECISE: Component = await driver.findComponent(ON.id('get1'));
      await GET_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('errorCode'));
      const text: string = await MY_TIPS.getText();
      expect(`${text}`).assertContain('17100001');
      console.log('SUB_Web_WebView_PostUrl_Func_0100 success');
      console.log('SUB_Web_WebView_PostUrl_Func_0100 test end');
    });

    it('SUB_Web_WebView_PostUrl_Func_0101', 0, async () => {
      console.log('SUB_Web_WebView_PostUrl_Func_0101 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const GET_PRECISE: Component = await driver.findComponent(ON.id('get2'));
      await GET_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('errorCode'));
      const text: string = await MY_TIPS.getText();
      expect(`${text}`).assertContain('17100002');
      console.log('SUB_Web_WebView_PostUrl_Func_0101 success');
      console.log('SUB_Web_WebView_PostUrl_Func_0101 test end');
    });

    it('SUB_Web_WebView_PostUrl_Func_0102', 0, async () => {
      console.log('SUB_Web_WebView_PostUrl_Func_0102 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const GET_PRECISE: Component = await driver.findComponent(ON.id('get401'));
      await GET_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('errorCode'));
      const text: string = await MY_TIPS.getText();
      expect(`${text}`).assertContain('401');
      console.log('SUB_Web_WebView_PostUrl_Func_0102 success');
      console.log('SUB_Web_WebView_PostUrl_Func_0102 test end');
    });

    it('SUB_Web_WebView_PostUrl_Func_0103', 0, async () => {
      console.log('SUB_Web_WebView_PostUrl_Func_0103 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const GET_PRECISE: Component = await driver.findComponent(ON.id('postUrlId'));
      await GET_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('TextId'));
      const text: string = await MY_TIPS.getText();
      expect(`${text}`).assertContain('https://developer.huawei.com/');
      console.log('SUB_Web_WebView_PostUrl_Func_0103 success');
      console.log('SUB_Web_WebView_PostUrl_Func_0103 test end');
    });

    it('SUB_Web_WebView_PostUrl_Func_0104', 0, async () => {
      console.log('SUB_Web_WebView_PostUrl_Func_0104 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const GET_PRECISE: Component = await driver.findComponent(ON.id('setResource'));
      await GET_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const GET_PRECISE2: Component = await driver.findComponent(ON.id('postUrlId'));
      await GET_PRECISE2.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('TextId'));
      const text: string = await MY_TIPS.getText();
      expect(`${text}`).assertContain('resource://rawfile/index.html');
      console.log('SUB_Web_WebView_PostUrl_Func_0104 success');
      console.log('SUB_Web_WebView_PostUrl_Func_0104 test end');
    });

    // it('SUB_Web_WebView_PostUrl_Func_0100', 0, async () => {
    //   console.log('SUB_Web_WebView_PostUrl_Func_0100 test start');
    //   const driver: Driver = Driver.create();
    //   await driver.delayMs(waitUiReadyMs);
    //   const GET_PRECISE: Component = await driver.findComponent(ON.id('getUrlId'));
    //   await GET_PRECISE.click();
    //   const MY_TIPS: Component = await driver.findComponent(ON.id('TextId'));
    //   const text: string = await MY_TIPS.getText();
    //   expect(`${text}`).assertContain('getUrl:');
    //   console.log('SUB_Web_WebView_PostUrl_Func_0100 success');
    //   console.log('SUB_Web_WebView_PostUrl_Func_0100 test end');
    // });
    //
    // it('SUB_Web_WebView_PostUrl_Func_0201', 0, async () => {
    //   console.log('SUB_Web_WebView_PostUrl_Func_0101 test start');
    //   const driver: Driver = Driver.create();
    //   await driver.delayMs(waitUiReadyMs);
    //   const POST_PRECISE: Component = await driver.findComponent(ON.id('postUrlId'));
    //   await POST_PRECISE.click();
    //   await driver.delayMs(waitUiReadyMs);
    //   const GET_PRECISE: Component = await driver.findComponent(ON.id('getUrlId'));
    //   await GET_PRECISE.click();
    //   await driver.delayMs(waitUiReadyMs);
    //   const MY_TIPS: Component = await driver.findComponent(ON.id('TextId'));
    //   const text: string = await MY_TIPS.getText();
    //   expect(`${text}`).assertContain('getUrl:https://developer.huawei.com/');
    //   console.log('SUB_Web_WebView_PostUrl_Func_0101 success');
    //   console.log('SUB_Web_WebView_PostUrl_Func_0101 test end');
    // });

  });
}
