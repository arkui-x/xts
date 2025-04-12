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

import { Component, Driver, ON } from '@ohos.UiTest';
import { afterEach, describe, expect, it } from '@ohos/hypium';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import deviceInfo from '@ohos.deviceInfo';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const AWAIT_SLEEP_MS_1000: number = 1000;
const AWAIT_SLEEP_MS_2000: number = 2000;
const AWAIT_SLEEP_MS_3000: number = 3000;
const AWAIT_SLEEP_MS_5000: number = 5000;
const AWAIT_SLEEP_MS_7000: number = 7000;
let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0].split('-')[0];

async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await abilityDelegatorRegistry.getAbilityDelegator().startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function Webxts() {
  describe('Webxts', () => {
    afterEach(async () => {
      if (platform != 'iOS') {
        let topAbility = await delegator.getCurrentTopAbility();
        await topAbility.context.terminateSelf();
        let driver = Driver.create()
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
      }
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnPageEndEvent_0100
     * @tc.name   : ACTS_ARKUIX_Web_OnPageEndEvent_0100
     * @tc.desc   : Test web OnPageEndEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnPageEndEvent_0100', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnPageEndEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_7000);
        let URL_Text = await driver.findComponent(ON.id('event.url'));
        const URL = await URL_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(URL != null).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })
    /**
     * @tc.number : ACTS_ARKUIX_Web_OnPageBeginEvent_0200
     * @tc.name   : ACTS_ARKUIX_Web_OnPageBeginEvent_0200
     * @tc.desc   : Test web OnPageBeginEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnPageBeginEvent_0200', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnPageBeginEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let URL_Text = await driver.findComponent(ON.id('event.url'));
        const URL = await URL_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        expect(URL).assertEqual('event.url: https://www.baidu.com/');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnProgressChangeEvent_0300
     * @tc.name   : ACTS_ARKUIX_Web_OnProgressChangeEvent_0300
     * @tc.desc   : Test web OnProgressChangeEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnProgressChangeEvent_0300', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnProgressChangeEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let Progress_Text = await driver.findComponent(ON.id('event.progress'));
        const Progress = await Progress_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        expect(Progress != null).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnTitleReceiveEvent_0400
     * @tc.name   : ACTS_ARKUIX_Web_OnTitleReceiveEvent_0400
     * @tc.desc   : Test web OnTitleReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnTitleReceiveEvent_0400', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnTitleReceiveEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let Progress_Text = await driver.findComponent(ON.id('event.title'));
        const Title = await Progress_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        expect(Title).assertEqual("event.title: 百度一下");
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnGeolocationShowEvent_0500
     * @tc.name   : ACTS_ARKUIX_Web_OnGeolocationShowEvent_0500
     * @tc.desc   : Test web OnGeolocationShowEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnGeolocationShowEvent_0500', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        if (platform != "iOS") {
          let one = await driver.findComponent(ON.text('one'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let Button = await driver.findComponent(ON.text('OnGeolocationShowEvent'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let isTrue_Text = await driver.findComponent(ON.id('isTrue'));
          const isTrue = await isTrue_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(isTrue).assertEqual("isTrue: true");
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnAlertEvent_0600
     * @tc.name   : ACTS_ARKUIX_Web_OnAlertEvent_0600
     * @tc.desc   : Test web OnAlertEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnAlertEvent_0600', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('two'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnAlertEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let url_Text = await driver.findComponent(ON.id('url'));
        const url = await url_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(url != "url: ").assertTrue();
        let message_Text = await driver.findComponent(ON.id('message'));
        const message = await message_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(message).assertEqual('event.message: Hello World');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnConfirmEvent_0700
     * @tc.name   : ACTS_ARKUIX_Web_OnConfirmEvent_0700
     * @tc.desc   : Test web OnConfirmEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnConfirmEvent_0700', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('two'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnConfirmEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let url_Text = await driver.findComponent(ON.id('url'));
        const url = await url_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(url != "url: ").assertTrue();
        let message_Text = await driver.findComponent(ON.id('message'));
        const message = await message_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(message).assertEqual('event.message: click button!');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnPromptEvent_0800
     * @tc.name   : ACTS_ARKUIX_Web_OnPromptEvent_0800
     * @tc.desc   : Test web OnPromptEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnPromptEvent_0800', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnPromptEvent_handleConfirm'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let url_Text = await driver.findComponent(ON.id('url'));
        const url = await url_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(url != null).assertTrue();
        let message_Text = await driver.findComponent(ON.id('message'));
        const message = await message_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(message).assertEqual('message: Message info');
        let value_Text = await driver.findComponent(ON.id('value'));
        const value = await value_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(value).assertEqual('value: Hello World');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnConsoleEvent_0900
     * @tc.name   : ACTS_ARKUIX_Web_OnConsoleEvent_0900
     * @tc.desc   : Test web OnConsoleEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnConsoleEvent_0900', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnConsoleEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Onconsole_Button = await driver.findComponent(ON.text('onconsole message'));
        await Onconsole_Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        await Onconsole_Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let getMessage_Text = await driver.findComponent(ON.id('getMessage'));
        const getMessage = await getMessage_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        expect(getMessage).assertEqual("getMessage: onconsole printf");
        if (platform != 'iOS') {
          let getSourceId_Text = await driver.findComponent(ON.id('getSourceId'));
          const getSourceId = await getSourceId_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(getSourceId != 'getSourceId: ').assertTrue();
          let getLineNumber_Text = await driver.findComponent(ON.id('getLineNumber'));
          const getLineNumber = await getLineNumber_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(getLineNumber).assertEqual("getLineNumber: 7");
        }
        let getMessageLevel_Text = await driver.findComponent(ON.id('getMessageLevel'));
        const getMessageLevel = await getMessageLevel_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        expect(getMessageLevel).assertEqual("getMessageLevel: 2");
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01000
     * @tc.name   : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01000
     * @tc.desc   : Test web OnErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnErrorReceiveEvent_01000', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnErrorReceiveEvent'));
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let getErrorInfo_Text = await driver.findComponent(ON.id('getErrorInfo'));
        const getErrorInfo = await getErrorInfo_Text.getText();
        if (platform == 'OpenHarmony') {
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getErrorInfo != null).assertTrue();
        } else if (platform == 'Android') {
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getErrorInfo != null).assertTrue();
        } else {
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getErrorInfo != null).assertTrue();
        }
        let getErrorCode_Text = await driver.findComponent(ON.id('getErrorCode'));
        const getErrorCode = await getErrorCode_Text.getText();
        if (platform == 'OpenHarmony') {
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getErrorCode != null).assertTrue();
        } else if (platform == 'Android') {
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getErrorCode != null).assertTrue();
        } else {
          expect(getErrorInfo != null).assertTrue();
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01100
     * @tc.name   : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01100
     * @tc.desc   : Test web OnErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnErrorReceiveEvent_01100', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnErrorReceiveEvent'));
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        if (platform != 'iOS') {
          let url_Text = await driver.findComponent(ON.id('url'));
          const url = await url_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(url != null).assertTrue();
          let isMainFrame_Text = await driver.findComponent(ON.id('isMainFrame'));
          const isMainFrame = await isMainFrame_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(isMainFrame).assertEqual("isMainFrame: true");
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01200
     * @tc.name   : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01200
     * @tc.desc   : Test web OnErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnErrorReceiveEvent_01200', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);

        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);

        let Button = await driver.findComponent(ON.text('OnErrorReceiveEvent'));
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        if (platform != 'iOS') {
          let isRedirect_Text = await driver.findComponent(ON.id('isRedirect'));
          const isRedirect = await isRedirect_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(isRedirect).assertEqual("isRedirect: false");
          let isRequestGesture_Text = await driver.findComponent(ON.id('isRequestGesture'));
          const isRequestGesture = await isRequestGesture_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(isRequestGesture).assertEqual("isRequestGesture: false");
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01300
     * @tc.name   : ACTS_ARKUIX_Web_OnErrorReceiveEvent_01300
     * @tc.desc   : Test web OnErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnErrorReceiveEvent_01300', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnErrorReceiveEvent'));
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        if (platform != 'iOS') {
          let getRequestHeader_headerKey_Text = await driver.findComponent(ON.id('getRequestHeader_headerKey'));
          const getRequestHeader_headerKey = await getRequestHeader_headerKey_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getRequestHeader_headerKey != 'getRequestHeader_headerKey: ').assertTrue();
        }

        let requestSize_Text = await driver.findComponent(ON.id('requestSize'));
        const requestSize = await requestSize_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(requestSize != "requestSize: ").assertTrue();
        if (platform != 'iOS') {
          let getRequestMethod_Text = await driver.findComponent(ON.id('getRequestMethod'));
          const getRequestMethod = await getRequestMethod_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getRequestMethod).assertEqual("getRequestMethod: GET");
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01400
     * @tc.name   : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01400
     * @tc.desc   : Test web OnHttpErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01400', 1, async (done: Function) => {
      try {
        if (platform != 'iOS') {
          await startAbility('com.example.webviewxts', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);

          let one = await driver.findComponent(ON.text('one'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);

          let Button = await driver.findComponent(ON.text('OnHttpErrorReceiveEvent'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let URL_Text = await driver.findComponent(ON.id("url"));
          const URL = await URL_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(URL).assertEqual("url: https://gitee.com/openharmony/docs/blob/master/READE.md");
          let isMainFrame_Text = await driver.findComponent(ON.id("isMainFrame"));
          const isMainFrame = await isMainFrame_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_2000);
          expect(isMainFrame).assertEqual("isMainFrame: true");
          let isRedirect_Text = await driver.findComponent(ON.id("isRedirect"));
          const isRedirect = await isRedirect_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_2000);
          expect(isRedirect).assertEqual("isRedirect: false");
          let isRequestGesture_Text = await driver.findComponent(ON.id('isRequestGesture'));
          const isRequestGesture = await isRequestGesture_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_2000);
          expect(isRequestGesture).assertEqual("isRequestGesture: false");
          let getResponseData_Text = await driver.findComponent(ON.id('getResponseData'));
          const getResponseData = await getResponseData_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_2000);
          expect(getResponseData).assertEqual("getResponseData: ");
          done()
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01500
     * @tc.name   : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01500
     * @tc.desc   : Test web OnHttpErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01500', 1, async (done: Function) => {
      try {
        if (platform != 'iOS') {
          await startAbility('com.example.webviewxts', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('one'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('OnHttpErrorReceiveEvent'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let getResponseEncoding_Text = await driver.findComponent(ON.id('getResponseEncoding'));
          const getResponseEncoding = await getResponseEncoding_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_5000);
          expect(getResponseEncoding).assertEqual("getResponseEncoding: utf-8");
          let getResponseMimeType_Text = await driver.findComponent(ON.id('getResponseMimeType'));
          const getResponseMimeType = await getResponseMimeType_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getResponseMimeType).assertEqual("getResponseMimeType: text/html");
          let getResponseCode_Text = await driver.findComponent(ON.id('getResponseCode'));
          const getResponseCode = await getResponseCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getResponseCode).assertEqual("getResponseCode: 404");
          let getReasonMessage_Text = await driver.findComponent(ON.id('getReasonMessage'));
          const getReasonMessage = await getReasonMessage_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getReasonMessage).assertEqual("getReasonMessage: Not Found");
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01600
     * @tc.name   : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01600
     * @tc.desc   : Test web OnHttpErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01600', 1, async (done: Function) => {
      try {
        if (platform != 'iOS') {
          await startAbility('com.example.webviewxts', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('one'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('OnHttpErrorReceiveEvent'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let getRequestMethod_Text = await driver.findComponent(ON.id('getRequestMethod'));
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const getRequestMethod = await getRequestMethod_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getRequestMethod).assertEqual("getRequestMethod: GET");

          let requestSize_Text = await driver.findComponent(ON.id('requestSize'));
          const requestSize = await requestSize_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(requestSize != "requestSize: ").assertTrue();
          let responseSize_Text = await driver.findComponent(ON.id('responseSize'));
          const responseSize = await responseSize_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(responseSize != "responseSize: ").assertTrue();
          let responseHeader_Text = await driver.findComponent(ON.id('responseHeader'));
          const responseHeader = await responseHeader_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(responseHeader != "responseHeader: ").assertTrue();
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01700
     * @tc.name   : ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01700
     * @tc.desc   : Test web OnHttpErrorReceiveEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnHttpErrorReceiveEvent_01700', 1, async (done: Function) => {
      try {
        if (platform != 'iOS') {
          await startAbility('com.example.webviewxts', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('one'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('OnHttpErrorReceiveEvent'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let getResponseDataEx_Text = await driver.findComponent(ON.id('getResponseDataEx'));
          const getResponseDataEx = await getResponseDataEx_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getResponseDataEx).assertEqual("getResponseDataEx: undefined");
          let getResponseIsReady_Text = await driver.findComponent(ON.id('getResponseIsReady'));
          const getResponseIsReady = await getResponseIsReady_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getResponseIsReady).assertEqual("getResponseIsReady: true");
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnDownloadStartEvent_01800
     * @tc.name   : ACTS_ARKUIX_Web_OnDownloadStartEvent_01800
     * @tc.desc   : Test web OnDownloadStartEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnDownloadStartEvent_01800', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnDownloadStartEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let URL_Text = await driver.findComponent(ON.id('url'));
        const URL = await URL_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        if (platform == 'iOS') {
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
        }
        expect(URL != null).assertTrue();
        let userAgent_Text = await driver.findComponent(ON.id('userAgent'));
        const userAgent = await userAgent_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(userAgent != 'userAgent: ').assertTrue();
        if (platform != 'iOS') {
          let contentDisposition_Text = await driver.findComponent(ON.id('contentDisposition'));
          const contentDisposition = await contentDisposition_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(contentDisposition).assertEqual("contentDisposition: ");
        }

        let contentLength_Text = await driver.findComponent(ON.id('contentLength'));
        const contentLength = await contentLength_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(contentLength).assertEqual("contentLength: 21657");

        let mimetype_Text = await driver.findComponent(ON.id('mimetype'));
        const mimetype = await mimetype_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        if (platform != 'iOS') {
          expect(mimetype).assertEqual("mimetype: application/octet-stream");
        } else {
          expect(mimetype).assertEqual("mimetype: application/x-gzip");
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnScaleChange_01900
     * @tc.name   : ACTS_ARKUIX_Web_OnScaleChange_01900
     * @tc.desc   : Test web OnScaleChangeEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnScaleChange_01900', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('one'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnScaleChangeEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let Button_change_percent = await driver.findComponent(ON.text('change_percent'));
        await Button_change_percent.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let oldScale_Text = await driver.findComponent(ON.id('oldScale'));
        const oldScale = await oldScale_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let newScale_Text = await driver.findComponent(ON.id('newScale'));
        const newScale = await newScale_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(oldScale != newScale).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnHttpAuthRequestEvent_02000
     * @tc.name   : ACTS_ARKUIX_Web_OnHttpAuthRequestEvent_02000
     * @tc.desc   : Test web OnHttpAuthRequestEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnHttpAuthRequestEvent_02000', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);

        let two = await driver.findComponent(ON.text('two'));
        await two.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);

        let Button = await driver.findComponent(ON.text('OnHttpAuthRequestEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_5000);
        if (platform == "iOS") {
          await driver.delayMs(AWAIT_SLEEP_MS_5000);
        }

        let isTrue_Text = await driver.findComponent(ON.id('TAG'));
        const isTrue = await isTrue_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(isTrue).assertEqual("isTrue: true");
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnPermissionRequest_02100
     * @tc.name   : ACTS_ARKUIX_Web_OnPermissionRequest_02100
     * @tc.desc   : Test web OnPermissionRequestEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnPermissionRequest_02100', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let two = await driver.findComponent(ON.text('two'));
        await two.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnPermissionRequestEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000)
        if (platform != 'iOS') {
          let getOrigin_Text = await driver.findComponent(ON.id('getOrigin'));
          const getOrigin = await getOrigin_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(getOrigin != null).assertTrue();
        }
        let getAccessibleResource_length_Text = await driver.findComponent(ON.id('getAccessibleResource_length'));
        const getAccessibleResource_length = await getAccessibleResource_length_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(getAccessibleResource_length != null).assertTrue();

        let getAccessibleResource_Text = await driver.findComponent(ON.id('getAccessibleResource'));
        const getAccessibleResource = await getAccessibleResource_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(getAccessibleResource != null).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnScroll_02200
     * @tc.name   : ACTS_ARKUIX_Web_OnScroll_02200
     * @tc.desc   : Test web OnScrollEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnScroll_02200', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let two = await driver.findComponent(ON.text('two'));
        await two.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnScrollEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let Button_change_percent = await driver.findComponent(ON.text('change_percent'));
        await Button_change_percent.click();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        let yOffset_Text = await driver.findComponent(ON.id('yOffset'));
        const yOffset = await yOffset_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(yOffset != null).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnPageVisibleEvent_02300
     * @tc.name   : ACTS_ARKUIX_Web_OnPageVisibleEvent_02300
     * @tc.desc   : Test web OnPageVisibleEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnPageVisibleEvent_02300', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let two = await driver.findComponent(ON.text('two'));
        await two.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnPageVisibleEvent'));
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let URL_Text = await driver.findComponent(ON.id('url'));
        const URL = await URL_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(URL != null).assertTrue();
        done()
      } catch (error) {
        expect().assertFail()
      }
    })

    /**
     * @tc.number : ACTS_ARKUIX_Web_OnLoadInterceptEvent_02400
     * @tc.name   : ACTS_ARKUIX_Web_OnLoadInterceptEvent_02400
     * @tc.desc   : Test web OnLoadInterceptEvent interface
     * @tc.level  : Level 1
     */
    it('ACTS_ARKUIX_Web_OnLoadInterceptEvent_02400', 1, async (done: Function) => {
      try {
        await startAbility('com.example.webviewxts', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let two = await driver.findComponent(ON.text('two'));
        await two.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button = await driver.findComponent(ON.text('OnLoadInterceptEvent'));
        await driver.delayMs(AWAIT_SLEEP_MS_2000);
        await Button.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let URL_Text = await driver.findComponent(ON.id('url'));
        const URL = await URL_Text.getText();
        if (platform == "Android") {
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(URL).assertEqual("url: https://www.baidu.com/");
        } else {
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(URL).assertEqual("url: http://www.baidu.com/");
        }
        if (platform != 'iOS') {
          let isMainFrame_Text = await driver.findComponent(ON.id('isMainFrame'));
          const isMainFrame = await isMainFrame_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(isMainFrame).assertEqual("isMainFrame: true");
        }

        let isRedirect_Text = await driver.findComponent(ON.id('isRedirect'));
        const isRedirect = await isRedirect_Text.getText();
        if (platform == 'OpenHarmony') {
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(isRedirect).assertEqual("isRedirect: false");
        } else if (platform == 'Android') {
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(isRedirect).assertEqual("isRedirect: true");
        }
        if (platform != 'iOS') {
          let isRequestGesture_Text = await driver.findComponent(ON.id('isRequestGesture'));
          const isRequestGesture = await isRequestGesture_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(isRequestGesture).assertEqual("isRequestGesture: false");
          let getRequestMethod_Text = await driver.findComponent(ON.id('getRequestMethod'));
          const getRequestMethod = await getRequestMethod_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(getRequestMethod).assertEqual("getRequestMethod: GET");
          let getRequestHeader_length_Text = await driver.findComponent(ON.id('getRequestHeader_length'));
          const getRequestHeader_length = await getRequestHeader_length_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          expect(getRequestHeader_length != "getRequestHeader_length: ").assertTrue();
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })
  })
}