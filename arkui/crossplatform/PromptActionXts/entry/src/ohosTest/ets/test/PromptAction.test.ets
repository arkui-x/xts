/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { describe, beforeAll, it, expect, Level } from '@ohos/hypium'
import { Driver, ON } from '@ohos.UiTest'

import promptAction from '@ohos.promptAction';

const waitReadyMs_1000 = 1000;
const waitReadyMs_3000 = 3000;

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function PromptActionTest() {
  beforeAll(async () => {
    await sleep(waitReadyMs_3000);
  })

  describe('PromptActionTest', () => {
    /**
     * @tc.number : SUB_promptAction_showToast_Func_0010
     * @tc.name   : ShowToast
     * @tc.desc   : Test the ToastShowMode.DEFAULT property of the ShowToastOptions
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('SUB_promptAction_showToast_Func_0010', Level.LEVEL0, async (done: Function) => {
      try {
        let driver = Driver.create();
        promptAction.showToast({
          message: 'ToastShowMode.DEFAULT',
          duration: waitReadyMs_3000,
          showMode: promptAction.ToastShowMode.DEFAULT,
        });
        await sleep(waitReadyMs_1000);
        let prompt_Action = await driver.findComponent(ON.text("ToastShowMode.DEFAULT"));
        expect(prompt_Action != null).assertTrue();
      }
      catch (err) {
        expect(err).assertFail();
        console.info('SUB_promptAction_showToast_Func_0010 error' + err);
      }
      done();
    });
  })
}