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

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const WAIT_MS_500 = 500;
const WAIT_PAGE_MS_1000 = 1000;
const WAIT_PAGE_MS_3000 = 3000;

let driver = Driver.create();

export default function ClearCookiesTest() {
  describe('ClearCookiesTest', () => {

    beforeAll(async () => {
      await sleep(WAIT_PAGE_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("index_nav_clear_all_cookies_test"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterAll(async () => {
      await sleep(WAIT_PAGE_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("session_cookie_back"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_PAGE_MS_1000);
    })

    /**
     * @tc.number : ArkUIX_WebCookieManager_ClearAllCookiesSync_0100
     * @tc.name   : ArkUIX_WebCookieManager_ClearAllCookiesSync_0100
     * @tc.desc   : Test clearAllCookiesSync(false) in normal mode
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ClearAllCookiesSync_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          await sleep(WAIT_MS_500);
          let writeBtn = await driver.findComponent(ON.id('clear_cookies_normal_write'));
          await writeBtn.click();
          await sleep(WAIT_PAGE_MS_3000);
          let clearBtn = await driver.findComponent(ON.id('clear_cookies_normal_read_before'));
          await clearBtn.click();
          await sleep(WAIT_MS_500);

          let clearBtn1 = await driver.findComponent(ON.id('clear_cookies_normal_clear'));
          await clearBtn1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id('clear_cookies_feedback'))).getText();
          expect(result).assertContain('clearAllCookiesSync(false) 成功');

          let clearBtn2 = await driver.findComponent(ON.id('clear_cookies_normal_read_after'));
          await clearBtn2.click();
          await sleep(WAIT_MS_500);
          let result1 = await (await driver.findComponent(ON.id('normalCookieAfter'))).getText();
          expect(result1).assertContain('(空)');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ClearAllCookiesSync_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ClearAllCookiesSync_0200
     * @tc.name   : ArkUIX_WebCookieManager_ClearAllCookiesSync_0200
     * @tc.desc   : Test clearAllCookiesSync(true) in incognito mode
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ClearAllCookiesSync_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          await sleep(WAIT_MS_500);
          let writeBtn = await driver.findComponent(ON.id('clear_cookies_incognito_write'));
          await writeBtn.click();
          await sleep(WAIT_MS_500);
          let clearBtn = await driver.findComponent(ON.id('clear_cookies_incognito_read_before'));
          await clearBtn.click();
          await sleep(WAIT_MS_500);
          let clearBtn1 = await driver.findComponent(ON.id('clear_cookies_incognito_clear'));
          await clearBtn1.click();
          await sleep(WAIT_MS_500)
          let result = await (await driver.findComponent(ON.id('clear_cookies_feedback'))).getText();
          expect(result).assertContain('clearAllCookiesSync(true) 成功');

          let clearBtn2 = await driver.findComponent(ON.id('clear_cookies_incognito_read_after'));
          await clearBtn2.click();
          await sleep(WAIT_MS_500);
          let result1 = await (await driver.findComponent(ON.id('incognitoCookieAfter'))).getText();
          expect(result1).assertContain('(空)');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ClearAllCookiesSync_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_ClearSessionCookieSync_0300
     * @tc.name   : ArkUIX_WebCookieManager_ClearSessionCookieSync_0300
     * @tc.desc   : Test clearSessionCookieSync
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_ClearSessionCookieSync_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          await sleep(WAIT_PAGE_MS_1000);
          let button_goPage = await driver.findComponent(ON.id("clear_cookies_back"));
          await button_goPage.click();
          await sleep(WAIT_PAGE_MS_1000);
          let button_goPage1 = await driver.findComponent(ON.id("index_nav_clear_session_cookie_test"));
          await button_goPage1.click();
          await sleep(WAIT_PAGE_MS_1000);
          let writeBtn1 = await driver.findComponent(ON.id('session_cookie_write_session'));
          await writeBtn1.click();
          await sleep(WAIT_PAGE_MS_1000);
          let writeBtn2 = await driver.findComponent(ON.id('session_cookie_read_before'));
          await writeBtn2.click();
          await sleep(WAIT_PAGE_MS_1000);
          let writeBtn3 = await driver.findComponent(ON.id('session_cookie_clear'));
          await writeBtn3.click();
          await sleep(WAIT_PAGE_MS_1000);
          let writeBtn4 = await driver.findComponent(ON.id('session_cookie_read_after'));
          await writeBtn4.click();
          await sleep(WAIT_PAGE_MS_3000);
          let result = await (await driver.findComponent(ON.id('session_cookie_feedback'))).getText();
          expect(result).assertContain('clearSessionCookieSync 成功');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_ClearSessionCookieSync_0300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });
  });
}
