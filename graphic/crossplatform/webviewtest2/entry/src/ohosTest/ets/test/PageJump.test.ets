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


async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function PageJumpTest() {
  describe('PageJumpTest', () => {

    /**
     * beforeAll: PrePageJumpTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest2', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PrePageJumpTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const CHANGE_TABS: Component = await driver.findComponent(ON.text('设置页签'));
      await CHANGE_TABS.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('Goto accessStep'));
      await TAB.click();
      await driver.delayMs(waitUiReadyMs);
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
      await stopAbility();
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Access_Step_Func_0100
     * @tc.name  : SUB_Web_WebView_Access_Step_Func_0100
     * @tc.desc  : test whether the accessStep function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Access_Step_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Access_Step_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('page_visible');
      const ACCESS_STEP: Component = await driver.findComponent(ON.text('ACCESS_STEP'));
      await ACCESS_STEP.click();
      await driver.delayMs(waitUiReadyMs);
      const prompt_back: Component = await driver.findComponent(ON.text('-1'));
      await prompt_back.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('-1');
      expect(value).assertContain('false');
      console.log('SUB_Web_WebView_Access_Step_Func_0100 success');
      console.log('SUB_Web_WebView_Access_Step_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Access_Step_Func_0200
     * @tc.name  : SUB_Web_WebView_Access_Step_Func_0200
     * @tc.desc  : test whether the accessStep function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Access_Step_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Access_Step_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('alert');
      const ACCESS_STEP: Component = await driver.findComponent(ON.text('ACCESS_STEP'));
      await ACCESS_STEP.click();
      await driver.delayMs(waitUiReadyMs);
      const prompt_back: Component = await driver.findComponent(ON.text('-1'));
      await prompt_back.click();
      await driver.delayMs(waitUiReadyMs);
      let ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('-1');
      expect(value).assertContain('true');
      await driver.delayMs(waitUiReadyMs);
      await ACCESS_STEP.click();
      await driver.delayMs(waitUiReadyMs);
      const prompt_now: Component = await driver.findComponent(ON.text('0'));
      await prompt_now.click();
      await driver.delayMs(waitUiReadyMs);
      ON_EVENT_VALUE = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      value = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('0');
      expect(value).assertContain('true');
      console.log('SUB_Web_WebView_Access_Step_Func_0200 success');
      console.log('SUB_Web_WebView_Access_Step_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Access_Step_Func_0300
     * @tc.name  : SUB_Web_WebView_Access_Step_Func_0300
     * @tc.desc  : test whether the accessStep function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Access_Step_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_Access_Step_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('page_visible');
      const ACCESS_STEP: Component = await driver.findComponent(ON.text('ACCESS_STEP'));
      await ACCESS_STEP.click();
      await driver.delayMs(waitUiReadyMs);
      const prompt_back: Component = await driver.findComponent(ON.text('-1'));
      await prompt_back.click();
      await driver.delayMs(waitUiReadyMs);
      let ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('-1');
      expect(value).assertContain('true');
      await ACCESS_STEP.click();
      await driver.delayMs(waitUiReadyMs);
      const prompt_forward: Component = await driver.findComponent(ON.text('1'));
      await prompt_forward.click();
      await driver.delayMs(waitUiReadyMs);
      ON_EVENT_VALUE = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      value = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('1');
      expect(value).assertContain('false');
      console.log('SUB_Web_WebView_Access_Step_Func_0300 success');
      console.log('SUB_Web_WebView_Access_Step_Func_0300 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Clear_History_Func_0100
     * @tc.name  : SUB_Web_WebView_Clear_History_Func_0100
     * @tc.desc  : test whether the clearHistory function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 1
     */
    /* IOS does not support function clearHistory (IOS不支持clearHistory方法) */
    it('SUB_Web_WebView_Clear_History_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Clear_History_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const UA: Component = await driver.findComponent(ON.text('UA'));
      await UA.click();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      let url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('page_visible');
      const ACCESS_STEP: Component = await driver.findComponent(ON.text('ACCESS_STEP'));
      await ACCESS_STEP.click();
      await driver.delayMs(waitUiReadyMs);
      let prompt_back: Component = await driver.findComponent(ON.text('-1'));
      await prompt_back.click();
      await driver.delayMs(waitUiReadyMs);
      let ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertContain('-1');
      expect(value).assertContain('true');
      const USER_AGENT: Component = await driver.findComponent(ON.id('USER_AGENT'));
      const uaText: string = await USER_AGENT.getText();
      if (uaText.includes('OpenHarmony') || uaText.includes('Android')) {
        const CLEAR_HISTORY: Component = await driver.findComponent(ON.text('CLEAR History'));
        await CLEAR_HISTORY.click();
        await driver.delayMs(waitUiReadyMs);
        await ACCESS_STEP.click();
        await driver.delayMs(waitUiReadyMs);
        prompt_back = await driver.findComponent(ON.text('-1'));
        await prompt_back.click();
        await driver.delayMs(waitUiReadyMs);
        ON_EVENT_VALUE = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
        value = await ON_EVENT_VALUE.getText();
        expect(value).assertContain('-1');
        expect(value).assertContain('false');
        console.log('SUB_Web_WebView_Clear_History_Func_0100 success');
      } else {
        expect(true).assertTrue();
      }
      console.log('SUB_Web_WebView_Clear_History_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Back_Or_Forward_Func_0100
     * @tc.name  : SUB_Web_WebView_Back_Or_Forward_Func_0100
     * @tc.desc  : test whether the backOrForward function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Back_Or_Forward_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Back_Or_Forward_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const BOF_BUTTON: Component = await driver.findComponent(ON.text('BOF'));
      await BOF_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const STEP: Component = await driver.findComponent(ON.text('-1'));
      await STEP.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('index_page_visible');
      console.log('SUB_Web_WebView_Back_Or_Forward_Func_0100 success');
      console.log('SUB_Web_WebView_Back_Or_Forward_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Back_Or_Forward_Func_0200
     * @tc.name  : SUB_Web_WebView_Back_Or_Forward_Func_0200
     * @tc.desc  : test whether the backOrForward function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Back_Or_Forward_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Back_Or_Forward_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const BOF_BUTTON: Component = await driver.findComponent(ON.text('BOF'));
      await BOF_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const STEP: Component = await driver.findComponent(ON.text('1'));
      await STEP.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      const url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('index_alert');
      console.log('SUB_Web_WebView_Back_Or_Forward_Func_0200 success');
      console.log('SUB_Web_WebView_Back_Or_Forward_Func_0200 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Get_Back_Forward_Entries_Func_0100
     * @tc.name  : SUB_Web_WebView_Get_Back_Forward_Entries_Func_0100
     * @tc.desc  : test whether the getBackForwardEntries function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const UA: Component = await driver.findComponent(ON.text('UA'));
      await UA.click();
      await driver.delayMs(waitUiReadyMs);
      const USER_AGENT: Component = await driver.findComponent(ON.id('USER_AGENT'));
      const uaText: string = await USER_AGENT.getText();
      if (uaText.includes('OpenHarmony') || uaText.includes('Android')) {
        const CLEAR_HISTORY: Component = await driver.findComponent(ON.text('CLEAR History'));
        await CLEAR_HISTORY.click();
        await driver.delayMs(waitUiReadyMs);
        const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
        await TRIGGER.click();
        await driver.delayMs(waitUiReadyMs);
        const HISTORY_LIST: Component = await driver.findComponent(ON.text('History_LIST'));
        await HISTORY_LIST.click();
        await driver.delayMs(waitUiReadyMs);
        const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
        const value: string = await ON_EVENT_VALUE.getText();
        expect(Number(value)).assertEqual(2);
      } else {
        const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
        await TRIGGER.click();
        await driver.delayMs(waitUiReadyMs);
        const HISTORY_LIST: Component = await driver.findComponent(ON.text('History_LIST'));
        await HISTORY_LIST.click();
        await driver.delayMs(waitUiReadyMs);
        const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
        const value: string = await ON_EVENT_VALUE.getText();
        expect(Number(value)).assertLarger(0);
      }
      console.log('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0100 success');
      console.log('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Get_Back_Forward_Entries_Func_0200
     * @tc.name  : SUB_Web_WebView_Get_Back_Forward_Entries_Func_0200
     * @tc.desc  : test whether the getBackForwardEntries function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const UA: Component = await driver.findComponent(ON.text('UA'));
      await UA.click();
      await driver.delayMs(waitUiReadyMs);
      const USER_AGENT: Component = await driver.findComponent(ON.id('USER_AGENT'));
      const uaText: string = await USER_AGENT.getText();
      if (uaText.includes('OpenHarmony') || uaText.includes('Android')) {
        const CLEAR_HISTORY: Component = await driver.findComponent(ON.text('CLEAR History'));
        await CLEAR_HISTORY.click();
        await driver.delayMs(waitUiReadyMs);
        const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
        await TRIGGER.click();
        await driver.delayMs(waitUiReadyMs);
        await TRIGGER.click();
        await driver.delayMs(waitUiReadyMs);
        await TRIGGER.click();
        await driver.delayMs(waitUiReadyMs);
        const HISTORY_LIST: Component = await driver.findComponent(ON.text('History_LIST'));
        await HISTORY_LIST.click();
        await driver.delayMs(waitUiReadyMs);
        const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
        const value: string = await ON_EVENT_VALUE.getText();
        expect(Number(value)).assertEqual(4);
      } else {
        const HISTORY_LIST: Component = await driver.findComponent(ON.text('History_LIST'));
        await HISTORY_LIST.click();
        await driver.delayMs(waitUiReadyMs);
        const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
        const value: string = await ON_EVENT_VALUE.getText();
        expect(Number(value)).assertLarger(0);
      }
      console.log('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0200 success');
      console.log('SUB_Web_WebView_Get_Back_Forward_Entries_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Get_Title_Func_0100
     * @tc.name  : SUB_Web_WebView_Get_Title_Func_0100
     * @tc.desc  : test whether the getTitle function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Title_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Get_Title_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const GET_TITLE_BUTTON: Component = await driver.findComponent(ON.text('GET_TITLE'));
      await GET_TITLE_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('page_visible');
      console.log('SUB_Web_WebView_Get_Title_Func_0100 success');
      console.log('SUB_Web_WebView_Get_Title_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Get_Title_Func_0200
     * @tc.name  : SUB_Web_WebView_Get_Title_Func_0200
     * @tc.desc  : test whether the getTitle function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Get_Title_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_Get_Title_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const GET_TITLE_BUTTON: Component = await driver.findComponent(ON.text('GET_TITLE'));
      await GET_TITLE_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('alert');
      console.log('SUB_Web_WebView_Get_Title_Func_0200 success');
      console.log('SUB_Web_WebView_Get_Title_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_On_Title_Receive_Func_0100
     * @tc.name  : SUB_Web_WebView_On_Title_Receive_Func_0100
     * @tc.desc  : test whether the onTitleReceive attribute is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_On_Title_Receive_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_On_Title_Receive_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const GET_TITLE_BUTTON: Component = await driver.findComponent(ON.text('GET_TITLE'));
      await GET_TITLE_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      let ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      let value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('page_visible');
      const SET_TITLE_BUTTON: Component = await driver.findComponent(ON.text('SET_TITLE'));
      await SET_TITLE_BUTTON.click();
      await driver.delayMs(waitUiReadyMs);
      ON_EVENT_VALUE = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      value = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('newTitle:change_page_visible');
      console.log('SUB_Web_WebView_On_Title_Receive_Func_0100 success');
      console.log('SUB_Web_WebView_On_Title_Receive_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Access_Forward_Func_0100
     * @tc.name  : SUB_Web_WebView_Access_Forward_Func_0100
     * @tc.desc  : test whether the accessForward function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Access_Forward_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Access_Forward_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const BACKWARD_BTN: Component = await driver.findComponent(ON.text('backward'));
      await BACKWARD_BTN.click();
      await driver.delayMs(waitUiReadyMs);
      const ACCESS: Component = await driver.findComponent(ON.text('access'));
      await ACCESS.click();
      await driver.delayMs(waitUiReadyMs);
      const FORWARD: Component = await driver.findComponent(ON.text('前进'));
      await FORWARD.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('accessForward: true');
      console.log('SUB_Web_WebView_Access_Forward_Func_0100 success');
      console.log('SUB_Web_WebView_Access_Forward_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Forward_Func_0100
     * @tc.name  : SUB_Web_WebView_Forward_Func_0100
     * @tc.desc  : test whether the forward function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Forward_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Forward_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      let url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('page');
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const FORWARD: Component = await driver.findComponent(ON.text('forward'));
      await FORWARD.click();
      await driver.delayMs(waitUiReadyMs);
      ON_EVENT_URL = await driver.findComponent(ON.id('ON_EVENT_URL'));
      url = await ON_EVENT_URL.getText();
      expect(url).assertContain('alert');
      console.log('SUB_Web_WebView_Forward_Func_0100 success');
      console.log('SUB_Web_WebView_Forward_Func_0100 test end');
    });
    
    /**
     * @tc.number: SUB_Web_WebView_Access_Backward_Func_0100
     * @tc.name  : SUB_Web_WebView_Access_Backward_Func_0100
     * @tc.desc  : test whether the accessBackward function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Access_Backward_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Access_Backward_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      const ACCESS: Component = await driver.findComponent(ON.text('access'));
      await ACCESS.click();
      await driver.delayMs(waitUiReadyMs);
      const BACKWARD: Component = await driver.findComponent(ON.text('后退'));
      await BACKWARD.click();
      await driver.delayMs(waitUiReadyMs);
      const ON_EVENT_VALUE: Component = await driver.findComponent(ON.id('ON_EVENT_VALUE'));
      const value: string = await ON_EVENT_VALUE.getText();
      expect(value).assertEqual('accessBackward: true');
      console.log('SUB_Web_WebView_Access_Backward_Func_0100 success');
      console.log('SUB_Web_WebView_Access_Backward_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_Backward_Func_0100
     * @tc.name  : SUB_Web_WebView_Backward_Func_0100
     * @tc.desc  : test whether the accessBackward function is valid
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 2
     */
    it('SUB_Web_WebView_Backward_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_Backward_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const TRIGGER: Component = await driver.findComponent(ON.text('TRIGGER'));
      await TRIGGER.click();
      await driver.delayMs(waitUiReadyMs);
      let ON_EVENT_URL: Component = await driver.findComponent(ON.id('ON_EVENT_URL'));
      let url: string = await ON_EVENT_URL.getText();
      expect(url).assertContain('alert');
      const BACKWARD: Component = await driver.findComponent(ON.text('backward'));
      await BACKWARD.click();
      await driver.delayMs(waitUiReadyMs);
      ON_EVENT_URL = await driver.findComponent(ON.id('ON_EVENT_URL'));
      url = await ON_EVENT_URL.getText();
      expect(url).assertContain('page');
      console.log('SUB_Web_WebView_Backward_Func_0100 success');
      console.log('SUB_Web_WebView_Backward_Func_0100 test end');
    });
  });
}
