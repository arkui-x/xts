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
import { describe, beforeAll, it, expect, TestType, Size, Level } from "@ohos/hypium";
import ohosWindow from '@ohos.window';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import settings from '@ohos.settings';
import window from "@ohos.window";

// export default function windowRichSceneTest(context: common.UIAbilityContext, windowStage: ohosWindow.WindowStage) {
export default function windowRichSceneTest() {
  describe('window_richScene_test', () => {
    let windowStage: window.WindowStage;
    // console.log('describe window_richScene_test start!!!')
    // let isPCStatus: string = '';
    beforeAll(() => {
      windowStage = AppStorage.get('windowStage') as window.WindowStage;
    })

    /**
     * @tc.number : SUB_GRAPHIC_Window_GetWindowAvoidArea_Invoke_Interface_Two_Times_0100
     * @tc.name   : testGraphicWindowGetWindowAvoidAreaInvokeInterfaceTwoTimes0100
     * @tc.desc   : Verify The optional parameter is error
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 4
     */
    it('testGraphicWindowGetWindowAvoidAreaInvokeInterfaceTwoTimes0100',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
        let caseName: string = 'testGetWindowAvoidArea_Invoke_Interface_Two_Times';
        let msgStr: string = 'jsUnittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        let windowClass: ohosWindow.Window | void;
        windowClass = await windowStage.createSubWindow('testGetWindowAvoidArea_Invoke_Interface_Two_Times')
          .catch((err: BusinessError) => {
            console.log(msgStr + 'windowStage.createSubWindow failed error: ' + JSON.stringify(err));
            expect().assertFail();
          });
        console.log(msgStr + 'windowStage.createSubWindow success');
        expect(!!windowClass).assertTrue();
        let type = ohosWindow.AvoidAreaType.TYPE_SYSTEM;
        try {
          let avoidArea: ohosWindow.AvoidArea = (windowClass as ohosWindow.Window).getWindowAvoidArea(type);
          expect(!!avoidArea).assertTrue();
        } catch (exception) {
          console.error(msgStr + 'Failed to obtain the area. Cause:' + JSON.stringify(exception));
          expect().assertFail();
        }
        let type2 = ohosWindow.AvoidAreaType.TYPE_CUTOUT;
        try {
          let avoidArea = (windowClass as ohosWindow.Window).getWindowAvoidArea(type2);
          expect(!!avoidArea).assertTrue();
          await (windowClass as ohosWindow.Window).destroyWindow();
        } catch (exception) {
          console.error(msgStr + 'Failed to obtain the area. Cause:' + JSON.stringify(exception));
          expect().assertFail();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_Window_GetWindowAvoidArea_Invalid_Parameter_0200
     * @tc.name   : testGraphicWindowGetWindowAvoidAreaInvalidParameter0200
     * @tc.desc   : Verify The optional parameter is error
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 4
     */
    it('testGraphicWindowGetWindowAvoidAreaInvalidParameter0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async () => {
        let caseName: string = 'testGetWindowAvoidArea_Invalid_Parameter';
        let msgStr: string = 'jsUnittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        let windowClass: ohosWindow.Window | void;
        windowClass =
          await windowStage.createSubWindow('testGetWindowAvoidArea_Invalid_Parameter').catch((err: BusinessError) => {
            console.log(msgStr + 'windowStage.createSubWindow failed error: ' + JSON.stringify(err));
            expect().assertFail();
          });
        console.log(msgStr + 'windowStage.createSubWindow success');
        expect(!!windowClass).assertTrue();
        try {
          let avoidArea: ohosWindow.AvoidArea = (windowClass as ohosWindow.Window).getWindowAvoidArea(888);
        } catch (exception) {
          console.error(msgStr + 'Failed to obtain the area. Cause:' + JSON.stringify(exception));
          expect(exception.code).assertEqual(401);
          await (windowClass as ohosWindow.Window).destroyWindow();
        }
      });
  })
}
