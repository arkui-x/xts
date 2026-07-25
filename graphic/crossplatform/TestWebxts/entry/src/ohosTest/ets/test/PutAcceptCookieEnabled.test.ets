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

const WAIT_PAGE_MS_1000 = 1000;
const WAIT_PAGE_MS_3000 = 3000;
let driver = Driver.create();

export default function PutAcceptCookieEnabledTest() {
  describe('PutAcceptCookieEnabledTest', () => {

    beforeAll(async () => {
      await sleep(WAIT_PAGE_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("index_nav_put_accept_cookie_enabled_test"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("acceptCookieBack"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_PAGE_MS_1000);
    })

    /**
     * @tc.number : ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0100
     * @tc.name   : ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0100
     * @tc.desc   : Test PutAcceptCookieEnabled true (Open cookie manager and check cookie reception)
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id("acceptCookieTrueProbe"));
          await button.click();
          await sleep(WAIT_PAGE_MS_3000);
          let result = await (await driver.findComponent(ON.id("acceptCookieStatus"))).getText();
          expect(result).assertContain('true');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0200
     * @tc.name   : ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0200
     * @tc.desc   : Test PutAcceptCookieEnabled false (Close cookie manager and verify cookie blocking)
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id("acceptCookieFalseProbe"));
          await button.click();
          await sleep(WAIT_PAGE_MS_3000);
          let result = await (await driver.findComponent(ON.id("acceptCookieStatus"))).getText();
          expect(result).assertContain('false');
        } catch (error) {
          console.error(`[ArkUIX_WebCookieManager_PutAcceptCookieEnabled_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });
  });
}
