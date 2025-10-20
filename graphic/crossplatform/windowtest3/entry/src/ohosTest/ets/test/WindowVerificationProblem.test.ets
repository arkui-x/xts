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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from "@ohos/hypium";
import ohosWindow from '@ohos.window';
import display from '@ohos.display';
import screenshot from '@ohos.screenshot';
import { UiDriver, BY, ON, PointerMatrix } from '@ohos.UiTest';
import { BusinessError } from '@ohos.base';

async function sleep(time: number) {
  let timeoutId: number = 0;
  let promise = new Promise<string>(resolve => {
    timeoutId = setTimeout(() => {
      resolve('sleep finished');
    }, time);
  })
  await promise;
  clearTimeout(timeoutId);
}

export default function windowVerificationProblemTest() {
  describe('window_verification_problem_test', async () => {
    console.log('describe window_verification_problem_test start!!!');

    /**
     * @tc.number : SUB_GRAPHIC_Display_OffAdd_RepeatOff_0100
     * @tc.name   : testGraphicDisplayOffAddRepeatOff0100
     * @tc.desc   : Turn off the monitor that shows device changes
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicDisplayOffAddRepeatOff0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let caseName = 'testGraphicDisplayOffAddRepeatOff0100';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      let callback: Callback<number> = (data: number) => {
        console.info(msgStr + 'Listening enabled. Data: ' + JSON.stringify(data));
      };
      try {
        display.on("add", callback);
      } catch (exception) {
        console.error(msgStr + 'Failed to register callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
      try {
        display.off("add");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
      try {
        display.off("add");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Display_OffRemove_RepeatOff_0200
     * @tc.name   : testGraphicDisplayOffRemoveRepeatOff0200
     * @tc.desc   : Turn off the monitor that shows device changes
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicDisplayOffRemoveRepeatOff0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let caseName = 'testGraphicDisplayOffRemoveRepeatOff0200';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      let callback: Callback<number> = (data: number) => {
        console.info(msgStr + 'Listening enabled. Data: ' + JSON.stringify(data));
      };
      try {
        display.on("remove", callback);
      } catch (exception) {
        console.error(msgStr + 'Failed to register callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
      try {
        display.off("remove");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
      try {
        display.off("remove");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Display_OffRemove_0300
     * @tc.name   : testGraphicDisplayOffRemove0300
     * @tc.desc   : Turn off the monitor that shows device changes
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicDisplayOffRemove0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let caseName = 'testGraphicDisplayOffRemove0300';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      try {
        display.off("remove");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Display_OffFoldDisplayModeChange_RepeatOff_0400
     * @tc.name   : testGraphicDisplayOffFoldDisplayModeChangeRepeatOff0400
     * @tc.desc   : Turn off monitoring for screen display mode changes on folding devices
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicDisplayOffFoldDisplayModeChangeRepeatOff0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        let caseName = 'testGraphicDisplayOffFoldDisplayModeChangeRepeatOff0400';
        let msgStr = 'jsunittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        let callback: Callback<display.FoldDisplayMode> = (data: display.FoldDisplayMode) => {
          console.info(msgStr + 'Listening enabled. Data: ' + JSON.stringify(data));
        };
        try {
          display.on('foldDisplayModeChange', callback);
        } catch (exception) {
          console.error(msgStr + 'Failed to register callback. Code: ' + JSON.stringify(exception));
          expect().assertFail();
        }
      });
  })
}
