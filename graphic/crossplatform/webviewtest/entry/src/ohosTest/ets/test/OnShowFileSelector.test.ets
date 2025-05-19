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
import { startAbility, waitUiReadyMs, sleep, stopAbility } from '../utils/index';

export default function OnShowFileSelectorTest() {
  describe('OnShowFileSelectorTest', () => {
    /**
     * beforeAll: PreOnShowFileSelectorTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreOnShowFileSelectorTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs * 2);
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
     * @tc.number: SUB_Web_WebView_On_Show_File_Selector_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Show_File_Selector_Func_0100
     * @tc.desc  : test whether the onShowFileSelector attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Show_File_Selector_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Show_File_Selector_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto onShowFileSelector'));
      await TAB.click();
      await driver.delayMs(2000);
      const DOCUMENT_SAVE: Component = await driver.findComponent(ON.id('DOCUMENT_SAVE'));
      await DOCUMENT_SAVE.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_MSG: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      const msg: string = await ON_EVENT_MSG.getText();
      expect(msg).assertEqual('SAVE test.txt');
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('.txt');
      console.log('SUB_Web_WebView_On_Show_File_Selector_Func_0100 success');
      console.log('SUB_Web_WebView_On_Show_File_Selector_Func_0100 test end');
    });
  });
}
