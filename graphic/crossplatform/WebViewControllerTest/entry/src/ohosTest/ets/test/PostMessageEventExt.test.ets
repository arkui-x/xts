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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { DisplayRotation, Driver, MatchPattern, ON, ResizeDirection, WindowMode } from '@ohos.UiTest'
import Want from '@ohos.app.ability.Want';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import { webview } from '@kit.ArkWeb';
import deviceInfo from '@ohos.deviceInfo';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();

async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await delegator.startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const WAIT_READY_MS_100 = 100;
const WAIT_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_3000 = 3000;
const WAIT_PAGE_READY_MS_8000 = 8000;
let driver = Driver.create();
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

export default function PostMessageEventExtTest() {
  describe('PostMessageEventExtTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_PAGE_READY_MS_8000);
      await startAbility('com.example.webviewcontrollertest', 'EntryAbility');
      await sleep(WAIT_PAGE_READY_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("postMessageEventExt测试"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_READY_MS_3000);
    })
    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("Back"));
      await button_goPage.click();
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_100);
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0100
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0100
     * @tc.desc   : Test WebMessagePort.postMessageEventExt function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0100', 0, async (done: Function) => {
      try {
        let button_setString = await driver.findComponent(ON.id("SendToH5 setString"));
        await button_setString.click();
        await sleep(WAIT_READY_MS_500);
        let result = await (await driver.findComponent(ON.id("h5MessageResult"))).getText();
        expect(result).assertEqual("String:helloFromEts")
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0200
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0200
     * @tc.desc   : Test WebMessagePort.postMessageEventExt function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0200', 0, async (done: Function) => {
      if (platform == 'Android') {
        done();
        return;
      }
      try {
        let button_setNumber = await driver.findComponent(ON.id("SendToH5 setNumber"));
        await button_setNumber.click();
        await sleep(WAIT_READY_MS_500);
        let result = await (await driver.findComponent(ON.id("h5MessageResult"))).getText();
        expect(result).assertEqual("Number:12345")
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0300
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0300
     * @tc.desc   : Test WebMessagePort.postMessageEventExt function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0300', 0, async (done: Function) => {
      if (platform == 'Android') {
        done();
        return;
      }
      try {
        let button_setBoolean = await driver.findComponent(ON.id("SendToH5 setBoolean"));
        await button_setBoolean.click();
        await sleep(WAIT_READY_MS_500);
        let result = await (await driver.findComponent(ON.id("h5MessageResult"))).getText();
        expect(result).assertEqual("Boolean:true")
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0400
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0400
     * @tc.desc   : Test WebMessagePort.postMessageEventExt function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0400', 0, async (done: Function) => {
      if (platform == 'Android') {
        done();
        return;
      }
      try {
        let button_setArray = await driver.findComponent(ON.id("SendToH5 setArray"));
        await button_setArray.click();
        await sleep(WAIT_READY_MS_500);
        let result = await (await driver.findComponent(ON.id("h5MessageResult"))).getText();
        expect(result).assertEqual("Array:1,2,3")
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0500
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0500
     * @tc.desc   : Test WebMessagePort.postMessageEventExt function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0500', 0, async (done: Function) => {
      try {
        let button_setNull = await driver.findComponent(ON.id("SendToH5 setNull"));
        await button_setNull.click();
        await sleep(WAIT_READY_MS_500);
        let result = await (await driver.findComponent(ON.id("h5MessageResult"))).getText();
        expect(result).assertEqual("ErrorCode:401")
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0600
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0600
     * @tc.desc   : Test WebMessagePort.postMessageEventExt function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0600', 0, async (done: Function) => {
      try {
        let button_setUndefined = await driver.findComponent(ON.id("SendToH5 setUndefined"));
        await button_setUndefined.click();
        await sleep(WAIT_READY_MS_500);
        let result = await (await driver.findComponent(ON.id("h5MessageResult"))).getText();
        expect(result).assertEqual("ErrorCode:401")
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0700
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0700
     * @tc.desc   : Test WebMessagePort.postMessageEventExt function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_postMessageEventExt_Func_0700', 0, async (done: Function) => {
      try {
        let button_setUndefined = await driver.findComponent(ON.id("SendToH5 closePost"));
        await button_setUndefined.click();
        await sleep(WAIT_READY_MS_500);
        let result = await (await driver.findComponent(ON.id("h5MessageResult"))).getText();
        expect(result).assertEqual("ErrorCode:17100010")
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0100
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0100
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0100', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.STRING);
        message.setString("12345");
        expect(message.getType()).assertEqual(webview.WebMessageType.STRING);
        expect(message.getString()).assertEqual("12345");
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0200
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0200
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0200', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.NUMBER);
        message.setNumber(12345);
        expect(message.getType()).assertEqual(webview.WebMessageType.NUMBER);
        expect(message.getNumber()).assertEqual(12345);
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0300
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0300
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0300', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.BOOLEAN);
        message.setBoolean(true);
        expect(message.getType()).assertEqual(webview.WebMessageType.BOOLEAN);
        expect(message.getBoolean()).assertEqual(true);
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0400
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0400
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0400', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.ARRAY);
        message.setArray([1, 2, 3]);
        expect(message.getType()).assertEqual(webview.WebMessageType.ARRAY);
        expect(JSON.stringify(message.getArray())).assertEqual('[1,2,3]');
        message.setArray(["1", "2", "3"]);
        expect(JSON.stringify(message.getArray())).assertEqual('["1","2","3"]');
        message.setArray([true, false, true]);
        expect(JSON.stringify(message.getArray())).assertEqual('[true,false,true]');
      } catch (error) {
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0500
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0500
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0500', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.STRING);
        message.setNumber(123);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("17100014");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0600
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0600
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0600', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.STRING);
        message.setString("123");
        message.getNumber();
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("17100014");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0700
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0700
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0700', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(null);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0800
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0800
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0800', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(undefined);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0900
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_0900
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_0900', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.STRING);
        message.setString(null);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1000
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1000
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_1000', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.STRING);
        message.setString(undefined);
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1100
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1100
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_1100', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.NUMBER);
        message.setNumber(null);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1200
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1200
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_1200', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.NUMBER);
        message.setNumber(undefined);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1300
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1300
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_1300', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.BOOLEAN);
        message.setBoolean(null);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1400
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1400
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_1400', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.BOOLEAN);
        message.setBoolean(undefined);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1500
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1500
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_1500', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.ARRAY);
        message.setArray(null);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1600
     * @tc.name   : ACTS_ArkUIX_WebMessagePort_MessageType_Func_1600
     * @tc.desc   : Test WebMessageType function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebMessagePort_MessageType_Func_1600', 0, async (done: Function) => {
      try {
        let message: webview.WebMessageExt = new webview.WebMessageExt();
        message.setType(webview.WebMessageType.ARRAY);
        message.setArray(undefined);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual("401");
      }
      done();
    })

  })
}