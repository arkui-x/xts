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
import resourceManager from '@ohos.resourceManager';
import hilog from '@ohos.hilog';

const DOMAIN: number = 0xF811;

export class Logger {
  private prefix: string;
  private format: string = '%{public}s, %{public}s';

  constructor(prefix: string) {
    this.prefix = prefix;
  }

  debug(...args: string[]): void {
    hilog.debug(DOMAIN, this.prefix, this.format, args);
  }

  info(...args: string[]): void {
    hilog.info(DOMAIN, this.prefix, this.format, args);
  }

  warn(...args: string[]): void {
    hilog.warn(DOMAIN, this.prefix, this.format, args);
  }

  error(...args: string[]): void {
    hilog.error(DOMAIN, this.prefix, this.format, args);
  }
}
let logger = new Logger('Vibrator_star_normal');

export default function Vibrator_star_noparam() {
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("Vibrator_star_noparam", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('Vibrator_star_noparam Device type = ' + deviceInfo.deviceType);
      console.info('Vibrator_star_noparam isAvailable = ' + isAvailable);
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
        console.error('Vibrator_star_noparam exception :' + JSON.stringify(error));
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
    /*
     * @tc.name:testStartVibrationFunc014
     * @tc.desc: Verify the behavior when passing null parameters to vibrator.startVibration interface.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1400
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc014", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const TAG = "testStartVibrationFunc014";
      console.info(`${TAG} Start testing vibrator.startVibration with null parameters.`);
      try {
        vibrator.startVibration(null, null);
        console.error(`${TAG} Unexpected success: vibrator.startVibration(null, null) did not throw an error.`);
        expect(false).assertTrue();
        done();
      } catch (error) {
        console.info(`${TAG} Expected error caught:`, error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
    /*
     * @tc.name:testStartVibrationFunc015
     * @tc.desc: Verify the error handling when passing empty effectId with preset type.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1500
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc015", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        vibrator.startVibration({
          type: "preset",
          effectId: "",
          count: 3,
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          if (error) {
            console.info('testStartVibrationFunc015 vibrator error');
            expect(true).assertTrue();
            done();
          } else {
            console.info('testStartVibrationFunc015 vibrator success');
            vibrator.stopVibration();
            expect(false).assertTrue();
            done();
          }
        });
      } catch (error) {
        console.info(error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });

    /*
     * @tc.name:testStartVibrationFunc016
     * @tc.desc: Verify the error handling when passing empty effectId with preset type.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1600
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc016", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const TAG = "testStartVibrationFunc016";
      console.info(`${TAG} Start testing vibrator.startVibration with negative duration.`);
      try {
        await vibrator.startVibration({
          type: "time",
          duration: -1,
        }, {
          usage: "unknown"
        }).then(() => {
          console.error(`${TAG} Unexpected success: vibrator.startVibration did not throw an error.`);
          expect(false).assertTrue();
          vibrator.stopVibration();
          done();
        }).catch((error: BusinessError) => {
          console.info(`${TAG} Expected error caught:`, error);
          expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
          expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
          setTimeout(() => {
            done();
          }, 500);
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An expected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(err.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(err.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });

    /*
     * @tc.name:testStartVibrationFunc017
     * @tc.desc: Verify the error handling when passing empty effectId with preset type.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1700
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc017", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const TAG = "testStartVibrationFunc017";
      try {
        await vibrator.startVibration({
          type: "preset",
          effectId: "",
          count: 3,
        }, {
          usage: "unknown"
        }).then(() => {
          console.info(`${TAG} success`);
          expect(false).assertTrue();
          vibrator.stopVibration();
          done();
        }).catch((error: BusinessError) => {
          console.error(`${TAG} error: Code ${error.code}, Message: ${error.message}`);
          expect(true).assertTrue();
          expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
          expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
          setTimeout(() => {
            done();
          }, 500);
        });
      } catch (error) {
        const e: BusinessError = error as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(e.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(e.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });

    /*
     * @tc.name:testStartVibrationFunc018
     * @tc.desc: Verify the error handling when passing empty effectId with preset type.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1800
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc018", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      try {
        vibrator.startVibration({
          type: "preset",
          effectId: "",
          count: 3,
        }, {
          id: null,
          usage: "unknown"
        }, async (error: BusinessError) => {
          if (error) {
            console.info("testStartVibrationFunc018 vibrator error" + error);
            expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
            expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
            setTimeout(() => {
              done();
            }, 500);
          } else {
            console.info("testStartVibrationFunc018 vibrator success");
            vibrator.stopVibration();
            expect(false).assertTrue();
            done();
          }
        });
      } catch (error) {
        console.info(error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });

    /*
    * @tc.name:testStartVibrationFunc019
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_6400
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc019", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await vibrator.startVibration({
          type: "time",
          duration: -1,
        }, {
          usage: "unknown"
        }).then(() => {
          console.info("testStartVibrationFunc019 success");
          vibrator.stopVibration();
          expect(false).assertTrue();
          done();
        }).catch((error: BusinessError) => {
          console.info("testStartVibrationFunc019 error :" + error);
          expect(true).assertTrue();
          setTimeout(() => {
            done();
          }, 500);
        });
      } catch (error) {
        console.info("testStartVibrationFunc019 catch error :" + error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
    /*
    * @tc.name:testStartVibrationFunc021
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_3700
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc021", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      let TAG = "testStartVibrationFunc021";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 99,
          frequency: 99
        };
        builder.addContinuousEvent(0, 8000, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
      try {
        vibrator.startVibration({
          type: "pattern",
          pattern: builder.build()
        }, {
          usage: "alarm",
          systemUsage: false
        }, async (error: BusinessError) => {
          if (error) {
            console.info(TAG + " vibrate fail:" + JSON.stringify(error));
            expect(false).assertTrue();
            done();
          } else {
            console.info(TAG + " vibrate success");
            vibrator.stopVibration();
            expect(true).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (error) {
        console.info("testStartVibrationFunc021 catch error :" + error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
    /*
    * @tc.name:testStartVibrationFunc025
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_6400
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc025", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      const TAG = "testStartVibrationFunc025";
      try {
        let rawFd: resourceManager.RawFileDescriptor | undefined = undefined
        await getContext().resourceManager.getRawFd("file_test.json").then((value) => {
          rawFd = value;
          logger.info(
            TAG,
            `rawFd of vibration: fd:${rawFd.fd}, offset:${rawFd.offset}, length:${rawFd.length}`
          );
        });
        console.info(`${TAG} RawFileDescriptor: ${JSON.stringify(rawFd)}`);
        vibrator.startVibration(
          {
            type: "file",
            hapticFd: { fd: -444, offset: 2, length: -10 }
          },
          {
            id: 0,
            usage: 'alarm'
          },
          (error: BusinessError) => {
            if (error) {
              console.error(`${TAG} Failed to start vibration: ${error.message}, code: ${error.code}`);
              expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
              expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} Vibration started successfully`);
              vibrator.stopVibration();
              expect(false).assertTrue();
              done();
            }
          }
        );
      } catch (error) {
        console.error(`${TAG} Error during test execution: ${error.message}, code: ${error.code}`);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
    /*
    * @tc.name:testStartVibrationFunc026
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_6500
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc026", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await vibrator.startVibration({
          type: "time",
          duration: 18000001,
        }, {
          usage: "unknown"
        }).then(() => {
          console.info("testStartVibrationFunc026 success");
          vibrator.stopVibration();
          expect(false).assertTrue();
          done();
        }).catch((error: BusinessError) => {
          console.info("testStartVibrationFunc026 error :" + error);
          expect(true).assertTrue();
          setTimeout(() => {
            done();
          }, 500);
        });
      } catch (error) {
        console.info("testStartVibrationFunc026 catch error :" + error);
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        expect(error.message).assertEqual(PARAMETER_ERROR_MSG);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
  })
}
