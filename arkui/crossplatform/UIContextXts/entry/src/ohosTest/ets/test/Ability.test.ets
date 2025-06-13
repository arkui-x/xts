/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { describe, beforeAll, it, expect } from '@ohos/hypium';
import { Driver } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import Want from '@ohos.app.ability.Want';
import { KeyboardAvoidMode } from '@ohos.arkui.UIContext';

const waitReadyMs_3000 = 3000;
const delegator = abilityDelegatorRegistry.getAbilityDelegator();
let driver = Driver.create()

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}
async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };
  await delegator.startAbility(want).then(result => {
    console.info(`PromptActionTestTest, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`PromptActionTestTest, start abilityFailed: ${err}`)
  })
}

export default function abilityTest() {
  describe('ActsAbilityTest', () => {
    beforeAll(async () => {
      await startAbility('com.example.uicontextxts', 'EntryAbility');
      await sleep(waitReadyMs_3000);
    })

    /**
     * @tc.number : SUB_setKeyboardAvoidMode_Func_0100
     * @tc.name   : setKeyboardAvoidMode
     * @tc.desc   : Test the KeyboardAvoidMode.RESIZE property of the setKeyboardAvoidMode
     * @tc.level  : Level 0
     */
    it('SUB_setKeyboardAvoidMode_Func_0100', 0, (done: Function) => {
      globalThis.context.setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      let status:number = globalThis.context.getKeyboardAvoidMode();
      expect(status).assertEqual(KeyboardAvoidMode.RESIZE);
      done();
    })

    /**
     * @tc.number : SUB_setKeyboardAvoidMode_Func_0200
     * @tc.name   : setKeyboardAvoidMode
     * @tc.desc   : Test the KeyboardAvoidMode.OFFSET property of the setKeyboardAvoidMode
     * @tc.level  : Level 0
     */
    it('SUB_setKeyboardAvoidMode_Func_0200', 0, (done: Function) => {
      globalThis.context.setKeyboardAvoidMode(KeyboardAvoidMode.OFFSET);
      let status:number = globalThis.context.getKeyboardAvoidMode();
      expect(status).assertEqual(KeyboardAvoidMode.OFFSET);
      done();
    })

    /**
     * @tc.number : SUB_setKeyboardAvoidMode_Func_0300
     * @tc.name   : setKeyboardAvoidMode
     * @tc.desc   : Test the KeyboardAvoidMode property of the setKeyboardAvoidMode
     * @tc.level  : Level 2
     */
    it('SUB_setKeyboardAvoidMode_Func_0300', 0, (done: Function) => {
      globalThis.context.setKeyboardAvoidMode(null);
      let status:number = globalThis.context.getKeyboardAvoidMode();
      expect(status).assertEqual(KeyboardAvoidMode.OFFSET);
      done();
    })

    /**
     * @tc.number : SUB_setKeyboardAvoidMode_Func_0400
     * @tc.name   : setKeyboardAvoidMode
     * @tc.desc   : Test the KeyboardAvoidMode property of the setKeyboardAvoidMode
     * @tc.level  : Level 2
     */
    it('SUB_setKeyboardAvoidMode_Func_0400', 0, (done: Function) => {
      globalThis.context.setKeyboardAvoidMode(undefined);
      let status:number = globalThis.context.getKeyboardAvoidMode();
      expect(status).assertEqual(KeyboardAvoidMode.OFFSET);
      done();
    })

    /**
     * @tc.number : SUB_setKeyboardAvoidMode_Func_0500
     * @tc.name   : setKeyboardAvoidMode
     * @tc.desc   : Test the KeyboardAvoidMode property of the setKeyboardAvoidMode
     * @tc.level  : Level 2
     */
    it('SUB_setKeyboardAvoidMode_Func_0500', 0, (done: Function) => {
      globalThis.context.setKeyboardAvoidMode();
      let status:number = globalThis.context.getKeyboardAvoidMode();
      expect(status).assertEqual(KeyboardAvoidMode.OFFSET);
      done();
    })

    /**
     * @tc.number : SUB_getKeyboardAvoidMode_Func_0100
     * @tc.name   : getKeyboardAvoidMode
     * @tc.desc   : Test the getKeyboardAvoidMode
     * @tc.level  : Level 0
     */
    it('SUB_getKeyboardAvoidMode_Func_0100', 0, (done: Function) => {
      globalThis.context.setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      let status:number = globalThis.context.getKeyboardAvoidMode();
      expect(status).assertEqual(KeyboardAvoidMode.RESIZE);
      done();
    })

    /**
     * @tc.number : SUB_getKeyboardAvoidMode_Func_0200
     * @tc.name   : getKeyboardAvoidMode
     * @tc.desc   : Test the getKeyboardAvoidMode
     * @tc.level  : Level 0
     */
    it('SUB_getKeyboardAvoidMode_Func_0200', 0, (done: Function) => {
      globalThis.context.setKeyboardAvoidMode(KeyboardAvoidMode.OFFSET);
      let status:number = globalThis.context.getKeyboardAvoidMode();
      expect(status).assertEqual(KeyboardAvoidMode.OFFSET);
      done();
    })

  })
}