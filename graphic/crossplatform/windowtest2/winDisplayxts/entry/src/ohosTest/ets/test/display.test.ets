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

import { describe, it, expect, Level, TestType, Size, beforeEach, afterAll } from '@ohos/hypium';
import { display } from '@kit.ArkUI';

const waitReadyMs_600 = 600;
const waitReadyMs_3000 = 3000;

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function displayTest() {
  describe('displayTest', () => {
    afterAll(async () => {
      await sleep(waitReadyMs_3000);
    })

    /**
     * @tc.number ArkUIX_Display_IsFoldable_0100
     * @tc.name ArkUIX_Display_IsFoldable_0100
     * @tc.desc Test the function isFoldable
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Display_IsFoldable_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let rec: boolean = true;
      try {
        rec = display.isFoldable();
        if (rec) {
          expect(rec).assertTrue();
        } else {
          expect(rec).assertFalse();
        }
      } catch (err) {
        console.log('ArkUIX_Display_IsFoldable_0100 failed, Error: ' + JSON.stringify(err));
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_Display_GetFoldStatus_0100
     * @tc.name ArkUIX_Display_GetFoldStatus_0100
     * @tc.desc Test the function getFoldStatus
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Display_GetFoldStatus_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let isPass: boolean = true;
      try {
        if(display.isFoldable()) {
          let rec: display.FoldStatus = display.getFoldStatus();
          if (rec === display.FoldStatus.FOLD_STATUS_EXPANDED || rec === display.FoldStatus.FOLD_STATUS_UNKNOWN ||
            rec === display.FoldStatus.FOLD_STATUS_HALF_FOLDED) {
            isPass = true;
          }
          expect(isPass).assertTrue();
        }
      } catch (err) {
        console.log('ArkUIX_Display_GetFoldStatus_0100 failed, Error: ' + JSON.stringify(err));
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_Display_Change_On_Off_0100
     * @tc.name ArkUIX_Display_Change_On_Off_0100
     * @tc.desc Test the function Change_On_Off
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Display_Change_On_Off_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let callback: Callback<number> = (data: number) => {
        console.info('Listening enabled. Data: ' + JSON.stringify(data));
      };
      try {
        if(display.isFoldable()) {
          display.on("change", callback);
          await sleep(waitReadyMs_600);
          display.off("change");
        }
      } catch (err) {
        console.error('ArkUIX_Display_Change_On_Off_0100 failed, Error: ' + JSON.stringify(err));
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_Display_FoldStatusChange_On_Off_0100
     * @tc.name ArkUIX_Display_FoldStatusChange_On_Off_0100
     * @tc.desc Test the function FoldStatusChange_On_Off
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_Display_FoldStatusChange_On_Off_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let callback: Callback<display.FoldStatus> = (data: display.FoldStatus) => {
        console.info('Listening enabled. Data: ' + JSON.stringify(data));
      };
      try {
        if(display.isFoldable()) {
          display.on('foldStatusChange', callback);
          await sleep(waitReadyMs_600);
          display.off("foldStatusChange");
        }
      } catch (err) {
        console.error('ArkUIX_Display_FoldStatusChange_On_Off_0100 failed, Error: ' + JSON.stringify(err));
        expect().assertFail();
      }
      done();
    });
  })
}