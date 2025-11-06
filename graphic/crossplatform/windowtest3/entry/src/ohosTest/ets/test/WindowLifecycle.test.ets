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
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';
import common from '@ohos.app.ability.common';
import { BusinessError, settings } from '@kit.BasicServicesKit';
import * as LoadContentByName from './testability/pages/WindowTest/LoadContentByName';
import { StartOptions, Want } from '@kit.AbilityKit';

let sleep = (sleepMs: number) => new Promise<string>(resolve => setTimeout(resolve, sleepMs));

async function startAbility(caseName: string, context: common.UIAbilityContext, options?: StartOptions) {
  let want: Want = {
    bundleName: AppStorage.get('bundleName'),
    abilityName: 'StartTestAbility'
  };
  if (options) {
    await context.startAbility(want, options).then(() => {
      console.info(`${caseName} Succeeded in starting ability.`);
    }).catch((err: BusinessError) => {
      console.info(`${caseName} Failed in starting ability. Cause code: ${err.code}, message: ${err.message}`);
    });
  } else {
    await context.startAbility(want).then(() => {
      console.info(`${caseName} Succeeded in starting ability.`);
    }).catch((err: BusinessError) => {
      console.info(`${caseName} Failed in starting ability. Cause code: ${err.code}, message: ${err.message}`);
    });
  }
  await sleep(1000);
  let windowStageStart = AppStorage.get('windowStageStartTest') as window.WindowStage;
  return windowStageStart;
}

async function terminateAbility(caseName: string) {
  let pageContext = AppStorage.get('contextTest') as common.UIAbilityContext;
  await pageContext.terminateSelf().then(() => {
    console.log(`${caseName} terminateSelf success`);
  }).catch((err: BusinessError) => {
    console.error(`${caseName} terminateSelf fail, err: ${JSON.stringify(err)}`);
  });
  await sleep(1000);
}

export default function WindowLifecycle() {
  describe('WindowLifecycleTest', async () => {
    let windowStage: window.WindowStage;
    beforeAll(() => {
      windowStage = AppStorage.get('windowStage') as window.WindowStage;
    });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_OffWindowStageEvent_RepeatOff_0100
     * @tc.name   : testGraphicWindowStageOffWindowStageEventRepeatOff0100
     * @tc.desc   : Turn off listening for Windows Stage lifecycle changes
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it('testGraphicWindowStageOffWindowStageEventRepeatOff0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async () => {
        let caseName = 'testGraphicWindowStageOffWindowStageEventRepeatOff0100';
        let msgStr = 'jsunittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        try {
          windowStage.on('windowStageEvent', (data) => {
            console.info(msgStr + 'Succeeded in enabling the listener for window stage event changes. Data: ' +
            JSON.stringify(data));
            expect(true).assertTrue();
          });
        } catch (exception) {
          console.error(msgStr + 'Failed to enable the listener for window stage event changes. Cause:' +
          JSON.stringify(exception));
          expect().assertFail();
        }
        try {
          windowStage.off('windowStageEvent');
          console.log(msgStr + 'windowStageEvent success first');
          expect(true).assertTrue();
        } catch (exception) {
          console.error(msgStr + 'Failed to disable the listener for window stage event changes. Cause:' +
          JSON.stringify(exception));
          expect().assertFail();
        }
        try {
          windowStage.off('windowStageEvent');
          console.log(msgStr + 'windowStageEvent success second');
          expect(true).assertTrue();
        } catch (exception) {
          console.error(msgStr + 'Failed to disable the listener for window stage event changes. Cause:' +
          JSON.stringify(exception));
          expect().assertFail();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_OnWindowSizeChange_SubWindow_0200
     * @tc.name   : testGraphicWindowStageOnWindowSizeChangeSubWindow0200
     * @tc.desc   : testOn_WindowSize_Change_subWindow
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 4
     */
    it('testGraphicWindowStageOnWindowSizeChangeSubWindow0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        let caseName: string = 'testGraphicWindowStageOnWindowSizeChangeSubWindow0200';
        let msgStr: string = 'jsUnittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        let subWindowClass: window.Window;
        let storage: LocalStorage = new LocalStorage();
        try {
          await windowStage.createSubWindow('testOn_WindowSize_Change_subWindow').then(async (data) => {
            subWindowClass = data;
            console.info(msgStr + 'Succeeded in creating the subwindow. Data: ' + JSON.stringify(data));
            expect(!!subWindowClass).assertTrue();
            await subWindowClass.loadContent('testability/pages/First/index2', storage);
            let promise = subWindowClass.showWindow();
            promise.then(async () => {
              console.info(msgStr + 'Succeeded in showing the window.');
              await sleep(1000);
              subWindowClass.on('windowSizeChange', (data) => {
                console.info(msgStr + 'Succeeded in enabling the listener for window size changes. Data: ' +
                JSON.stringify(data));
                expect(data.width).assertEqual(800);
                expect(data.height).assertEqual(1000);
                subWindowClass.destroyWindow();
                done();
              });
              await subWindowClass.resize(800, 1000);
              console.info(msgStr + 'Succeeded in resize the subWindowClass');
            }).catch((err: BusinessError) => {
              console.error(msgStr + `Failed to show the window. Cause code: ${err.code}, message: ${err.message}`);
              subWindowClass.destroyWindow();
              expect().assertFail();
              done();
            });
          }).catch((err: BusinessError) => {
            console.log(msgStr + 'windowStage.createSubWindow failed error: ' + JSON.stringify(err));
            subWindowClass.destroyWindow();
            expect().assertFail();
            done();
          });
        } catch (exception) {
          console.error('Failed to check whether the window is showing. Cause: ' + JSON.stringify(exception));
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_OnWindowSizeChange_TwoCallback_0300
     * @tc.name   : testGraphicWindowStageOnWindowSizeChangeTwoCallback0300
     * @tc.desc   : testOn_WindowSize_Change_Two_callback
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 4
     */
    it('testGraphicWindowStageOnWindowSizeChangeTwoCallback0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        let caseName: string = 'testGraphicWindowStageOnWindowSizeChangeTwoCallback0300';
        let msgStr: string = 'jsUnittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        let subWindowClass: window.Window;
        let storage: LocalStorage = new LocalStorage();
        let num = 0;
        let callback1 = (size: window.Size) => {
          console.info(msgStr + 'callback1 is called ' + JSON.stringify(size));
          num++;
        };
        let callback2 = (size: window.Size) => {
          console.info(msgStr + 'callback2 is called ' + JSON.stringify(size));
          num++;
        };
        try {
          await windowStage.createSubWindow('testOn_WindowSize_Change_Two_callback').then(async (data) => {
            subWindowClass = data;
            console.info(msgStr + 'Succeeded in creating the subwindow. Data: ' + JSON.stringify(data));
            expect(!!subWindowClass).assertTrue();
            await subWindowClass.loadContent('testability/pages/First/index2', storage);
            await subWindowClass.showWindow();
            await sleep(1000);
            subWindowClass.on('windowSizeChange', callback1);
            subWindowClass.on('windowSizeChange', callback2);
            await subWindowClass.resize(800, 900);
            console.info(msgStr + 'Succeeded in resize the subWindowClass');
            await sleep(1000);
            console.info(msgStr + 'num: ' + num);
            expect(num).assertEqual(2);
            await subWindowClass.destroyWindow();
            done();
          }).catch((err: BusinessError) => {
            console.log(msgStr + 'windowStage.createSubWindow failed error: ' + JSON.stringify(err));
            subWindowClass.destroyWindow();
            expect().assertFail();
            done();
          });
        } catch (exception) {
          console.error('Failed to check whether the window is showing. Cause: ' + JSON.stringify(exception));
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_OnWindowSizeChange_OffCallback1_0400
     * @tc.name   : testGraphicWindowStageOnWindowSizeChangeOffCallback10400
     * @tc.desc   : testOn_WindowSize_Change_off_callback1
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 4
     */
    it('testGraphicWindowStageOnWindowSizeChangeOffCallback10400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        let caseName: string = 'testGraphicWindowStageOnWindowSizeChangeOffCallback10400';
        let msgStr: string = 'jsUnittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        let subWindowClass: window.Window;
        let storage: LocalStorage = new LocalStorage();
        let num = 0;
        let callback1 = (size: window.Size) => {
          console.info(msgStr + 'callback1 is called ' + JSON.stringify(size));
          num++;
        };
        let callback2 = (size: window.Size) => {
          console.info(msgStr + 'callback2 is called ' + JSON.stringify(size));
          num--;
        };
        try {
          await windowStage.createSubWindow('testOn_WindowSize_Change_off_callback1').then(async (data) => {
            subWindowClass = data;
            console.info(msgStr + 'Succeeded in creating the subwindow. Data: ' + JSON.stringify(data));
            expect(!!subWindowClass).assertTrue();
            await subWindowClass.loadContent('testability/pages/First/index2', storage);
            await subWindowClass.showWindow();
            await sleep(1000);
            subWindowClass.on('windowSizeChange', callback1);
            subWindowClass.on('windowSizeChange', callback2);
            subWindowClass.off('windowSizeChange', callback1);
            await subWindowClass.resize(800, 1200);
            console.info(msgStr + 'Succeeded in resize the subWindowClass');
            await sleep(1000);
            console.info(msgStr + 'num: ' + num);
            expect(num).assertEqual(-1);
            await subWindowClass.destroyWindow();
            done();
          }).catch((err: BusinessError) => {
            console.log(msgStr + 'windowStage.createSubWindow failed error: ' + JSON.stringify(err));
            expect().assertFail();
            subWindowClass.destroyWindow();
            done();
          });
        } catch (exception) {
          console.error('Failed to check whether the window is showing. Cause: ' + JSON.stringify(exception));
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_OnWindowSizeChange_OffCallbackAll_0500
     * @tc.name   : testGraphicWindowStageOnWindowSizeChangeOffCallbackAll0500
     * @tc.desc   : testOn_WindowSize_Change_off_callback_all
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 4
     */
    it('testGraphicWindowStageOnWindowSizeChangeOffCallbackAll0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4,
      async (done: Function) => {
        let caseName: string = 'testGraphicWindowStageOnWindowSizeChangeOffCallbackAll0500';
        let msgStr: string = 'jsUnittest ' + caseName + ' ';
        console.log(msgStr + 'begin');
        let subWindowClass: window.Window;
        let storage: LocalStorage = new LocalStorage();
        let num = 0;
        let callback1 = (size: window.Size) => {
          console.info(msgStr + 'callback1 is called ' + JSON.stringify(size));
          num++;
        };
        let callback2 = (size: window.Size) => {
          console.info(msgStr + 'callback2 is called ' + JSON.stringify(size));
          num++;
        };
        try {
          await windowStage.createSubWindow('testOn_WindowSize_Change_off_callback_all').then(async (data) => {
            subWindowClass = data;
            console.info(msgStr + 'Succeeded in creating the subwindow. Data: ' + JSON.stringify(data));
            expect(!!subWindowClass).assertTrue();
            await subWindowClass.loadContent('testability/pages/First/index2', storage);
            await subWindowClass.showWindow();
            await sleep(1000);
            subWindowClass.on('windowSizeChange', callback1);
            subWindowClass.on('windowSizeChange', callback2);
            subWindowClass.off('windowSizeChange');
            await subWindowClass.resize(800, 1300);
            console.info(msgStr + 'Succeeded in resize the subWindowClass');
            await sleep(1000);
            console.info(msgStr + 'num: ' + num);
            expect(num).assertEqual(0);
            await subWindowClass.destroyWindow();
            done();
          }).catch((err: BusinessError) => {
            console.log(msgStr + 'windowStage.createSubWindow failed error: ' + JSON.stringify(err));
            expect().assertFail();
            subWindowClass.destroyWindow();
            done();
          });
        } catch (exception) {
          console.error('Failed to check whether the window is showing. Cause: ' + JSON.stringify(exception));
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number : SUB_GRAPHIC_WindowStage_LoadContentByName_0600
     * @tc.name   : testGraphicWindowStageLoadContentByName0600
     * @tc.desc   : test_loadContentByName
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("testGraphicWindowStageLoadContentByName0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        let msgStr = "testGraphicWindowStageLoadContentByName0600";
        console.log(msgStr + "begin");
        try {
          windowStage.loadContentByName(LoadContentByName.entryName).then(async () => {
            console.info('Succeeded in loadContentByName.');
            expect(true).assertTrue();
            await windowStage.loadContent('testability/pages/Index');
            done();
          }).catch(async (err: BusinessError) => {
            console.error(`Failed to test loadContentByName. Cause code: ${err.code}, message: ${err.message}`);
            expect().assertFail();
            await windowStage.loadContent('testability/pages/Index');
            done();
          });
        } catch (error) {
          console.log(msgStr + 'Failed to test_loadContentByName. Cause: ' + JSON.stringify(error));
          expect().assertFail();
          await windowStage.loadContent('testability/pages/Index');
          done();
        }
      });
  })
}