/*
 * Copyright (C) 2024-2025 Huawei Device Co., Ltd.
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

export default function testStopVibration() {
  let osFullNameInfo: string = deviceInfo.osFullName;
  let isIOS: boolean = osFullNameInfo.includes('iOS');
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("testStopVibration", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('the value of the deviceInfo osFullName is :' + osFullNameInfo);
      console.info('isIOS:' + isIOS);
      console.info('testStopVibration Device type = ' + deviceInfo.deviceType);
      console.info('testStopVibration isAvailable = ' + isAvailable);
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
        console.error('testStopVibration exception :' + JSON.stringify(error));
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
    const PARAMETER_ERROR_CODE = 401
    const PARAMETER_ERROR_MSG = 'The parameter invalid.';

    /*
     * @tc.number:testStopVibrationFunc001
     * @tc.name: SUB_SensorSystem_Vibrator_EtsTest_2000
     * @tc.desc:Using the stopVibration (callback) method with VIBRATOR_STOP_MODE_TIME
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStopVibrationFunc001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc001";
      console.info(`--------${TAG}--------`);
      try {
        console.info(`${TAG} Attempting to stop vibration...`);
        vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_TIME,
          async (error: BusinessError) => {
          if (error) {
            console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(false).assertTrue();
            done();
          } else {
            console.info(`${TAG} Succeed in stopping vibration`);
            expect(true).assertTrue();
            done();
          }
        });
      } catch (err) {
        let e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.number:testStopVibrationFunc002
     * @tc.name: SUB_SensorSystem_Vibrator_EtsTest_2100
     * @tc.desc:Using the stopVibration (promise) method with VIBRATOR_STOP_MODE_TIME
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStopVibrationFunc002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc002";
      console.info(`--------${TAG}--------`);
      try {
        console.info(`${TAG} Attempting to stop vibration with VIBRATOR_STOP_MODE_TIME...`);
        await vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_TIME)
          .then(() => {
            console.info(`${TAG} Succeed in stopping vibration`);
            expect(true).assertTrue();
            done();
          })
          .catch(async (error: BusinessError) => {
            console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(false).assertTrue();
            done();
          });
      } catch (err) {
        let e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.number:testStopVibrationFunc003
     * @tc.name: SUB_SensorSystem_Vibrator_EtsTest_2200
     * @tc.desc:Using the stopVibration (callback) method with VIBRATOR_STOP_MODE_PRESET
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStopVibrationFunc003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc003";
      console.info(`--------${TAG}--------`);
      try {
        console.info(`${TAG} Attempting to stop vibration...`);
        vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_PRESET,async (error: BusinessError) => {
          if (error) {
            console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(false).assertTrue();
            done();
          } else {
            console.info(`${TAG} Succeed in stopping vibration`);
            expect(true).assertTrue();
            done();
          }
        });
      } catch (err) {
        let e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });


    /*
     * @tc.number:testStopVibrationFunc004
     * @tc.name: SUB_SensorSystem_Vibrator_EtsTest_2300
     * @tc.desc:Using the stopVibration (promise) method with VIBRATOR_STOP_MODE_PRESET
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStopVibrationFunc004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc004";
      console.info(`--------${TAG}--------`);
      try {
        console.info(`${TAG} Attempting to stop vibration with VIBRATOR_STOP_MODE_TIME...`);
        await vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_PRESET)
          .then(() => {
            console.info(`${TAG} Succeed in stopping vibration`);
            expect(true).assertTrue();
            done();
          })
          .catch(async (error: BusinessError) => {
            console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(false).assertTrue();
            done();
          });
      } catch (err) {
        let e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:testStopVibrationFunc005
    * @tc.desc:Verify the error handling when passing incorrect parameters to stopVibration interface.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_2400
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStopVibrationFunc005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const  TAG = "testStopVibrationFunc005";
      console.info(`--------${TAG}--------`);
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        console.info(`${TAG} Starting vibration...`);
        vibrator.startVibration(
          { type: "time", duration: 1000 },
          { usage: "unknown" },
          async (error: BusinessError) => {
            if (error) {
              console.error(`${TAG} Failed to start vibration. Code: ${error.code}, message: ${error.message}`);
              expect(false).assertTrue();
              done();
            }
            console.info(`${TAG} Vibration started successfully.`);
          }
        );
        console.info(`${TAG} Attempting to stop vibration...`);
        try {
          await vibrator.stopVibration({ deviceId: -1, vibratorId: -1 })
            .then(() => {
              console.info(`${TAG} Vibration stopped successfully.`);
              expect(true).assertTrue();
              done();
            })
            .catch(async (error: BusinessError) => {
              console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
              expect(false).assertTrue();
              done();
            });
        } catch (error) {
          const e: BusinessError = error as BusinessError;
          console.error(`${TAG} Unexpected error while stopping vibration. Code: ${e.code}, message: ${e.message}`);
          expect(false).assertTrue();
          done();
        }
      } catch (error) {
        console.error(`${TAG} Test failed with error: ${JSON.stringify(error)}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
    * @tc.name:testStopVibrationFunc006
    * @tc.desc:Verify the error handling when passing incorrect parameters to stopVibration interface.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_2500
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStopVibrationFunc006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc006";
      console.info(`--------${TAG}--------`);
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        await (vibrator.stopVibration as (param?: vibrator.VibratorInfoParam) => Promise<void>)().then(() => {
          console.info(`${TAG} Succeed in stopping vibration`);
          expect(true).assertTrue();
          done();
        }).catch((error: BusinessError) => {
          console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
          expect(false).assertTrue()
          done();
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done();
      }
    });
    /*
     * @tc.number:testStopVibrationFunc007
     * @tc.name: SUB_SensorSystem_Vibrator_EtsTest_2600
     * @tc.desc:Using the stopVibration (promise) method without permission
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStopVibrationFunc007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc007";
      console.info(`--------${TAG}--------`);
      try {
        console.info(`${TAG} Attempting to stop vibration...`);
        await vibrator.stopVibration()
          .then(() => {
            console.info(`${TAG} Succeed in stopping vibration`);
            expect(true).assertTrue();
            done();
          })
          .catch(async  (error: BusinessError) => {
            console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(false).assertTrue();
            done();
          });
      } catch (err) {
        let e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.number:testStopVibrationFunc008
     * @tc.name: SUB_SensorSystem_Vibrator_EtsTest_2700
     * @tc.desc:Using the stopVibration (callback) method without permission
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStopVibrationFunc008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc008";
      console.info(`--------${TAG}--------`);
      try {
        console.info(`${TAG} Attempting to stop all vibrations...`);

        vibrator.stopVibration(async (error: BusinessError) => {
          if (error) {
            console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(false).assertTrue();
            done();
          } else {
            console.info(`${TAG} Succeed in stopping vibration`);
            expect(true).assertTrue();
            done();
          }
        });
      } catch (error) {
        let e: BusinessError = error as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.number:testStopVibrationFunc009
     * @tc.name: SUB_SensorSystem_Vibrator_EtsTest_2800
     * @tc.desc:Using the stopVibration (callback) method without permission
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStopVibrationFunc009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStopVibrationFunc009";
      console.info(`--------${TAG}--------`);
      try {
        console.info(`${TAG} Attempting to stop vibration synchronously...`);

        try {
          vibrator.stopVibrationSync();
          console.info(`${TAG} Succeed in stopping vibration synchronously`);
          expect(true).assertTrue();
          done();
        } catch (error) {
          console.error(`${TAG} Failed to stop vibration synchronously. Error: ${JSON.stringify(error)}`);
          expect(false).assertTrue();
          done();
        }
      } catch (error) {
        let e: BusinessError = error as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:testStopVibrationFunc010
    * @tc.desc:Verify the error handling when passing incorrect parameters to stopVibration interface.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_2900
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStopVibrationFunc010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const TAG = "testStopVibrationFunc010";
      console.info(`--------${TAG}--------`);
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        console.info(`${TAG} Starting vibration with duration 1000ms...`);
        await vibrator.startVibration({
          type: "time",
          duration: 1000,
        }, {
          usage: "unknown"
        }).then(() => {
          console.info(`${TAG}successfully started vibration`);
        }).catch((error: BusinessError) => {
          console.error(`${TAG} error: Code ${error.code}, Message: ${error.message}`);
          expect(false).assertTrue();
          done();
        });
        console.info(`${TAG} Attempting to stop vibration with VIBRATOR_STOP_MODE_TIME...`);
        vibrator.stopVibration("1" as vibrator.VibratorStopMode, (error: BusinessError) => {
          if (error) {
            console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
            expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
            done();
          } else {
            console.info(`${TAG} Vibration stopped successfully`);
            expect(false).assertTrue();
            done();
          }
        });
      } catch (error) {
        console.error(`${TAG} Test failed with error: ${JSON.stringify(error)}`);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        done();
      }
    });
  })
}