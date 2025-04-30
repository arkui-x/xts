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
import Want from '@ohos.app.ability.Want';

let driver = Driver.create();
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

export default function DeleteJavaScriptRegister_Function() {
  describe('DeleteJavaScriptRegister_Function', () => {
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
     * @tc.number ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0100
     * @tc.name ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0100
     * @tc.desc Test WebViewController.DeleteJavaScriptRegister function with string
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0100', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("DeleteJSRegister_Function");
        await clickButton("RegisterAsyncMethodList");
        await clickButton("Refresh");
        await clickButton("TestAsyncString");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncString is call, parameter is: webTest");

        await clickButton("DeleteJavaScriptRegister");
        await clickButton("Refresh");
        await clickButton("TestAsyncString");

        result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertEqual("testAsyncString is not call");

        await goToPage("Back");
      } catch (error) {
        console.error(`ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0100, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0200
     * @tc.name ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0200
     * @tc.desc Test WebViewController.DeleteJavaScriptRegister function with no binding exception
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0200', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
      try {
        await goToPage("DeleteJSRegister_Function_Exception");
        await clickButton("NoBinding");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertContain("17100001");
      } catch (error) {
        console.error(`ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0200, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0300
     * @tc.name ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0300
     * @tc.desc Test WebViewController.DeleteJavaScriptRegister function with not exist name
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0300', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
      try {
        await clickButton("DeleteNameIsNotExist");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertContain("17100008");
      } catch (error) {
        console.error(`ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0300, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0400
     * @tc.name ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0400
     * @tc.desc Test WebViewController.DeleteJavaScriptRegister function with empty name
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0400', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
      try {
        await clickButton("DeleteNameIsEmpty");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertContain("17100008");
      } catch (error) {
        console.error(`ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0400, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0500
     * @tc.name ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0500
     * @tc.desc Test WebViewController.DeleteJavaScriptRegister function with undefined name
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0500', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
      try {
        await clickButton("DeleteNameIsUndefined");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertContain("401");
      } catch (error) {
        console.error(`ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0500, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0600
     * @tc.name ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0600
     * @tc.desc Test WebViewController.DeleteJavaScriptRegister function with null name
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0600', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
      try {
        await clickButton("DeleteNameIsNull");

        let result = await (await driver.findComponent(ON.id("Result"))).getText();
        expect(result).assertContain("401");

        await goToPage("Back");
      } catch (error) {
        console.error(`ArkUIX_WebView_WebViewController_DeleteJavaScriptRegister_0600, code: ${error.code},
          message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });
  })
}