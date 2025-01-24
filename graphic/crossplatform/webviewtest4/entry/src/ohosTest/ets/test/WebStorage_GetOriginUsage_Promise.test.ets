/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
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

import { describe, it, expect, beforeAll, beforeEach, afterEach, afterAll, } from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import deviceInfo from '@ohos.deviceInfo';
import { startAbility, stopAbility, waitUiReadyMs } from '../utils/index';

export default function WebStorage_GetOriginUsage_Promise() {
  describe('WebStorage_GetOriginUsage_Promise', () => {
    /**
     * beforeAll: PreCookieManagerTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest4', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreCookieManagerTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const Page: Component = await driver.findComponent(ON.text('WebStorage_Index'));
      await Page.click();
      await driver.delayMs(waitUiReadyMs);
      let TAB: Component = await driver.findComponent(ON.text('WebStorage_GetOriginUsage_Promise'));
      await TAB!.click();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(async () => {
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
     * @tc.number: SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0100
     * @tc.name  : SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0100
     * @tc.desc  : test webStorage GetOriginUsage
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0100 test start');
      let osName: string | undefined = deviceInfo.osFullName;
      if (osName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else {
        const driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        const BTN_ORIGIN: Component = await driver.findComponent(ON.text('getOriginUsage'));
        await BTN_ORIGIN.click();
        await driver.delayMs(waitUiReadyMs);
        const TEXT: Component = await driver.findComponent(ON.id('originValue'));
        const str: string = await TEXT.getText();
        expect(str).not().assertEqual('Usage：-200');
      }
      console.log('SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0100 success');
      console.log('SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0100 test end');
    })

    /**
     * @tc.number: SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0200
     * @tc.name  : SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0200
     * @tc.desc  : test webStorage GetOriginUsage
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Storage_GetOriginUsage_Promise_Func_0200 test start');
      let osName: string | undefined = deviceInfo.osFullName;
      if (osName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else {
        const driver: Driver = Driver.create();
        const BTN_DELETE: Component = await driver.findComponent(ON.text('捕获错误401'));
        await BTN_DELETE.click();
        await driver.delayMs(waitUiReadyMs);
        const TEXT: Component = await driver.findComponent(ON.id('errorCode'));
        const str: string = await TEXT.getText();
        expect(str).assertContain('401');
      }
      console.log('SUB_Web_WebView_Storage_GetOriginQuota_Callback_Func_0200 success');
      console.log('SUB_Web_WebView_Storage_GetOriginQuota_Callback_Func_0200 test end');
    })
  });
}
