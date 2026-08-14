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

import window from '@ohos.window';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { Driver } from '@ohos.UiTest';
import display from '@ohos.display';
import { getClickCount, resetClickCount } from '../testability/ClickCounter';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function DialogAndLifecycleTest() {
  describe('DialogAndLifecycleTest', () => {
    let windowStage: window.WindowStage | undefined = undefined;

    beforeAll(async () => {
      console.info('DialogAndLifecycleTest beforeAll begin');
      try {
        windowStage = globalThis.windowStage;
      } catch (e) {
        console.error('get windowStage error: ' + JSON.stringify(e));
        windowStage = undefined;
      }
    });

    beforeEach(async () => {
      console.info('DialogAndLifecycleTest beforeEach begin');
    });

    afterEach(async () => {
      await sleep(1000);
      console.info('DialogAndLifecycleTest afterEach end');
    });

    afterAll(async () => {
      console.info('DialogAndLifecycleTest afterAll end');
    });

    /**
     * @tc.number  : TEST_WINDOW_STAGE_EVENT_TYPE_RESUMED_PAUSED_001
     * @tc.name    : testWindowStageEventTypeResumedPaused001
     * @tc.desc    : Verify WindowStageEventType.RESUMED and PAUSED enum values are defined
     * @tc.size    : MediumTest
     * @tc.type    : Function
     * @tc.level   : Level 0
     */
    it('testWindowStageEventTypeResumedPaused001', 0, async (done: Function) => {
      console.info('DialogAndLifecycleTest testWindowStageEventTypeResumedPaused001 begin');
      try {
        let stageEventType = window.WindowStageEventType;
        expect(stageEventType !== undefined).assertTrue();
        expect(stageEventType !== null).assertTrue();
        console.info('WindowStageEventType: ' + JSON.stringify(stageEventType));
        expect(typeof stageEventType.RESUMED).assertEqual('number');
        expect(typeof stageEventType.PAUSED).assertEqual('number');
        expect(stageEventType.RESUMED).assertEqual(5);
        expect(stageEventType.PAUSED).assertEqual(6);
        console.info('WindowStageEventType.RESUMED=' + stageEventType.RESUMED +
          ', PAUSED=' + stageEventType.PAUSED);
        done();
      } catch (err) {
        console.error('testWindowStageEventTypeResumedPaused001 error: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number  : TEST_WINDOW_TYPE_DIALOG_001
     * @tc.name    : testWindowTypeDialog001
     * @tc.desc    : Verify WindowType.TYPE_DIALOG enum value is defined
     * @tc.size    : MediumTest
     * @tc.type    : Function
     * @tc.level   : Level 0
     */
    it('testWindowTypeDialog001', 0, async (done: Function) => {
      console.info('DialogAndLifecycleTest testWindowTypeDialog001 begin');
      try {
        let windowType = window.WindowType;
        expect(windowType !== undefined).assertTrue();
        expect(windowType !== null).assertTrue();
        console.info('WindowType: ' + JSON.stringify(windowType));
        expect(typeof windowType.TYPE_DIALOG).assertEqual('number');
        expect(windowType.TYPE_DIALOG).assertEqual(16);
        console.info('WindowType.TYPE_DIALOG=' + windowType.TYPE_DIALOG);
        done();
      } catch (err) {
        console.error('testWindowTypeDialog001 error: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number  : TEST_WINDOW_TYPE_DIALOG_CREATE_001
     * @tc.name    : testWindowTypeDialogCreate001
     * @tc.desc    : Verify Window createWindow API accepts TYPE_DIALOG parameter
     * @tc.size    : MediumTest
     * @tc.type    : Function
     * @tc.level   : Level 1
     */
    it('testWindowTypeDialogCreate001', 0, async (done: Function) => {
      console.info('DialogAndLifecycleTest testWindowTypeDialogCreate001 begin');
      try {
        if (windowStage === undefined) {
          windowStage = globalThis.windowStage;
        }
        expect(windowStage !== undefined).assertTrue();

        let mainWindow = await windowStage!.getMainWindow();
        expect(mainWindow !== null).assertTrue();
        expect(mainWindow !== undefined).assertTrue();
        let uiContext = mainWindow.getUIContext();
        let hostContext = uiContext.getHostContext();
        expect(hostContext !== undefined).assertTrue();

        await windowStage!.loadContent('testability/pages/ModalDialogTestPage');
        await sleep(500);
        console.info('ModalDialogTestPage loaded');
        resetClickCount();

        let config: window.Configuration = {
          name: 'testDialogWin001',
          windowType: window.WindowType.TYPE_DIALOG,
          ctx: hostContext
        };
        let dialogWindow = await window.createWindow(config);
        expect(dialogWindow !== null).assertTrue();
        expect(dialogWindow !== undefined).assertTrue();
        console.info('TYPE_DIALOG created');

        await dialogWindow.resize(400, 300);
        await dialogWindow.moveWindowTo(100, 600);
        expect(dialogWindow.isWindowShowing()).assertEqual(false);
        await dialogWindow.showWindow();
        expect(dialogWindow.isWindowShowing()).assertEqual(true);
        await sleep(500);
        console.info('TYPE_DIALOG shown at (100,600)px, main button exposed above it');

        let driver = Driver.create();
        let densityPixels: number = display.getDefaultDisplaySync().densityPixels;
        let btnX: number = Math.floor(250 * densityPixels);
        let btnY: number = Math.floor(110 * densityPixels);
        console.info('densityPixels=' + densityPixels + ', click at (' + btnX + ',' + btnY + ')');
        await driver.click(btnX, btnY);
        await sleep(300);
        console.info('click while dialog showing, clickCount=' + getClickCount());
        expect(getClickCount()).assertEqual(0);

        await dialogWindow.destroyWindow();
        await sleep(500);
        console.info('TYPE_DIALOG destroyed');

        await windowStage!.loadContent('testability/pages/Index');
        await sleep(300);

        done();
      } catch (err) {
        console.error('testWindowTypeDialogCreate001 error: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

  })
}
