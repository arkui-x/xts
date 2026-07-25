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

export default function SslErrorInvalidTest() {
  describe('SslErrorInvalidTest', () => {

    beforeAll(async () => {
      await sleep(WAIT_MS_500);
      let navBtn = await driver.findComponent(ON.id("index_nav_ssl_error_invalid"));
      await navBtn.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterAll(async () => {
      let backBtn = await driver.findComponent(ON.id("sslErrorBack"));
      await backBtn.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_MS_500);
    })

    /**
     * @tc.number : ArkUIX_Web_SslError_Invalid_Value_0100
     * @tc.name   : ArkUIX_Web_SslError_Invalid_Value_0100
     * @tc.desc   : Verify SslError.Invalid value equals 0
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */

    it('ArkUIX_Web_SslError_Invalid_Value_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await sleep(WAIT_PAGE_MS_3000);
          let result = await (await driver.findComponent(ON.id("invalidValue"))).getText();
          expect(result).assertContain('0');
        } catch (error) {
          console.error(`[ArkUIX_Web_SslError_Invalid_Value_0100] fail, error: ${JSON.stringify(error)}`);
          expect().assertFail();
        }
        done();
      });
  });
}
