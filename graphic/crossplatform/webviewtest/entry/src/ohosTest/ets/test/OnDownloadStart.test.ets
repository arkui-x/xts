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
  Level,
  TestType,
  Size
} from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import { startAbility, waitUiReadyMs, sleep, waitForIdText } from '../utils/index';

export default function OnDownloadStartTest() {
  describe('OnDownloadStartTest', () => {
    /**
     * beforeAll: PreOnDownloadStartTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreOnDownloadStartTest at the test case level, which are executed before each test case is executed.
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
     * @tc.number: SUB_Web_WebView_On_Download_Start_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Download_Start_Func_0100
     * @tc.desc  : test whether the onDownloadStart attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('SUB_Web_WebView_On_Download_Start_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      console.log('SUB_Web_WebView_On_Download_Start_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto onDownloadStart'));
      await TAB.click();
      await driver.delayMs(2000);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const url: string = await waitForIdText(driver, 'ON_EVENT_URL',
        (value: string) => value.includes('aspell') || value.includes('.gz'), 10000);
      const ON_DOWNLOAD_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_DOWNLOAD_EVENT_VALUE.getText();
      expect(url.length > 0).assertTrue();
      expect(value.length > 0).assertTrue();
      console.log('SUB_Web_WebView_On_Download_Start_Func_0100 success');
      console.log('SUB_Web_WebView_On_Download_Start_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Media_Play_Gesture_Access_Func_0100
     * @tc.name  : SUB_Web_WebView_Media_Play_Gesture_Access_Func_0100
     * @tc.desc  : test whether the mediaPlayGestureAccess attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    /* IOS does not support mediaPlayGestureAccess（IOS不支持mediaPlayGestureAccess） */
    it('SUB_Web_WebView_Media_Play_Gesture_Access_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        console.log('SUB_Web_WebView_Media_Play_Gesture_Access_Func_0100 test start');
        const driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
        await CHANGE_TABS.click();
        await driver.delayMs(waitUiReadyMs);
        const TAB: Component = await driver.findComponent(ON.text('Goto playVideo'));
        await TAB.click();
        await driver.delayMs(waitUiReadyMs * 2);
        const UA: Component = await driver.findComponent(ON.text('UA'));
        await UA.click();
        await driver.delayMs(waitUiReadyMs);
        const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
        await TRIGGER.click();
        await driver.delayMs(waitUiReadyMs);
        const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
        const value: string = await ON_EVENT_VALUE.getText();
        expect(value).assertContain('是否播放: 否');
        console.log('SUB_Web_WebView_Media_Play_Gesture_Access_Func_0100 success');
        console.log('SUB_Web_WebView_Media_Play_Gesture_Access_Func_0100 test end');
      });
  });
}
