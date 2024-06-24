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

export default function OnHttpAuthReqTest() {
  describe('OnHttpAuthReqTest', () => {
    /**
     * beforeAll: PreOnHttpAuthReqTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreOnHttpAuthReqTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto onHttpAuthRequest'));
      await TAB.click();
      await driver.delayMs(2000);
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
     * @tc.number: SUB_Web_WebView_On_Http_Auth_Request_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Http_Auth_Request_Func_0100
     * @tc.desc  : test whether the onHttpAuthRequest attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Http_Auth_Request_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Http_Auth_Request_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs * 2);
      const MESSAGE: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      const text: string = await MESSAGE.getText();
      expect(text).assertEqual('host: www.spincast.org, realm: protected example');
      console.log('SUB_Web_WebView_On_Http_Auth_Request_Func_0100 success');
      console.log('SUB_Web_WebView_On_Http_Auth_Request_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0100
     * @tc.name  : SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0100
     * @tc.desc  : test whether the saveHttpAuthCredentials function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const SAVE_BTN: Component = await driver.findComponent(ON.text('SAVE_HAC'));
      await SAVE_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      let MESSAGE: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      let text: string = await MESSAGE.getText();
      expect(text).assertEqual('save host: www.spincast.org, realm: protected example');
      const EXIST_HAC: Component = await driver.findComponent(ON.text('EXIST_HAC'));
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: true');
      console.log('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0100 success');
      console.log('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0200
     * @tc.name  : SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0200
     * @tc.desc  : test whether the saveHttpAuthCredentials function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let SAVE_BTN: Component = await driver.findComponent(ON.text('SAVE_HAC'));
      await SAVE_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      const DELETE_HAC: Component = await driver.findComponent(ON.text('DELETE_HAC'));
      await DELETE_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      let MESSAGE: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      let text: string = await MESSAGE.getText();
      expect(text).assertEqual('已删除');
      const EXIST_HAC: Component = await driver.findComponent(ON.text('EXIST_HAC'));
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: false');
      SAVE_BTN = await driver.findComponent(ON.text('SAVE_HAC'));
      await SAVE_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('save host: www.spincast.org, realm: protected example');
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: true');
      console.log('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0200 success');
      console.log('SUB_Web_WebView_Save_Http_Auth_Credentials_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Get_Http_Auth_Credentials_Func_0100
     * @tc.name  : SUB_Web_WebView_Get_Http_Auth_Credentials_Func_0100
     * @tc.desc  : test whether the getHttpAuthCredentials function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Http_Auth_Credentials_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Get_Http_Auth_Credentials_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let SAVE_BTN: Component = await driver.findComponent(ON.text('SAVE_HAC'));
      await SAVE_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      const GET_HAC: Component = await driver.findComponent(ON.text('GET_HAC'));
      await GET_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      const MESSAGE: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      const text: string = await MESSAGE.getText();
      expect(text).assertEqual('2222,2222');
      console.log('SUB_Web_WebView_Get_Http_Auth_Credentials_Func_0100 success');
      console.log('SUB_Web_WebView_Get_Http_Auth_Credentials_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Exist_Http_Auth_Credentials_Func_0100
     * @tc.name  : SUB_Web_WebView_Exist_Http_Auth_Credentials_Func_0100
     * @tc.desc  : test whether the existHttpAuthCredentials function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Exist_Http_Auth_Credentials_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Exist_Http_Auth_Credentials_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let SAVE_BTN: Component = await driver.findComponent(ON.text('SAVE_HAC'));
      await SAVE_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      const EXIST_HAC: Component = await driver.findComponent(ON.text('EXIST_HAC'));
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      let MESSAGE: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      let text: string = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: true');
      const DELETE_HAC: Component = await driver.findComponent(ON.text('DELETE_HAC'));
      await DELETE_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('已删除');
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: false');
      SAVE_BTN = await driver.findComponent(ON.text('SAVE_HAC'));
      await SAVE_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: true');
      console.log('SUB_Web_WebView_Exist_Http_Auth_Credentials_Func_0100 success');
      console.log('SUB_Web_WebView_Exist_Http_Auth_Credentials_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Delete_Http_Auth_Credentials_Func_0100
     * @tc.name  : SUB_Web_WebView_Delete_Http_Auth_Credentials_Func_0100
     * @tc.desc  : test whether the deleteHttpAuthCredentials function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Delete_Http_Auth_Credentials_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Delete_Http_Auth_Credentials_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let SAVE_BTN: Component = await driver.findComponent(ON.text('SAVE_HAC'));
      await SAVE_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      const EXIST_HAC: Component = await driver.findComponent(ON.text('EXIST_HAC'));
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      let MESSAGE: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      let text: string = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: true');
      const DELETE_HAC: Component = await driver.findComponent(ON.text('DELETE_HAC'));
      await DELETE_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('已删除');
      await EXIST_HAC.click();
      await driver.delayMs(waitUiReadyMs);
      MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      text = await MESSAGE.getText();
      expect(text).assertEqual('existHttpAuthCredentials: false');
      console.log('SUB_Web_WebView_Delete_Http_Auth_Credentials_Func_0100 success');
      console.log('SUB_Web_WebView_Delete_Http_Auth_Credentials_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_On_Http_Error_Receive_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Http_Error_Receive_Func_0100
     * @tc.desc  : test whether the onHttpErrorReceive attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Http_Error_Receive_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Http_Error_Receive_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      await driver.delayMs(waitUiReadyMs);
      const url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('www.spincast.org');
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      const code: number = Number(value);
      expect(code).assertLessOrEqual(404);
      console.log('SUB_Web_WebView_On_Http_Error_Receive_Func_0100 success');
      console.log('SUB_Web_WebView_On_Http_Error_Receive_Func_0100 test end');
    });

  });
}
