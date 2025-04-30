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

import { afterAll, afterEach, beforeAll, describe, expect, it, Level, TestType, Size } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import deviceInfo from '@ohos.deviceInfo';
import Want from '@ohos.app.ability.Want';

let driver = Driver.create();
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];
const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const WAIT_MS_800 = 800;
const WAIT_MS_1500 = 1500;
const WAIT_MS_3000 = 3000;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

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

async function goToPage(pageName: string) {
  let button = await driver.findComponent(ON.id(pageName));
  await button.click();
  await sleep(WAIT_MS_1500);
}

async function clickButton(buttonName: string) {
  let button = await driver.findComponent(ON.id(buttonName));
  await button.click();
  await sleep(WAIT_MS_800);
}

export default function JavaScriptProxy_Component() {
  describe('JavaScriptProxy_Component', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_1500);
      await startAbility('com.example.webviewjsregistertest', 'EntryAbility');
      await sleep(WAIT_MS_3000);
    });
    afterAll(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0100
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0100
     * @tc.desc Test Web.JavaScriptProxy component with string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await goToPage("RegisterJSProxy_SyncMethod_Component");
        await clickButton("TestSyncString");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testSyncString is call, parameter is: webTest");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0100, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0200
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0200
     * @tc.desc Test Web.JavaScriptProxy component with number
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncNumber");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testSyncNumber is call, parameter is: 123");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0200, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0300
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0300
     * @tc.desc Test Web.JavaScriptProxy component with boolean
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncBoolean");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testSyncBoolean is call, parameter is: true");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0300, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0400
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0400
     * @tc.desc Test Web.JavaScriptProxy component with number array
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncNumberArray");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testSyncNumberArray is call, parameter is: 1,2,3");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0400, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0500
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0500
     * @tc.desc Test Web.JavaScriptProxy component with string array
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncStringArray");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testSyncStringArray is call, parameter is: a,b,c");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0500, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0600
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0600
     * @tc.desc Test Web.JavaScriptProxy component with boolean array
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncBooleanArray");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testSyncBooleanArray is call, parameter is: true,false,true");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0600, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0700
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0700
     * @tc.desc Test Web.JavaScriptProxy component with number dictionary
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncNumberDictionary");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual('testSyncNumberDictionary is call, parameter is: {"key":1}');
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0700, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0800
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0800
     * @tc.desc Test Web.JavaScriptProxy component with string dictionary
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncStringDictionary");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual('testSyncStringDictionary is call, parameter is: {"key":"test"}');
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0800, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_0900
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_0900
     * @tc.desc Test Web.JavaScriptProxy component with boolean dictionary
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      // The iOS side does not support JS synchronization method registration, so this use case will be skipped on iOS
      if (platform === 'iOS') {
        done();
        return;
      }
      try {
        await clickButton("TestSyncBooleanDictionary");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual('testSyncBooleanDictionary is call, parameter is: {"key":true}');

        await goToPage("Back");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_0900, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1000
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1000
     * @tc.desc Test Web.JavaScriptProxy component with string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await goToPage("RegisterJSProxy_AsyncMethod_Component");
        await clickButton("TestAsyncString");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncString is call, parameter is: webTest");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1000, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1100
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1100
     * @tc.desc Test Web.JavaScriptProxy component with number
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncNumber");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncNumber is call, parameter is: 123");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1100, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1200
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1200
     * @tc.desc Test Web.JavaScriptProxy component with boolean
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncBoolean");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncBoolean is call, parameter is: true");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1200, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1300
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1300
     * @tc.desc Test Web.JavaScriptProxy component with number array
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncNumberArray");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncNumberArray is call, parameter is: 1,2,3");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1300, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1400
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1400
     * @tc.desc Test Web.JavaScriptProxy component with string array
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncStringArray");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncStringArray is call, parameter is: a,b,c");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1400, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1500
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1500
     * @tc.desc Test Web.JavaScriptProxy component with boolean array
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncBooleanArray");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncBooleanArray is call, parameter is: true,false,true");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1500, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1600
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1600
     * @tc.desc Test Web.JavaScriptProxy component with number dictionary
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncNumberDictionary");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual('testAsyncNumberDictionary is call, parameter is: {"key":1}');
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1600, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1700
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1700
     * @tc.desc Test Web.JavaScriptProxy component with string dictionary
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncStringDictionary");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual('testAsyncStringDictionary is call, parameter is: {"key":"test"}');
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1700, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_Web_JavaScriptProxy_1800
     * @tc.name ArkUIX_WebView_Web_JavaScriptProxy_1800
     * @tc.desc Test Web.JavaScriptProxy component with boolean dictionary
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_Web_JavaScriptProxy_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        await clickButton("TestAsyncBooleanDictionary");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual('testAsyncBooleanDictionary is call, parameter is: {"key":true}');

        await goToPage("Back");
      } catch (error) {
        console.error(`ArkUIX_WebView_Web_JavaScriptProxy_1800, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });
  })
}