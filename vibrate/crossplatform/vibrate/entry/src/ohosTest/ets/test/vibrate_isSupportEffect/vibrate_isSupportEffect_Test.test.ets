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

export default function vibrate_isSupportEffect_Test() {
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("vibrate_isSupportEffect_Test", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('vibrate_isSupportEffect_Test Device type = ' + deviceInfo.deviceType);
      console.info('vibrate_isSupportEffect_Test isAvailable = ' + isAvailable);
      try {
        const vibratorsList = vibrator.getVibratorInfoSync();
        if (ABILITYJUDGMENT === false || vibratorsList.length === 0 ||
          (vibratorsList.length !== 0 && vibratorsList.every(vibrator => !vibrator.isLocalVibrator))) {
          isAvailable = false;
          console.info('vibrate_isSupportEffect_Test isAvailable ' + isAvailable);
          done();
        } else {
          isAvailable = true;
          console.info('vibrate_isSupportEffect_Test isAvailable ' + isAvailable);
          done();
        }
      } catch (error) {
        console.error('vibrate_isSupportEffect_Test exception :' + JSON.stringify(error));
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
    const PARAMETER_ERROR_CODE = 401;
    const PARAMETER_ERROR_MSG = 'The parameter invalid.';
    let EFFECT_ID=vibrator.EffectId.EFFECT_CLOCK_TIMER;
    let INVALID_EFFECT_ID = "haptic.xxx.yyy";

    /*
     * @tc.name:UniversalVibratorEtsTest011
     * @tc.desc:Verify isSupportEffect returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_1100
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const TAG = "UniversalVibratorEtsTest011";
      try {
        vibrator.isSupportEffect(INVALID_EFFECT_ID, async (error: BusinessError, state: boolean) => {
          if (error) {
            console.error(`${TAG} Error checking support for effect: Code ${error.code}, Message: ${error.message}`);
            expect(false).assertTrue();
            done();
            return;
          }
          console.info(`${TAG} Effect support check completed. State: ${state}`);
          expect(!state).assertTrue();
          done();
        });
      } catch (error) {
        expect(false).assertTrue();
        done();
        return;
      }
    });
    /*
     * @tc.name:UniversalVibratorEtsTest012
     * @tc.desc:Verify isSupportEffect returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_1200
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest012", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "UniversalVibratorEtsTest012";
      try {
          vibrator.isSupportEffect(EFFECT_ID, async (error: BusinessError, state: boolean) => {
            if (error) {
              console.error(`${TAG} isSupportEffect error: ${error.message}`);
              expect(false).assertTrue();
              done();
            } else {
              console.info(`${TAG} Effect support check completed. State: ${state}`);
              expect(state).assertTrue();
              done();
            }
          });
      } catch (error) {
        console.error(`${TAG} isSupportEffect error: ${JSON.stringify(error)}`);
        expect(false).assertTrue();
        done();
      }
      done();
    });
    /*
     * @tc.name:UniversalVibratorEtsTest013
     * @tc.desc:Verify isSupportEffect returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_1300
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest013", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "UniversalVibratorEtsTest013";
      let isSupport = false;
      try {
        isSupport = await vibrator.isSupportEffect(EFFECT_ID)
        console.info(`${TAG} Effect support check completed. State: ${isSupport}`);
        expect(isSupport).assertTrue();
      } catch (error) {
        console.error(`${TAG} isSupportEffect error: ${JSON.stringify(error)}`);
        expect(false).assertTrue();
        done();
      }
      if (!isSupport) {
        console.log(`${TAG} effect ${EFFECT_ID} is not supported.`);
        done();
      }
      try {
        vibrator.startVibration({
          type: "preset",
          effectId: EFFECT_ID,
          count: 1,
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          if (error) {
            console.error(`${TAG} startVibration error: ${error.message}`);
            expect(false).assertTrue();
          } else {
            console.log(`${TAG} startVibration success`);
            expect(true).assertTrue();
          }
        });
      } catch (error) {
        expect(false).assertTrue();
        done();
      }
      try {
        vibrator.stopVibration(async (error: BusinessError) => {
          if (error) {
            console.error(`${TAG} stopVibration error: ${error.message}`);
            done();
          } else {
            console.log(`${TAG} stopVibration success`);
            expect(true).assertTrue();
            done();
          }
        });
      } catch (error) {
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:UniversalVibratorEtsTest014
     * @tc.desc:Verify isSupportEffect returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_1400
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest014", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "UniversalVibratorEtsTest014";
      vibrator.isSupportEffect(INVALID_EFFECT_ID).then((state) => {
        expect(!state).assertTrue();
      }, async (error: BusinessError) => {
        console.error(TAG + ' isSupportEffect error: ' + error.message);
        expect(false).assertTrue();
      });
      done();
    });
    /*
     * @tc.name:UniversalVibratorEtsTest015
     * @tc.desc:Verify isSupportEffect returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_1500
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest015", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const TAG = "UniversalVibratorEtsTest015";
      const unsupportedEffectId = "undefined";

      try {
        console.info(`${TAG} Checking support for effect: ${unsupportedEffectId}`);
        const isSupported = await vibrator.isSupportEffect(undefined);

        console.info(`${TAG} Effect ${unsupportedEffectId} is supported: ${isSupported}`);
        expect(isSupported).assertFalse();
        done();
      } catch (error) {
        console.info(`${TAG} Expected error caught:`, error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        done();
      }
    });
    /*
     * @tc.name:UniversalVibratorEtsTest016
     * @tc.desc:Verify isSupportEffect returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_1600
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest016", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const TAG = "UniversalVibratorEtsTest016";
      const unsupportedEffectId = "null";

      try {
        console.info(`${TAG} Checking support for effect: ${unsupportedEffectId}`);
        const isSupported = await vibrator.isSupportEffect(null);

        console.info(`${TAG} Effect ${unsupportedEffectId} is supported: ${isSupported}`);
        expect(isSupported).assertFalse();
        done();
      } catch (error) {
        console.info(`${TAG} Expected error caught:`, error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        done();
      }
    });
  })
}
