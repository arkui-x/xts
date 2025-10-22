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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium'
import { BusinessError } from '@ohos.base';
import hilog from '@ohos.hilog';
import resourceManager from '@ohos.resourceManager';

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

export default function Vibrator_star_normal() {
  describe("Vibrator_star_normal", () => {
    beforeAll(() => {
      console.info('beforeAll called');
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
    /*
     * @tc.name:testStartVibrationFunc001
     * @tc.desc: Verify the behavior of the vibration interface when an invalid usage parameter ("unknown") is provided.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0100
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc001";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.name:testStartVibrationFunc002
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("communication").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0200
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc002";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "communication"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc003
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("touch").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0300
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc003";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "touch"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc004
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("media").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0400
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc004";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "media"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc005
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("alarm").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0500
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc005";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "alarm"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc006
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("ring").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0600
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc006";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "ring"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc007
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("notification").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0700
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc007";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "notification"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc008
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("simulateReality").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0800
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc008";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "simulateReality"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc009
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter ("physicalFeedback").
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_0900
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc009";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000
        }, {
          usage: "physicalFeedback"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.name:testStartVibrationFunc010
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid parameter.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1000
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc010";
      try {
        vibrator.startVibration({
          type: "preset",
          effectId: "haptic.clock.timer",
          count: 1,
        }, {
          usage: "unknown"
        }, async (error: BusinessError) => {
          try {
            if (error) {
              console.info(`${TAG} vibrator error: Code ${error.code}, Message: ${error.message}`);
              expect(false).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            } else {
              console.info(`${TAG} vibrator success`);
              expect(true).assertTrue();
              await vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          } catch (err) {
            const e: BusinessError = err as BusinessError;
            console.error(`${TAG} An unexpected error in callback. Code: ${e.code}, message: ${e.message}`);
            expect(false).assertTrue();
            setTimeout(() => {
              done();
            }, 500);
          }
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
     * @tc.name:testStartVibrationFunc011
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid parameter.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1100
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc011";
      try {
        vibrator.startVibration({
          type: "time",
          duration: 1000,
        }, {
          usage: "unknown"
        }).then(() => {
          console.info(`${TAG} success`);
          expect(true).assertTrue();
          vibrator.stopVibration();
          setTimeout(() => {
            done();
          }, 500);
        }).catch((error: BusinessError) => {
          console.error(`${TAG} error: Code ${error.code}, Message: ${error.message}`);
          expect(false).assertTrue();
          vibrator.stopVibration();
          done();
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });


    /*
     * @tc.name:testStartVibrationFunc012
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1200
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc012", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc012";
      try {
        vibrator.startVibration({
          type: "preset",
          effectId: "haptic.clock.timer",
          count: 3,
        }, {
          usage: "unknown",
        }).then(() => {
          console.info(`${TAG} success`);
          expect(true).assertTrue();
          vibrator.stopVibration();
          setTimeout(() => {
            done();
          }, 500);
        }).catch((error: BusinessError) => {
          console.error(`${TAG} error: Code ${error.code}, Message: ${error.message}`);
          expect(false).assertTrue();
          vibrator.stopVibration();
          done();
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });
    /*
     * @tc.name:testStartVibrationFunc013
     * @tc.desc: Verify the vibration interface can successfully start vibration with a valid usage parameter.
     * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_1300
     * @tc.level:Level 1
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testStartVibrationFunc013", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testStartVibrationFunc013";
      try {
        vibrator.startVibration({
          type: "preset",
          effectId: "haptic.clock.timer",
          count: 1,
        }, {
          usage: "unknown"
        }).then(() => {
          console.info(`${TAG} success`);
          expect(true).assertTrue();
          vibrator.stopVibration();
          setTimeout(() => {
            done();
          }, 500);
        }).catch((error: BusinessError) => {
          console.error(`${TAG} error: Code ${error.code}, Message: ${error.message}`);
          expect(false).assertTrue();
          vibrator.stopVibration();
          done();
        });
        vibrator.startVibration({
          type: "time",
          duration: 1000,
        }, {
          usage: "unknown"
        }).then(() => {
          console.info(`${TAG} success`);
          expect(true).assertTrue();
          vibrator.stopVibration();
          setTimeout(() => {
            done();
          }, 500);
        }).catch((error: BusinessError) => {
          console.error(`${TAG} error: Code ${error.code}, Message: ${error.message}`);
          expect(false).assertTrue();
          vibrator.stopVibration();
          done();
        });
      } catch (err) {
        const e: BusinessError = err as BusinessError;
        console.error(`${TAG} An unexpected error occurred. Code: ${e.code}, message: ${e.message}`);
        expect(false).assertTrue();
        done();
      }
    });

    /*
    * @tc.name:testStartVibrationFunc020
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_3600
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc020", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
        let TAG = "testStartVibrationFunc020";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          let pointsMe :vibrator.VibratorCurvePoint[] = [
            {
              time:0,
              intensity:0,
              frequency:-7
            },
            {
              time:62,
              intensity:1,
              frequency:-6
            },
            {
              time:82,
              intensity:1,
              frequency:-6
            },
            {
              time:102,
              intensity:1,
              frequency:-6
            },
            {
              time:122,
              intensity:1,
              frequency:-6
            },
            {
              time:142,
              intensity:1,
              frequency:-6
            },
            {
              time:162,
              intensity:1,
              frequency:-6
            },
            {
              time:182,
              intensity:1,
              frequency:-6
            },
            {
              time:202,
              intensity:1,
              frequency:-6
            },
            {
              time:222,
              intensity:1,
              frequency:-6
            },
            {
              time:1242,
              intensity:1,
              frequency:-6
            },
            {
              time:2062,
              intensity:1,
              frequency:-6
            },
            {
              time:2802,
              intensity:1,
              frequency:-6
            },
            {
              time:3002,
              intensity:1,
              frequency:-6
            },
            {
              time:4002,
              intensity:1,
              frequency:-6
            },
            {
              time:5000,
              intensity:0,
              frequency:-4
            }
          ]
          let param : vibrator.ContinuousParam = {
            intensity: 97,
            frequency: 34,
            points:pointsMe,
            index: 0
          }
          builder.addContinuousEvent(0, 5000, param);
          console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
        }catch (error){
          console.info(TAG + " ContinuousEvent error: " + JSON.stringify(error));
          expect(false).assertTrue();
          done();
        }
        try {
          vibrator.startVibration({
            type:"pattern",
            pattern:builder.build()
          },{
            usage:"alarm",
            systemUsage:false
          },(error) => {
            if (error) {
              console.info(TAG + " vibrate fail:" + JSON.stringify(error))
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
          })
        } catch (error) {
          console.info(TAG + " Exception error:" + error);
          expect(false).assertTrue();
          done();
        }
      });
    /*
    * @tc.name:testStartVibrationFunc022
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_3800
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc022", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      let TAG = "testStartVibrationFunc022";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 99,
          frequency: 99
        };
        builder.addContinuousEvent(0, 2000, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
      }
      try {
        vibrator.startVibration({
          type: "pattern",
          pattern: builder.build()
        }, {
          usage: "alarm",
          systemUsage: false
        },async  (error: BusinessError) => {
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
        console.info(TAG + " Exception error:" + error);
        expect(false).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:testStartVibrationFunc023
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_3900
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc023", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      let TAG = "testStartVibrationFunc023";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param : vibrator.TransientParam = {
          intensity: 100,
          frequency: 100,
          index: 0
        };
        builder.addTransientEvent(0, param);
        console.info(TAG + " builder.build is:" + JSON.stringify(builder.build()));
      } catch (error) {
        console.info(TAG + " TransientParam error: " + JSON.stringify(error));
      }
      try {
        vibrator.startVibration({
          type: "pattern",
          pattern: builder.build()
        }, {
          usage: "alarm",
          systemUsage: false
        },async  (error: BusinessError) => {
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
        console.info(TAG + " Exception error:" + error);
        expect(false).assertTrue();
        done();
      }
    });
    /*
    * @tc.name:testStartVibrationFunc024
    * @tc.desc: Verify the error handling when passing empty effectId with preset type.
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5600
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testStartVibrationFunc024", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async (done: Function) => {
      const TAG = "testStartVibrationFunc024";
      try {
        let rawFd: resourceManager.RawFileDescriptor | undefined = undefined
        await getContext().resourceManager.getRawFd("file_test.json").then((value) => {
          rawFd = value;
          logger.info(TAG,
            `rawFd of vibration: fd:${rawFd.fd}, offset:${rawFd.offset}, length:${rawFd.length}`
          );
        });
        console.info(`${TAG} RawFileDescriptor: ${JSON.stringify(rawFd)}`);
        vibrator.startVibration(
          {
            type: "file",
            hapticFd: { fd: rawFd!.fd, offset: rawFd!.offset, length: rawFd!.length }
          },
          {
            id: 0,
            usage: 'alarm'
          },
          (error: BusinessError) => {
            if (error) {
              console.error(`${TAG} Failed to start vibration: ${error.message}, code: ${error.code}`);
              expect(false).assertTrue();
              done();
            } else {
              console.info(`${TAG} Vibration started successfully`);
              expect(true).assertTrue();
              vibrator.stopVibration();
              setTimeout(() => {
                done();
              }, 500);
            }
          }
        );
      }
      catch (error) {
        console.error(`${TAG} Error during test execution: ${error.message}`);
        expect(false).assertTrue();
        done();
      }
    });
  })
}
