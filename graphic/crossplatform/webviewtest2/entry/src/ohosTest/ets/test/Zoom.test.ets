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

export default function ZoomTest() {
  describe('ZoomTest', () => {

    /**
     * beforeAll: PreZoomTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest2', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreZoomTest at the test case level, which are executed before each test case is executed.
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
     * @tc.number: SUB_Web_WebView_Zoom_Func_0100
     * @tc.name  : SUB_Web_WebView_Zoom_Func_0100
     * @tc.desc  : test whether the zoom function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Zoom_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Zoom_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('ZoomPrecise'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const PRECISE: Component = await driver.findComponent(ON.text('magnify'));
      await PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      const MY_TIPS: Component = await driver.findComponent(ON.id('MY_TIPS'));
      const tips: string = await MY_TIPS.getText();
      expect(value).assertContain('magnify');
      expect(tips).assertContain('onScaleChange changed');
      console.log('SUB_Web_WebView_Zoom_Func_0100 success');
      console.log('SUB_Web_WebView_Zoom_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Zoom_Func_0200
     * @tc.name  : SUB_Web_WebView_Zoom_Func_0200
     * @tc.desc  : test whether the zoom function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Zoom_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Zoom_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('ZoomPrecise'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      let PRECISE: Component = await driver.findComponent(ON.text('magnify'));
      await PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      PRECISE = await driver.findComponent(ON.text('shrink'));
      await PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      const MY_TIPS: Component = await driver.findComponent(ON.id('MY_TIPS'));
      const tips: string = await MY_TIPS.getText();
      expect(value).assertContain('shrink');
      expect(tips).assertContain('onScaleChange changed');
      console.log('SUB_Web_WebView_Zoom_Func_0200 success');
      console.log('SUB_Web_WebView_Zoom_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Zoom_Func_0300
     * @tc.name  : SUB_Web_WebView_Zoom_Func_0300
     * @tc.desc  : test whether the zoom function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Zoom_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_Zoom_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_RESTORE: Component = await driver.findComponent(ON.text('ZoomRestore'));
      await ZOOM_RESTORE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).assertContain('100%');
      console.log('SUB_Web_WebView_Zoom_Func_0300 success');
      console.log('SUB_Web_WebView_Zoom_Func_0300 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Zoom_Func_0400
     * @tc.name  : SUB_Web_WebView_Zoom_Func_0400
     * @tc.desc  : test whether the zoom function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Zoom_Func_0400', 0, async () => {
      console.log('SUB_Web_WebView_Zoom_Func_0400 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_RANDOM: Component = await driver.findComponent(ON.text('ZoomRandom'));
      await ZOOM_RANDOM.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_VALUE: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const value: string = await MY_VALUE.getText();
      expect(value).not().assertNull();
      console.log('SUB_Web_WebView_Zoom_Func_0400 success');
      console.log('SUB_Web_WebView_Zoom_Func_0400 test end');
    });
  });
}
