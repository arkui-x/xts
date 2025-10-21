/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
import vibrator from '@ohos.vibrator'
import deviceInfo from '@ohos.deviceInfo'
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium'
import { BusinessError } from '@ohos.base';


export default function vibrate_getVibratorInfoSync() {
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("vibrate_getVibratorInfoSync", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('vibrate_getVibratorInfoSync Device type = ' + deviceInfo.deviceType);
      console.info('vibrate_getVibratorInfoSync isAvailable = ' + isAvailable);
      try {
        const vibratorsList = vibrator.getVibratorInfoSync();
        if (ABILITYJUDGMENT === false || vibratorsList.length === 0 ||
          (vibratorsList.length !== 0 && vibratorsList.every(vibrator => !vibrator.isLocalVibrator))) {
          isAvailable = false;
          console.info('Vibtate_PatternBuilder isAvailable ' + isAvailable);
          done();
        } else {
          isAvailable = true;
          console.info('Vibtate_PatternBuilder isAvailable ' + isAvailable);
          done();
        }
      } catch (error) {
        console.error('VibratorJsTest_misc_7 exception :' + JSON.stringify(error));
        done();
      }
    });
    afterAll(() => {
      console.info('afterAll called');
    });
    beforeEach(() => {
      console.info('beforeEach called');
    });
    afterEach(async () => {
      console.info('afterEach called');
    });
    let TAG = "";

    /*
    * @tc.name:testGetInfoSyncFunc005
    * @tc.desc:Verify getVibratorInfoSync returns correct support status when passing invalid vibrator parameters.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5500
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testGetInfoSyncFunc005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "testGetInfoSyncFunc005";
        try {
          const vibrators = vibrator.getVibratorInfoSync();
          expect(vibrators[0].deviceId >= -1).assertEqual(true);
          console.info(TAG + " getVibratorInfoSync deviceId:" + vibrators[0].deviceId);
          console.info(TAG + " getVibratorInfoSync vibratorId:" + vibrators[0].vibratorId);
          console.info(TAG + " getVibratorInfoSync deviceName:" + vibrators[0].deviceName);
          console.info(TAG + " getVibratorInfoSync isHdHapticSupported:" + vibrators[0].isHdHapticSupported);
          console.info(TAG + " getVibratorInfoSync isLocalVibrator:" + vibrators[0].isLocalVibrator);
          const freshVibratorsData = vibrator.getVibratorInfoSync();
          expect(freshVibratorsData[0].deviceId >= -1).assertEqual(true);
          expect(vibrators[0].deviceId === freshVibratorsData[0].deviceId).assertEqual(true);
          done();
        } catch (error) {
          console.info(TAG + " getVibratorInfoSync error: " + JSON.stringify(error));
          expect(false).assertEqual(true);
          done();
        }
        console.info(TAG + " end");
    });

    /*
    * @tc.name:testGetInfoSyncFunc006
    * @tc.desc:Verify getVibratorInfoSync returns correct support status when passing invalid vibrator parameters.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5600
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testGetInfoSyncFunc006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "testGetInfoSyncFunc006";
        try {
          const vibratorInfoParam:vibrator.VibratorInfoParam = {
            deviceId: -1,
            vibratorId: -1
          };
          const vibrators = vibrator.getVibratorInfoSync(vibratorInfoParam);
          expect(vibrators[0].deviceId >= -1).assertEqual(true);
          console.info(TAG + " getVibratorInfoSync deviceId:" + vibrators[0].deviceId);
          console.info(TAG + " getVibratorInfoSync vibratorId:" + vibrators[0].vibratorId);
          console.info(TAG + " getVibratorInfoSync deviceName:" + vibrators[0].deviceName);
          console.info(TAG + " getVibratorInfoSync isHdHapticSupported:" + vibrators[0].isHdHapticSupported);
          console.info(TAG + " getVibratorInfoSync isLocalVibrator:" + vibrators[0].isLocalVibrator);
          const freshVibratorsData = vibrator.getVibratorInfoSync();
          expect(freshVibratorsData[0].deviceId >= -1).assertEqual(true);
          expect(vibrators[0].deviceId === freshVibratorsData[0].deviceId).assertEqual(true);
          done();
        } catch (error) {
          console.info(TAG + " getVibratorInfoSync error: " + JSON.stringify(error));
          expect(false).assertEqual(true);
          done();
        }
        console.info(TAG + " end");
    });

  })
}
