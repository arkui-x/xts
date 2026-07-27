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
const WAIT_PAGE_MS_3000 = 3000;
let driver = Driver.create();

export default function WebviewControllerTest() {
  describe('WebviewControllerTest', () => {

    beforeAll(async () => {
      await sleep(WAIT_MS_500);
      let button_goPage = await driver.findComponent(ON.id("index_nav_webview_controller"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("webview_controller_back"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_MS_500);
    })

    /**
     * @tc.number : ArkUIX_WebviewController_SetNetworkAvailable_0100
     * @tc.name   : ArkUIX_WebviewController_SetNetworkAvailable_0100
     * @tc.desc   : Test setNetworkAvailable(true)
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebviewController_SetNetworkAvailable_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("webview_controller_set_network_available_true"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("webview_controller_feedback"))).getText();
          expect(result).assertContain('true');
        } catch (error) {
          console.error(`[ArkUIX_WebviewController_SetNetworkAvailable_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebviewController_SetNetworkAvailable_0200
     * @tc.name   : ArkUIX_WebviewController_SetNetworkAvailable_0200
     * @tc.desc   : Test setNetworkAvailable(false)
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebviewController_SetNetworkAvailable_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("webview_controller_set_network_available_false"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("webview_controller_feedback"))).getText();
          expect(result).assertContain('false');
        } catch (error) {
          console.error(`[ArkUIX_WebviewController_SetNetworkAvailable_0200] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebviewController_SetNetworkAvailable_0300
     * @tc.name   : ArkUIX_WebviewController_SetNetworkAvailable_0300
     * @tc.desc   : Test setNetworkAvailable(null) expect error
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ArkUIX_WebviewController_SetNetworkAvailable_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("webview_controller_set_network_available_null"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("webview_controller_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebviewController_SetNetworkAvailable_0300] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number : ArkUIX_WebviewController_SetNetworkAvailable_0400
     * @tc.name   : ArkUIX_WebviewController_SetNetworkAvailable_0400
     * @tc.desc   : Test setNetworkAvailable(undefined) expect error
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ArkUIX_WebviewController_SetNetworkAvailable_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button1 = await driver.findComponent(ON.id("webview_controller_set_network_available_undefined"));
          await button1.click();
          await sleep(WAIT_MS_500);
          let result = await (await driver.findComponent(ON.id("webview_controller_feedback"))).getText();
          expect(result).assertContain('401');
        } catch (error) {
          console.error(`[ArkUIX_WebviewController_SetNetworkAvailable_0400] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });
  });
}
