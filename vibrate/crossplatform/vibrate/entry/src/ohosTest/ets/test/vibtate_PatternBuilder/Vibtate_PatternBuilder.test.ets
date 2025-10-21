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

export default function Vibtate_PatternBuilder() {
  let isAvailable: boolean;
  const ABILITYJUDGMENT: boolean = canIUse('SystemCapability.Sensors.MiscDevice');
  describe("Vibtate_PatternBuilder", () => {
    beforeAll(async (done: Function) => {
      console.info('beforeAll called');
      console.info('Vibtate_PatternBuilder Device type = ' + deviceInfo.deviceType);
      console.info('Vibtate_PatternBuilder isAvailable = ' + isAvailable);
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
        console.error('Vibtate_PatternBuilder exception :' + JSON.stringify(error));
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
    let TAG = "";
    /*
    * @tc.name:testVibtatePatternBuilderFunc001
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4400
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
        let TAG = "testVibtatePatternBuilderFunc001";
          let builder = new vibrator.VibratorPatternBuilder();
          try {
            let pointsMe : vibrator.VibratorCurvePoint[] = [
              {
                time: 0,
                intensity: 0,
                frequency: -7
              },
              {
                time: 100,
                intensity: 1,
                frequency: -1
              },
              {
                time: 300,
                intensity: 1,
                frequency: -4
              },
              {
                time: 500,
                intensity: 0.1,
                frequency: -4
              },
              {
                time: 800,
                intensity: 1,
                frequency: -1
              },
              {
                time: 900,
                intensity: 1,
                frequency: -4
              },
              {
                time: 1009,
                intensity: 1,
                frequency: -1
              },
              {
                time: 1596,
                intensity: 1,
                frequency: -4
              },
              {
                time: 1830,
                intensity: 0,
                frequency: -7
              },
              {
                time: 2000,
                intensity: 1,
                frequency: -1
              },
              {
                time: 2369,
                intensity: 1,
                frequency: -4
              },
              {
                time: 2600,
                intensity: 0.1,
                frequency: -4
              },
              {
                time: 2860,
                intensity: 1,
                frequency: -1
              },
              {
                time: 3000,
                intensity: 1,
                frequency: -4
              },
              {
                time: 4000,
                intensity: 1,
                frequency: -4
              },
              {
                time: 5000,
                intensity: 0,
                frequency: -4
              }
            ];
            let param: vibrator.ContinuousParam = {
              intensity: 100,
              frequency: 50,
              points: pointsMe,
              index: 0
            };
            builder.addContinuousEvent(0, 5000, param);
            console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
          } catch (error) {
            console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
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
                expect(true).assertTrue();
                setTimeout(() => {
                  done();
                }, 5000);
              }
            });
          } catch (error) {
            console.info(TAG + " Exception error:" + error);
            expect(false).assertTrue();
            done();
          }
      });
    /*
    * @tc.name:testVibtatePatternBuilderFunc002
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4500
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc002";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          let param: vibrator.ContinuousParam = {
            intensity: 99,
            frequency: 99
          };
          builder.addContinuousEvent(0, 5001, param);
          console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
          expect(false).assertTrue();
          done();
        } catch (error) {
          console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
          expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
          done();
        }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc003
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4600
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc003";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          let param: vibrator.ContinuousParam = {
            intensity: 99,
            frequency: 50
          };
          builder.addContinuousEvent(0, 5000, param);
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
          }, async (error: BusinessError) => {
            if (error) {
              console.info(TAG + " vibrate fail:" + JSON.stringify(error));
              expect(false).assertTrue();
              done();
            } else {
              console.info(TAG + " vibrate success");
              expect(true).assertTrue();
              setTimeout(() => {
                done();
              }, 500);
            }
          });
        } catch (error) {
          console.info(TAG + " Exception error:" + error);
          setTimeout(() => {
            done();
          }, 500);
        }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc004
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4700
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc004";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          let param: vibrator.ContinuousParam = {
            intensity: 99,
            frequency: 99
          };
          builder.addContinuousEvent(-1, 2000, param);
          console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
          expect(false).assertTrue();
          done();
        } catch (error) {
          console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
          expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
          done();
        }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc005
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4800
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc005";
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
          expect(false).assertTrue();
          done();
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
    * @tc.name:testVibtatePatternBuilderFunc006
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_4900
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      TAG = "testVibtatePatternBuilderFunc006";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          builder.addContinuousEvent(0, 272);
          console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
        } catch (error) {
          console.info(TAG + " TransientParam error: " + JSON.stringify(error));
          expect(false).assertTrue();
          done();
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
    * @tc.name:testVibtatePatternBuilderFunc007
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5000
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      TAG = "testVibtatePatternBuilderFunc007";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          builder.addTransientEvent(0);
          console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
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
          }, async (error: BusinessError) => {
            if (error) {
              console.info(TAG + " vibrate fail:" + JSON.stringify(error));
              expect(false).assertTrue();
              done();
            } else {
              console.info(TAG + " vibrate success");
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
    * @tc.name:testVibtatePatternBuilderFunc008
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5100
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      TAG = "testVibtatePatternBuilderFunc008";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          let param: vibrator.TransientParam = {
            intensity: 100,
            frequency: 50,
            index: 0
          };
          builder.addTransientEvent(-1, param);
          console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
          expect(true).assertFalse("Expected error but passed");
          done();
        } catch (error) {
          console.info(TAG + " Caught expected error: " + JSON.stringify(error));
          expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
          done();
        }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc009
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5200
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc009";
        let builder = new vibrator.VibratorPatternBuilder();
        try {
          let param: vibrator.ContinuousParam = {
            intensity: -1,
            frequency: 50
          };
          builder.addContinuousEvent(0, 2000, param);
          console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
          expect(true).assertFalse("Expected error but passed");
          done();
        } catch (error) {
          console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
          expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
          done();
        }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc010
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5300
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
        TAG = "testVibtatePatternBuilderFunc010";
          let builder = new vibrator.VibratorPatternBuilder();
          try {
            let pointsMe : vibrator.VibratorCurvePoint[] = [
              {
                time: 0,
                intensity: 0,
                frequency: -7
              },
              {
                time: 22,
                intensity: 1,
                frequency: -6
              },
              {
                time: 52,
                intensity: 0.94,
                frequency: -4
              },
              {
                time: 72,
                intensity: 0.63,
                frequency: -14
              },
              {
                time: 92,
                intensity: 0.48,
                frequency: -14
              },
              {
                time: 120,
                intensity: 0.53,
                frequency: -10
              },
              {
                time: 130,
                intensity: 0.53,
                frequency: -10
              },
              {
                time: 150,
                intensity: 0.42,
                frequency: -14
              },
              {
                time: 200,
                intensity: 0.39,
                frequency: -14
              },
              {
                time: 269,
                intensity: 0.34,
                frequency: -17
              },
              {
                time: 300,
                intensity: 0.21,
                frequency: -14
              },
              {
                time: 369,
                intensity: 0.19,
                frequency: -21
              },
              {
                time: 400,
                intensity: 0.19,
                frequency: -7
              },
              {
                time: 442,
                intensity: 1,
                frequency: -6
              },
              {//15
                time: 500,
                intensity: 0.94,
                frequency: -4
              },
              {//16
                time: 517,
                intensity: 0.63,
                frequency: -14
              },
              {//17
                time: 530,
                intensity: 0.63,
                frequency: -14
              },
            ];
            let param:vibrator.ContinuousParam = {
              intensity: 97,
              frequency: 10,
              points: pointsMe,
              index: 0
            };
            builder.addContinuousEvent(0, 5000, param);
            console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
          } catch (error) {
            console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
            expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
            done();
          }
      });
    /*
    * @tc.name:testVibtatePatternBuilderFunc011
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5800
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc011";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 99,
          frequency: 50
        };
        builder.addContinuousEvent(0, 0, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        done();
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
            expect(true).assertTrue();
            done();
          }
        });
      } catch (error) {
        console.info(TAG + " Exception error:" + error);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc012
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_5900
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc012", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc012";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 99,
          frequency: 50
        };
        builder.addContinuousEvent(1800000, 1000, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        done();
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
            expect(true).assertTrue();
            done();
          }
        });
      } catch (error) {
        console.info(TAG + " Exception error:" + error);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc013
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_6000
    * @tc.level:Level 1
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc013", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc013";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 99,
          frequency: 50
        };
        builder.addContinuousEvent(1800001, 1000, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        done();
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
            expect(true).assertTrue();
            done();
          }
        });
      } catch (error) {
        console.info(TAG + " Exception error:" + error);
        setTimeout(() => {
          done();
        }, 500);
      }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc014
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_6100
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc014", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc014";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 101,
          frequency: 50
        };
        builder.addContinuousEvent(0, 2000, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
        expect(true).assertFalse("Expected error but passed");
        done();
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        done();
      }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc015
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_6200
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc015", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc014";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 50,
          frequency: -1
        };
        builder.addContinuousEvent(0, 2000, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
        expect(true).assertFalse("Expected error but passed");
        done();
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        done();
      }
    });
    /*
    * @tc.name:testVibtatePatternBuilderFunc016
    * @tc.desc: Verify the error handling when passing incorrect parameters to the stopVibration interface
    * @tc.number:SUB_SensorSystem_Vibrator_EtsTest_6300
    * @tc.level:Level 2
    * @tc.type:Function
    * @tc.size:MediumTest
    */
    it("testVibtatePatternBuilderFunc016", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      let TAG = "testVibtatePatternBuilderFunc016";
      let builder = new vibrator.VibratorPatternBuilder();
      try {
        let param: vibrator.ContinuousParam = {
          intensity: 50,
          frequency: 101
        };
        builder.addContinuousEvent(0, 2000, param);
        console.info(TAG + " builder.build is " + JSON.stringify(builder.build()));
        expect(true).assertFalse("Expected error but passed");
        done();
      } catch (error) {
        console.info(TAG + " addContinuousEvent error: " + JSON.stringify(error));
        expect(error.code).assertEqual(PARAMETER_ERROR_CODE);
        done();
      }
    });
  })
}