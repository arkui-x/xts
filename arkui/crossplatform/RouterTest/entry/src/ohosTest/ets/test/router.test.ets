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
import { Driver, On, ON } from '@ohos.UiTest'
import { describe, afterEach, beforeEach, it, expect, beforeAll, afterAll } from '@ohos/hypium';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const WAIT_PAGE_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_1500 = 1500;
const WAIT_PAGE_READY_MS_2000 = 2000;
const WAIT_PAGE_READY_MS_3000 = 3000;
let driver = Driver.create();

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

async function gotoPage(on: On) {
  let goPage = await driver.findComponent(on);
  await goPage.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1500);
}

async function clickButton(on: On) {
  let button = await driver.findComponent(on);
  await button.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_1500);
}

async function getPageInfo() {
  let button = await driver.findComponent(ON.id('getPageInfo'));
  await button.click();
  await driver.delayMs(WAIT_PAGE_READY_MS_500);
}

export default function RouterTest() {
  describe("RouterTest", () => {
    beforeAll(async () => {
      await driver.delayMs(WAIT_PAGE_READY_MS_3000);
    })
    beforeEach(async () => {
      await startAbility('com.example.routertest', 'EntryAbility');
      await driver.delayMs(WAIT_PAGE_READY_MS_2000);
    })
    afterEach(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(WAIT_PAGE_READY_MS_500);
    })
    afterAll(async () => {
      await driver.delayMs(WAIT_PAGE_READY_MS_3000);
    })

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0100
     * @tc.name   : testRouterReplaceUrlPromise0001
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0001", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:TestPage'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0200
     * @tc.name   : testRouterReplaceUrlPromise0002
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0002", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:/'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0300
     * @tc.name   : testRouterReplaceUrlPromise0003
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0003", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:NotExistPage'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 200002');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0400
     * @tc.name   : testRouterReplaceUrlPromise0004
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0004", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:""'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: ReplaceUrl_OneParameter_Promise');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0500
     * @tc.name   : testRouterReplaceUrlPromise0005
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0005", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:null'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0600
     * @tc.name   : testRouterReplaceUrlPromise0006
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0006", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:undefined'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0700
     * @tc.name   : testRouterReplaceUrlPromise0007
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0007", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Params:message'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: The message from ReplaceUrl_OneParameter_Promise page');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0800
     * @tc.name   : testRouterReplaceUrlPromise0008
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0008", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Params:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_0900
     * @tc.name   : testRouterReplaceUrlPromise0009
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0009", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Params:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1000
     * @tc.name   : testRouterReplaceUrlPromise0010
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0010", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:TestPage'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1100
     * @tc.name   : testRouterReplaceUrlPromise0011
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0011", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:/'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1200
     * @tc.name   : testRouterReplaceUrlPromise0012
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0012", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:NotExistPage'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 200002');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1300
     * @tc.name   : testRouterReplaceUrlPromise0013
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0013", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:""'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: ReplaceUrl_TwoParameter_Promise');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1400
     * @tc.name   : testRouterReplaceUrlPromise0014
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0014", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:null'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1500
     * @tc.name   : testRouterReplaceUrlPromise0015
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0015", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:undefined'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1600
     * @tc.name   : testRouterReplaceUrlPromise0016
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0016", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Params:message'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: The message from ReplaceUrl_TwoParameter_Promise page');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1700
     * @tc.name   : testRouterReplaceUrlPromise0017
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0017", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Params:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1800
     * @tc.name   : testRouterReplaceUrlPromise0018
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlPromise0018", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Params:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_1900
     * @tc.name   : testRouterReplaceUrlPromise0019
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0019", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await gotoPage(ON.id('ReplaceUrl_TestPage page'));
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise Page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_RouterMode:Standard'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 4');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Promise_2000
     * @tc.name   : testRouterReplaceUrlPromise0020
     * @tc.desc   : Test ReplaceUrl Promise
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlPromise0020", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise page'));
        await gotoPage(ON.id('ReplaceUrl_TestPage page'));
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Promise Page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_RouterMode:Single'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0100
     * @tc.name   : testRouterReplaceUrlCallback0001
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0001", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:TestPage'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0200
     * @tc.name   : testRouterReplaceUrlCallback0002
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0002", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:/'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0300
     * @tc.name   : testRouterReplaceUrlCallback0003
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0003", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:NotExistPage'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 200002');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0400
     * @tc.name   : testRouterReplaceUrlCallback0004
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0004", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:""'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: ReplaceUrl_OneParameter_Callback');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0500
     * @tc.name   : testRouterReplaceUrlCallback0005
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0005", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:null'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0600
     * @tc.name   : testRouterReplaceUrlCallback0006
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0006", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Url:undefined'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0700
     * @tc.name   : testRouterReplaceUrlCallback0007
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0007", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Params:message'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: The message from ReplaceUrl_OneParameter_Callback page');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0800
     * @tc.name   : testRouterReplaceUrlCallback0008
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0008", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Params:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_0900
     * @tc.name   : testRouterReplaceUrlCallback0009
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0009", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_OneParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_OneParameter_Params:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1000
     * @tc.name   : testRouterReplaceUrlCallback0010
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0010", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:TestPage'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1100
     * @tc.name   : testRouterReplaceUrlCallback0011
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0011", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:/'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1200
     * @tc.name   : testRouterReplaceUrlCallback0012
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0012", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:NotExistPage'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 200002');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1300
     * @tc.name   : testRouterReplaceUrlCallback0013
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0013", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:""'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: ReplaceUrl_TwoParameter_Callback');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1400
     * @tc.name   : testRouterReplaceUrlCallback0014
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0014", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:null'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1500
     * @tc.name   : testRouterReplaceUrlCallback0015
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0015", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Url:undefined'));
        await getPageInfo();

        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: 401');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1600
     * @tc.name   : testRouterReplaceUrlCallback0016
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0016", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Params:message'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: The message from ReplaceUrl_TwoParameter_Callback page');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1700
     * @tc.name   : testRouterReplaceUrlCallback0017
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0017", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Params:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1800
     * @tc.name   : testRouterReplaceUrlCallback0018
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 2
     */
    it("testRouterReplaceUrlCallback0018", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_Params:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_1900
     * @tc.name   : testRouterReplaceUrlCallback0019
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0019", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await gotoPage(ON.id('ReplaceUrl_TestPage page'));
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback Page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_RouterMode:Standard'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 4');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_ReplaceUrl_Callback_2000
     * @tc.name   : testRouterReplaceUrlCallback0020
     * @tc.desc   : Test ReplaceUrl Callback
     * @tc.level  : Level 0
     */
    it("testRouterReplaceUrlCallback0020", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback page'));
        await gotoPage(ON.id('ReplaceUrl_TestPage page'));
        await gotoPage(ON.id('ReplaceUrl_TwoParameter_Callback Page'));
        await clickButton(ON.id('ReplaceUrl_TwoParameter_RouterMode:Single'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: TestPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0100
     * @tc.name   : testRouterBack0001
     * @tc.desc   : Test Back
     * @tc.level  : Level 0
     */
    it("testRouterBack0001", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Url:Index'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0200
     * @tc.name   : testRouterBack0002
     * @tc.desc   : Test Back
     * @tc.level  : Level 0
     */
    it("testRouterBack0002", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Url:/'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Back_OneParameter');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0300
     * @tc.name   : testRouterBack0003
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0003", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Url:NotExistPage'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Back_OneParameter');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0400
     * @tc.name   : testRouterBack0004
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0004", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Url:""'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: BackPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0500
     * @tc.name   : testRouterBack0005
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0005", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Url:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: BackPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0600
     * @tc.name   : testRouterBack0006
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0006", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Url:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: BackPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0700
     * @tc.name   : testRouterBack0007
     * @tc.desc   : Test Back
     * @tc.level  : Level 0
     */
    it("testRouterBack0007", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Params:message'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: The message from Back_OneParameter page');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0800
     * @tc.name   : testRouterBack0008
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0008", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Params:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_0900
     * @tc.name   : testRouterBack0009
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0009", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_Params:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1000
     * @tc.name   : testRouterBack0010
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0010", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: BackPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1100
     * @tc.name   : testRouterBack0011
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0011", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_OneParameter Page'));
        await clickButton(ON.id('Back_OneParameter_undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: BackPage');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 2');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1200
     * @tc.name   : testRouterBack0012
     * @tc.desc   : Test Back
     * @tc.level  : Level 0
     */
    it("testRouterBack0012", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Index:1'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1300
     * @tc.name   : testRouterBack0013
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0013", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Index:-1'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Back_TwoParameter');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1400
     * @tc.name   : testRouterBack0014
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0014", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Index:10'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Back_TwoParameter');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1500
     * @tc.name   : testRouterBack0015
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0015", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Index:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Back_TwoParameter');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1600
     * @tc.name   : testRouterBack0016
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0016", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Index:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Back_TwoParameter');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 3');
        let errResult = await (await driver.findComponent(ON.id('Errcode'))).getText();
        expect(errResult).assertEqual('Errcode: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1700
     * @tc.name   : testRouterBack0017
     * @tc.desc   : Test Back
     * @tc.level  : Level 0
     */
    it("testRouterBack0017", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Params:message'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: The message from Back_TwoParameter page');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1800
     * @tc.name   : testRouterBack0018
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0018", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Params:null'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : ArkUIX_Router_Back_1900
     * @tc.name   : testRouterBack0019
     * @tc.desc   : Test Back
     * @tc.level  : Level 2
     */
    it("testRouterBack0019", 0, async (done: Function) => {
      try {
        await gotoPage(ON.id('BackPage page'));
        await gotoPage(ON.id('Back_TwoParameter Page'));
        await clickButton(ON.id('Back_TwoParameter_Params:undefined'));
        await getPageInfo();

        let nameResult = await (await driver.findComponent(ON.id('PageName'))).getText();
        expect(nameResult).assertEqual('PageName: Index');
        let stackLengthResult = await (await driver.findComponent(ON.id('StackLength'))).getText();
        expect(stackLengthResult).assertEqual('StackLength: 1');
        let paramsResult = await (await driver.findComponent(ON.id('Params'))).getText();
        expect(paramsResult).assertEqual('Params: ');
      } catch (error) {
        console.error(`testCase error, code is ${error.code}, message is ${error.message}`);
        expect().assertFail();
      }
      done();
    });

  })
}