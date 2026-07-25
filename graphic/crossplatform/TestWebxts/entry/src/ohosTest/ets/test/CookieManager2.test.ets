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
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];
let driver = Driver.create();

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const WAIT_MS_500 = 500;
const WAIT_PAGE_MS_3000 = 3000;

export default function CookieManagerTest2() {
  describe('CookieManagerTest2', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_500);
      let button_goPage = await driver.findComponent(ON.id("index_nav_web_cookie_manager2"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("web_cookie_manager2_back"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_MS_500);
    })


    /**
     * @tc.number : ArkUIX_WebCookieManager_SaveCookieAsync_0100
     * @tc.name   : ArkUIX_WebCookieManager_SaveCookieAsync_0100
     * @tc.desc   : Test SaveCookieSync callback
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_SaveCookieAsync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          if (platform === 'iOS') {
            done();
            return;
          }
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_save_cookie_async_callback"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SaveCookieAsync_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_SaveCookieAsync_0200
     * @tc.name   : ArkUIX_WebCookieManager_SaveCookieAsync_0200
     * @tc.desc   : Test SaveCookieSync promise
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_SaveCookieAsync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          if (platform === 'iOS') {
            done();
            return;
          }
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_save_cookie_async_promise"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SaveCookieAsync_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_SaveCookieAsync_0300
     * @tc.name   : ArkUIX_WebCookieManager_SaveCookieAsync_0300
     * @tc.desc   : Test SaveCookieAsynccallback with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_SaveCookieAsync_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          if (platform === 'iOS') {
            done();
            return;
          }
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_save_cookie_async_callback_invalid_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SaveCookieAsync_0300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_SaveCookieAsync_0400
     * @tc.name   : ArkUIX_WebCookieManager_SaveCookieAsync_0400
     * @tc.desc   : Test SaveCookieAsync with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_SaveCookieAsync_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          if (platform === 'iOS') {
            done();
            return;
          }
          let button1 =
            await driver.findComponent(ON.id("web_cookie_manager_save_cookie_async_callback_invalid_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SaveCookieAsync_0400] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_FetchCookieSync_0100
     * @tc.name   : ArkUIX_WebCookieManager_FetchCookieSync_0100
     * @tc.desc   : Test FetchCookieSync
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_FetchCookieSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_fetch_cookie_sync"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('success');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_FetchCookieSync_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_FetchCookieSync_0200
     * @tc.name   : ArkUIX_WebCookieManager_FetchCookieSync_0200
     * @tc.desc   : Test FetchCookieSync callback with code 17100002
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_FetchCookieSync_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_fetch_cookie_sync_expect_17100002"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('17100002');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_FetchCookieSync_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_FetchCookieSync_0300
     * @tc.name   : ArkUIX_WebCookieManager_FetchCookieSync_0300
     * @tc.desc   : Test FetchCookieSync callback with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_FetchCookieSync_0300',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_fetch_cookie_sync_invalid_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_FetchCookieSync_0300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_FetchCookieSync_0400
     * @tc.name   : ArkUIX_WebCookieManager_FetchCookieSync_0400
     * @tc.desc   : Test FetchCookieSync callback with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_FetchCookieSync_0400',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_fetch_cookie_sync_invalid_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_FetchCookieSync_0400] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_SetAcceptCookie_0100
     * @tc.name   : ArkUIX_WebCookieManager_SetAcceptCookie_0100
     * @tc.desc   : Test SetAcceptCookie with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_SetAcceptCookie_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_set_accept_cookie_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SetAcceptCookie_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_SetAcceptCookie_0200
     * @tc.name   : ArkUIX_WebCookieManager_SetAcceptCookie_0200
     * @tc.desc   : Test SetAcceptCookie with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_SetAcceptCookie_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_set_accept_cookie_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SetAcceptCookie_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0100
     * @tc.name   : ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0100
     * @tc.desc   : Test SetAcceptThirdPartyCookie with invalid null parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_set_accept_third_party_cookie_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0200
     * @tc.name   : ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0200
     * @tc.desc   : Test SetAcceptThirdPartyCookie with invalid undefined parameter
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */

    it('ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0200',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("web_cookie_manager_set_accept_third_party_cookie_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("web_cookie_manager2_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_SetAcceptThirdPartyCookie_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });
  });
}
