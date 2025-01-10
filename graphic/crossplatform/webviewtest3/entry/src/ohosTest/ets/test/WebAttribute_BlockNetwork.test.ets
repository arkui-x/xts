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

export default function WebAttribute_BlockNetwork() {
  describe('WebAttribute_BlockNetwork', () => {
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
      const TAB: Component = await driver.findComponent(ON.text('WebAttribute_BlockNetwork'));
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
     * @tc.number: SUB_Web_WebView_WebAttribute_BlockNetwork_0100
     * @tc.name  : SUB_Web_WebView_WebAttribute_BlockNetwork_0100
     * @tc.desc  : test WebAttribute BlockNetwork
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebAttribute_BlockNetwork_0100', 0, async () => {
      console.log('SUB_Web_WebAttribute_BlockNetwork_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(1000);

      const blockNetworkTrueButton: Component = await driver.findComponent(ON.text('blockNetwork true'));
      await blockNetworkTrueButton.click();
      await driver.delayMs(2000);
    });

    /**
     * @tc.number: SUB_Web_WebView_WebAttribute_BlockNetwork_0200
     * @tc.name  : SUB_Web_WebView_WebAttribute_BlockNetwork_0200
     * @tc.desc  : test WebAttribute BlockNetwork
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebAttribute_BlockNetwork_0200', 0, async () => {
      console.log('SUB_Web_WebAttribute_BlockNetwork_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(1000);

      const backButton: Component = await driver.findComponent(ON.text('返回'));
      await backButton.click();
      await driver.delayMs(1500);

      const blockNetworkFalseButton: Component = await driver.findComponent(ON.text('blockNetwork false'));
      await blockNetworkFalseButton.click();
      await driver.delayMs(5000);
    });
  });
}
