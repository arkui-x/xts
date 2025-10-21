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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import vibrator from '@ohos.vibrator';
import deviceInfo from '@ohos.deviceInfo';

const PERMISSION_DENIED_CODE = 201
const  EFFECT_ID=vibrator.EffectId.EFFECT_CLOCK_TIMER;

export default function vibrator_nop_Test() {
  let osFullNameInfo: string = deviceInfo.osFullName;
  let isIOS: boolean = osFullNameInfo.includes('iOS');
  describe('SensorTest_vibrator_1_nop', () => {
    beforeAll(async () => {
      console.info('the value of the deviceInfo osFullName is :' + osFullNameInfo);
      console.info('isIOS:' + isIOS);
      console.info('vibrator module:', vibrator.getVibratorInfoSync());
    });
    beforeEach(() => {
    })
    afterEach(async () => {
    })
    afterAll(() => {
    })

    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test001
     * @tc.name: Vibrator_Sensor_nop_Test001
     * @tc.desc:Using the startVibration (callback) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test001--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        vibrator.startVibration({
          type: 'time',
          duration: 1000,
        }, {
          id: 0,
          usage: 'alarm'
        }, async (error: BusinessError) => {
          if (error) {
            console.error(`Failed to start vibration. Code: ${error.code}, message: ${error.message}`);
            expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
            done();
          } else {
            console.info('Succeed in starting vibration');
            expect(false).assertTrue();
            done();
          }
        });
        setTimeout(() => {
          done();
        }, 1200);
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done();
      }
    });


    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test002
     * @tc.name: Vibrator_Sensor_nop_Test001
     * @tc.desc:Using the startVibration (promise) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test002--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      const TAG = "Vibrator_Sensor_nop_Test002";
      try {
        await vibrator.startVibration({
          type: 'time',
          duration: 1000
        }, {
          id: 0,
          usage: 'alarm'
        }).then(
          async () => {
            console.error(`${TAG} Unexpected success without permission`);
            expect(false).assertTrue();
            done();
          },
          async (error: BusinessError) => {
            if (error) {
              console.error(`Failed to start vibration. Code: ${error.code}, message: ${error.message}`);
              expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
              done();
            } else {
              console.info('Succeed in starting vibration');
              expect(false).assertTrue();
              done();
            }
          }
        );
        done();
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done();
      }
    });

    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test003
     * @tc.name: Vibrator_Sensor_nop_Test001
     * @tc.desc:Using the stopVibration (callback) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test003--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_TIME, async (error: BusinessError) => {
          if (error) {
            console.error(`Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
            done();
          } else {
            console.error('Unexpected success without permission');
            expect(false).assertTrue();
            done();
          }
        });
        setTimeout(() => {
          done();
        }, 800);
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
      }
    });



    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test004
     * @tc.name: Vibrator_Sensor_nop_Test001
     * @tc.desc:Using the stopVibration (promise) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test004--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        await vibrator.stopVibration(vibrator.VibratorStopMode.VIBRATOR_STOP_MODE_TIME).then(async () => {
          console.info('Succeed in stopping vibration');
          expect(false).assertTrue()
          done();
        }, async (error: BusinessError) => {
          if (error) {
            console.error(`Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
            done()
          }else {
            console.info('Succeed in stopping vibration');
            expect(false).assertTrue();
            done()
          }
        });
        done();
      } catch (err) {
        let e: BusinessError = err as BusinessError;
        console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done()
      }
    })

    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test005
     * @tc.name: Vibrator_Sensor_nop_Test001
     * @tc.desc:Using the stopVibration (promise) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test005--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        vibrator.stopVibration().then(async () => {
          console.info('Succeed in stopping vibration');
          expect(false).assertTrue()
          done()
        },async (error: BusinessError) => {
          if (error) {
            console.error(`Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            if (error.code === PERMISSION_DENIED_CODE) {
              expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
              done()
            } else {
              expect(false).assertTrue();
              done()
            }
          }else {
            console.info('Succeed in stopping vibration');
            expect(false).assertTrue();
            done()
          }
        });
        setTimeout(() => {
          done();
        }, 800);
      } catch (err) {
        let e: BusinessError = err as BusinessError;
        console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done()
      }
    })

    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test006
     * @tc.name: Vibrator_Sensor_nop_Test006
     * @tc.desc:Using the stopVibration (callback) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test006--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        vibrator.stopVibration(async (error: BusinessError) => {
          if (error) {
            console.error(`Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
            if (error.code === PERMISSION_DENIED_CODE) {
              expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
              done()
            } else {
              expect(false).assertTrue();
              done()
            }
          }else {
            console.info('Succeed in stopping vibration');
            expect(false).assertTrue();
            done()
          }
        })
        setTimeout(() => {
          done();
        }, 800);
      } catch (error) {
        let e: BusinessError = error as BusinessError;
        console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done()
      }
    })

    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test007
     * @tc.name: Vibrator_Sensor_nop_Test007
     * @tc.desc:Using the stopVibration (callback) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test007--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      try {
        try {
          vibrator.stopVibrationSync();
          console.info("Vibrator_Sensor_nop_Test007 stopVibrationSync success");
          expect(false).assertTrue();
          done();
        } catch (error) {
          console.info("Vibrator_Sensor_nop_Test007 stopVibrationSync error:" + JSON.stringify(error));
          expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
          done()
        }
      } catch (error) {
        let e: BusinessError = error as BusinessError;
        console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done()
      }
    })
    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test008
     * @tc.name: Vibrator_Sensor_nop_Test008
     * @tc.desc:Using the stopVibration (callback) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test008--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      const TAG = "Vibrator_Sensor_nop_Test008";
      try {
        try {
          (vibrator.stopVibration as (param?: vibrator.VibratorInfoParam) => Promise<void>)().then(async () => {
            console.info(`${TAG} Succeed in stopping vibration`);
            expect(false).assertTrue()
            done();
          }).catch(async (error: BusinessError) => {
            if (error) {
              console.error(`${TAG} Failed to stop vibration. Code: ${error.code}, message: ${error.message}`);
              expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
              done();
            } else {
              console.info(`${TAG} Succeed in stopping vibration`);
              expect(false).assertTrue()
              done();
            }
          });
          setTimeout(() => {
            done();
          }, 800);
        } catch (err) {
          const e: BusinessError = err as BusinessError;
          console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
          done();
        }
      } catch (error) {
        let e: BusinessError = error as BusinessError;
        console.error(`An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done();
      }
    })
    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test009
     * @tc.name: Vibrator_Sensor_nop_Test009
     * @tc.desc:Using the isSupportEffect (callback) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test009--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      const TAG = "Vibrator_Sensor_nop_Test009";
      try {
        vibrator.isSupportEffect(EFFECT_ID, async (error: BusinessError, state: boolean) => {
          if (error) {
            console.error(`${TAG} isSupportEffect error: Code ${error.code}, Message: ${error.message}`);
            expect(error.code).assertEqual(PERMISSION_DENIED_CODE);
            done();
          } else {
            console.error(`${TAG} Unexpected success without permission`);
            expect(true).assertFalse();
            done();
          }
        });
        setTimeout(() => {
          done();
        }, 800);
        } catch (error) {
          const e: BusinessError = error as BusinessError;
          console.error(`${TAG} Unexpected error: Code ${e.code}, Message: ${e.message}`);
          expect(e.code).assertEqual(PERMISSION_DENIED_CODE);
          done();
          return;
        }
    });


    /*
     * @tc.number:SUB_SensorsSystem_Vibrator_Sensor_nop_Test010
     * @tc.name: Vibrator_Sensor_nop_Test010
     * @tc.desc:Using the isSupportEffect (Promise) method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("Vibrator_Sensor_nop_Test010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('--------Vibrator_Sensor_nop_Test010--------');
      if (isIOS) {
        console.info('Skipping 201 test on iOS system');
        done();
        return;
      }
      const TAG = "Vibrator_Sensor_nop_Test010";

      try {
        await vibrator.isSupportEffect(EFFECT_ID).then(
          async (state: boolean) => {
            console.error(`${TAG} Unexpected success with invalid effect ID: ${EFFECT_ID}`);
            expect(false).assertTrue();
            done();
          },
          async (error: BusinessError) => {
            if (error.code === 201) {
              console.info(`${TAG} Expected permission error: Code ${error.code}, Message: ${error.message}`);
              expect(error.code).assertEqual(201);
              done();
            } else {
              console.error(`${TAG} Unexpected error code: ${error.code}, expected 201`);
              expect(false).assertTrue();
              done();
            }
          }
        );
      } catch (error) {
        const e: BusinessError = error as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        done();
      }
    });
  })
}