/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { describe, it, expect, TestType, Size, Level, beforeAll } from "@ohos/hypium";
import common from '@ohos.app.ability.common';
import hilog from '@ohos.hilog';

let domain = 0x0000;
let tag: string = 'testTag';
let context: common.UIAbilityContext

export default function UIAbilityContextStatic() {
  describe("UIAbilityContextStatic", () => {

    beforeAll(async () => {
      context = AppStorage.get<common.UIAbilityContext>("UIAbilityContext") as common.UIAbilityContext
      hilog.info(domain, tag, 'beforeAll end');
    })

    /**
     * @tc.number : SUB_ABILITY_UIAbilityContext_ReportDrawnCompleted_0100
     * @tc.name   : testAbilityUIAbilityContextReportDrawnCompleted0100
     * @tc.desc   : test Method of reportDrawnCompleted
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testAbilityUIAbilityContextReportDrawnCompleted0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (): Promise<void> => {
        let temp = false;
        try {
          context.reportDrawnCompleted((err) => {
            if (err?.code) {
              console.error(`reportDrawnCompleted failed, code is ${err?.code}, message is ${err?.message}`);
              expect().assertFail();
            }
            console.info('reportDrawnCompleted succeed');
            temp = true
            expect(temp).assertTrue();
          });
        } catch (err) {
          hilog.info(domain, tag, `testReportDrawnCompletedStatic001 fail: ` + err);
          expect().assertFail();
        }
      });
  })
}
