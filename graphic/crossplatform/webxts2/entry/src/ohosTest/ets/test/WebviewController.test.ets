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

export default function WebviewController() {

  describe('WebviewController', () => {

    afterEach(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(AWAIT_SLEEP_MS_1000);
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_SETCUSTOMUSERAGENT_0100
     * @tc.name  : ACTS_ARKUIX_Web_setCustomUserAgent_0100
     * @tc.desc  : Test setCustomUserAgent getCustomUserAgent
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_setCustomUserAgent_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebviewController'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('setCustomUserAgent'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('getCustomUserAgent'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let UserAgent_Text = await driver.findComponent(ON.id('userAgent'));
          const UserAgent = await UserAgent_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(UserAgent != null).assertTrue();
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_GETUSERAGENT_0200
     * @tc.name  : ACTS_ARKUIX_Web_getUserAgent_0200
     * @tc.desc  : Test getUserAgent
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_getUserAgent_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebviewController'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('getUserAgent'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let UserAgent_Text = await driver.findComponent(ON.id('userAgent1'));
          const UserAgent = await UserAgent_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(UserAgent != null).assertTrue();
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_SETCUSTOMUSERAGENT_0300
     * @tc.name  : ACTS_ARKUIX_Web_setCustomUserAgent_0300
     * @tc.desc  : Test setCustomUserAgent Set special symbols
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('ACTS_ARKUIX_Web_setCustomUserAgent_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebviewController'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('setCustomUserAgent(123qwe!@#)'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('getCustomUserAgent'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let UserAgent_Text = await driver.findComponent(ON.id('userAgent'));
          const UserAgent = await UserAgent_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(UserAgent != null).assertTrue();
          expect(UserAgent).assertEqual('123qwe!@#');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_SETCUSTOMUSERAGENT_0400
     * @tc.name  : ACTS_ARKUIX_Web_setCustomUserAgent_0400
     * @tc.desc  : Test setCustomUserAgent Set to undefined
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('ACTS_ARKUIX_Web_setCustomUserAgent_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await startAbility('com.example.webxts2', 'EntryAbility');
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestWebviewController'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('setCustomUserAgent(undefined)'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('getCustomUserAgent'));
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