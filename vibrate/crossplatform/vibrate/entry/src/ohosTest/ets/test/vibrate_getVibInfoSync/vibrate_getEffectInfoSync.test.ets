/*
 * Copyright (C) 2021-2025 Huawei Device Co., Ltd.
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


export default function vibrate_getEffectInfoSync() {
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("vibrate_getEffectInfoSync", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('vibrate_getEffectInfoSync Device type = ' + deviceInfo.deviceType);
      console.info('vibrate_getEffectInfoSync isAvailable = ' + isAvailable);
      try {
        const vibratorsList = vibrator.getVibratorInfoSync();
        if (ABILITYJUDGMENT === false || vibratorsList.length === 0 ||
          (vibratorsList.length !== 0 && vibratorsList.every(vibrator => !vibrator.isLocalVibrator))) {
          isAvailable = false;
          console.info('vibrate_getEffectInfoSync isAvailable ' + isAvailable);
          done();
        } else {
          isAvailable = true;
          console.info('vibrate_getEffectInfoSync isAvailable ' + isAvailable);
          done();
        }
      } catch (error) {
        console.error('vibrate_getEffectInfoSync exception :' + JSON.stringify(error));
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
    * @tc.name:testGetInfoSyncFunc001
    * @tc.desc:Verify getEffectInfoSync returns correct support status when passing invalid vibrator parameters.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4000
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testGetInfoSyncFunc001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "testGetInfoSyncFunc001";
        try {
          const effectId = "haptic.clock.timer";
          const vibratorInfoParam:vibrator.VibratorInfoParam = {
            deviceId: -1,
            vibratorId: -1
          };
          const jsEffectInfo = vibrator.getEffectInfoSync(effectId, vibratorInfoParam);
          console.info(TAG + " jsEffectInfo.isEffectSupported:" + jsEffectInfo.isEffectSupported);
          if (!jsEffectInfo.isEffectSupported) {
            console.info(TAG + 'is not supported on this device.');
            expect(false).assertTrue();
            done();
            return;
          } else {
            expect(jsEffectInfo.isEffectSupported).assertTrue();
            done();
          }
        } catch (error) {
          console.info(TAG + " getEffectInfoSync error: " + JSON.stringify(error));
          expect(false).assertTrue();
          done();
        }
        console.info(TAG + " end");
    });
    /*
    * @tc.name:testGetInfoSyncFunc002
    * @tc.desc:Verify getEffectInfoSync returns correct support status when passing invalid vibrator parameters.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4100
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testGetInfoSyncFunc002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "testGetInfoSyncFunc002";
        try {
          const effectId = "haptic.clock.timer";
          const jsEffectInfo = vibrator.getEffectInfoSync(effectId);
          console.info(TAG + " jsEffectInfo.isEffectSupported:" + jsEffectInfo.isEffectSupported);
          if (!jsEffectInfo.isEffectSupported) {
            console.info(TAG + 'is not supported on this device.');
            expect(jsEffectInfo.isEffectSupported).assertTrue();
            done();
            return;
          } else {
            expect(jsEffectInfo.isEffectSupported).assertTrue();
            done();
          }
        } catch (error) {
          console.info(TAG + " getEffectInfoSync error: " + JSON.stringify(error));
          expect(false).assertEqual(true);
          done();
        }
    });
    /*
    * @tc.name:testGetInfoSyncFunc003
    * @tc.desc:Verify getEffectInfoSync returns correct support status when passing invalid vibrator parameters.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4200
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testGetInfoSyncFunc003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "testGetInfoSyncFunc003";
        try {
          const ineffectId = "invalidEffectId";
          const jsEffectInfo = vibrator.getEffectInfoSync(ineffectId);
          console.info(TAG + " jsEffectInfo.isEffectSupported:" + jsEffectInfo.isEffectSupported);
          expect(jsEffectInfo.isEffectSupported).assertFalse();
          done();
        } catch (error) {
          console.info(TAG + " getEffectInfoSync error: " + JSON.stringify(error));
          expect(false).assertEqual(true);
          done();
        }
    });
    /*
    * @tc.name:testGetInfoSyncFunc004
    * @tc.desc:Verify getEffectInfoSync returns correct support status when passing invalid vibrator parameters.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4300
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testGetInfoSyncFunc004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "testGetInfoSyncFunc004";
        try {
          const ineffectId = "invalidEffectId";
          const jsEffectInfo = vibrator.getEffectInfoSync(ineffectId,{deviceId:-1,vibratorId:-1});
          console.info(TAG + " jsEffectInfo.isEffectSupported:" + jsEffectInfo.isEffectSupported);
          expect(jsEffectInfo.isEffectSupported).assertFalse();
          done();
        } catch (error) {
          console.info(TAG + " getEffectInfoSync error: " + JSON.stringify(error));
          expect(false).assertEqual(true);
          done();
        }
    });
  })
}
