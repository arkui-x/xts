/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, afterAll, beforeAll, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { driver, openTestPage, sendClickEvent, startAbility, terminateTopAbility } from './utils/TestUtils';

const WAIT_PAGE_READY_MS_500 = 500;

export default function TextPickerDialogEnableHapticFeedbackTest() {
  describe('TextPickerDialogEnableHapticFeedback', () => {
    beforeAll(async () => {
      await startAbility('com.example.enablehapticfeedbacktest', 'EntryAbility');
      await openTestPage('textPickerDialogTest');
    });

    afterAll(async () => {
      await terminateTopAbility();
    })

    /**
     * @tc.number ArkUIX_TextPickerDialog_EnableHapticFeedback_0100
     * @tc.name ArkUIX_TextPickerDialog_EnableHapticFeedback_0100
     * @tc.desc Test the TextPickerDialog component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_TextPickerDialog_EnableHapticFeedback_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await sendClickEvent('TextPickerDialog_true');
          let obj: ESObject = JSON.parse(JSON.stringify(getInspectorTree()));
          await driver.delayMs(WAIT_PAGE_READY_MS_500);
          let textPicker = JSON.stringify(obj.$children[1].$children[0].$children[0].$children[0]);
          await sendClickEvent('TextPickerDialog_true');
          expect(JSON.parse(textPicker).$attrs.enableHapticFeedback).assertEqual(true);
        } catch (error) {
          console.error(`ArkUIX_TextPickerDialog_EnableHapticFeedback_0100 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_TextPickerDialog_EnableHapticFeedback_0200
     * @tc.name ArkUIX_TextPickerDialog_EnableHapticFeedback_0200
     * @tc.desc Test the TextPickerDialog component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_TextPickerDialog_EnableHapticFeedback_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await sendClickEvent('TextPickerDialog_false');
          let obj: ESObject = JSON.parse(JSON.stringify(getInspectorTree()));
          await driver.delayMs(WAIT_PAGE_READY_MS_500);
          let textPicker = JSON.stringify(obj.$children[1].$children[0].$children[0].$children[0]);
          await sendClickEvent('TextPickerDialog_false');
          expect(JSON.parse(textPicker).$attrs.enableHapticFeedback).assertEqual(false);
        } catch (error) {
          console.error(`ArkUIX_TextPickerDialog_EnableHapticFeedback_0200 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_TextPickerDialog_EnableHapticFeedback_0300
     * @tc.name ArkUIX_TextPickerDialog_EnableHapticFeedback_0300
     * @tc.desc Test the TextPickerDialog component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_TextPickerDialog_EnableHapticFeedback_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        try {
          await sendClickEvent('TextPickerDialog_null');
          let obj: ESObject = JSON.parse(JSON.stringify(getInspectorTree()));
          await driver.delayMs(WAIT_PAGE_READY_MS_500);
          let textPicker = JSON.stringify(obj.$children[1].$children[0].$children[0].$children[0]);
          await sendClickEvent('TextPickerDialog_null');
          expect(JSON.parse(textPicker).$attrs.enableHapticFeedback).assertEqual(true);
        } catch (error) {
          console.error(`ArkUIX_TextPickerDialog_EnableHapticFeedback_0300 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_TextPickerDialog_EnableHapticFeedback_0400
     * @tc.name ArkUIX_TextPickerDialog_EnableHapticFeedback_0400
     * @tc.desc Test the TextPickerDialog component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_TextPickerDialog_EnableHapticFeedback_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        try {
          await sendClickEvent('TextPickerDialog_undefined');
          let obj: ESObject = JSON.parse(JSON.stringify(getInspectorTree()));
          await driver.delayMs(WAIT_PAGE_READY_MS_500);
          let textPicker = JSON.stringify(obj.$children[1].$children[0].$children[0].$children[0]);
          await sendClickEvent('TextPickerDialog_undefined');
          expect(JSON.parse(textPicker).$attrs.enableHapticFeedback).assertEqual(true);
        } catch (error) {
          console.error(`ArkUIX_TextPickerDialog_EnableHapticFeedback_0400 failed: ${error}`, error);
          expect().assertFail();
        }
      });
    })
}
