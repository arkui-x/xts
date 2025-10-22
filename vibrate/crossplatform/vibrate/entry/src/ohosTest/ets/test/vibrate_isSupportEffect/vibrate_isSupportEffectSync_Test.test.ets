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

export default function vibrate_isSupportEffectSync_Test() {
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("vibrate_isSupportEffectSync_Test", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('vibrate_isSupportEffect_normal Device type = ' + deviceInfo.deviceType);
      console.info('vibrate_isSupportEffect_normal isAvailable = ' + isAvailable);
      try {
        const vibratorsList = vibrator.getVibratorInfoSync();
        if (ABILITYJUDGMENT === false || vibratorsList.length === 0 ||
          (vibratorsList.length !== 0 && vibratorsList.every(vibrator => !vibrator.isLocalVibrator))) {
          isAvailable = false;
          console.info('vibrate_isSupportEffect_normal isAvailable ' + isAvailable);
          done();
        } else {
          isAvailable = true;
          console.info('vibrate_isSupportEffect_normal isAvailable ' + isAvailable);
          done();
        }
      } catch (error) {
        console.error('vibrate_isSupportEffect_normal exception :' + JSON.stringify(error));
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
    const EFFECT_IDSUCCESS = "haptic.notice.success";
    const EFFECT_IDFAIL = "haptic.notice.fail";
    const EFFECT_IDWARNING = "haptic.notice.warning";
    const EFFECT_IDSOFT = "haptic.effect.soft";
    const EFFECT_IDHARD = "haptic.effect.hard";
    const EFFECT_IDSHARP = "haptic.effect.sharp";
    const  EFFECT_CLOCK_TIMER='haptic.clock.timer';
    const  INVALID_EFFECT_ID = "haptic.xxx.yyy";
    const PARAMETER_ERROR_CODE = 401;
    const PARAMETER_ERROR_MSG = 'The parameter invalid.';
    let TAG = "";
    /*
     * @tc.name:UniversalVibratorEtsTest001
     * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0100
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "UniversalVibratorEtsTest001";
      try {
        let ret = vibrator.isSupportEffectSync(EFFECT_IDSUCCESS);
        console.info(TAG + "ret:" + ret);
        expect(ret).assertTrue();
        done();
      }catch (error) {
        console.error(TAG + "error:" + JSON.stringify(error));
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:UniversalVibratorEtsTest002
     * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0200
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "UniversalVibratorEtsTest002";
      try {
        let ret = vibrator.isSupportEffectSync(EFFECT_IDFAIL);
        console.info(TAG + "ret:" + ret);
        expect(ret).assertTrue();
        done();
      }catch (error) {
        console.error(TAG + "error:" + JSON.stringify(error));
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:UniversalVibratorEtsTest003
     * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0300
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      TAG = "UniversalVibratorEtsTest003";
      try {
        let ret = vibrator.isSupportEffectSync(EFFECT_IDWARNING);
        console.info(TAG + "ret:" + ret);
        expect(ret).assertTrue();
        done();
      }catch (error) {
        console.error(TAG + "error:" + JSON.stringify(error));
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.name:UniversalVibratorEtsTest004
     * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
     * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0400
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("UniversalVibratorEtsTest004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      TAG = 'UniversalVibratorEtsTest004';

      let ret = vibrator.isSupportEffectSync(EFFECT_IDSOFT );
      console.info(TAG + "ret:" + ret);
      expect(ret).assertTrue();
      if (ret) {
        vibrator.startVibration({
          type: "preset",
          effectId: EFFECT_IDSOFT ,
          count: 1,
          intensity: 50,
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          if (error) {
            console.info(TAG + ' vibrator error');
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          } else {
            console.info(TAG + ' vibrator success');
            expect(true).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } else {
        console.info(TAG + ' This device is not supportEffect haptic.effect.soft');
        expect(true).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:UniversalVibratorEtsTest005
    * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
    * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0500
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("UniversalVibratorEtsTest005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      TAG = 'UniversalVibratorEtsTest005';
      let ret = vibrator.isSupportEffectSync(EFFECT_IDHARD);
      console.info(TAG + "ret:" + ret);
      expect(ret).assertTrue();
      if (ret) {
        vibrator.startVibration({
          type: "preset",
          effectId: EFFECT_IDHARD,
          count: 1,
          intensity: 50,
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          if (error) {
            console.info(TAG + ' vibrator error');
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          } else {
            console.info(TAG + ' vibrator success');
            expect(true).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } else {
        console.info(TAG + ' This device is not supportEffect haptic.effect.hard');
        expect(true).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:UniversalVibratorEtsTest006
    * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
    * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0600
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("UniversalVibratorEtsTest006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      TAG = 'UniversalVibratorEtsTest006';
      let ret = vibrator.isSupportEffectSync(EFFECT_IDSHARP);
      console.info(TAG + "ret:" + ret);
      expect(ret).assertTrue();
      if (ret) {
        vibrator.startVibration({
          type: "preset",
          effectId: EFFECT_IDSHARP,
          count: 1,
          intensity: 50,
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          if (error) {
            console.info(TAG + ' vibrator error');
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          } else {
            console.info(TAG + ' vibrator success');
            expect(true).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } else {
        console.info(TAG + ' This device is not supportEffect haptic.effect.sharp');
        expect(true).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:UniversalVibratorEtsTest007
    * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
    * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0700
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("UniversalVibratorEtsTest007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      TAG = 'UniversalVibratorEtsTest007';
      let ret = vibrator.isSupportEffectSync(EFFECT_CLOCK_TIMER);
      console.info(TAG + "ret:" + ret);
      expect(ret).assertTrue();
      if (ret) {
        vibrator.startVibration({
          type: "preset",
          effectId: "haptic.effect.sharp",
          count: 1,
          intensity: 50,
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          if (error) {
            console.info(TAG + ' vibrator error');
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          } else {
            console.info(TAG + ' vibrator success');
            expect(true).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } else {
        console.info(TAG + ' This device is not supportEffect  haptic.clock.timer');
        expect(true).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:UniversalVibratorEtsTest008
    * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
    * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0800
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("UniversalVibratorEtsTest008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      TAG = 'UniversalVibratorEtsTest008';
      try {
        let ret = vibrator.isSupportEffectSync(null);
        expect(ret).assertFalse();
        done();
      } catch (error) {
        console.info(TAG +"catch error :" + error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        done();
      }
    });
    /*
    * @tc.name:UniversalVibratorEtsTest009
    * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
    * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_0900
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("UniversalVibratorEtsTest009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      TAG = 'UniversalVibratorEtsTest009';
      try {
        let ret = vibrator.isSupportEffectSync(undefined);
        expect(ret).assertFalse();
        done();
      } catch (error) {
        console.info(TAG +"catch error :" + error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        done();
      }
    });
    /*
    * @tc.name:UniversalVibratorEtsTest010
    * @tc.desc:Verify isSupportEffectSync returns correct state when passing invalid effectId parameter.
    * @tc.number:SUB_SensorSystem_SmallComponentService_Miscdevice_UniversalVibration_1000
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("UniversalVibratorEtsTest010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      TAG = 'UniversalVibratorEtsTest010';
      try {
        let ret = vibrator.isSupportEffectSync(INVALID_EFFECT_ID);
        expect(ret).assertFalse();
        done();
      } catch (error) {
        console.info(TAG +"catch error :" + error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        done();
      }
    });
  })
}
