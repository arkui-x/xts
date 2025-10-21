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

export default function Vibrator_isHdHapticSupported() {
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("Vibrator_isHdHapticSupported", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('Vibrator_isHdHapticSupported Device type = ' + deviceInfo.deviceType);
      console.info('Vibrator_isHdHapticSupported isAvailable = ' + isAvailable);
      try {
        const vibratorsList = vibrator.getVibratorInfoSync();
        if (ABILITYJUDGMENT === false || vibratorsList.length === 0 ||
          (vibratorsList.length !== 0 && vibratorsList.every(vibrator => !vibrator.isLocalVibrator))) {
          isAvailable = false;
          console.info('Vibrator_isHdHapticSupported isAvailable ' + isAvailable);
          done();
        } else {
          isAvailable = true;
          console.info('Vibrator_isHdHapticSupported isAvailable ' + isAvailable);
          done();
        }
      } catch (error) {
        console.error('Vibrator_isHdHapticSupported exception :' + JSON.stringify(error));
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
    /*
    * @tc.name:testisHdHapticSupportedFunc001
    * @tc.desc: Verify that the return value type of the vibrator.isHdHapticSupported() interface meets expectations (should be a boolean type)
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5400
    * @tc.level:Level 0
    * @tc.type:Function
    * @tc.size:MediumTest
    */
      it("testisHdHapticSupportedFunc001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done :Function) => {
        let TAG = "testisHdHapticSupportedFunc001"
        console.info(TAG + ' isAvailable ' + isAvailable);
          try {
            console.info(TAG + " vibrator.isHdHapticSupported()");
            expect(typeof(vibrator.isHdHapticSupported())).assertEqual("boolean");
            done();
          } catch (error) {
            console.info(TAG + " exception in, err:" + error);
            expect(true).assertEqual(false);
            done();
          }
      });

  })
}


