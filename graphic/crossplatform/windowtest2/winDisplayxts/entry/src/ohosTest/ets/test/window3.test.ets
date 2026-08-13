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

import { afterAll, afterEach, beforeAll, beforeEach, describe, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { window } from '@kit.ArkUI';
import deviceInfo from '@ohos.deviceInfo';
import { BusinessError } from '@kit.BasicServicesKit';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function isMainWindowStatusTypeValid(status: window.WindowStatusType): boolean {
  return status == window.WindowStatusType.FULL_SCREEN || status == window.WindowStatusType.FLOATING;
}

function isWindowStatusPlatform(platform: string): boolean {
  return platform.startsWith('OpenHarmony') || platform === 'iOS';
}

function isWindowRectChangePlatform(platform: string): boolean {
  return platform.startsWith('OpenHarmony') || platform === 'Android' || platform === 'iOS';
}

function isRectChangeOptionsValid(data: window.RectChangeOptions | undefined): boolean {
  if (data === undefined || data.rect === undefined) {
    return false;
  }
  return data.rect.width > 0 && data.rect.height > 0 &&
    data.reason >= window.RectChangeReason.UNDEFINED && data.reason <= window.RectChangeReason.DRAG_END;
}

function isSameRect(rect: window.Rect, expectedRect: window.Rect): boolean {
  return rect.left === expectedRect.left && rect.top === expectedRect.top &&
    rect.width === expectedRect.width && rect.height === expectedRect.height;
}

function isExpectedRectChangeOptionsValid(data: window.RectChangeOptions | undefined, platform: string,
  expectedRect: window.Rect): boolean {
  if (data === undefined || data.rect === undefined) {
    return false;
  }
  let rect: window.Rect = data.rect;
  if (!isSameRect(rect, expectedRect)) {
    return false;
  }
  if (platform === 'Android' || platform === 'iOS') {
    return data.reason === window.RectChangeReason.UNDEFINED;
  }
  return data.reason >= window.RectChangeReason.UNDEFINED && data.reason <= window.RectChangeReason.DRAG_END;
}

function hasExpectedRectChange(dataList: Array<window.RectChangeOptions>, platform: string,
  expectedRect: window.Rect): boolean {
  for (let index = 0; index < dataList.length; index++) {
    if (isExpectedRectChangeOptionsValid(dataList[index], platform, expectedRect)) {
      return true;
    }
  }
  return false;
}

async function layoutSubWindow(windowClass: window.Window, left: number, top: number, width: number,
  height: number, testName: string): Promise<void> {
  await windowClass.moveWindowTo(left, top).then(() => {
    console.info(testName + ' moveWindowTo success. left: ' + left + ', top: ' + top);
  }).catch((err: BusinessError) => {
    console.error(testName + ` moveWindowTo failed. Cause code: ${err.code}, message: ${err.message}`);
    expect().assertFail();
  });
  await windowClass.resize(width, height).then(() => {
    console.info(testName + ' resize success. width: ' + width + ', height: ' + height);
  }).catch((err: BusinessError) => {
    console.error(testName + ` resize failed. Cause code: ${err.code}, message: ${err.message}`);
    expect().assertFail();
  });
}

export default function windowTest3() {
  describe('windowTest3', () => {
    let osFullNameInfo: string = deviceInfo.osFullName;
    let platform = osFullNameInfo.split(' ')[0];
    let AWAIT_SLEEP_MS_300 = 300;
    let AWAIT_SLEEP_MS_500 = 500;
    let AWAIT_SLEEP_MS_2000 = 2000;

    beforeAll(async () => {
      console.info('windowTest3 wait for the test ability window to be ready.');
      await sleep(AWAIT_SLEEP_MS_2000);
    })

    beforeEach(async () => {
      await sleep(AWAIT_SLEEP_MS_300);
    })

    afterEach(async () => {
      await sleep(AWAIT_SLEEP_MS_300);
    })

    afterAll(async () => {
      await sleep(AWAIT_SLEEP_MS_300);
    })

    /**
     * @tc.number ArkUIX_window_getWindowStatus_0100
     * @tc.name ArkUIX_window_getWindowStatus_0100
     * @tc.desc Verify that the OpenHarmony/iOS main window calls getWindowStatus and returns a valid window status
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_getWindowStatus_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        if (!isWindowStatusPlatform(platform)) {
          console.info('ArkUIX_window_getWindowStatus_0100 skip current platform: ' + platform);
          expect(true).assertTrue();
          done();
          return;
        }

        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        if (windowClass != null && windowClass != undefined) {
          let status: window.WindowStatusType = windowClass.getWindowStatus();
          console.info('ArkUIX_window_getWindowStatus_0100 status: ' + status);
          expect(isMainWindowStatusTypeValid(status)).assertTrue();
        } else {
          console.log('window equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        console.error(`ArkUIX_window_getWindowStatus_0100 failed. Cause code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_getWindowStatus_0200
     * @tc.name ArkUIX_window_getWindowStatus_0200
     * @tc.desc Verify that the OpenHarmony/iOS sub-window calls getWindowStatus and returns a valid window status
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_getWindowStatus_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let subWindow: window.Window | undefined = undefined;
      try {
        if (!isWindowStatusPlatform(platform)) {
          console.info('ArkUIX_window_getWindowStatus_0200 skip current platform: ' + platform);
          expect(true).assertTrue();
          done();
          return;
        }

        let subWindowName: string = 'getWindowStatusSubWindow' + Date.now();
        subWindow = await globalThis.windowStage.createSubWindow(subWindowName);
        if (subWindow != null && subWindow != undefined) {
          await subWindow.setUIContent('testability/pages/Index');
          await subWindow.showWindow();
          await sleep(AWAIT_SLEEP_MS_500);
          let status: window.WindowStatusType = subWindow.getWindowStatus();
          console.info('ArkUIX_window_getWindowStatus_0200 status: ' + status);
          expect(status).assertEqual(window.WindowStatusType.FLOATING);
          await subWindow.destroyWindow();
          subWindow = undefined;
        } else {
          console.log('subWindow equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        if (subWindow != undefined) {
          try {
            await subWindow.destroyWindow();
          } catch (destroyErr) {
            console.error(`ArkUIX_window_getWindowStatus_0200 cleanup failed. Cause code: ` +
              `${destroyErr.code}, message: ${destroyErr.message}`);
          }
        }
        console.error(`ArkUIX_window_getWindowStatus_0200 failed. Cause code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_getWindowStatus_0300
     * @tc.name ArkUIX_window_getWindowStatus_0300
     * @tc.desc Verify that a dialog window calls getWindowStatus and returns FLOATING
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_getWindowStatus_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let dialogWindow: window.Window | undefined = undefined;
      try {
        if (!isWindowStatusPlatform(platform)) {
          console.info('ArkUIX_window_getWindowStatus_0300 skip current platform: ' + platform);
          expect(true).assertTrue();
          done();
          return;
        }

        let mainWindow: window.Window = await globalThis.windowStage.getMainWindow();
        let hostContext = mainWindow.getUIContext().getHostContext();
        expect(hostContext !== undefined).assertTrue();
        let config: window.Configuration = {
          name: 'getWindowStatusDialogWindow' + Date.now(),
          windowType: window.WindowType.TYPE_DIALOG,
          ctx: hostContext
        };
        let createdDialogWindow: window.Window = await window.createWindow(config);
        dialogWindow = createdDialogWindow;
        await createdDialogWindow.setUIContent('testability/pages/Index');
        await createdDialogWindow.showWindow();
        await sleep(AWAIT_SLEEP_MS_500);
        let status: window.WindowStatusType = createdDialogWindow.getWindowStatus();
        console.info('ArkUIX_window_getWindowStatus_0300 status: ' + status);
        expect(status).assertEqual(window.WindowStatusType.FLOATING);
        await createdDialogWindow.destroyWindow();
        dialogWindow = undefined;
      } catch (err) {
        if (dialogWindow != undefined) {
          try {
            await dialogWindow.destroyWindow();
          } catch (destroyErr) {
            console.error(`ArkUIX_window_getWindowStatus_0300 cleanup failed. Cause code: ` +
              `${destroyErr.code}, message: ${destroyErr.message}`);
          }
        }
        console.error(`ArkUIX_window_getWindowStatus_0300 failed. Cause code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_on_windowRectChange_0100
     * @tc.name ArkUIX_window_on_windowRectChange_0100
     * @tc.desc Verify that position and size changes each trigger windowRectChange once and verify on/off behavior
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_on_windowRectChange_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let subWindow: window.Window | undefined = undefined;
      let callbackData1: window.RectChangeOptions | undefined = undefined;
      let callbackData2: window.RectChangeOptions | undefined = undefined;
      let callbackCount1: number = 0;
      let callbackCount2: number = 0;
      const callback1 = (data: window.RectChangeOptions) => {
        console.info('ArkUIX_window_on_windowRectChange_0100 callback1 data: ' + JSON.stringify(data));
        callbackData1 = data;
        callbackCount1++;
      }
      const callback2 = (data: window.RectChangeOptions) => {
        console.info('ArkUIX_window_on_windowRectChange_0100 callback2 data: ' + JSON.stringify(data));
        callbackData2 = data;
        callbackCount2++;
      }

      try {
        if (!isWindowRectChangePlatform(platform)) {
          console.info('ArkUIX_window_on_windowRectChange_0100 skip current platform: ' + platform);
          expect(true).assertTrue();
          done();
          return;
        }

        let subWindowName: string = 'windowRectChangeSubWindow' + Date.now();
        subWindow = await globalThis.windowStage.createSubWindow(subWindowName);
        if (subWindow != null && subWindow != undefined) {
          subWindow.on('windowRectChange', callback1);
          subWindow.on('windowRectChange', callback2);
          await subWindow.setUIContent('testability/pages/Index');
          await subWindow.showWindow();
          await sleep(AWAIT_SLEEP_MS_500);

          callbackData1 = undefined;
          callbackData2 = undefined;
          callbackCount1 = 0;
          callbackCount2 = 0;
          let initialRect: window.Rect = subWindow.getWindowProperties().windowRect;
          let targetWidth: number = initialRect.width === 260 ? 280 : 260;
          let targetHeight: number = initialRect.height === 260 ? 280 : 260;
          await subWindow.resize(targetWidth, targetHeight);
          await sleep(AWAIT_SLEEP_MS_2000);
          expect(callbackCount1).assertEqual(1);
          expect(callbackCount2).assertEqual(1);
          expect(isRectChangeOptionsValid(callbackData1)).assertTrue();
          expect(isRectChangeOptionsValid(callbackData2)).assertTrue();

          let rectAfterResize: window.Rect = subWindow.getWindowProperties().windowRect;
          let targetLeft: number = rectAfterResize.left === 30 ? 40 : 30;
          let targetTop: number = rectAfterResize.top === 80 ? 90 : 80;
          let callbackCount1BeforeMove: number = callbackCount1;
          let callbackCount2BeforeMove: number = callbackCount2;
          callbackData1 = undefined;
          callbackData2 = undefined;
          await subWindow.moveWindowTo(targetLeft, targetTop);
          await sleep(AWAIT_SLEEP_MS_2000);
          expect(callbackCount1).assertEqual(callbackCount1BeforeMove + 1);
          expect(callbackCount2).assertEqual(callbackCount2BeforeMove + 1);
          expect(isRectChangeOptionsValid(callbackData1)).assertTrue();
          expect(isRectChangeOptionsValid(callbackData2)).assertTrue();

          let callbackCount1AfterOff: number = callbackCount1;
          let callbackCount2BeforeSecondChange: number = callbackCount2;
          callbackData2 = undefined;
          subWindow.off('windowRectChange', callback1);
          await subWindow.resize(300, 300);
          await sleep(AWAIT_SLEEP_MS_2000);
          expect(callbackCount1).assertEqual(callbackCount1AfterOff);
          expect(callbackCount2).assertEqual(callbackCount2BeforeSecondChange + 1);
          expect(isRectChangeOptionsValid(callbackData2)).assertTrue();

          let callbackCount1BeforeOffAll: number = callbackCount1;
          let callbackCount2BeforeOffAll: number = callbackCount2;
          subWindow.off('windowRectChange');
          await subWindow.moveWindowTo(50, 100);
          await sleep(AWAIT_SLEEP_MS_2000);
          expect(callbackCount1).assertEqual(callbackCount1BeforeOffAll);
          expect(callbackCount2).assertEqual(callbackCount2BeforeOffAll);
          await subWindow.destroyWindow();
          subWindow = undefined;
        } else {
          console.log('subWindow equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        if (subWindow != undefined) {
          try {
            subWindow.off('windowRectChange');
            await subWindow.destroyWindow();
          } catch (destroyErr) {
            console.error(`ArkUIX_window_on_windowRectChange_0100 cleanup failed. Cause code: ` +
              `${destroyErr.code}, message: ${destroyErr.message}`);
          }
        }
        console.error(`ArkUIX_window_on_windowRectChange_0100 failed. Cause code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_on_windowRectChange_0200
     * @tc.name ArkUIX_window_on_windowRectChange_0200
     * @tc.desc Verify that the sub-window calls on('windowRectChange') and returns the actual window rect data
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_on_windowRectChange_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let subWindow: window.Window | undefined = undefined;
      let callbackDataList: Array<window.RectChangeOptions> = [];
      const callback = (data: window.RectChangeOptions) => {
        console.info('ArkUIX_window_on_windowRectChange_0200 callback data: ' + JSON.stringify(data));
        callbackDataList.push(data);
      }

      try {
        if (!isWindowRectChangePlatform(platform)) {
          console.info('ArkUIX_window_on_windowRectChange_0200 skip current platform: ' + platform);
          expect(true).assertTrue();
          done();
          return;
        }

        let targetLeft: number = 30;
        let targetTop: number = 80;
        let targetWidth: number = 260;
        let targetHeight: number = 260;
        let subWindowName: string = 'windowRectChangeSubWindowValue' + Date.now();
        subWindow = await globalThis.windowStage.createSubWindow(subWindowName);
        if (subWindow != null && subWindow != undefined) {
          subWindow.on('windowRectChange', callback);
          await subWindow.setUIContent('testability/pages/Index');
          await subWindow.showWindow();
          await sleep(AWAIT_SLEEP_MS_500);
          callbackDataList.splice(0, callbackDataList.length);
          await layoutSubWindow(subWindow, targetLeft, targetTop, targetWidth, targetHeight,
            'ArkUIX_window_on_windowRectChange_0200');
          await sleep(AWAIT_SLEEP_MS_2000);
          subWindow.off('windowRectChange', callback);
          let actualRect: window.Rect = subWindow.getWindowProperties().windowRect;
          console.info('ArkUIX_window_on_windowRectChange_0200 actual rect: ' + JSON.stringify(actualRect));
          expect(hasExpectedRectChange(callbackDataList, platform, actualRect)).assertTrue();
          await subWindow.destroyWindow();
          subWindow = undefined;
        } else {
          console.log('subWindow equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        if (subWindow != undefined) {
          try {
            subWindow.off('windowRectChange', callback);
            await subWindow.destroyWindow();
          } catch (destroyErr) {
            console.error(`ArkUIX_window_on_windowRectChange_0200 cleanup failed. Cause code: ` +
              `${destroyErr.code}, message: ${destroyErr.message}`);
          }
        }
        console.error(`ArkUIX_window_on_windowRectChange_0200 failed. Cause code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_on_windowStatusDidChange_0100
     * @tc.name ArkUIX_window_on_windowStatusDidChange_0100
     * @tc.desc Verify that the OpenHarmony/iOS sub-window calls on/off('windowStatusDidChange')
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_on_windowStatusDidChange_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let subWindow: window.Window | undefined = undefined;
      let callbackStatus1: window.WindowStatusType = window.WindowStatusType.UNDEFINED;
      let callbackStatus2: window.WindowStatusType = window.WindowStatusType.UNDEFINED;
      let callbackCount1: number = 0;
      let callbackCount2: number = 0;
      const callback1 = (data: window.WindowStatusType) => {
        console.info('ArkUIX_window_on_windowStatusDidChange_0100 callback1 data: ' + JSON.stringify(data));
        callbackStatus1 = data;
        callbackCount1++;
      }
      const callback2 = (data: window.WindowStatusType) => {
        console.info('ArkUIX_window_on_windowStatusDidChange_0100 callback2 data: ' + JSON.stringify(data));
        callbackStatus2 = data;
        callbackCount2++;
      }

      try {
        if (!isWindowStatusPlatform(platform)) {
          console.info('ArkUIX_window_on_windowStatusDidChange_0100 skip current platform: ' + platform);
          expect(true).assertTrue();
          done();
          return;
        }

        let subWindowName: string = 'windowStatusDidChangeSubWindow' + Date.now();
        subWindow = await globalThis.windowStage.createSubWindow(subWindowName);
        if (subWindow != null && subWindow != undefined) {
          subWindow.on('windowStatusDidChange', callback1);
          subWindow.on('windowStatusDidChange', callback2);
          await subWindow.setUIContent('testability/pages/Index');
          await subWindow.showWindow();
          await sleep(AWAIT_SLEEP_MS_2000);
          expect(callbackCount1).assertEqual(1);
          expect(callbackCount2).assertEqual(1);
          expect(callbackStatus1).assertEqual(window.WindowStatusType.FLOATING);
          expect(callbackStatus2).assertEqual(window.WindowStatusType.FLOATING);
          subWindow.off('windowStatusDidChange');
          await subWindow.destroyWindow();
          subWindow = undefined;

          callbackStatus1 = window.WindowStatusType.UNDEFINED;
          callbackStatus2 = window.WindowStatusType.UNDEFINED;
          callbackCount1 = 0;
          callbackCount2 = 0;
          let offOneSubWindowName: string = 'windowStatusDidChangeOffOneSubWindow' + Date.now();
          subWindow = await globalThis.windowStage.createSubWindow(offOneSubWindowName);
          if (subWindow != null && subWindow != undefined) {
            subWindow.on('windowStatusDidChange', callback1);
            subWindow.on('windowStatusDidChange', callback2);
            subWindow.off('windowStatusDidChange', callback1);
            await subWindow.setUIContent('testability/pages/Index');
            await subWindow.showWindow();
            await sleep(AWAIT_SLEEP_MS_2000);
            expect(callbackCount1).assertEqual(0);
            expect(callbackCount2).assertEqual(1);
            expect(callbackStatus2).assertEqual(window.WindowStatusType.FLOATING);
            subWindow.off('windowStatusDidChange');
            await subWindow.destroyWindow();
            subWindow = undefined;
          } else {
            console.log('offOneSubWindow equal undefined');
            expect().assertFail();
          }

          callbackStatus1 = window.WindowStatusType.UNDEFINED;
          callbackStatus2 = window.WindowStatusType.UNDEFINED;
          callbackCount1 = 0;
          callbackCount2 = 0;
          let offAllSubWindowName: string = 'windowStatusDidChangeOffAllSubWindow' + Date.now();
          subWindow = await globalThis.windowStage.createSubWindow(offAllSubWindowName);
          if (subWindow != null && subWindow != undefined) {
            subWindow.on('windowStatusDidChange', callback1);
            subWindow.on('windowStatusDidChange', callback2);
            subWindow.off('windowStatusDidChange');
            await subWindow.setUIContent('testability/pages/Index');
            await subWindow.showWindow();
            await sleep(AWAIT_SLEEP_MS_2000);
            expect(callbackCount1).assertEqual(0);
            expect(callbackCount2).assertEqual(0);
            await subWindow.destroyWindow();
            subWindow = undefined;
          } else {
            console.log('offAllSubWindow equal undefined');
            expect().assertFail();
          }
        } else {
          console.log('subWindow equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        if (subWindow != undefined) {
          try {
            subWindow.off('windowStatusDidChange');
            await subWindow.destroyWindow();
          } catch (destroyErr) {
            console.error(`ArkUIX_window_on_windowStatusDidChange_0100 cleanup failed. Cause code: ` +
              `${destroyErr.code}, message: ${destroyErr.message}`);
          }
        }
        console.error(`ArkUIX_window_on_windowStatusDidChange_0100 failed. Cause code: ` +
          `${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_on_windowStatusDidChange_0200
     * @tc.name ArkUIX_window_on_windowStatusDidChange_0200
     * @tc.desc Verify that a dialog window reports FLOATING through on('windowStatusDidChange')
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_on_windowStatusDidChange_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      let dialogWindow: window.Window | undefined = undefined;
      let callbackCount: number = 0;
      let callbackStatus: window.WindowStatusType = window.WindowStatusType.UNDEFINED;
      const callback = (data: window.WindowStatusType) => {
        console.info('ArkUIX_window_on_windowStatusDidChange_0200 callback data: ' + JSON.stringify(data));
        callbackStatus = data;
        callbackCount++;
      }

      try {
        if (!isWindowStatusPlatform(platform)) {
          console.info('ArkUIX_window_on_windowStatusDidChange_0200 skip current platform: ' + platform);
          expect(true).assertTrue();
          done();
          return;
        }

        let mainWindow: window.Window = await globalThis.windowStage.getMainWindow();
        let hostContext = mainWindow.getUIContext().getHostContext();
        expect(hostContext !== undefined).assertTrue();
        let config: window.Configuration = {
          name: 'windowStatusDidChangeDialogWindow' + Date.now(),
          windowType: window.WindowType.TYPE_DIALOG,
          ctx: hostContext
        };
        let createdDialogWindow: window.Window = await window.createWindow(config);
        dialogWindow = createdDialogWindow;
        createdDialogWindow.on('windowStatusDidChange', callback);
        await createdDialogWindow.setUIContent('testability/pages/Index');
        await createdDialogWindow.showWindow();
        await sleep(AWAIT_SLEEP_MS_2000);
        expect(callbackCount).assertEqual(1);
        expect(callbackStatus).assertEqual(window.WindowStatusType.FLOATING);
        createdDialogWindow.off('windowStatusDidChange', callback);
        await createdDialogWindow.destroyWindow();
        dialogWindow = undefined;
      } catch (err) {
        if (dialogWindow != undefined) {
          try {
            dialogWindow.off('windowStatusDidChange', callback);
            await dialogWindow.destroyWindow();
          } catch (destroyErr) {
            console.error(`ArkUIX_window_on_windowStatusDidChange_0200 cleanup failed. Cause code: ` +
              `${destroyErr.code}, message: ${destroyErr.message}`);
          }
        }
        console.error(`ArkUIX_window_on_windowStatusDidChange_0200 failed. Cause code: ` +
          `${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
  })
}
