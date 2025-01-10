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
import deviceInfo from '@ohos.deviceInfo'
import { startAbility, stopAbility, waitUiReadyMs } from '../utils/index';

export default function WebAttributeFun_OnFullScreenEnter() {
  describe('WebAttributeFun_OnFullScreenEnter', () => {
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
      const Page: Component = await driver.findComponent(ON.text('WebAttribute_Index'));
      await Page.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('WebAttribute_OnFullScreenEnter'));
      await TAB.click();
      await driver.delayMs(waitUiReadyMs)
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
     * @tc.number: SUB_Web_WebView_WebAttributeFun_onFullScreenEnter_0100
     * @tc.name  : SUB_Web_WebView_WebAttributeFun_onFullScreenEnter_0100
     * @tc.desc  : test whether the stop function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebAttributeFun_onFullScreenEnter_0100', 0, async () => {

      let osName: string = deviceInfo.osFullName;
      console.log('osName = ' + osName);
      if (osName.startsWith('OpenHarmony')) {
        const driver: Driver = Driver.create();
        await driver.delayMs(5000);
        let videoElement = driver;
        await videoElement.click(602, 841);
        await driver.delayMs(3000);
        const MY_TIPS: Component = await driver.findComponent(ON.id('onFullScreenEnter'));
        const webId: string = await MY_TIPS.getText();
        expect(webId).assertContain("已进入全屏");
      } else if (osName.startsWith('Android')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else if (osName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      }
    });

  });
}
