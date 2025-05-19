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

export default function WebController_PageDownTest() {
  describe('WebController_PageDownTest', () => {
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
      const TAB: Component = await driver.findComponent(ON.text('WebController_PageDown'));
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
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * @tc.number: SUB_Web_WebView_WebController_PageDown_Func_0100
     * @tc.name  : SUB_Web_WebView_WebController_PageDown_Func_0100
     * @tc.desc  : test whether the stop function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_PageDown_Func_0100', 0, async () => {

      console.log('SUB_Web_WebView_WebController_PageDown_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);

      const START_OFFSET_Y: Component = await driver.findComponent(ON.id('currentOffsetY'));
      const startOffsetYText = await START_OFFSET_Y.getText()
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('pageDownFalse'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const END_TOFFSET_Y: Component = await driver.findComponent(ON.id('currentOffsetY'));
      await driver.delayMs(waitUiReadyMs);
      const endOffsetYText = await END_TOFFSET_Y.getText();
      expect(`${endOffsetYText}`).assertLarger(Number(startOffsetYText));
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0100 success');
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0100 test end');
    });
    /**
     * @tc.number: SUB_Web_WebView_WebController_PageDown_Func_0200
     * @tc.name  : SUB_Web_WebView_WebController_PageDown_Func_0200
     * @tc.desc  : test whether the stop function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_PageDown_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const START_OFFSET_Y: Component = await driver.findComponent(ON.id('currentOffsetY'));
      const startOffsetYText = await START_OFFSET_Y.getText()
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('pageDownTrue'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const END_TOFFSET_Y: Component = await driver.findComponent(ON.id('currentOffsetY'));
      await driver.delayMs(waitUiReadyMs);
      const endOffsetYText = await END_TOFFSET_Y.getText();
      expect(`${endOffsetYText}`).assertLarger(Number(startOffsetYText));
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0200 success');
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0200 test end');
    });

    it('SUB_Web_WebView_WebController_PageDown_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('pageDown17100001'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('errorMsg'));
      const errorId: string = await MY_TIPS.getText();
      expect(`${errorId}`).assertContain('17100001');
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0300 success');
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0300 test end');
    });

    it('SUB_Web_WebView_WebController_PageDown_Func_0400', 0, async () => {
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0400 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_PRECISE: Component = await driver.findComponent(ON.id('pageDown401'));
      await ZOOM_PRECISE.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_TIPS: Component = await driver.findComponent(ON.id('errorMsg'));
      const errorId: string = await MY_TIPS.getText();
      expect(`${errorId}`).assertContain('401');
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0400 success');
      console.log('SUB_Web_WebView_WebController_PageDown_Func_0400 test end');
    });


  });
}
