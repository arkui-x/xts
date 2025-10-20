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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import display from '@ohos.display';
import window from '@ohos.window';

export default function displayTest() {
  console.log('describe displayTest start!!!')

  describe('displayTest', () => {

    /**
     * @tc.number : SUB_GRAPHIC_Display_FoldAngleChange_On_Off_0100
     * @tc.name   : testGraphicDisplayFoldAngleChangeOnOff0100
     * @tc.desc   : register and unregister fold angle changes
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicDisplayFoldAngleChangeOnOff0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let caseName = 'testFoldAngleChange_On_Off';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      try {
        display.off("foldAngleChange");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Display_FoldAngleChange_ON_Off_Off_0200
     * @tc.name   : testGraphicDisplayFoldAngleChangeOnOffOff0200
     * @tc.desc   : repeat unregister fold angle changes
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicDisplayFoldAngleChangeOnOffOff0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let caseName = 'testFoldAngleChange_ON_Off_Off';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      let callback = (angles: Array<number>) => {
        console.info(msgStr + 'Listening enabled. angles length: ' + angles.length);
        let angleLen = angles.length;
        for (let i = 0; i < angleLen; i++) {
          console.info(msgStr + 'Listening enabled. angles[' + i + ']=' + angles[i]);
        }
      };
      try {
        display.off("foldAngleChange");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
      try {
        display.off("foldAngleChange");
      } catch (exception) {
        console.error(msgStr + 'Failed to unregister callback. Code: ' + JSON.stringify(exception));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Display_FoldAngleChange_Off_0300
     * @tc.name   : testGraphicDisplayFoldAngleChangeOff0300
     * @tc.desc   : unregister of the fold angle changes without register
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testGraphicDisplayFoldAngleChangeOff0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      try {
        display.off("foldAngleChange");
      } catch (exception) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Display_GetAvailableDPI_0400
     * @tc.name   : testGraphicDisplayGetAvailableDPI0400
     * @tc.desc   : get display available width and height
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testGraphicDisplayGetAvailableDPI0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let displayInfo = display.getDefaultDisplaySync();
        expect(displayInfo.xDPI != null).assertTrue();
        expect(displayInfo.yDPI != null).assertTrue();
      } catch (error) {
        expect().assertFail();
      }
    });
  })
}