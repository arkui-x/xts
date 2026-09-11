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

import Intl from "@ohos.intl";
import { describe, it, expect, TestType, Size, Level } from '@ohos/hypium';

export default function dateTimeHour12Test() {
  describe("dateTimeHour12Test", () => {

    /**
     * @tc.number SUB_GLOBAL_INTL_JS_DATETIME_2500
     * @tc.name   dateTimeFormat_test_2500
     * @tc.desc   format the hour in zh-CN-u-hc-h12 with matcher. Rewritten as a
     *            dynamic case: pass hour12: true (together with hourCycle h24)
     *            in DateTimeOptions and verify resolvedOptions round-trip,
     *            especially hour12?: boolean field readability.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it("dateTimeFormat_test_2500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      try {
        let option: Intl.DateTimeOptions = {
          year: 'numeric', month: 'long', day: 'numeric',
          hour: 'numeric', minute: '2-digit', second: 'numeric', weekday: 'long', era: 'short',
          hourCycle: 'h24', numberingSystem: 'arab', hour12: true, dayPeriod: 'short',
          formatMatcher: 'basic', localeMatcher: 'lookup'
        };
        let datefmt = new Intl.DateTimeFormat('zh-CN-u-hc-h12', option);
        expect(datefmt.resolvedOptions().locale).assertEqual('zh-CN');
        expect(datefmt.resolvedOptions().hourCycle).assertEqual('h24');
        expect(datefmt.resolvedOptions().numberingSystem).assertEqual('arab');
        expect(datefmt.resolvedOptions().hour12).assertTrue();
        expect(datefmt.resolvedOptions().era).assertEqual('short');
        expect(datefmt.resolvedOptions().month).assertEqual('long');
        expect(datefmt.resolvedOptions().day).assertEqual('numeric');
        expect(datefmt.resolvedOptions().minute).assertEqual('2-digit');
        expect(datefmt.resolvedOptions().second).assertEqual('numeric');
        expect(datefmt.resolvedOptions().dayPeriod).assertEqual('short');
        expect(datefmt.resolvedOptions().formatMatcher).assertEqual('basic');
        expect(datefmt.resolvedOptions().localeMatcher).assertEqual('lookup');
      } catch (err) {
        console.error(`dateTimeFormat_test_2500 failed, error: ${JSON.stringify(err)}`);
        expect().assertFail();
      }
    })
  })
}
