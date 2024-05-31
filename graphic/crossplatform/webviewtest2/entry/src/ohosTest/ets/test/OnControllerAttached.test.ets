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

export default function OnControllerAttachedTest() {
  describe('OnControllerAttachedTest', () => {
    /**
     * beforeAll: PreOnControllerAttachedTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest2', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreOnControllerAttachedTest at the test case level, which are executed before each test case is executed.
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
     * @tc.number: SUB_Web_WebView_On_Controller_Attached_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Controller_Attached_Func_0100
     * @tc.desc  : test whether the onControllerAttached attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Controller_Attached_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Controller_Attached_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TO_STRING_RESULT: Component = await driver.findComponent(ON.id('MY_TO_STRING'));
      const result: string = await TO_STRING_RESULT.getText();
      expect(result).assertEqual('index_controller.html');
      console.log('SUB_Web_WebView_On_Controller_Attached_Func_0100 success');
      console.log('SUB_Web_WebView_On_Controller_Attached_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_On_Controller_Attached_Func_0200
     * @tc.name  : SUB_Web_WebView_On_Controller_Attached_Func_0200
     * @tc.desc  : test whether the onControllerAttached attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Controller_Attached_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_On_Controller_Attached_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const MY_COUNT_RESULT: Component = await driver.findComponent(ON.id('MY_COUNT'));
      const result: string = await MY_COUNT_RESULT.getText();
      const id: string = result.trim().split(':')[1];
      expect(id).not().assertNull();
      console.log('SUB_Web_WebView_On_Controller_Attached_Func_0200 success');
      console.log('SUB_Web_WebView_On_Controller_Attached_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Get_Page_Height_Func_0100
     * @tc.name  : SUB_Web_WebView_Get_Page_Height_Func_0100
     * @tc.desc  : test whether the getPageHeight function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Page_Height_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Get_Page_Height_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ZOOM_BUTTON: Component = await driver.findComponent(ON.text('zoom'));
      await ZOOM_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const GET_BUTTON: Component = await driver.findComponent(ON.text('GET_HEIGHT'));
      await GET_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const MY_COUNT: Component = await driver.findComponent(ON.id('MY_VALUE'));
      const heightStr: string = await MY_COUNT.getText();
      const height: number = Number(heightStr.trim().split(':')[1]);
      expect(height).assertEqual(300);
      console.log('SUB_Web_WebView_Get_Page_Height_Func_0100 success');
      console.log('SUB_Web_WebView_Get_Page_Height_Func_0100 test end');
    });
  });
}
