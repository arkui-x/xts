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
import window from '@ohos.window';

export default function window_test() {
  describe('window_test', () => {

    /**
     * @tc.number : SUB_GRAPHIC_Window_WindowStageEventType_Enum_Value_0100
     * @tc.name   : testGraphicWindowWindowStageEventTypeEnumValue0100
     * @tc.desc   : To test the enum value of WindowStageEventType.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testGraphicWindowWindowStageEventTypeEnumValue0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async () => {
        let msgStr = 'testGraphicWindowWindowStageEventTypeEnumValue0100';
        console.log(msgStr + ' begin' + JSON.stringify(window.WindowStageEventType));
        try {
          // {"SHOWN":1,"ACTIVE":2,"INACTIVE":3,"HIDDEN":4}
          expect(1).assertEqual(window.WindowStageEventType.SHOWN);
          expect(2).assertEqual(window.WindowStageEventType.ACTIVE);
          expect(3).assertEqual(window.WindowStageEventType.INACTIVE);
          expect(4).assertEqual(window.WindowStageEventType.HIDDEN);
          // expect(5).assertEqual(window.WindowStageEventType.RESUMED);
          // expect(6).assertEqual(window.WindowStageEventType.PAUSED);
        } catch (err) {
          console.log(msgStr + ' error ' + JSON.stringify(err));
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_Window_Orientation_Enum_Value_0200
     * @tc.name   : testGraphicWindowOrientationEnumValue0200
     * @tc.desc   : To test the enum value of Orientation.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testGraphicWindowOrientationEnumValue0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      let msgStr = 'testGraphicWindowOrientationEnumValue0200';
      console.log(msgStr + ' begin');
      try {
        expect(0).assertEqual(window.Orientation.UNSPECIFIED);
        expect(3).assertEqual(window.Orientation.PORTRAIT_INVERTED);
        expect(4).assertEqual(window.Orientation.LANDSCAPE_INVERTED);
      } catch (err) {
        console.info(msgStr + 'test enum value of windowStageEventType error ' + JSON.stringify(err));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Window_WindowEventType_Enum_0300
     * @tc.name   : testGraphicWindowEventTypeEnum0300
     * @tc.desc   : Test the enumeration value of WindowEventType
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowEventTypeEnum0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      let msgStr = 'testGraphicWindowEventTypeEnum0300';
      console.log(msgStr + ' begin');
      try {
        expect(1).assertEqual(window.WindowEventType.WINDOW_SHOWN);
        expect(2).assertEqual(window.WindowEventType.WINDOW_ACTIVE);
        expect(3).assertEqual(window.WindowEventType.WINDOW_INACTIVE);
        expect(4).assertEqual(window.WindowEventType.WINDOW_HIDDEN);
      } catch (err) {
        console.info(msgStr + 'test enum value of windowStageEventType error ' + JSON.stringify(err));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Window_AvoidAreaType_Enum_Value_0400
     * @tc.name   : testGraphicWindowAvoidAreaTypeEnumValue0400
     * @tc.desc   : To test the enum value of avoidareatype.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('testGraphicWindowAvoidAreaTypeEnumValue0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      let msgStr = 'testGraphicWindowAvoidAreaTypeEnumValue0400';
      console.log(msgStr + ' begin');
      try {
        expect(0).assertEqual(window.AvoidAreaType.TYPE_SYSTEM);
        expect(1).assertEqual(window.AvoidAreaType.TYPE_CUTOUT);
        expect(2).assertEqual(window.AvoidAreaType.TYPE_SYSTEM_GESTURE);
        expect(3).assertEqual(window.AvoidAreaType.TYPE_KEYBOARD);
        expect(4).assertEqual(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      } catch (err) {
        console.info(msgStr + 'test enum value of AvoidArea error :' + JSON.stringify(err));
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_GRAPHIC_Window_WindowStatusType_Enum_0500
     * @tc.name   : testGraphicWindowStatusTypeEnum0500
     * @tc.desc   : test the enum value of WindowStatusType
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 4
     */
    it('testGraphicWindowStatusTypeEnum0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msgStr = 'testGraphicWindowStatusTypeEnum0500';
      console.log(msgStr + ' begin');
      try {
        expect(window.WindowStatusType.UNDEFINED).assertEqual(0);
        expect(window.WindowStatusType.FULL_SCREEN).assertEqual(1);
        expect(window.WindowStatusType.MINIMIZE).assertEqual(3);
        expect(window.WindowStatusType.FLOATING).assertEqual(4);
        expect(window.WindowStatusType.SPLIT_SCREEN).assertEqual(5);
      } catch (err) {
        if (err.code) {
          console.log(msgStr + "failed to test enum value" + JSON.stringify(err));
          expect().assertFail();
        } else {
          expect(true).assertTrue();
          console.log(msgStr + "failed to test enum value" + JSON.stringify(err));
        }
      }
    });
  })
}
