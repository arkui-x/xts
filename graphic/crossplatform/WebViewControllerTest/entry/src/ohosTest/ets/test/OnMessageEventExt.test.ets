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

import { describe, beforeAll, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest'
import deviceInfo from '@ohos.deviceInfo';

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const WAIT_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_3000 = 3000;
let driver = Driver.create();
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

export default function OnMessageEventExtTest() {
  describe('OnMessageEventExtTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_PAGE_READY_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("onMessageEventExt测试"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_READY_MS_3000);
    })
    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("Back"));
      await button_goPage.click();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0100
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0100
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button_sendString = await driver.findComponent(ON.id("notifyH5 sendString"));
          await button_sendString.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("String:helloFromH5")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0200
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0200
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendNumber = await driver.findComponent(ON.id("notifyH5 sendNumber"));
          await button_sendNumber.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("Number:54321")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0300
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0300
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendBoolean = await driver.findComponent(ON.id("notifyH5 sendBoolean"));
          await button_sendBoolean.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("Boolean:false")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0400
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0400
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendArray = await driver.findComponent(ON.id("notifyH5 sendArray"));
          await button_sendArray.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("Array:3,2,1")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0500
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0500
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_sendError = await driver.findComponent(ON.id("nullCallback"));
          await button_sendError.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0600
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0600
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_sendError = await driver.findComponent(ON.id("undefinedCallback"));
          await button_sendError.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0700
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0700
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_sendError = await driver.findComponent(ON.id("notifyH5 sendString_getNumber"));
          await button_sendError.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("ErrorCode:17100014")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0800
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0800
     * @tc.desc   : Test WebMessagePort.onMessageEventExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_onMessageEventExt_Func_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        if (platform == 'iOS') {
          done();
          return;
        }
        try {
          let button_sendError = await driver.findComponent(ON.id("notifyH5 closePost"));
          await button_sendError.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("onMessageResult"))).getText();
          expect(result).assertEqual("ErrorCode:17100006")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

  })
}