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

import { describe, beforeAll, it, expect, Level, TestType, Size, afterAll, afterEach } from '@ohos/hypium';
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
const WAIT_PAGE_MS_5000 = 5000;


export default function JavaScriptOnDocumentEndTest() {
  describe('JavaScriptOnDocumentEndTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_500);
      let navBtn = await driver.findComponent(ON.id('index_nav_javascript_on_document_End'));
      await navBtn.click();
      await sleep(WAIT_PAGE_MS_3000);
    });

    afterAll(async () => {
      await sleep(WAIT_PAGE_MS_3000);
      let backBtn = await driver.findComponent(ON.id("javascript_doc_end_back"));
      await backBtn.click();
      await sleep(WAIT_PAGE_MS_3000);
    })

    afterEach(async () => {
      await sleep(WAIT_MS_500);
    })

    /**
     * @tc.number : ArkUIX_Web_runJavaScriptOnDocumentEnd_0100
     * @tc.name   : ArkUIX_Web_runJavaScriptOnDocumentEnd_0100
     * @tc.desc   : Test runJavaScriptOnDocumentEnd End script injection
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */

    it('ArkUIX_Web_runJavaScriptOnDocumentEnd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          await sleep(WAIT_PAGE_MS_5000);
          let feedback = await driver.findComponent(ON.id('js_doc_end_feedback'));
          let text = await feedback.getText();
          expect(text).assertContain('Web 页面加载成功');
        } catch (error) {
          console.error('[ArkUIX_Web_runJavaScriptOnDocumentEnd_0100] test failed: ' + JSON.stringify(error));
          expect().assertFail();
        }
        done();
      });
  });
}
