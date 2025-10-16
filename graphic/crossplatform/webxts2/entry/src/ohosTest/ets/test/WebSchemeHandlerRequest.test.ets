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


export default function WebSchemeHandlerRequest() {

  describe('WebSchemeHandlerRequest', () => {

    afterEach(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(AWAIT_SLEEP_MS_1000);
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERREQUEST_0100
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerRequest_0100
     * @tc.desc  : Test RequestUrl
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerRequest_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandler'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let RequestUrl_Text = await driver.findComponent(ON.id('RequestUrl'));
          const RequestUrl = await RequestUrl_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(RequestUrl).assertEqual('https://www.example.com/');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERREQUEST_0200
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerRequest_0200
     * @tc.desc  : Test RequestMethod
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerRequest_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandler'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let RequestMethod_Text = await driver.findComponent(ON.id('RequestMethod'));
          const RequestMethod = await RequestMethod_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(RequestMethod != null).assertTrue();
          expect(RequestMethod).assertEqual('GET');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERREQUEST_0300
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerRequest_0300
     * @tc.desc  : Test isMainFrame
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerRequest_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandler'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let isMainFrame_Text = await driver.findComponent(ON.id('isMainFrame'));
          const isMainFrame = await isMainFrame_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(isMainFrame).assertEqual('true');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERREQUEST_0400
     * @tc.name  : ACTS_ARKUIX_WEBSCHEMEHANDLERREQUEST_0400
     * @tc.desc  : Test hasGesture
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerRequest_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandler'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let hasGesture_Text = await driver.findComponent(ON.id('hasGesture'));
          const hasGesture = await hasGesture_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(hasGesture != null).assertTrue();
          expect(hasGesture).assertEqual('false');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEBSCHEMEHANDLERREQUEST_0500
     * @tc.name  : ACTS_ARKUIX_WebSchemeHandlerRequest_0500
     * @tc.desc  : Test getHeader
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_WebSchemeHandlerRequest_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebSchemeHandler'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          let Header_Text = await driver.findComponent(ON.id('Header'));
          const Header = await Header_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(Header != null).assertTrue();
        } catch (error) {
          expect().assertFail()
        }
        done()
      })
  })
}