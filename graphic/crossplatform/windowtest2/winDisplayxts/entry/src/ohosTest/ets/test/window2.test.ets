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
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import deviceInfo from '@ohos.deviceInfo';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { UIAbility, Want } from '@kit.AbilityKit';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function windowTest2() {
  describe('windowTest2', () => {
    const WANT: Want = {
      bundleName: 'com.example.winassisttestapp',
      moduleName: 'entry',
      abilityName: 'EntryAbility'
    }
    let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
    let osFullNameInfo: string = deviceInfo.osFullName;
    let platform = osFullNameInfo.split(' ')[0];
    let AWAIT_SLEEP_MS_1500 = 1500;
    let AWAIT_SLEEP_MS_2000 = 2000;
    let AWAIT_SLEEP_MS_6000 = 6000;

    // /**
    //  * @tc.number ArkUIX_window_on_windowStatusChange_0100
    //  * @tc.name ArkUIX_window_on_windowStatusChange_0100
    //  * @tc.desc Verify that the main window calls the callback function on(‘windowStatusChange’)
    //  * @tc.size MEDIUM
    //  * @tc.type Function
    //  * @tc.level Level0
    //  * @tc.require
    //  */
    // it('ArkUIX_window_on_windowStatusChange_0100', TestType.FUNCTION |
    // Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
    //   try {
    //     let windowClass: window.Window = globalThis.windowStage.getMainWindowSync();
    //     let flag: boolean = false;
    //     if (windowClass != null && windowClass != undefined) {
    //       const callback = (data: window.WindowStatusType) => {
    //         console.info('Succeeded in enabling the listener for window status changes. Data: ' + JSON.stringify(data));
    //         flag = true;
    //       }
    //       if (platform.startsWith('OpenHarmony')) {
    //         windowClass.on('windowStatusChange', callback);
    //         delegator.getCurrentTopAbility(async (err: BusinessError, data: UIAbility) => {
    //           await delegator.doAbilityBackground(data).then(() => {
    //             console.info('ArkUIX_window_on_windowStatusChange_0100 doAbilityBackground')
    //           }).catch(() => {
    //             expect().assertFail()
    //           })
    //           await sleep(AWAIT_SLEEP_MS_2000)
    //           await delegator.doAbilityForeground(data).then(() => {
    //             console.info('ArkUIX_window_on_windowStatusChange_0100 doAbilityForeground')
    //           }).catch(() => {
    //             expect().assertFail()
    //           })
    //         })
    //         await sleep(AWAIT_SLEEP_MS_6000)
    //         expect(flag).assertTrue();
    //         windowClass.off('windowStatusChange');
    //       } else if (platform === 'iOS') {
    //         windowClass.on('windowStatusChange', callback);
    //         await delegator.startAbility(WANT).then(() => {
    //         }).catch(() => {
    //           expect().assertFail()
    //         })
    //         await sleep(AWAIT_SLEEP_MS_6000)
    //         expect(flag).assertTrue();
    //         windowClass.off('windowStatusChange');
    //       }
    //     } else {
    //       console.log('window equal undefined');
    //       expect().assertFail();
    //     }
    //   } catch (err) {
    //     if (err.code != 801) {
    //       console.error(`Failed to unregister callback. Cause code: ${err.code}, message: ${err.message}`);
    //       expect().assertFail();
    //     } else {
    //       console.log('Device type does not support the system capability SystemCapability.Window.SessionManager')
    //       console.log('err.code: ' + err.code + 'err.message: ' + err.message)
    //       expect(err.code).assertEqual(801);
    //     }
    //   }
    //   done();
    // })

    // /**
    //  * @tc.number ArkUIX_window_on_windowStatusChange_0200
    //  * @tc.name setWindowPrivacyMode
    //  * @tc.desc Verify that the sub-window calls the callback function on(‘windowStatusChange’)
    //  * @tc.size MEDIUM
    //  * @tc.type Function
    //  * @tc.level Level0
    //  * @tc.require
    //  */
    // it('ArkUIX_window_on_windowStatusChange_0200', TestType.FUNCTION |
    // Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
    //   try {
    //     let subWindow: window.Window = await globalThis.windowStage.createSubWindow('mySubWindow');
    //     let flag: boolean = false;
    //     if (subWindow != null && subWindow != undefined) {
    //       const callback = (data: window.WindowStatusType) => {
    //         console.info('Succeeded in enabling the listener for window status changes. Data: ' + JSON.stringify(data));
    //         flag = true;
    //       }
    //       if (platform.startsWith('OpenHarmony') || platform === 'iOS') {
    //         subWindow.on('windowStatusChange', callback);
    //         globalThis.windowStage.loadContentByName("mySubWindow", globalThis.storage, (err: BusinessError) => {
    //           const errCode: number = err.code;
    //           if (errCode) {
    //             console.error(`Failed to load the content. Cause code: ${err.code}, message: ${err.message}`);
    //             expect().assertFail();
    //           }
    //           console.info('Succeeded in loading the content.');
    //         });
    //         subWindow.showWindow();
    //         await sleep(AWAIT_SLEEP_MS_1500);
    //         expect(flag).assertTrue();
    //         subWindow.off('windowStatusChange');
    //       }
    //       await subWindow.destroyWindow();
    //     } else {
    //       console.log('window equal undefined');
    //       expect().assertFail();
    //     }
    //   } catch (err) {
    //     if (err.code != 801) {
    //       console.error(`Failed to unregister callback. Cause code: ${err.code}, message: ${err.message}`);
    //       expect().assertFail();
    //     } else {
    //       console.log('Device type does not support the system capability SystemCapability.Window.SessionManager')
    //       console.log('err.code: ' + err.code + 'err.message: ' + err.message)
    //       expect(err.code).assertEqual(801);
    //     }
    //   }
    //   done();
    // })
  })
}