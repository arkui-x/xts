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

import { describe, afterAll, beforeAll, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { ON } from '@ohos.UiTest';
import { clickButton, driver, openTestPage, startAbility, terminateTopAbility } from './utils/TestUtils';

export default function richEditorEnableHapticFeedbackTest() {
  describe('richEditorEnableHapticFeedbackTest', () => {
    beforeAll(async () => {
      await startAbility('com.example.enablehapticfeedbacktest', 'EntryAbility');
      await openTestPage('richEditorTest');
    });

    afterAll(async () => {
      await terminateTopAbility();
    })

    /**
     * @tc.number ArkUIX_RichEditor_EnableHapticFeedback_0100
     * @tc.name ArkUIX_RichEditor_EnableHapticFeedback_0100
     * @tc.desc Test the RichEditor component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_RichEditor_EnableHapticFeedback_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await clickButton('enableHapticFeedback_true');
          let component = getInspectorByKey('richEditor');
          expect(JSON.parse(component).$attrs.enableHapticFeedback).assertEqual('true');
        } catch (error) {
          console.error(`ArkUIX_RichEditor_EnableHapticFeedback_0100 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_RichEditor_EnableHapticFeedback_0200
     * @tc.name ArkUIX_RichEditor_EnableHapticFeedback_0200
     * @tc.desc Test the RichEditor component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_RichEditor_EnableHapticFeedback_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await clickButton('enableHapticFeedback_false');
          let component = getInspectorByKey('richEditor');
          expect(JSON.parse(component).$attrs.enableHapticFeedback).assertEqual('false');
        } catch (error) {
          console.error(`ArkUIX_RichEditor_EnableHapticFeedback_0200 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_RichEditor_EnableHapticFeedback_0300
     * @tc.name ArkUIX_RichEditor_EnableHapticFeedback_0300
     * @tc.desc Test the RichEditor component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_RichEditor_EnableHapticFeedback_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        try {
          await clickButton('enableHapticFeedback_null');
          let component = getInspectorByKey('richEditor');
          expect(JSON.parse(component).$attrs.enableHapticFeedback).assertEqual('true');
        } catch (error) {
          console.error(`ArkUIX_RichEditor_EnableHapticFeedback_0300 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_RichEditor_EnableHapticFeedback_0400
     * @tc.name ArkUIX_RichEditor_EnableHapticFeedback_0400
     * @tc.desc Test the RichEditor component's enableHapticFeedback property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_RichEditor_EnableHapticFeedback_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async () => {
        try {
          await clickButton('enableHapticFeedback_undefined');
          let component = getInspectorByKey('richEditor');
          expect(JSON.parse(component).$attrs.enableHapticFeedback).assertEqual('true');
        } catch (error) {
          console.error(`ArkUIX_RichEditor_EnableHapticFeedback_0400 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_RichEditor_HapticFeedbackMode_0100
     * @tc.name ArkUIX_RichEditor_HapticFeedbackMode_0100
     * @tc.desc Test the RichEditor component's hapticFeedbackMode property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_RichEditor_HapticFeedbackMode_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await clickButton('hapticFeedbackMode_ENABLED');
          let result = await driver.findComponent(ON.id('hapticMode'));
          expect(await result.getText()).assertEqual('1');
        } catch (error) {
          console.error(`ArkUIX_RichEditor_HapticFeedbackMode_0100 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_RichEditor_HapticFeedbackMode_0200
     * @tc.name ArkUIX_RichEditor_HapticFeedbackMode_0200
     * @tc.desc Test the RichEditor component's hapticFeedbackMode property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_RichEditor_HapticFeedbackMode_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await clickButton('hapticFeedbackMode_DISABLED');
          let result = await driver.findComponent(ON.id('hapticMode'));
          expect(await result.getText()).assertEqual('0');
        } catch (error) {
          console.error(`ArkUIX_RichEditor_HapticFeedbackMode_0200 failed: ${error}`, error);
          expect().assertFail();
        }
      });

    /**
     * @tc.number ArkUIX_RichEditor_HapticFeedbackMode_0300
     * @tc.name ArkUIX_RichEditor_HapticFeedbackMode_0300
     * @tc.desc Test the RichEditor component's hapticFeedbackMode property.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_RichEditor_HapticFeedbackMode_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        try {
          await clickButton('hapticFeedbackMode_AUTO');
          let result = await driver.findComponent(ON.id('hapticMode'));
          expect(await result.getText()).assertEqual('2');
        } catch (error) {
          console.error(`ArkUIX_RichEditor_HapticFeedbackMode_0300 failed: ${error}`, error);
          expect().assertFail();
        }
      });
  })
}