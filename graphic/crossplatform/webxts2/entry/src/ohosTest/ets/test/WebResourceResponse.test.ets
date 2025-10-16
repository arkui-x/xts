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
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import deviceInfo from '@ohos.deviceInfo';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium'

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const AWAIT_SLEEP_MS_1000: number = 1000;
const AWAIT_SLEEP_MS_3000: number = 3000;

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


export default function WebResourceResponse() {

  describe('WebResourceResponse', () => {

    afterEach(async () => {
        let topAbility = await delegator.getCurrentTopAbility();
        await topAbility.context.terminateSelf();
        let driver = Driver.create()
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0200
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0100
     * @tc.desc  : Test setResponseData getResponseData
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ResponseData_Text = await driver.findComponent(ON.id('ResponseData'));
        const ResponseData = await ResponseData_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ResponseData != null).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0200
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0200
     * @tc.desc  : Test setResponseEncoding getResponseEncoding
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ResponseEncoding_Text = await driver.findComponent(ON.id('ResponseEncoding'));
        const ResponseEncoding = await ResponseEncoding_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ResponseEncoding).assertEqual('utf-8');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0300
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0300
     * @tc.desc  : Test setResponseMimeType getResponseMimeType
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ResponseMimeType_Text = await driver.findComponent(ON.id('ResponseMimeType'));
        const ResponseMimeType = await ResponseMimeType_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ResponseMimeType).assertEqual('text/html');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0400
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0400
     * @tc.desc  : Test setReasonMessage getReasonMessage
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ReasonMessage_Text = await driver.findComponent(ON.id('ReasonMessage'));
        const ReasonMessage = await ReasonMessage_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ReasonMessage).assertEqual('OK');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0500
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0500
     * @tc.desc  : Test getResponseDataEx
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ResponseDataEx_Text = await driver.findComponent(ON.id('ResponseDataEx'));
        const ResponseDataEx = await ResponseDataEx_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ResponseDataEx != null).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0600
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0600
     * @tc.desc  : Test setResponseCode getResponseCode
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ResponseCode_Text = await driver.findComponent(ON.id('ResponseCode'));
        const ResponseCode = await ResponseCode_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ResponseCode).assertEqual('200');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0700
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0700
     * @tc.desc  : Test getResponseIsReady
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ResponseIsReady_Text = await driver.findComponent(ON.id('ResponseIsReady'));
        const ResponseIsReady = await ResponseIsReady_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ResponseIsReady).assertEqual('true');
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBRESOURCERESPONSE_0800
     * @tc.name  : ACTS_ARKUIX_WebResourceResponse_0800
     * @tc.desc  : Test getResponseHeader
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebResourceResponse_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await startAbility('com.example.webxts2', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let one = await driver.findComponent(ON.text('TestWebResourceResponse'));
        await one.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let Button1 = await driver.findComponent(ON.text('TestResponseResource'));
        await Button1.click();
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
        let ResponseHeader_Text = await driver.findComponent(ON.id('ResponseHeader'));
        const ResponseHeader = await ResponseHeader_Text.getText();
        await driver.delayMs(AWAIT_SLEEP_MS_3000);
        expect(ResponseHeader != null).assertTrue();
      } catch (error) {
        expect().assertFail()
      }
      done()
    })
  })
}