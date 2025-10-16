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

export default function WebSchemeHandlerResponse() {

  describe('WebSchemeHandlerResponse', () => {

    afterEach(async () => {
        let topAbility = await delegator.getCurrentTopAbility();
        await topAbility.context.terminateSelf();
        let driver = Driver.create()
        await driver.delayMs(AWAIT_SLEEP_MS_1000);
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0100
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0100
     * @tc.desc  : Test setUrl getUrl
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('TestSchemeHandlerResponse'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Url_Text = await driver.findComponent(ON.id('Url'));
          const Url = await Url_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(Url).assertEqual('http://www.example.com');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0200
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0200
     * @tc.desc  : Test setStatus getStatus
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('TestSchemeHandlerResponse'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Status_Text = await driver.findComponent(ON.id('Status'));
          const Status = await Status_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(Status).assertEqual('200');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0300
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0300
     * @tc.desc  : Test setStatusText getStatusText
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('TestSchemeHandlerResponse'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let StatusText_Text = await driver.findComponent(ON.id('StatusText'));
          const StatusText = await StatusText_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(StatusText).assertEqual('OK');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0400
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0400
     * @tc.desc  : Test setMimeType getMimeType
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('TestSchemeHandlerResponse'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let MimeType_Text = await driver.findComponent(ON.id('MimeType'));
          const MimeType = await MimeType_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(MimeType).assertEqual('text/html');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0500
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0500
     * @tc.desc  : Test setEncoding getEncoding
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('TestSchemeHandlerResponse'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Encoding_Text = await driver.findComponent(ON.id('Encoding'));
          const Encoding = await Encoding_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(Encoding).assertEqual('utf-8');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0600
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0600
     * @tc.desc  : Test setHeaderByName getHeaderByName
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('TestSchemeHandlerResponse'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let HeaderByName_Text = await driver.findComponent(ON.id('HeaderByName'));
          const HeaderByName = await HeaderByName_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(HeaderByName).assertEqual('value1');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0700
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0700
     * @tc.desc  : Test setNetErrorCode getNetErrorCode
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('TestSchemeHandlerResponse'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('0');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0800
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0800
     * @tc.desc  : Test response Set as an empty string
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('response设置为空字符串'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let ErrorCode_Text = await driver.findComponent(ON.id('ErrorCode'));
          const ErrorCode = await ErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(ErrorCode).assertEqual('"401"');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0900
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0900
     * @tc.desc  : Test response Set to null
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('response设置为null'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let ErrorCode_Text = await driver.findComponent(ON.id('ErrorCode'));
          const ErrorCode = await ErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(ErrorCode).assertEqual('"401"');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERRESPONSE_0900
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerResponse_0900
     * @tc.desc  : Test response Set to undefined
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('ACTS_ARKUIX_WebSchemeHandlerResponse_01000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandlerResponse'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('response设置为undefined'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let ErrorCode_Text = await driver.findComponent(ON.id('ErrorCode'));
          const ErrorCode = await ErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(ErrorCode).assertEqual('"401"');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })
  })
}