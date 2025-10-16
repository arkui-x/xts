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
const AWAIT_SLEEP_MS_2000: number = 2000;
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

export default function WebNetErrorList() {

  describe('WebNetErrorList', () => {

    beforeAll(async () => {
      const driver = Driver.create();
      await startAbility('com.example.webxts2', 'EntryAbility');
      await driver.delayMs(AWAIT_SLEEP_MS_3000);
    });

    afterEach(async () => {
      const driver = Driver.create();
      await driver.delayMs(AWAIT_SLEEP_MS_1000);
      const one = await driver.findComponent(ON.text('return'));
      await one.click();
      await driver.delayMs(AWAIT_SLEEP_MS_2000);
      const two = await driver.findComponent(ON.text('return_index'));
      await two.click();
      await driver.delayMs(AWAIT_SLEEP_MS_2000);
    })

    afterAll(async () => {
      const driver = Driver.create();
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(AWAIT_SLEEP_MS_3000);
    })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0001
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0001
     * @tc.desc  : Test ERR_IO_PENDING
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_IO_PENDING'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-1');

        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0002
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0002
     * @tc.desc  : Test ERR_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one1 = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_FAILED'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-2');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0003
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0003
     * @tc.desc  : Test ERR_ABORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_ABORTED'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-3');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0004
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0004
     * @tc.desc  : Test ERR_INVALID_ARGUMENT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_2000);
          const btn1 = await driver.findComponent(ON.text('ERR_INVALID_ARGUMENT'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-4');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0005
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0005
     * @tc.desc  : Test ERR_INVALID_HANDLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_INVALID_HANDLE'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-5');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0006
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0006
     * @tc.desc  : Test ERR_FILE_NOT_FOUND
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_FILE_NOT_FOUND'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-6');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0007
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0007
     * @tc.desc  : Test ERR_TIMED_OUT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_TIMED_OUT'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-7');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0008
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0008
     * @tc.desc  : Test ERR_FILE_TOO_LARGE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_FILE_TOO_LARGE'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-8');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0009
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0009
     * @tc.desc  : Test ERR_UNEXPECTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_UNEXPECTED'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-9');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0010
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0010
     * @tc.desc  : Test ERR_ACCESS_DENIED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          const driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await btn.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const btn1 = await driver.findComponent(ON.text('ERR_ACCESS_DENIED'));
          await btn1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          const netErrorCodeText = await driver.findComponent(ON.id('NetErrorCode'));
          const netErrorCode = await netErrorCodeText.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(netErrorCode).assertEqual('-10');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0011
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0011
     * @tc.desc  : Test ERR_NOT_IMPLEMENTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NOT_IMPLEMENTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-11');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0012
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0012
     * @tc.desc  : Test ERR_INSUFFICIENT_RESOURCES
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INSUFFICIENT_RESOURCES'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-12');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0013
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0013
     * @tc.desc  : Test ERR_OUT_OF_MEMORY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_OUT_OF_MEMORY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-13');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0014
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0014
     * @tc.desc  : Test ERR_UPLOAD_FILE_CHANGED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UPLOAD_FILE_CHANGED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-14');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0015
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0015
     * @tc.desc  : Test ERR_SOCKET_NOT_CONNECTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKET_NOT_CONNECTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-15');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0016
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0016
     * @tc.desc  : Test ERR_FILE_EXISTS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_FILE_EXISTS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-16');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0017
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0017
     * @tc.desc  : Test ERR_FILE_PATH_TOO_LONG
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_FILE_PATH_TOO_LONG'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-17');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0018
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0018
     * @tc.desc  : Test ERR_FILE_NO_SPACE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_FILE_NO_SPACE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-18');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0019
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0019
     * @tc.desc  : Test ERR_FILE_VIRUS_INFECTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_FILE_VIRUS_INFECTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-19');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0020
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0020
     * @tc.desc  : Test ERR_BLOCKED_BY_CLIENT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst1'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_BLOCKED_BY_CLIENT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-20');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0021
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0021
     * @tc.desc  : Test ERR_BLOCKED_BY_ADMINISTRATOR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_BLOCKED_BY_ADMINISTRATOR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-22');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0022
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0022
     * @tc.desc  : Test ERR_SOCKET_CONNECTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKET_CONNECTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-23');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0022
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0022
     * @tc.desc  : Test ERR_UPLOAD_STREAM_REWIND_NOT_SUPPORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UPLOAD_STREAM_REWIND_NOT_SUPPORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-25');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0024
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0024
     * @tc.desc  : Test ERR_CONTEXT_SHUT_DOWN
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONTEXT_SHUT_DOWN'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-26');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0025
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0025
     * @tc.desc  : Test ERR_BLOCKED_BY_RESPONSE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_BLOCKED_BY_RESPONSE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-27');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0026
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0026
     * @tc.desc  : Test ERR_CLEARTEXT_NOT_PERMITTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CLEARTEXT_NOT_PERMITTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-29');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0027
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0027
     * @tc.desc  : Test ERR_BLOCKED_BY_CSP
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_BLOCKED_BY_CSP'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-30');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0028
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0028
     * @tc.desc  : Test ERR_H2_OR_QUIC_REQUIRED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_H2_OR_QUIC_REQUIRED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-31');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0029
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0029
     * @tc.desc  : Test ERR_BLOCKED_BY_ORB
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_BLOCKED_BY_ORB'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-32');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0030
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0030
     * @tc.desc  : Test ERR_CONNECTION_CLOSED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONNECTION_CLOSED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-100');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0031
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0031
     * @tc.desc  : Test ERR_CONNECTION_RESET
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONNECTION_RESET'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-101');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0032
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0032
     * @tc.desc  : Test ERR_CONNECTION_REFUSED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONNECTION_REFUSED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-102');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0033
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0033
     * @tc.desc  : Test ERR_CONNECTION_ABORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONNECTION_ABORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-103');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0034
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0034
     * @tc.desc  : Test ERR_CONNECTION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONNECTION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-104');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0035
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0035
     * @tc.desc  : Test ERR_NAME_NOT_RESOLVED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NAME_NOT_RESOLVED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-105');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0036
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0036
     * @tc.desc  : Test ERR_INTERNET_DISCONNECTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INTERNET_DISCONNECTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-106');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0037
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0037
     * @tc.desc  : Test ERR_SSL_PROTOCOL_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_PROTOCOL_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-107');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0038
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0038
     * @tc.desc  : Test ERR_ADDRESS_INVALID
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ADDRESS_INVALID'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-108');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0039
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0039
     * @tc.desc  : Test ERR_ADDRESS_UNREACHABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ADDRESS_UNREACHABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-109');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0040
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0040
     * @tc.desc  : Test ERR_NETWORK_CHANGED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst2'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NETWORK_CHANGED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-21');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0041
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0041
     * @tc.desc  : Test ERR_SSL_CLIENT_AUTH_CERT_NEEDED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_CLIENT_AUTH_CERT_NEEDED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-110');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0042
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0042
     * @tc.desc  : Test ERR_TUNNEL_CONNECTION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_TUNNEL_CONNECTION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-111');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0043
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0043
     * @tc.desc  : Test ERR_NO_SSL_VERSIONS_ENABLED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NO_SSL_VERSIONS_ENABLED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-112');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0044
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0044
     * @tc.desc  : Test ERR_SSL_VERSION_OR_CIPHER_MISMATCH
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_VERSION_OR_CIPHER_MISMATCH'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-113');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0045
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0045
     * @tc.desc  : Test ERR_SSL_RENEGOTIATION_REQUESTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_RENEGOTIATION_REQUESTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-114');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     *
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0046
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0046
     * @tc.desc  : Test ERR_PROXY_AUTH_UNSUPPORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_PROXY_AUTH_UNSUPPORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-115');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0047
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0047
     * @tc.desc  : Test ERR_BAD_SSL_CLIENT_AUTH_CERT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0047', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_BAD_SSL_CLIENT_AUTH_CERT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-117');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0048
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0048
     * @tc.desc  : Test ERR_CONNECTION_TIMED_OUT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0048', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONNECTION_TIMED_OUT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-118');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0049
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0049
     * @tc.desc  : Test ERR_HOST_RESOLVER_QUEUE_TOO_LARGE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0049', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_HOST_RESOLVER_QUEUE_TOO_LARGE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-119');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0050
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0050
     * @tc.desc  : Test ERR_SOCKS_CONNECTION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0050', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKS_CONNECTION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-120');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0051
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0051
     * @tc.desc  : Test ERR_SOCKS_CONNECTION_HOST_UNREACHABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0051', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKS_CONNECTION_HOST_UNREACHABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-121');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0052
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0052
     * @tc.desc  : Test ERR_ALPN_NEGOTIATION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0052', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ALPN_NEGOTIATION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-122');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0053
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0053
     * @tc.desc  : Test ERR_SSL_NO_RENEGOTIATION
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0053', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_NO_RENEGOTIATION'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-123');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0054
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0054
     * @tc.desc  : Test ERR_WINSOCK_UNEXPECTED_WRITTEN_BYTES
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0054', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_WINSOCK_UNEXPECTED_WRITTEN_BYTES'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-124');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0055
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0055
     * @tc.desc  : Test ERR_SSL_DECOMPRESSION_FAILURE_ALERT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0055', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_DECOMPRESSION_FAILURE_ALERT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-125');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0056
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0056
     * @tc.desc  : Test ERR_SSL_BAD_RECORD_MAC_ALERT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0056', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_BAD_RECORD_MAC_ALERT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-126');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0057
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0057
     * @tc.desc  : Test ERR_PROXY_AUTH_REQUESTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0057', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_PROXY_AUTH_REQUESTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-127');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0058
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0058
     * @tc.desc  : Test ERR_PROXY_CONNECTION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0058', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_PROXY_CONNECTION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-130');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0059
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0059
     * @tc.desc  : Test ERR_MANDATORY_PROXY_CONFIGURATION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0059', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_MANDATORY_PROXY_CONFIGURATION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-131');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0060
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0060
     * @tc.desc  : Test ERR_PRECONNECT_MAX_SOCKET_LIMIT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0060', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst3'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_PRECONNECT_MAX_SOCKET_LIMIT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-133');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0061
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0061
     * @tc.desc  : Test ERR_SSL_CLIENT_AUTH_PRIVATE_KEY_ACCESS_DENIED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0061', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_CLIENT_AUTH_PRIVATE_KEY_ACCESS_DENIED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-134');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0062
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0062
     * @tc.desc  : Test ERR_SSL_CLIENT_AUTH_CERT_NO_PRIVATE_KEY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0062', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_CLIENT_AUTH_CERT_NO_PRIVATE_KEY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-135');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0063
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0063
     * @tc.desc  : Test ERR_NAME_RESOLUTION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0063', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NAME_RESOLUTION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-137');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0064
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0064
     * @tc.desc  : Test ERR_NETWORK_ACCESS_DENIED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0064', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NETWORK_ACCESS_DENIED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-138');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0065
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0065
     * @tc.desc  : Test ERR_TEMPORARILY_THROTTLED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0065', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_TEMPORARILY_THROTTLED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-139');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0066
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0066
     * @tc.desc  : Test ERR_HTTPS_PROXY_TUNNEL_RESPONSE_REDIRECT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0066', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_HTTPS_PROXY_TUNNEL_RESPONSE_REDIRECT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-140');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0067
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0067
     * @tc.desc  : Test ERR_SSL_CLIENT_AUTH_SIGNATURE_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0067', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_CLIENT_AUTH_SIGNATURE_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-141');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0068
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0068
     * @tc.desc  : Test ERR_MSG_TOO_BIG
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0068', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_MSG_TOO_BIG'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-142');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0069
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0069
     * @tc.desc  : Test ERR_WS_PROTOCOL_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0069', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_WS_PROTOCOL_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-145');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0070
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0070
     * @tc.desc  : Test ERR_ADDRESS_IN_USE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0070', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ADDRESS_IN_USE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-147');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0071
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0071
     * @tc.desc  : Test ERR_SSL_HANDSHAKE_NOT_COMPLETED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0071', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_HANDSHAKE_NOT_COMPLETED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-148');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0072
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0072
     * @tc.desc  : Test ERR_SSL_BAD_PEER_PUBLIC_KEY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0072', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_BAD_PEER_PUBLIC_KEY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-149');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0073
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0073
     * @tc.desc  : Test ERR_SSL_PINNED_KEY_NOT_IN_CERT_CHAIN
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0073', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_PINNED_KEY_NOT_IN_CERT_CHAIN'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-150');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0074
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0074
     * @tc.desc  : Test ERR_CLIENT_AUTH_CERT_TYPE_UNSUPPORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0074', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CLIENT_AUTH_CERT_TYPE_UNSUPPORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-151');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0075
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0075
     * @tc.desc  : Test ERR_SSL_DECRYPT_ERROR_ALERT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0075', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_DECRYPT_ERROR_ALERT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-153');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0076
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0076
     * @tc.desc  : Test ERR_WS_THROTTLE_QUEUE_TOO_LARGE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0076', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_WS_THROTTLE_QUEUE_TOO_LARGE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-154');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0077
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0077
     * @tc.desc  : Test ERR_SSL_SERVER_CERT_CHANGED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0077', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_SERVER_CERT_CHANGED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-156');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0078
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0078
     * @tc.desc  : Test ERR_SSL_UNRECOGNIZED_NAME_ALERT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0078', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_UNRECOGNIZED_NAME_ALERT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-159');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0079
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0079
     * @tc.desc  : Test ERR_SOCKET_SET_RECEIVE_BUFFER_SIZE_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0079', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKET_SET_RECEIVE_BUFFER_SIZE_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-160');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0080
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0080
     * @tc.desc  : Test ERR_PROXY_CERTIFICATE_INVALID
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0080', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst4'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_PROXY_CERTIFICATE_INVALID'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-136');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0081
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0081
     * @tc.desc  : Test ERR_SOCKET_SET_SEND_BUFFER_SIZE_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0081', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKET_SET_SEND_BUFFER_SIZE_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-161');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0082
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0082
     * @tc.desc  : Test ERR_SOCKET_RECEIVE_BUFFER_SIZE_UNCHANGEABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0082', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKET_RECEIVE_BUFFER_SIZE_UNCHANGEABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-162');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0083
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0083
     * @tc.desc  : Test ERR_SOCKET_SEND_BUFFER_SIZE_UNCHANGEABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0083', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SOCKET_SEND_BUFFER_SIZE_UNCHANGEABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-163');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0084
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0084
     * @tc.desc  : Test ERR_SSL_CLIENT_AUTH_CERT_BAD_FORMAT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0084', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_CLIENT_AUTH_CERT_BAD_FORMAT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-164');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0085
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0085
     * @tc.desc  : Test ERR_ICANN_NAME_COLLISION
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0085', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ICANN_NAME_COLLISION'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-166');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0086
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0086
     * @tc.desc  : Test ERR_SSL_SERVER_CERT_BAD_FORMAT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0086', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_SERVER_CERT_BAD_FORMAT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-167');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0087
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0087
     * @tc.desc  : Test ERR_CT_STH_PARSING_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0087', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CT_STH_PARSING_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-168');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })
    /**
     *
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0088
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0088
     * @tc.desc  : Test ERR_CT_STH_INCOMPLETE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0088', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CT_STH_INCOMPLETE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-169');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0089
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0089
     * @tc.desc  : Test ERR_UNABLE_TO_REUSE_CONNECTION_FOR_PROXY_AUTH
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0089', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNABLE_TO_REUSE_CONNECTION_FOR_PROXY_AUTH'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-170');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0090
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0090
     * @tc.desc  : Test ERR_CT_CONSISTENCY_PROOF_PARSING_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0090', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CT_CONSISTENCY_PROOF_PARSING_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-171');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0091
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0091
     * @tc.desc  : Test ERR_SSL_OBSOLETE_CIPHER
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0091', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_OBSOLETE_CIPHER'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-172');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0092
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0092
     * @tc.desc  : Test ERR_WS_UPGRADE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0092', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_WS_UPGRADE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-173');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0093
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0093
     * @tc.desc  : Test ERR_READ_IF_READY_NOT_IMPLEMENTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0093', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_READ_IF_READY_NOT_IMPLEMENTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-174');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0094
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0094
     * @tc.desc  : Test ERR_NO_BUFFER_SPACE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0094', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NO_BUFFER_SPACE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-176');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0095
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0095
     * @tc.desc  : Test ERR_SSL_CLIENT_AUTH_NO_COMMON_ALGORITHMS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0095', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_CLIENT_AUTH_NO_COMMON_ALGORITHMS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-177');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0096
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0096
     * @tc.desc  : Test ERR_EARLY_DATA_REJECTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0096', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_EARLY_DATA_REJECTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-178');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0097
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0097
     * @tc.desc  : Test ERR_WRONG_VERSION_ON_EARLY_DATA
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0097', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_WRONG_VERSION_ON_EARLY_DATA'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-179');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0098
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0098
     * @tc.desc  : Test ERR_TLS13_DOWNGRADE_DETECTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0098', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_TLS13_DOWNGRADE_DETECTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-180');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0099
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0099
     * @tc.desc  : Test ERR_SSL_KEY_USAGE_INCOMPATIBLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0099', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_KEY_USAGE_INCOMPATIBLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-181');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0100
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0100
     * @tc.desc  : Test ERR_INVALID_ECH_CONFIG_LIST
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst5'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INVALID_ECH_CONFIG_LIST'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-182');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0101
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0101
     * @tc.desc  : Test ERR_ECH_NOT_NEGOTIATED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0101', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ECH_NOT_NEGOTIATED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-183');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0102
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0102
     * @tc.desc  : Test ERR_ECH_FALLBACK_CERTIFICATE_INVALID
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0102', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ECH_FALLBACK_CERTIFICATE_INVALID'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-184');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0103
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0103
     * @tc.desc  : Test ERR_CERT_COMMON_NAME_INVALID
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0103', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_COMMON_NAME_INVALID'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-200');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0104
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0104
     * @tc.desc  : Test ERR_CERT_DATE_INVALID
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0104', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_DATE_INVALID'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-201');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0105
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0105
     * @tc.desc  : Test ERR_CERT_AUTHORITY_INVALID
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0105', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_AUTHORITY_INVALID'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-202');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0106
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0106
     * @tc.desc  : Test ERR_CERT_CONTAINS_ERRORS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0106', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_CONTAINS_ERRORS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-203');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0107
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0107
     * @tc.desc  : Test ERR_CERT_NO_REVOCATION_MECHANISM
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0107', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_NO_REVOCATION_MECHANISM'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-204');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0108
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0108
     * @tc.desc  : Test ERR_CERT_UNABLE_TO_CHECK_REVOCATION
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0108', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_UNABLE_TO_CHECK_REVOCATION'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-205');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0109
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0109
     * @tc.desc  : Test ERR_CERT_REVOKED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0109', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_REVOKED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-206');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0110
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0110
     * @tc.desc  : Test ERR_CERT_INVALID
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0110', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_INVALID'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-207');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0111
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0111
     * @tc.desc  : Test ERR_CERT_WEAK_SIGNATURE_ALGORITHM
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0111', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_WEAK_SIGNATURE_ALGORITHM'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-208');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0112
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0112
     * @tc.desc  : Test ERR_CERT_NON_UNIQUE_NAME
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0112', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_NON_UNIQUE_NAME'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-210');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0113
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0113
     * @tc.desc  : Test ERR_CERT_WEAK_KEY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0113', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_WEAK_KEY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-211');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0114
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0114
     * @tc.desc  : Test ERR_CERT_NAME_CONSTRAINT_VIOLATION
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0114', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_NAME_CONSTRAINT_VIOLATION'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-212');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0115
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0115
     * @tc.desc  : Test ERR_CERT_VALIDITY_TOO_LONG
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0115', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_VALIDITY_TOO_LONG'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-213');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0116
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0116
     * @tc.desc  : Test ERR_CERTIFICATE_TRANSPARENCY_REQUIRED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0116', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERTIFICATE_TRANSPARENCY_REQUIRED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-214');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0117
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0117
     * @tc.desc  : Test ERR_CERT_SYMANTEC_LEGACY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0117', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_SYMANTEC_LEGACY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-215');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     *
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0118
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0118
     * @tc.desc  : Test ERR_CERT_KNOWN_INTERCEPTION_BLOCKED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0118', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_KNOWN_INTERCEPTION_BLOCKED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-217');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0119
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0119
     * @tc.desc  : Test ERR_SSL_OBSOLETE_VERSION_OR_CIPHER
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0119', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SSL_OBSOLETE_VERSION_OR_CIPHER'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-218');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0120
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0120
     * @tc.desc  : Test ERR_CERT_END
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0120', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst6'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CERT_END'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-219');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0121
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0121
     * @tc.desc  : Test ERR_INVALID_URL
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0121', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INVALID_URL'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-300');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0122
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0122
     * @tc.desc  : Test ERR_DISALLOWED_URL_SCHEME
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0122', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_DISALLOWED_URL_SCHEME'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-301');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0123
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0123
     * @tc.desc  : Test ERR_UNKNOWN_URL_SCHEME
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0123', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNKNOWN_URL_SCHEME'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-302');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0124
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0124
     * @tc.desc  : Test ERR_INVALID_REDIRECT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0124', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INVALID_REDIRECT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-303');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0125
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0125
     * @tc.desc  : Test ERR_TOO_MANY_REDIRECTS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0125', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_TOO_MANY_REDIRECTS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-310');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0126
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0126
     * @tc.desc  : Test ERR_UNSAFE_REDIRECT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0126', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNSAFE_REDIRECT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-311');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0127
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0127
     * @tc.desc  : Test ERR_UNSAFE_PORT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0127', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNSAFE_PORT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-312');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0128
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0128
     * @tc.desc  : Test ERR_INVALID_RESPONSE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0128', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INVALID_RESPONSE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-320');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0129
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0129
     * @tc.desc  : Test ERR_INVALID_CHUNKED_ENCODING
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0129', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INVALID_CHUNKED_ENCODING'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-321');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0130
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0130
     * @tc.desc  : Test ERR_METHOD_UNSUPPORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0130', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_METHOD_UNSUPPORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-322');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0131
     * @tc.name  : ACTS_ARKUIX_WEB_WEBNETERRORLIST_0131
     * @tc.desc  : Test ERR_UNEXPECTED_PROXY_AUTH
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0131', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNEXPECTED_PROXY_AUTH'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-323');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0132
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0132
     * @tc.desc  : Test ERR_EMPTY_RESPONSE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0132', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_EMPTY_RESPONSE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-324');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0133
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0133
     * @tc.desc  : Test ERR_RESPONSE_HEADERS_TOO_BIG
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0133', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_RESPONSE_HEADERS_TOO_BIG'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-325');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0134
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0134
     * @tc.desc  : Test ERR_PAC_SCRIPT_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0134', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_PAC_SCRIPT_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-327');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0135
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0135
     * @tc.desc  : Test ERR_REQUEST_RANGE_NOT_SATISFIABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0135', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_REQUEST_RANGE_NOT_SATISFIABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-328');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_00136
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0136
     * @tc.desc  : Test ERR_MALFORMED_IDENTITY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0136', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_MALFORMED_IDENTITY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-329');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0137
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0137
     * @tc.desc  : Test ERR_CONTENT_DECODING_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0137', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONTENT_DECODING_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-330');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     *
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0138
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0138
     * @tc.desc  : Test ERR_NETWORK_IO_SUSPENDED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0138', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NETWORK_IO_SUSPENDED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-331');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0139
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0139
     * @tc.desc  : Test ERR_SYN_REPLY_NOT_RECEIVED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0139', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_SYN_REPLY_NOT_RECEIVED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-332');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0140
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0140
     * @tc.desc  : Test ERR_ENCODING_CONVERSION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0140', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst7'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ENCODING_CONVERSION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-333');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0141
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0141
     * @tc.desc  : Test ERR_UNRECOGNIZED_FTP_DIRECTORY_LISTING_FORMAT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0141', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNRECOGNIZED_FTP_DIRECTORY_LISTING_FORMAT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-334');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0142
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0142
     * @tc.desc  : Test ERR_NO_SUPPORTED_PROXIES
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0142', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_NO_SUPPORTED_PROXIES'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-336');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0143
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0143
     * @tc.desc  : Test ERR_HTTP2_PROTOCOL_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0143', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_HTTP2_PROTOCOL_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-337');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     *
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0144
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0144
     * @tc.desc  : Test ERR_INVALID_AUTH_CREDENTIALS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0144', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INVALID_AUTH_CREDENTIALS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-338');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0145
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0145
     * @tc.desc  : Test ERR_UNSUPPORTED_AUTH_SCHEME
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0145', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNSUPPORTED_AUTH_SCHEME'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-339');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0146
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0146
     * @tc.desc  : Test ERR_ENCODING_DETECTION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0146', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_ENCODING_DETECTION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-340');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0147
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0147
     * @tc.desc  : Test ERR_MISSING_AUTH_CREDENTIALS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0147', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_MISSING_AUTH_CREDENTIALS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-341');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0148
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0148
     * @tc.desc  : Test ERR_UNEXPECTED_SECURITY_LIBRARY_STATUS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0148', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNEXPECTED_SECURITY_LIBRARY_STATUS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-342');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0149
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0149
     * @tc.desc  : Test ERR_MISCONFIGURED_AUTH_ENVIRONMENT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0149', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_MISCONFIGURED_AUTH_ENVIRONMENT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-343');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0150
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0150
     * @tc.desc  : Test ERR_UNDOCUMENTED_SECURITY_LIBRARY_STATUS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0150', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_UNDOCUMENTED_SECURITY_LIBRARY_STATUS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-344');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0151
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0151
     * @tc.desc  : Test ERR_RESPONSE_BODY_TOO_BIG_TO_DRAIN
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0151', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_RESPONSE_BODY_TOO_BIG_TO_DRAIN'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-345');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0152
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0152
     * @tc.desc  : Test ERR_RESPONSE_HEADERS_MULTIPLE_CONTENT_LENGTH
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0152', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_RESPONSE_HEADERS_MULTIPLE_CONTENT_LENGTH'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-346');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0153
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0153
     * @tc.desc  : Test ERR_INCOMPLETE_HTTP2_HEADERS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0153', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INCOMPLETE_HTTP2_HEADERS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-347');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0154
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0154
     * @tc.desc  : Test ERR_PAC_NOT_IN_DHCP
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0154', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_PAC_NOT_IN_DHCP'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-348');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0155
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0155
     * @tc.desc  : Test ERR_RESPONSE_HEADERS_MULTIPLE_CONTENT_DISPOSITION
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0155', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_RESPONSE_HEADERS_MULTIPLE_CONTENT_DISPOSITION'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-349');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0156
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0156
     * @tc.desc  : Test ERR_RESPONSE_HEADERS_MULTIPLE_LOCATION
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0156', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_RESPONSE_HEADERS_MULTIPLE_LOCATION'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-350');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0157
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0157
     * @tc.desc  : Test ERR_HTTP2_SERVER_REFUSED_STREAM
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0157', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_HTTP2_SERVER_REFUSED_STREAM'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-351');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0158
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0158
     * @tc.desc  : Test ERR_HTTP2_PING_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0158', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_HTTP2_PING_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-352');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0159
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0159
     * @tc.desc  : Test ERR_CONTENT_LENGTH_MISMATCH
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0159', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_CONTENT_LENGTH_MISMATCH'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-354');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0160
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0160
     * @tc.desc  : Test ERR_INCOMPLETE_CHUNKED_ENCODING
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0160', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst8'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.text('ERR_INCOMPLETE_CHUNKED_ENCODING'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-355');
        } catch (error) {
          expect().assertFail()
        }
        done()
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0161
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0161
     * @tc.desc  : Test ERR_QUIC_PROTOCOL_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0161', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_QUIC_PROTOCOL_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-356');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0162
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0162
     * @tc.desc  : Test ERR_RESPONSE_HEADERS_TRUNCATED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0162', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_RESPONSE_HEADERS_TRUNCATED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-357');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0163
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0163
     * @tc.desc  : Test ERR_QUIC_HANDSHAKE_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0163', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_QUIC_HANDSHAKE_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-358');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0164
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0164
     * @tc.desc  : Test ERR_HTTP2_INADEQUATE_TRANSPORT_SECURITY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0164', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_INADEQUATE_TRANSPORT_SECURITY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-360');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0165
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0165
     * @tc.desc  : Test ERR_HTTP2_FLOW_CONTROL_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */

    it('ACTS_ARKUIX_Web_WebNetErrorList_0165', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_FLOW_CONTROL_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-361');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0166
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0166
     * @tc.desc  : Test ERR_HTTP2_FRAME_SIZE_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0166', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_FRAME_SIZE_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-362');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0167
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0167
     * @tc.desc  : Test ERR_HTTP2_COMPRESSION_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0167', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_COMPRESSION_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-363');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0168
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0168
     * @tc.desc  : Test ERR_PROXY_AUTH_REQUESTED_WITH_NO_CONNECTION
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0168', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PROXY_AUTH_REQUESTED_WITH_NO_CONNECTION'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-364');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0169
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0169
     * @tc.desc  : Test ERR_HTTP_1_1_REQUIRED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0169', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP_1_1_REQUIRED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-365');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0170
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0170
     * @tc.desc  : Test ERR_PROXY_HTTP_1_1_REQUIRED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0170', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PROXY_HTTP_1_1_REQUIRED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-366');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0171
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0171
     * @tc.desc  : Test ERR_PAC_SCRIPT_TERMINATED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0171', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PAC_SCRIPT_TERMINATED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-367');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0172
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0172
     * @tc.desc  : Test ERR_INVALID_HTTP_RESPONSE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0172', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_INVALID_HTTP_RESPONSE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-370');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0173
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0173
     * @tc.desc  : Test ERR_CONTENT_DECODING_INIT_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0173', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CONTENT_DECODING_INIT_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-371');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })
    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0174
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0174
     * @tc.desc  : Test ERR_HTTP2_RST_STREAM_NO_ERROR_RECEIVED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0174', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_RST_STREAM_NO_ERROR_RECEIVED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-372');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0175
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0175
     * @tc.desc  : Test ERR_HTTP2_PUSHED_STREAM_NOT_AVAILABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0175', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_PUSHED_STREAM_NOT_AVAILABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-373');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0176
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0176
     * @tc.desc  : Test ERR_HTTP2_CLAIMED_PUSHED_STREAM_RESET_BY_SERVER
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0176', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_CLAIMED_PUSHED_STREAM_RESET_BY_SERVER'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-374');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0177
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0177
     * @tc.desc  : Test ERR_TOO_MANY_RETRIES
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0177', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_TOO_MANY_RETRIES'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-375');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0178
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0178
     * @tc.desc  : Test ERR_HTTP2_STREAM_CLOSED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0178', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_STREAM_CLOSED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-376');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0179
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0179
     * @tc.desc  : Test ERR_HTTP2_CLIENT_REFUSED_STREAM
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0179', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_CLIENT_REFUSED_STREAM'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-377');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0180
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0180
     * @tc.desc  : Test ERR_HTTP2_PUSHED_RESPONSE_DOES_NOT_MATCH
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0180', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst9'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP2_PUSHED_RESPONSE_DOES_NOT_MATCH'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-378');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0181
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0181
     * @tc.desc  : Test ERR_HTTP_RESPONSE_CODE_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0181', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_HTTP_RESPONSE_CODE_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-379');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0182
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0182
     * @tc.desc  : Test ERR_QUIC_UNKNOWN_CERT_ROOT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0182', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_QUIC_UNKNOWN_CERT_ROOT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-380');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0183
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0183
     * @tc.desc  : Test ERR_QUIC_GOAWAY_REQUEST_CAN_BE_RETRIED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0183', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_QUIC_GOAWAY_REQUEST_CAN_BE_RETRIED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-381');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0184
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0184
     * @tc.desc  : Test ERR_TOO_MANY_ACCEPT_CH_RESTARTS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0184', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_TOO_MANY_ACCEPT_CH_RESTARTS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-382');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0185
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0185
     * @tc.desc  : Test ERR_INCONSISTENT_IP_ADDRESS_SPACE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0185', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_INCONSISTENT_IP_ADDRESS_SPACE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-383');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0186
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0186
     * @tc.desc  : Test ERR_CACHED_IP_ADDRESS_SPACE_BLOCKED_BY_LOCAL_NETWORK_ACCESS_POLICY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0186', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 =
            await driver.findComponent(ON.id('ERR_CACHED_IP_ADDRESS_SPACE_BLOCKED_BY_LOCAL_NETWORK_ACCESS_POLICY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-384');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0187
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0187
     * @tc.desc  : Test ERR_CACHE_MISS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0187', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_MISS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-400');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0188
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0188
     * @tc.desc  : Test ERR_CACHE_READ_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0188', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_READ_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-401');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0189
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0189
     * @tc.desc  : Test ERR_CACHE_WRITE_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0189', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_WRITE_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-402');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0190
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0190
     * @tc.desc  : Test ERR_CACHE_OPERATION_UNSUPPORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0190', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_OPERATION_UNSUPPORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-403');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0191
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0191
     * @tc.desc  : Test ERR_CACHE_OPEN_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0191', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_OPEN_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-404');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0192
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0192
     * @tc.desc  : Test ERR_CACHE_CREATE_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0192', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_CREATE_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-405');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0193
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0193
     * @tc.desc  : Test ERR_CACHE_RACE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0193', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_RACE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-406');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0194
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0194
     * @tc.desc  : Test ERR_CACHE_CHECKSUM_READ_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0194', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_CHECKSUM_READ_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-407');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0195
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0195
     * @tc.desc  : Test ERR_CACHE_CHECKSUM_MISMATCH
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0195', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_CHECKSUM_MISMATCH'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-408');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0196
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0196
     * @tc.desc  : Test ERR_CACHE_LOCK_TIMEOUT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0196', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_LOCK_TIMEOUT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-409');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0197
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0197
     * @tc.desc  : Test ERR_CACHE_AUTH_FAILURE_AFTER_READ
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0197', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_AUTH_FAILURE_AFTER_READ'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-410');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })
    /**
     *
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0198
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0198
     * @tc.desc  : Test ERR_CACHE_ENTRY_NOT_SUITABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0198', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_ENTRY_NOT_SUITABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-411');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0199
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0199
     * @tc.desc  : Test ERR_CACHE_DOOM_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0199', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_DOOM_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-412');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0200
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0200
     * @tc.desc  : Test ERR_CACHE_OPEN_OR_CREATE_FAILURE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst10'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CACHE_OPEN_OR_CREATE_FAILURE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-413');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0201
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0201
     * @tc.desc  : Test ERR_INSECURE_RESPONSE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0201', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_INSECURE_RESPONSE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-501');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0202
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0202
     * @tc.desc  : Test ERR_NO_PRIVATE_KEY_FOR_CERT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0202', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_NO_PRIVATE_KEY_FOR_CERT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-502');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0203
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0203
     * @tc.desc  : Test ERR_ADD_USER_CERT_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0203', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_ADD_USER_CERT_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-503');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0204
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0204
     * @tc.desc  : Test ERR_INVALID_SIGNED_EXCHANGE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0204', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_INVALID_SIGNED_EXCHANGE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-504');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0205
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0205
     * @tc.desc  : Test ERR_INVALID_WEB_BUNDLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0205', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_INVALID_WEB_BUNDLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-505');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0206
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0206
     * @tc.desc  : Test ERR_TRUST_TOKEN_OPERATION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0206', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_TRUST_TOKEN_OPERATION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-506');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0207
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0207
     * @tc.desc  : Test ERR_TRUST_TOKEN_OPERATION_SUCCESS_WITHOUT_SENDING_REQUEST
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0207', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_TRUST_TOKEN_OPERATION_SUCCESS_WITHOUT_SENDING_REQUEST'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-507');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0208
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0208
     * @tc.desc  : Test ERR_FTP_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0208', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_FTP_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-601');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0209
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0209
     * @tc.desc  : Test ERR_FTP_SERVICE_UNAVAILABLE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0209', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_FTP_SERVICE_UNAVAILABLE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-602');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0210
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0210
     * @tc.desc  : Test ERR_FTP_TRANSFER_ABORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0210', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_FTP_TRANSFER_ABORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-603');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0211
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0211
     * @tc.desc  : Test ERR_FTP_FILE_BUSY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0211', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_FTP_FILE_BUSY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-604');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0212
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0212
     * @tc.desc  : Test ERR_FTP_SYNTAX_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0212', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_FTP_SYNTAX_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-605');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     *
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0213
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0213
     * @tc.desc  : Test ERR_FTP_COMMAND_UNSUPPORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0213', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_FTP_COMMAND_UNSUPPORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-606');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0214
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0214
     * @tc.desc  : Test ERR_FTP_BAD_COMMAND_SEQUENCE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0214', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_FTP_BAD_COMMAND_SEQUENCE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-607');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0215
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0215
     * @tc.desc  : Test ERR_PKCS12_IMPORT_BAD_PASSWORD
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0215', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PKCS12_IMPORT_BAD_PASSWORD'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-701');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0216
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0216
     * @tc.desc  : Test ERR_PKCS12_IMPORT_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0216', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PKCS12_IMPORT_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-702');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0217
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0217
     * @tc.desc  : Test ERR_IMPORT_CA_CERT_NOT_CA
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0217', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_IMPORT_CA_CERT_NOT_CA'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-703');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0218
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0218
     * @tc.desc  : Test ERR_IMPORT_CERT_ALREADY_EXISTS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0218', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_IMPORT_CERT_ALREADY_EXISTS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-704');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0219
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0219
     * @tc.desc  : Test ERR_IMPORT_CA_CERT_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0219', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_IMPORT_CA_CERT_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-705');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0220
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0220
     * @tc.desc  : Test ERR_IMPORT_SERVER_CERT_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0220', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst11'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_IMPORT_SERVER_CERT_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-706');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0221
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0221
     * @tc.desc  : Test ERR_PKCS12_IMPORT_INVALID_MAC
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0221', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PKCS12_IMPORT_INVALID_MAC'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-707');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0222
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0222
     * @tc.desc  : Test ERR_PKCS12_IMPORT_INVALID_FILE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0222', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PKCS12_IMPORT_INVALID_FILE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-708');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0223
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0223
     * @tc.desc  : Test ERR_PKCS12_IMPORT_UNSUPPORTED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0223', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PKCS12_IMPORT_UNSUPPORTED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-709');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0224
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0224
     * @tc.desc  : Test ERR_KEY_GENERATION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0224', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_KEY_GENERATION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-710');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0225
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0225
     * @tc.desc  : Test ERR_PRIVATE_KEY_EXPORT_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0225', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_PRIVATE_KEY_EXPORT_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-712');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0226
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0226
     * @tc.desc  : Test ERR_SELF_SIGNED_CERT_GENERATION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0226', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_SELF_SIGNED_CERT_GENERATION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-713');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0227
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0227
     * @tc.desc  : Test ERR_CERT_DATABASE_CHANGED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0227', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CERT_DATABASE_CHANGED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-714');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0228
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0228
     * @tc.desc  : Test ERR_CERT_VERIFIER_CHANGED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0228', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_CERT_VERIFIER_CHANGED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-716');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0229
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0229
     * @tc.desc  : Test ERR_DNS_MALFORMED_RESPONSE
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0229', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_MALFORMED_RESPONSE'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-800');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0230
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0230
     * @tc.desc  : Test ERR_DNS_SERVER_REQUIRES_TCP
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0230', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_SERVER_REQUIRES_TCP'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-801');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0231
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0231
     * @tc.desc  : Test ERR_DNS_SERVER_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0231', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_SERVER_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-802');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0232
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0232
     * @tc.desc  : Test ERR_DNS_TIMED_OUT
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0232', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_TIMED_OUT'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-803');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0233
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0233
     * @tc.desc  : Test ERR_DNS_CACHE_MISS
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0233', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_CACHE_MISS'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-804');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0234
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0234
     * @tc.desc  : Test ERR_DNS_SEARCH_EMPTY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0234', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_SEARCH_EMPTY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-805');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0235
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0235
     * @tc.desc  : Test ERR_DNS_SORT_ERROR
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0235', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_SORT_ERROR'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-806');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0236
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0236
     * @tc.desc  : Test ERR_DNS_SECURE_RESOLVER_HOSTNAME_RESOLUTION_FAILED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0236', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_SECURE_RESOLVER_HOSTNAME_RESOLUTION_FAILED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-808');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0237
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0237
     * @tc.desc  : Test ERR_DNS_NAME_HTTPS_ONLY
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0237', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_NAME_HTTPS_ONLY'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-809');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0238
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0238
     * @tc.desc  : Test ERR_DNS_REQUEST_CANCELED
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0238', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_REQUEST_CANCELED'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-810');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number: ACTS_ARKUIX_WEB_WEBNETERRORLIST_0239
     * @tc.name  : ACTS_ARKUIX_Web_WebNetErrorList_0239
     * @tc.desc  : Test ERR_DNS_NO_MATCHING_SUPPORTED_ALPN
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('ACTS_ARKUIX_Web_WebNetErrorList_0239', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let driver = Driver.create();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let one = await driver.findComponent(ON.text('TestNetErrorLIst'));
          await one.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button = await driver.findComponent(ON.text('TestNetErrorLIst12'));
          await Button.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let Button1 = await driver.findComponent(ON.id('ERR_DNS_NO_MATCHING_SUPPORTED_ALPN'));
          await Button1.click();
          await driver.delayMs(AWAIT_SLEEP_MS_1000);
          let NetErrorCode_Text = await driver.findComponent(ON.id('NetErrorCode'));
          const NetErrorCode = await NetErrorCode_Text.getText();
          await driver.delayMs(AWAIT_SLEEP_MS_3000);
          expect(NetErrorCode).assertEqual('-811');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })
  })
}