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

import { describe, it, expect, beforeAll, beforeEach, afterEach, afterAll, } from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import { startAbility, stopAbility, waitUiReadyMs } from '../utils/index';
import deviceInfo from '@ohos.deviceInfo';

export default function GeolocationPermissions_AllowGeolocationTest() {
  describe('GeolocationPermissions_AllowGeolocation', () => {
    /**
     * beforeAll: PrePageControlTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest4', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PrePageControlTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const Page: Component = await driver.findComponent(ON.text('GeolocationPermissions_Index'));
      await Page.click();
      await driver.delayMs(waitUiReadyMs);
      // 向上滑动屏幕，方便找到导航按钮
      await driver.fling({
        x: 500, y: 800
      }, {
        x: 450, y: 300
      }, 5, 600);
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('GeolocationPermissions_allowGeolocation'));
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
     * @tc.number: SUB_Web_GeolocationPermissions_allowGeolocation_Func_0100
     * @tc.name  : SUB_Web_GeolocationPermissions_allowGeolocation_Func_0100
     * @tc.desc  : test GeolocationPermissions AllowGeolocation
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0100', 0, async () => {
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0100 test start');
      let systemName: string | undefined = deviceInfo.osFullName;
      if (systemName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else {
        const driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        const GET_PRECISE: Component = await driver.findComponent(ON.id('error11'));
        await GET_PRECISE.click();
        await driver.delayMs(waitUiReadyMs);
        const MY_TIPS: Component = await driver.findComponent(ON.id('message'));
        const text: string = await MY_TIPS.getText();
        expect(`${text}`).assertContain('ErrorCode: 17100011,  Message: Invalid origin');
      }
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0100 success');
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_GeolocationPermissions_allowGeolocation_Func_0200
     * @tc.name  : SUB_Web_GeolocationPermissions_allowGeolocation_Func_0200
     * @tc.desc  : test GeolocationPermissions AllowGeolocation
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0200', 0, async () => {
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0200 test start');
      let systemName: string | undefined = deviceInfo.osFullName;
      if (systemName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else {
        const driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        const GET_PRECISE: Component = await driver.findComponent(ON.id('error401'));
        await GET_PRECISE.click();
        await driver.delayMs(waitUiReadyMs);
        const MY_TIPS: Component = await driver.findComponent(ON.id('message'));
        const text: string = await MY_TIPS.getText();
        expect(`${text}`)
          .assertContain("ErrorCode: 401,  Message: BusinessError 401: Parameter error. The type of 'origin' must be string.");
      }
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0200 success');
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_GeolocationPermissions_allowGeolocation_Func_0300
     * @tc.name  : SUB_Web_GeolocationPermissions_allowGeolocation_Func_0300
     * @tc.desc  : test GeolocationPermissions AllowGeolocation
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0300', 0, async () => {
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0300 test start');
      let systemName: string | undefined = deviceInfo.osFullName;
      if (systemName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else {
        const driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        const GET_PRECISE: Component = await driver.findComponent(ON.id('allowGTrue'));
        await GET_PRECISE.click();
        await driver.delayMs(waitUiReadyMs);
        const MY_TIPS: Component = await driver.findComponent(ON.id('message'));
        const text: string = await MY_TIPS.getText();
        expect(`${text}`).assertContain("allowG incognito is true 执行成功");
      }
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0300 success');
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0300 test end');
    });

    /**
     * @tc.number: SUB_Web_GeolocationPermissions_allowGeolocation_Func_0400
     * @tc.name  : SUB_Web_GeolocationPermissions_allowGeolocation_Func_0400
     * @tc.desc  : test GeolocationPermissions AllowGeolocation
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0400', 0, async () => {
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0400 test start');
      let systemName: string | undefined = deviceInfo.osFullName;
      if (systemName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else {
        const driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        const GET_PRECISE: Component = await driver.findComponent(ON.id('allowGFalse'));
        await GET_PRECISE.click();
        await driver.delayMs(waitUiReadyMs);
        const MY_TIPS: Component = await driver.findComponent(ON.id('message'));
        const text: string = await MY_TIPS.getText();
        expect(`${text}`).assertContain("allowG incognito is false 执行成功");
      }
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0400 success');
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0400 test end');
    });

    /**
     * @tc.number: SUB_Web_GeolocationPermissions_allowGeolocation_Func_0500
     * @tc.name  : SUB_Web_GeolocationPermissions_allowGeolocation_Func_0500
     * @tc.desc  : test GeolocationPermissions AllowGeolocation
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0500', 0, async () => {
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0500 test start');
      let systemName: string | undefined = deviceInfo.osFullName;
      if (systemName.startsWith('iOS')) {
        console.log('当前设配不支持')
        expect("true").assertContain("true");
      } else {
        const driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        const GET_PRECISE: Component = await driver.findComponent(ON.id('allowGDefault'));
        await GET_PRECISE.click();
        await driver.delayMs(waitUiReadyMs);
        const MY_TIPS: Component = await driver.findComponent(ON.id('message'));
        const text: string = await MY_TIPS.getText();
        expect(`${text}`).assertContain("allowG incognito is default 执行成功");
      }
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0500 success');
      console.log('SUB_Web_GeolocationPermissions_allowGeolocation_Func_0500 test end');
    });

  });
}
