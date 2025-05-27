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
import deviceInfo from '@ohos.deviceInfo';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function windowTest() {
  describe('windowTest', () => {
    let osFullNameInfo: string = deviceInfo.osFullName;
    let platform = osFullNameInfo.split(' ')[0];
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_Promise_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        if (windowClass != null && windowClass != undefined) {
          await windowClass.setWindowPrivacyMode(false).then(() => {
            console.info('Succeeded in setting the window to privacy mode.');
          }).catch((err: BusinessError) => {
            console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
            expect().assertFail();
          });
          if (platform.startsWith('OpenHarmony')) {
            let privacyMode: boolean = windowClass.getWindowProperties().isPrivacyMode;
            console.log('PrivacyMode is: ' + privacyMode);
            expect(privacyMode).assertFalse();
          }
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_Promise_0200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        if (windowClass != null && windowClass != undefined) {
          await windowClass.setWindowPrivacyMode(true).then(() => {
            console.info('Succeeded in setting the window to privacy mode.');
          }).catch((err: BusinessError) => {
            console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
            expect().assertFail();
          });
          if (platform.startsWith('OpenHarmony')) {
            let privacyMode: boolean = windowClass.getWindowProperties().isPrivacyMode;
            console.log('PrivacyMode is: ' + privacyMode);
            expect(privacyMode).assertTrue();
          }
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
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_Promise_0300
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_Promise_0300
     * @tc.desc Verify that the sub-window calls the Promise function SetWindowPrivacyMode and
     *          sets the parameter to false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_Promise_0300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let subWindow: window.Window = await globalThis.windowStage.createSubWindow('mySubWindow')
        if (windowClass != null && windowClass != undefined) {
          await windowClass.setWindowPrivacyMode(false).then(() => {
            console.info('Succeeded in setting the window to privacy mode.');
          }).catch((err: BusinessError) => {
            console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
            expect().assertFail();
          });
          if (subWindow != null && subWindow != undefined) {
            if (platform.startsWith('OpenHarmony')) {
              let privacyMode: boolean = subWindow.getWindowProperties().isPrivacyMode;
              console.log('PrivacyMode is: ' + privacyMode);
              expect(privacyMode).assertFalse();
            }
            await subWindow.destroyWindow();
          } else {
            console.log('subWindow equal undefined');
            expect().assertFail();
          }
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
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_Promise_0400
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_Promise_0400
     * @tc.desc Verify that the sub-window calls the Promise function SetWindowPrivacyMode and
     *          sets the parameter to true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_Promise_0400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let subWindow: window.Window = await globalThis.windowStage.createSubWindow('mySubWindow')
        if (windowClass != null && windowClass != undefined) {
          await windowClass.setWindowPrivacyMode(true).then(() => {
            console.info('Succeeded in setting the window to privacy mode.');
          }).catch((err: BusinessError) => {
            console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
            expect().assertFail();
          });
          if (subWindow != null && subWindow != undefined) {
            if (platform.startsWith('OpenHarmony')) {
              let privacyMode: boolean = subWindow.getWindowProperties().isPrivacyMode;
              console.log('PrivacyMode is: ' + privacyMode);
              expect(privacyMode).assertFalse();
            }
            await subWindow.destroyWindow();
          } else {
            console.log('subWindow equal undefined');
            expect().assertFail();
          }
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
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
          if (platform.startsWith('OpenHarmony')) {
            let privacyMode: boolean = windowClass.getWindowProperties().isPrivacyMode;
            console.log('PrivacyMode is: ' + privacyMode);
            expect(privacyMode).assertFalse();
          }
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
     * @tc.name setWindowPrivacyMode
     * @tc.desc Verify that the main window calls the callback function getMainWindowSync and
     *          sets the parameter to true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_callback_0200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
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
          if (platform.startsWith('OpenHarmony')) {
            let privacyMode: boolean = windowClass.getWindowProperties().isPrivacyMode;
            console.log('PrivacyMode is: ' + privacyMode);
            expect(privacyMode).assertTrue();
          }
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
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_callback_0300
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_callback_0300
     * @tc.desc Verify that the sub-window calls the Promise function SetWindowPrivacyMode and
     *          sets the parameter to false
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_callback_0300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let subWindow: window.Window = await globalThis.windowStage.createSubWindow('mySubWindow');
        if (windowClass != null && windowClass != undefined) {
          windowClass.setWindowPrivacyMode(false, (err: BusinessError, data) => {
            if (err.code) {
              console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
            }
            console.info('Succeeded in setting the window to privacy mode.');
          });
          await sleep(AWAIT_SLEEP_MS_1500);
          if (subWindow != null && subWindow != undefined) {
            if (platform.startsWith('OpenHarmony')) {
              let privacyMode: boolean = subWindow.getWindowProperties().isPrivacyMode;
              console.log('PrivacyMode is: ' + privacyMode);
              expect(privacyMode).assertFalse();
            }
            await subWindow.destroyWindow();
          } else {
            console.log('subWindow equal undefined');
            expect().assertFail();
          }
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
     * @tc.number ArkUIX_window_SetWindowPrivacyMode_callback_0400
     * @tc.name ArkUIX_window_SetWindowPrivacyMode_callback_0400
     * @tc.desc Verify that the sub-window calls the Promise function SetWindowPrivacyMode and
     *          sets the parameter to true
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_SetWindowPrivacyMode_callback_0400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let subWindow: window.Window = await globalThis.windowStage.createSubWindow('mySubWindow');
        if (windowClass != null && windowClass != undefined) {
          windowClass.setWindowPrivacyMode(true, (err: BusinessError, data) => {
            if (err.code) {
              console.error(`Failed to set the window to privacy mode. Cause code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
            }
            console.info('Succeeded in setting the window to privacy mode.');
          });
          await sleep(AWAIT_SLEEP_MS_1500);
          if (subWindow != null && subWindow != undefined) {
            if (platform.startsWith('OpenHarmony')) {
              let privacyMode: boolean = subWindow.getWindowProperties().isPrivacyMode;
              console.log('PrivacyMode is: ' + privacyMode);
              expect(privacyMode).assertFalse();
            }
            await subWindow.destroyWindow();
          } else {
            console.log('subWindow equal undefined');
            expect().assertFail();
          }
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_on_avoidAreaChange_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let flag: boolean = false;
        if (windowClass != null && windowClass != undefined) {
          const callback = (data: window.AvoidAreaOptions) => {
            console.info(` Succeeded in enabling the listener for avoid area changes. Data: ${JSON.stringify(data)}`);
            flag = true;
          }
          windowClass.on('avoidAreaChange', callback);
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          statusBarColor: '#ff00ff',
          navigationBarColor: '#00ff00',
          statusBarContentColor: '#ffffff',
          navigationBarContentColor: '#00ffff'
        }
        windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
          if (platform.startsWith('OpenHarmony')) {
            let systemBarProperty = windowClass.getWindowSystemBarProperties();
            expect(systemBarProperty.statusBarColor).assertEqual('#FFFF00FF');
            expect(systemBarProperty.navigationBarColor).assertEqual('#FF00FF00');
            expect(systemBarProperty.statusBarContentColor).assertEqual('#FFFFFFFF');
            expect(systemBarProperty.navigationBarContentColor).assertEqual('#FF00FFFF');
            expect(systemBarProperty.isStatusBarLightIcon).assertEqual(false);
            expect(systemBarProperty.isNavigationBarLightIcon).assertEqual(false);
            expect(systemBarProperty.enableStatusBarAnimation).assertEqual(false);
            expect(systemBarProperty.enableNavigationBarAnimation).assertEqual(false);
          }
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0200', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          statusBarColor: '#ff00ff',
          isStatusBarLightIcon: true,
          statusBarContentColor: '#00ff00',
          enableStatusBarAnimation: true
        };
        windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
          if (platform.startsWith('OpenHarmony')) {
            let systemBarProperty = windowClass.getWindowSystemBarProperties();
            console.info(`Success in obtaining system bar properties. Property:   ${JSON.stringify(systemBarProperty)}`);
            expect(systemBarProperty.statusBarContentColor).assertEqual('#FF00FF00');
            expect(systemBarProperty.isStatusBarLightIcon).assertEqual(false);
            expect(systemBarProperty.enableStatusBarAnimation).assertEqual(true);
          }
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          isStatusBarLightIcon: true
        };
        windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
          if (platform.startsWith('OpenHarmony')) {
            let systemBarProperty = windowClass.getWindowSystemBarProperties();
            console.info(`Success in obtaining system bar properties. Property:   ${JSON.stringify(systemBarProperty)}`);
            expect(systemBarProperty.isStatusBarLightIcon).assertEqual(true);
          }
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          navigationBarColor: '#ff00ff',
          isNavigationBarLightIcon: true,
          navigationBarContentColor: '#00ff00',
          enableNavigationBarAnimation: true
        };
        windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
          if (platform.startsWith('OpenHarmony')) {
            let systemBarProperty = windowClass.getWindowSystemBarProperties();
            console.info(`Success in obtaining system bar properties. Property:   ${JSON.stringify(systemBarProperty)}`);
            expect(systemBarProperty.navigationBarColor).assertEqual('#FFFF00FF');
            expect(systemBarProperty.navigationBarContentColor).assertEqual('#FF00FF00');
            expect(systemBarProperty.isNavigationBarLightIcon).assertEqual(false);
            expect(systemBarProperty.enableNavigationBarAnimation).assertEqual(true);
          }
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
     * @tc.level Level0
     * @tc.require
     */
    it('ArkUIX_window_setWindowSystemBarProperties_0500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
        let SystemBarProperties: window.SystemBarProperties = {
          isNavigationBarLightIcon: true
        };
        windowClass.setWindowSystemBarProperties(SystemBarProperties).then(() => {
          if (platform.startsWith('OpenHarmony')) {
            let systemBarProperty = windowClass.getWindowSystemBarProperties();
            console.info(`Success in obtaining system bar properties. Property:   ${JSON.stringify(systemBarProperty)}`);
            expect(systemBarProperty.isNavigationBarLightIcon).assertEqual(true);
          }
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