/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { describe, it, expect, Level, TestType, Size, beforeAll, afterAll, afterEach } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest';
import Want from '@ohos.app.ability.Want';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'


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

const WAIT_MS_500 = 500;
const WAIT_PAGE_MS_3000 = 3000;
let driver = Driver.create();

export default function CookieManagerTest() {
  describe('CookieManagerTest', () => {

    beforeAll(async () => {
      await sleep(WAIT_MS_500);
      await startAbility('com.example.testweb', 'EntryAbility');
      await sleep(WAIT_PAGE_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("index_nav_web_cookie_manager"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("web_cookie_manager_back"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_MS_500);
    })

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0100
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0100
     * @tc.desc   : Test ConfigCookieSync
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0200
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0200
     * @tc.desc   : Test ConfigCookieSync callback with code 17100005
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_expect_17100005"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('17100005');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0300
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0300
     * @tc.desc   : Test ConfigCookieSync callback with code 17100002
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_expect_17100002"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('17100002');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0400
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0400
     * @tc.desc   : Test ConfigCookieSync callback with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_invalid_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0400] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0500
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0500
     * @tc.desc   : Test ConfigCookieSync callback with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_invalid_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0500] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0600
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0600
     * @tc.desc   : Test ConfigCookieSync with incognito false and include http false options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_incognito_false_include_http_false"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0600] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0700
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0700
     * @tc.desc   : Test ConfigCookieSync with incognito true and include http false options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0700',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_incognito_true_include_http_false"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0700] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0800
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0800
     * @tc.desc   : Test ConfigCookieSync with incognito false and include http true options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_incognito_false_include_http_true"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0800] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_0900
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_0900
     * @tc.desc   : Test ConfigCookieSync with incognito true and include http true options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {

          let button1 = await driver.findComponent(ON.id("web_cookie_manager_incognito_true_include_http_true"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_0900] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_01000
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_01000
     * @tc.desc   : Test ConfigCookieSync with options callback with code 17100005
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_01000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_with_options_expect_17100005"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('17100005');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_01000] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_01100
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_01100
     * @tc.desc   : Test ConfigCookieSync with options callback with code 17100002
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_01100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_with_options_expect_17100002"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('17100002');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_01100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_01200
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_01200
     * @tc.desc   : Test ConfigCookieSync with options callback with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_01200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_with_options_invalid_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_01200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_01300
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_01300
     * @tc.desc   : Test ConfigCookieSync with options callback with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_01300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_sync_with_options_invalid_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_01300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_01400
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_01400
     * @tc.desc   : Test ConfigCookieSync with incognito false and include http false options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_01400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_incognito_false"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('false');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_01400] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieSync_01500
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieSync_01500
     * @tc.desc   : Test ConfigCookieSync with incognito true and include http false options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieSync_01500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_incognito_true"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('true');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieSync_01500] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });


    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieCallback_0100
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieCallback_0100
     * @tc.desc   : Test ConfigCookieCallback
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookieCallback_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_callback"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieCallback_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieCallback_0200
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieCallback_0200
     * @tc.desc   : Test ConfigCookieCallback with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieCallback_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_callback_invalid_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieCallback_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookieCallback_0300
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookieCallback_0300
     * @tc.desc   : Test ConfigCookieCallback with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookieCallback_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_callback_invalid_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookieCallback_0300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0100
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0100
     * @tc.desc   : Test ConfigCookiePromise
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0200
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0200
     * @tc.desc   : Test ConfigCookiePromise with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_invalid_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0300
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0300
     * @tc.desc   : Test ConfigCookiePromise with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_invalid_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });


    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0400
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0400
     * @tc.desc   : Test ConfigCookiePromise with options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_with_options"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0400] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0500
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0500
     * @tc.desc   : Test ConfigCookiePromise with incognito true and include http false options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0500',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        try {
          ;
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_incognito_true_include_http_false"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0500] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0600
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0600
     * @tc.desc   : Test ConfigCookiePromise with incognito false and include http true options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0600',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_incognito_false_include_http_true"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0600] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0700
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0700
     * @tc.desc   : Test ConfigCookiePromise with incognito true and include http true options
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0700',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_incognito_true_include_http_true"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0700] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0800
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0800
     * @tc.desc   : Test ConfigCookiePromise with options with code 17100002
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0800',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_with_options_expect_17100002"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('17100002');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0800] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_0900
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_0900
     * @tc.desc   : Test ConfigCookiePromise with options with code 17100005
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_0900',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_with_options_expect_17100005"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('17100005');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_0900] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_01000
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_01000
     * @tc.desc   : Test ConfigCookiePromise with options with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_01000',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_with_options_invalid_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_01000] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ConfigCookiePromise_01100
     * @tc.name   : ArkUIX_WebCookieManager_ConfigCookiePromise_01100
     * @tc.desc   : Test ConfigCookiePromise with options with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_ConfigCookiePromise_01100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_config_cookie_promise_with_options_invalid_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ConfigCookiePromise_01100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });
  });
}
