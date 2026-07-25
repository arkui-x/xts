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

export default function WebAttributeTest() {
  describe('WebAttributeTest', () => {

    beforeAll(async () => {
      await sleep(WAIT_MS_500);
      let button_goPage = await driver.findComponent(ON.id("index_nav_web_attribute"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("web_attribute_back"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_MS_500);
    })

    /**
     * @tc.number : ArkUIX_WebAttribute_GetDefaultUserAgent_0100
     * @tc.name   : ArkUIX_WebAttribute_GetDefaultUserAgent_0100
     * @tc.desc   : Test getDefaultUserAgent function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_WebAttribute_GetDefaultUserAgent_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let result = await (await driver.findComponent(ON.id('web_attribute_feedback'))).getText();
          expect(result).assertContain('onResourceLoad资源加载回调 成功');
          await sleep(WAIT_MS_500);
          let button = await driver.findComponent(ON.id("web_attribute_get_default_user_agent"));
          await button.click();
          await sleep(WAIT_MS_500);
          let result1 = await (await driver.findComponent(ON.id('web_attribute_feedback'))).getText();
          expect(result1).assertContain('获取默认 UserAgent 成功');
        } catch (error) {
          console.error(`[ArkUIX_WebAttribute_GetDefaultUserAgent_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });
  });
}
