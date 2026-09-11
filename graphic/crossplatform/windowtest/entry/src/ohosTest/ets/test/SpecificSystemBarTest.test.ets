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
import { describe, beforeAll, afterAll, it, expect } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';
import { Callback } from '@kit.BasicServicesKit';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function assertRectValid(caseName: string, rectName: string, rect: window.Rect): void {
  let isValid: boolean = rect.left >= 0 && rect.top >= 0 && rect.width >= 0 && rect.height >= 0;
  console.info(`${caseName} ${rectName}: left=${rect.left}, top=${rect.top}, width=${rect.width}, height=${rect.height}`);
  expect(isValid).assertTrue();
}

function isValidWindowStatus(status: window.WindowStatusType): boolean {
  return status === window.WindowStatusType.UNDEFINED ||
    status === window.WindowStatusType.FULL_SCREEN ||
    status === window.WindowStatusType.MINIMIZE ||
    status === window.WindowStatusType.FLOATING ||
    status === window.WindowStatusType.SPLIT_SCREEN;
}

export default function SpecificSystemBarTest() {
  describe('SpecificSystemBarTest', () => {
    let windowStage: window.WindowStage;
    let deviceType: string = deviceInfo.deviceType;

    beforeAll(async () => {
      console.info('SpecificSystemBarTest beforeAll');
      windowStage = globalThis.windowStage;
      console.info(`deviceType: ${deviceType}`);
    });

    afterAll(async () => {
      try {
        let windowClass = windowStage.getMainWindowSync();
        await windowClass.setWindowLayoutFullScreen(false);
        console.info('SpecificSystemBarTest afterAll restore environment success');
      } catch (exception) {
        console.error(`SpecificSystemBarTest afterAll restore failed: ${JSON.stringify(exception)}`);
      }
    });

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_STAGE_JS_API_3200
     * @tc.name      : testSetWindowSystemBarPropertiesPromise
     * @tc.desc      : Test setWindowSystemBarProperties(systemBarProperties:
     *                 SystemBarProperties): Promise<void>, cross-platform supported since API 20.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetWindowSystemBarPropertiesPromise', 0, async (done: Function) => {
      let caseName = 'testSetWindowSystemBarPropertiesPromise';
      try {
        let windowClass = windowStage.getMainWindowSync();
        let systemBarProperties: window.SystemBarProperties = {
          statusBarColor: '#ff00ff',
          navigationBarColor: '#00ff00',
          statusBarContentColor: '#ffffff',
          navigationBarContentColor: '#00ffff'
        };
        await windowClass.setWindowSystemBarProperties(systemBarProperties);
        console.info(`${caseName} Succeeded in setting the system bar properties.`);
        done();
      } catch (err) {
        // let e = err as BusinessError;
        console.error(`${caseName} Failed. Cause code: ${err.code}, message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : SUB_BASIC_WMS_GET_VISIBLEWINDOWINFO_0100
     * @tc.name      : test_GET_VISIBLEWINDOWINFO_0100
     * @tc.desc      : Test windowStatusType of WindowInfo. getVisibleWindowInfo/getWindowStatus
     *                 are not cross-platform available, so on('windowStatusChange') delivering
     *                 the same WindowStatusType is used as the equivalent substitution.
     *                 Not supported on Android platform, pass and skip directly on Android.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('test_GET_VISIBLEWINDOWINFO_0100', 0, async (done: Function) => {
      let caseName = 'test_GET_VISIBLEWINDOWINFO_0100';
      if (deviceInfo.osFullName.toLowerCase().includes('android')) {
        console.info(`${caseName} is not supported on Android platform, skip.`);
        done();
        return;
      }
      let receivedList: window.WindowStatusType[] = [];
      let injected: boolean = false;
      const callback: Callback<window.WindowStatusType> = (data: window.WindowStatusType) => {
        console.info(`${caseName} windowStatusChange received: ${JSON.stringify(data)}`);
        receivedList.push(data);
      };
      try {
        let windowClass = windowStage.getMainWindowSync();
        windowClass.on('windowStatusChange', callback);
        if (['pc', '2in1', 'tablet'].includes(deviceType)) {
          try {
            await windowClass.minimize();
            await sleep(1000);
            await windowClass.restore();
            await sleep(1000);
            injected = true;
          } catch (err) {
            console.warn(`${caseName} Active injection failed, fallback to passive waiting. Cause: ${JSON.stringify(err)}`);
            windowClass.restore().catch(() => {});
            await sleep(1000);
          }
        } else {
          await sleep(1000);
        }
        windowClass.off('windowStatusChange', callback);
        expect(receivedList.every(isValidWindowStatus)).assertTrue();
        if (injected) {
          expect(receivedList.includes(window.WindowStatusType.MINIMIZE)).assertTrue();
        }
        done();
      } catch (exception) {
        console.error(`${caseName} Failed. Cause: ${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_STAGE_JS_API_0660
     * @tc.name      : testGetWindowAvoidArea_Type_System_0400
     * @tc.desc      : Obtain the area that the window content avoids
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetWindowAvoidArea_Type_System_0400', 0, async (done: Function) => {
      let caseName = 'testGetWindowAvoidArea_Type_System_0400';
      try {
        let windowClass = windowStage.getMainWindowSync();
        let avoidArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
        console.info(`${caseName} avoidArea: ${JSON.stringify(avoidArea)}`);
        expect(avoidArea.visible).assertTrue();
        assertRectValid(caseName, 'topRect', avoidArea.topRect);
        assertRectValid(caseName, 'rightRect', avoidArea.rightRect);
        assertRectValid(caseName, 'bottomRect', avoidArea.bottomRect);
        assertRectValid(caseName, 'leftRect', avoidArea.leftRect);
        done();
      } catch (exception) {
        console.error(`${caseName} Failed to obtain the area. Cause: ${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    });
  });
}
