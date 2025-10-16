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
import { describe, it, expect, Level, TestType, Size } from '@ohos/hypium';
import display from '@ohos.display';

export default function display_test() {
  describe('display_test', () => {

    /**
     * @tc.number : SUB_GRAPHIC_Display_Orientation_Enum_0100
     * @tc.name   : testGraphicDisplayOrientationEnum0100
     * @tc.desc   : To test the attributes of Orientation
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testGraphicDisplayOrientationEnum0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      try {
        expect(display.Orientation.PORTRAIT).assertEqual(0);
        expect(display.Orientation.LANDSCAPE).assertEqual(1);
        expect(display.Orientation.PORTRAIT_INVERTED).assertEqual(2);
        expect(display.Orientation.LANDSCAPE_INVERTED).assertEqual(3);
      } catch (error) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Display_GetFoldDisplayMode_0200
     * @tc.name   : testGraphicDisplayGetFoldDisplayMode0200
     * @tc.desc   : To test the function of getFoldDisplayMode
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testGraphicDisplayGetFoldDisplayMode0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let tag = 'getFoldDisplayMode_Test_001 '
      console.info(tag + ' begin');
      try {
        display.getFoldDisplayMode();
      } catch (err) {
        console.log(tag + 'getFoldStatus failed, err : ' + JSON.stringify(err));
        expect().assertFail();
      }
    });
  })
}
