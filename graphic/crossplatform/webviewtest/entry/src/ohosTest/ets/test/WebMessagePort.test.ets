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
import { startAbility, stopAbility, waitUiReadyMs, sleep } from '../utils/index';

export default function WebMessagePortTest() {
  describe('WebMessagePortTest', () => {
    /**
     * beforeAll: PreWebMessagePortTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreWebMessagePortTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto WebMessagePort'));
      await TAB.click();
      await driver.delayMs(2000);
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(async () => {
      await sleep(1000)
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
     * @tc.number: SUB_Web_WebView_Create_Web_Message_Ports_Func_0100
     * @tc.name  : SUB_Web_WebView_Create_Web_Message_Ports_Func_0100
     * @tc.desc  : test whether the createWebMessagePorts function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Create_Web_Message_Ports_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Create_Web_Message_Ports_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CREATE: Component = await driver.findComponent(ON.text('createPorts'));
      await CREATE.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const text: string = await ON_EVENT_VALUE.getText();
      expect(text).assertEqual('create ports: 2个');
      console.log('SUB_Web_WebView_Create_Web_Message_Ports_Func_0100 success');
      console.log('SUB_Web_WebView_Create_Web_Message_Ports_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Post_Message_Func_0100
     * @tc.name  : SUB_Web_WebView_Post_Message_Func_0100
     * @tc.desc  : test whether the postMessage function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Post_Message_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Post_Message_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CREATE: Component = await driver.findComponent(ON.text('createPorts'));
      await CREATE.click();
      await driver.delayMs(waitUiReadyMs);
      const POST_MSG: Component = await driver.findComponent(ON.text('postMessage'));
      await POST_MSG.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const text: string = await ON_EVENT_VALUE.getText();
      expect(text).assertEqual('console log:get msg __init_port__');
      console.log('SUB_Web_WebView_Post_Message_Func_0100 success');
      console.log('SUB_Web_WebView_Post_Message_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Post_Message_Event_Func_0100
     * @tc.name  : SUB_Web_WebView_Post_Message_Event_Func_0100
     * @tc.desc  : test whether the postMessageEvent function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Post_Message_Event_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Post_Message_Event_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CREATE: Component = await driver.findComponent(ON.text('createPorts'));
      await CREATE.click();
      await driver.delayMs(waitUiReadyMs);
      const POST_MSG: Component = await driver.findComponent(ON.text('postMessage'));
      await POST_MSG.click();
      await driver.delayMs(waitUiReadyMs);
      const SEND: Component = await driver.findComponent(ON.text('SendToHTML'));
      await SEND.click();
      await driver.delayMs(waitUiReadyMs);
      const postMsg: Component = await driver.findComponent(ON.text('HelloArkTs'));
      await postMsg.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_MSG: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      const msg: string = await ON_EVENT_MSG.getText();
      expect(msg).assertEqual('post message: HelloArkTs');
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('console log:Got message from ets:HelloArkTs');
      console.log('SUB_Web_WebView_Post_Message_Event_Func_0100 success');
      console.log('SUB_Web_WebView_Post_Message_Event_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Post_Message_Event_Func_0200
     * @tc.name  : SUB_Web_WebView_Post_Message_Event_Func_0200
     * @tc.desc  : test whether the postMessageEvent function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Post_Message_Event_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Post_Message_Event_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CREATE: Component = await driver.findComponent(ON.text('createPorts'));
      await CREATE.click();
      await driver.delayMs(waitUiReadyMs);
      const POST_MSG: Component = await driver.findComponent(ON.text('postMessage'));
      await POST_MSG.click();
      await driver.delayMs(waitUiReadyMs);
      const SEND: Component = await driver.findComponent(ON.text('SendToHTML'));
      await SEND.click();
      await driver.delayMs(waitUiReadyMs);
      const postMsg: Component = await driver.findComponent(ON.text('HelloOH'));
      await postMsg.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_MSG: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      const msg: string = await ON_EVENT_MSG.getText();
      expect(msg).assertEqual('post message: HelloOH');
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('console log:Got message from ets:HelloOH');
      console.log('SUB_Web_WebView_Post_Message_Event_Func_0200 success');
      console.log('SUB_Web_WebView_Post_Message_Event_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_On_Message_Event_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Message_Event_Func_0100
     * @tc.desc  : test whether the onMessageEvent function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Message_Event_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Message_Event_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CREATE: Component = await driver.findComponent(ON.text('createPorts'));
      await CREATE.click();
      await driver.delayMs(waitUiReadyMs);
      const POST_MSG: Component = await driver.findComponent(ON.text('postMessage'));
      await POST_MSG.click();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('Got msg from HTML:message from HTML');
      console.log('SUB_Web_WebView_On_Message_Event_Func_0100 success');
      console.log('SUB_Web_WebView_On_Message_Event_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Close_Func_0100
     * @tc.name  : SUB_Web_WebView_Close_Func_0100
     * @tc.desc  : test whether the close function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Close_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Close_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CREATE: Component = await driver.findComponent(ON.text('createPorts'));
      await CREATE.click();
      await driver.delayMs(waitUiReadyMs);
      const POST_MSG: Component = await driver.findComponent(ON.text('postMessage'));
      await POST_MSG.click();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const CLOSE: Component = await driver.findComponent(ON.text('close'));
      await CLOSE.click();
      await driver.delayMs(waitUiReadyMs);
      let ON_EVENT_MESSAGE: Component = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      let msg: string = await ON_EVENT_MESSAGE.getText();
      expect(msg).assertEqual('close port');
      let ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('Got msg from HTML:message from HTML');
      const SEND: Component = await driver.findComponent(ON.text('SendToHTML'));
      await SEND.click();
      await driver.delayMs(waitUiReadyMs);
      const postMsg: Component = await driver.findComponent(ON.text('HelloOH'));
      await postMsg.click();
      await driver.delayMs(waitUiReadyMs);
      ON_EVENT_MESSAGE = await driver.findComponent(ON.id('ON_EVENT_MESSAGE'));
      msg = await ON_EVENT_MESSAGE.getText();
      expect(msg).assertEqual('post message: HelloOH');
      ON_EVENT_VALUE = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      value = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('Got msg from HTML:message from HTML');
      console.log('SUB_Web_WebView_Close_Func_0100 success');
      console.log('SUB_Web_WebView_Close_Func_0100 test end');
    });
  });
}
