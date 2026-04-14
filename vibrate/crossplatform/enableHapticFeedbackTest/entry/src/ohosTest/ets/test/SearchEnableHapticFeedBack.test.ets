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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { clickButton, openTestPage, startAbility, terminateTopAbility } from './utils/TestUtils';

export default function searchEnableHapticFeedBack() {
  describe('searchEnableHapticFeedBack', () => {
    beforeAll(async () => {
      await startAbility('com.example.enablehapticfeedbacktest', 'EntryAbility');
      await openTestPage('searchTest');
    });

    afterAll(async () => {
      await terminateTopAbility();
    })

    /**
     * @tc.number ArkUIX_Search_EnableHapticFeedback_0100
     * @tc.name ArkUIX_Search_EnableHapticFeedback_0100
     * @tc.desc Test the Search component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Search_EnableHapticFeedback_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await clickButton('enableHapticFeedback_true');
          let slider = getInspectorByKey('search');
          expect(JSON.parse(slider).$attrs.enableHapticFeedback).assertEqual('true');
        } catch (error) {
          console.error(`ArkUIX_Search_EnableHapticFeedback_0100 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_Search_EnableHapticFeedback_0200
     * @tc.name ArkUIX_Search_EnableHapticFeedback_0200
     * @tc.desc Test the Search component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Search_EnableHapticFeedback_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await clickButton('enableHapticFeedback_false');
          let slider = getInspectorByKey('search');
          expect(JSON.parse(slider).$attrs.enableHapticFeedback).assertEqual('false');
        } catch (error) {
          console.error(`ArkUIX_Search_EnableHapticFeedback_0200 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_Search_EnableHapticFeedback_0300
     * @tc.name ArkUIX_Search_EnableHapticFeedback_0300
     * @tc.desc Test the Search component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Search_EnableHapticFeedback_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        try {
          await clickButton('enableHapticFeedback_null');
          let slider = getInspectorByKey('search');
          expect(JSON.parse(slider).$attrs.enableHapticFeedback).assertEqual('true');
        } catch (error) {
          console.error(`ArkUIX_Search_EnableHapticFeedback_0300 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_Search_EnableHapticFeedback_0400
     * @tc.name ArkUIX_Search_EnableHapticFeedback_0400
     * @tc.desc Test the Search component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Search_EnableHapticFeedback_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        try {
          await clickButton('enableHapticFeedback_undefined');
          let slider = getInspectorByKey('search');
          expect(JSON.parse(slider).$attrs.enableHapticFeedback).assertEqual('true');
        } catch (error) {
          console.error(`ArkUIX_Search_EnableHapticFeedback_0400 failed: ${error}`, error);
          expect().assertFail();
        }
      });
  })
}
