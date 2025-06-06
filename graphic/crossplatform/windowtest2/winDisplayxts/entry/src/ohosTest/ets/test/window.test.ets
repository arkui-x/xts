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
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function windowTest() {
  describe('windowTest', () => {
    let AWAIT_SLEEP_MS_1500 = 1500;
    beforeEach(async () => {
      await sleep(AWAIT_SLEEP_MS_1500);
    })
    afterAll(async () => {
      await sleep(AWAIT_SLEEP_MS_1500);
    })

    /**
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_Promise_0100
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_Promise_0100
     * @tc.desc Verify that the main window calls the Promise function SetWindowPrivacyMode and
     *          sets the parameter to false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_Promise_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        if (windowClass != null && windowClass != undefined) {
          await windowClass.setWindowPrivacyMode(false).then(() => {
            console.info('Succeeded in setting the window to privacy mode.');
          }).catch((err: BusinessError) => {
            console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
            expect().assertFail();
          });
        } else {
          console.log('window equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_Promise_0200
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_Promise_0200
     * @tc.desc Verify that the main window calls the Promise function SetWindowPrivacyMode and
     *          sets the parameter to true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_Promise_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        if (windowClass != null && windowClass != undefined) {
          await windowClass.setWindowPrivacyMode(true).then(() => {
            console.info('Succeeded in setting the window to privacy mode.');
          }).catch((err: BusinessError) => {
            console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
            expect().assertFail();
          });
        } else {
          console.log('window equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_callback_0100
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_callback_0100
     * @tc.desc Verify that the main window calls the callback function getMainWindowSync and
     *          sets the parameter to false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_callback_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        if (windowClass != null && windowClass != undefined) {
          windowClass.setWindowPrivacyMode(false, (err: BusinessError) => {
            if (err.code) {
              console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
            }
            console.info('Succeeded in setting the window to privacy mode.');
          });
          await sleep(AWAIT_SLEEP_MS_1500);
        } else {
          console.log('window equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_callback_0200
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_callback_0200
     * @tc.desc Verify that the main window calls the callback function getMainWindowSync and
     *          sets the parameter to true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_callback_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        if (windowClass != null && windowClass != undefined) {
          windowClass.setWindowPrivacyMode(true, (err: BusinessError) => {
            if (err.code) {
              console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
            }
            console.info('Succeeded in setting the window to privacy mode.');
          });
          await sleep(AWAIT_SLEEP_MS_1500);
        } else {
          console.log('window equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_on_avoidAreaChange_0100
     * @tc.name ArkUIX_window_on_avoidAreaChange_0100
     * @tc.desc Verify that the main window calls the callback function on(‘avoidAreaChange’)
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_on_avoidAreaChange_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let flag: boolean = false;
        if (windowClass != null && windowClass != undefined) {
          const callback = (data: window.AvoidAreaOptions) => {
            console.info(` Succeeded in enabling the listener for avoid area changes. Data: ${JSON.stringify(data)}`);
            flag = true;
          }
          windowClass.on('avoidAreaChange', callback);
          await windowClass.setWindowLayoutFullScreen(true);
          windowClass.setPreferredOrientation(window.Orientation.LANDSCAPE);
          await sleep(AWAIT_SLEEP_MS_1500);
          expect(flag).assertTrue();
          windowClass.off('avoidAreaChange');
          windowClass.setPreferredOrientation(window.Orientation.PORTRAIT);
        } else {
          console.log('window equal undefined');
          expect().assertFail();
        }
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_setWindowSystemBarProperties_0100
     * @tc.name ArkUIX_window_setWindowSystemBarProperties_0100
     * @tc.desc Verify setWindowSystemBarProperties function sets the main window three key navigation bar,
     *          status bar properties
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          statusBarColor: '#ff00ff',
          navigationBarColor: '#00ff00'
        }
        await windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
        }).catch((err: BusinessError) => {
          console.error(`Failed to set the system bar properties. Cause code: ${err.code}, message: ${err.message}`);
          expect().assertFail();
        });
      } catch (err) {
        console.error(`Error. Cause code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_setWindowSystemBarProperties_0200
     * @tc.name ArkUIX_window_setWindowSystemBarProperties_0200
     * @tc.desc Verify setWindowSystemBarProperties function sets the main window three key navigation bar,
     *          status bar properties
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          statusBarColor: '#ff00ff',
          isStatusBarLightIcon: true,
          enableStatusBarAnimation: true
        };
        await windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
        }).catch((err: BusinessError) => {
          console.error(`Failed to set the system bar properties. Cause code: ${err.code}, message: ${err.message}`);
          expect().assertFail();
        })
      } catch (err) {
        console.error(`Failed code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_setWindowSystemBarProperties_0300
     * @tc.name ArkUIX_window_setWindowSystemBarProperties_0300
     * @tc.desc Verify setWindowSystemBarProperties function sets the main window three key navigation bar,
     *          status bar properties
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          isStatusBarLightIcon: true
        };
        await windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
        }).catch((err: BusinessError) => {
          console.error(`Failed to set the system bar properties. Cause code: ${err.code}, message: ${err.message}`);
          expect().assertFail();
        })
      } catch (err) {
        console.error(`Failed code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_setWindowSystemBarProperties_0400
     * @tc.name ArkUIX_window_setWindowSystemBarProperties_0400
     * @tc.desc Verify setWindowSystemBarProperties function sets the main window three key navigation bar,
     *          status bar properties
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          navigationBarColor: '#ff00ff',
          isNavigationBarLightIcon: true
        };
        await windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
        }).catch((err: BusinessError) => {
          console.error(`Failed to set the system bar properties. Cause code: ${err.code}, message: ${err.message}`);
          expect().assertFail();
        })
      } catch (err) {
        console.error(`Failed code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ArkUIX_window_setWindowSystemBarProperties_0500
     * @tc.name ArkUIX_window_setWindowSystemBarProperties_0500
     * @tc.desc Verify setWindowSystemBarProperties function sets the main window three key navigation bar,
     *          status bar properties
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          isNavigationBarLightIcon: true
        };
        await windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
        }).catch((err: BusinessError) => {
          console.error(`Failed code: ${err.code}, message: ${err.message}`);
          expect().assertFail();
        })
      } catch (err) {
        console.error(`Failed code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
      }
      done();
    })
  })
}