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
import deviceInfo from '@ohos.deviceInfo'
export default function WebAttribute_OnlineImageAccess() {
  describe('WebAttribute_OnlineImageAccess', () => {
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
    /**
     * beforeEach: PrePageControlTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const Page: Component = await driver.findComponent(ON.text('WebAttribute_Index'));
      await Page.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('WebAttribute_OnlineImageAccess'));
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
     * @tc.number: SUB_Web_WebView_WebAttribute_OnlineImageAccess_0100
     * @tc.name  : SUB_Web_WebView_WebAttribute_OnlineImageAccess_0100
     * @tc.desc  : test WebAttribute OnlineImageAccess
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebAttribute_OnlineImageAccess_0100', 0, async () => {
      console.log('SUB_Web_WebAttribute_OnlineImageAccess_0100 test start');
      let osName: string = deviceInfo.osFullName;
      if (osName.startsWith('OpenHarmony')) {
      const driver: Driver = Driver.create();
      await driver.delayMs(1000);

      const onlineImageAccessTrueButton: Component = await driver.findComponent(ON.text('onlineImageAccess true'));
      await onlineImageAccessTrueButton.click();
      await driver.delayMs(2000);

      const onlineImageAccess: Component = await driver.findComponent(ON.id('onlineImageAccessTrue'));
      const onlineImageAccessTextValue: string = await onlineImageAccess.getText();
      expect(onlineImageAccessTextValue).assertContain('ImageLoadResult: "load image complete"');
      } else if (osName.startsWith('Android')) {
        const driver: Driver = Driver.create();
        await driver.delayMs(1000);

        const onlineImageAccessTrueButton: Component = await driver.findComponent(ON.text('onlineImageAccess true'));
        await onlineImageAccessTrueButton.click();
        await driver.delayMs(3000);

        const onlineImageAccess: Component = await driver.findComponent(ON.id('onlineImageAccessTrue'));
        await driver.delayMs(2000);
        const onlineImageAccessTextValue: string = await onlineImageAccess.getText();
        await driver.delayMs(2000);
        expect(onlineImageAccessTextValue).assertContain('ImageLoadResult: "load image complete"');
      } else if (osName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      }
    });

    /**
     * @tc.number: SUB_Web_WebView_WebAttribute_OnlineImageAccess_0200
     * @tc.name  : SUB_Web_WebView_WebAttribute_OnlineImageAccess_0200
     * @tc.desc  : test WebAttribute OnlineImageAccess
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebAttribute_OnlineImageAccess_0200', 0, async () => {
      console.log('SUB_Web_WebAttribute_OnlineImageAccess_0200 test start');
      let osName: string = deviceInfo.osFullName;
      if (osName.startsWith('OpenHarmony')) {
      const driver: Driver = Driver.create();
      await driver.delayMs(1000);

      const backButton: Component = await driver.findComponent(ON.text('返回'));
      await backButton.click();
      await driver.delayMs(1500);

      const onlineImageAccessFalseButton: Component = await driver.findComponent(ON.text('onlineImageAccess false'));
      await onlineImageAccessFalseButton.click();
      await driver.delayMs(2000);

      const onlineImageAccessFalse: Component = await driver.findComponent(ON.id('onlineImageAccessFalse'));
      const onlineImageAccessFalseTextValue: string = await onlineImageAccessFalse.getText();
      expect(onlineImageAccessFalseTextValue).assertContain('ImageLoadResult: null');
      } else if (osName.startsWith('Android')) {
        const driver: Driver = Driver.create();
        await driver.delayMs(1000);

        const backButton: Component = await driver.findComponent(ON.text('返回'));
        await backButton.click();
        await driver.delayMs(1500);

        const onlineImageAccessFalseButton: Component = await driver.findComponent(ON.text('onlineImageAccess false'));
        await onlineImageAccessFalseButton.click();
        await driver.delayMs(2000);

        const onlineImageAccessFalse: Component = await driver.findComponent(ON.id('onlineImageAccessFalse'));
        const onlineImageAccessFalseTextValue: string = await onlineImageAccessFalse.getText();
        expect(onlineImageAccessFalseTextValue).assertContain('ImageLoadResult: null');
      } else if (osName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      }
    });
  });
}
