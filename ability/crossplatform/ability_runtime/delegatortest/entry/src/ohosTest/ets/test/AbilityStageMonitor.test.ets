/*
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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
import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, } from "@ohos/hypium";
import AbilityDelegatorRegistry from "@ohos.app.ability.abilityDelegatorRegistry";
import { BusinessError } from "@kit.BasicServicesKit";
import Want from "@ohos.app.ability.Want";

let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
let errMsgArr = ["Parse parameters failed, monitor must be Monitor and isExited must be boolean.",
  "Parse monitor failed, removeAbilityMonitor must be Monitor.",
  "Incorrect parameters."];
let errMsgStr = JSON.stringify(errMsgArr);

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function AbilityStageMonitorTest() {
  const factoryWant = (
    bundleName: string,
    abilityName: string,
    moduleName: string
  ) => {
    return {
      bundleName: bundleName,
      abilityName: abilityName,
      moduleName: moduleName,
    } as Want;
  };

  describe("AbilityStageMonitorTest", () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0100
     * @tc.name actsAddAbilityStageMonitorCallback0100
     * @tc.desc pass in a null monitor.
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 3
     */
    it(
      "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0100",
      0,
      async (done: Function) => {
        let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
        let monitor = null;
        try {
          abilityDelegator.addAbilityStageMonitor(
            monitor,
            (err, data) => {
              abilityDelegator.printSync(
                "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0100" + err.code
              );
              expect().assertFail();
              done();
            }
          );
        } catch (e) {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0100 code：" + e.code
          );
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0100 message:" + e.message
          );
          expect(errMsgStr.indexOf(e.message) > 0).assertTrue();
          expect(e.code).assertEqual(401);
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0100 pass"
          );
          done();
        }
      }
    );

    /**
     * @tc.number ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0200
     * @tc.name actsAddAbilityStageMonitorCallback0200
     * @tc.desc Pass in a stagemonitor and perform add, wait, and remove operations respectively.(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it(
      "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0200",
      0,
      async (done: Function) => {
        const want = factoryWant(
          "com.example.delegatortest",
          "FeatureassistAbility",
          "featureassist"
        );
        let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
          moduleName: "featureassist",
          srcEntrance: "./ets/Application/AbilityStage.ts",
        };

        abilityDelegator.addAbilityStageMonitor(monitor, (err, data) => {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0200 waitAbilityStageMonitor data: " +
              data
          );
        });

        abilityDelegator.waitAbilityStageMonitor(monitor, (err, data) => {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0200 waitAbilityStageMonitor data: " +
              data
          );
        });

        abilityDelegator.removeAbilityStageMonitor(monitor, (err, data) => {
          expect(true).assertTrue();
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_CALLBACK_0200 removeAbilityStageMonitor pass"
          );
          done();
        });
      }
    );

    /**
     * @tc.number ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0100
     * @tc.name actsAddAbilityStageMonitorPromise0100
     * @tc.desc pass in a null monitor.
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 3
     */
    it("ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0100", 0, async (done: Function) => {
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let monitor = null;
      try {
        await abilityDelegator.addAbilityStageMonitor(monitor);
        abilityDelegator.printSync(
          "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0100 error"
        );
        expect().assertFail();
        done();
      } catch (e) {
        abilityDelegator.printSync(
          "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0100 code：" + e.code
        );
        abilityDelegator.printSync(
          "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0100 message:" + e.message
        );
        expect(errMsgStr.indexOf(e.message) > 0).assertTrue();
        expect(e.code).assertEqual(401);
        abilityDelegator.printSync(
          "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0100 pass"
        );
        done();
      }
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200
     * @tc.name actsAddAbilityStageMonitorPromise0200
     * @tc.desc Pass in a stagemonitor and perform add, wait, and remove operations respectively.(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it("ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "FeatureassistAbility",
        "featureassist"
      );
      let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
        moduleName: "featureassist",
        srcEntrance: "./ets/Application/AbilityStage.ts",
      };

      abilityDelegator
        .addAbilityStageMonitor(monitor)
        .then((data) => {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200 waitAbilityStageMonitor data: " +
              data
          );
        })
        .catch((error: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200 wait catch error" +
              error
          );
        });

      abilityDelegator
        .waitAbilityStageMonitor(monitor)
        .then((data) => {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200 waitAbilityStageMonitor data: " +
              data
          );
        })
        .catch((error: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200 wait catch error" +
              error
          );
        });

      abilityDelegator
        .removeAbilityStageMonitor(monitor)
        .then((data) => {
          expect(true).assertTrue();
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200 removeAbilityStageMonitor pass"
          );
          done();
        })
        .catch((error: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_ADD_ABILITY_STAGE_MONITOR_PROMISE_0200 remove catch error" +
              error
          );
        });
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0100
     * @tc.name actsRemoveAbilityStageMonitorCallback0100
     * @tc.desc pass in a null monitor.
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 3
     */
    it(
      "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0100",
      0,
      async (done: Function) => {
        let monitor = null;
        try {
          abilityDelegator.removeAbilityStageMonitor(monitor, (err) => {
            expect().assertFail();
            abilityDelegator.printSync(
              "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0100 error"
            );
            done();
          });
        } catch (e) {
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0100 code：" + e.code
          );
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0100 message:" +
            e.message
          );
          expect(errMsgStr.indexOf(e.message) > 0).assertTrue();
          expect(e.code).assertEqual(401);
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0100 pass"
          );
          done();
        }
        setTimeout(() => {
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0100 timeout"
          );
          done();
        }, 3000);
      }
    );

    /**
     * @tc.number ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0200
     * @tc.name actsRemoveAbilityStageMonitorCallback0200
     * @tc.desc Pass in a stagemonitor and perform wait and remove operations, respectively.(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it(
      "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0200",
      0,
      async (done: Function) => {
        const want = factoryWant(
          "com.example.delegatortest",
          "FeatureassistAbility",
          "featureassist"
        );
        let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
          moduleName: "featureassist",
          srcEntrance: "./ets/Application/AbilityStage.ts",
        };

        abilityDelegator.waitAbilityStageMonitor(monitor, (err, data) => {
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0200 waitAbilityStageMonitor data: " +
              data
          );
        });

        abilityDelegator.removeAbilityStageMonitor(monitor, (err, data) => {
          expect(true).assertTrue();
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0200 removeAbilityStageMonitor pass"
          );
          done();
        });
      }
    );

    /**
     * @tc.number ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0300
     * @tc.name actsRemoveAbilityStageMonitorCallback0300
     * @tc.desc Pass in a stagemonitor and perform wait (6 seconds) and remove operations, respectively.(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it(
      "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0300",
      0,
      async (done: Function) => {
        const want = factoryWant(
          "com.example.delegatortest",
          "FeatureassistAbility",
          "featureassist"
        );
        let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
          moduleName: "featureassist",
          srcEntrance: "./ets/Application/AbilityStage.ts",
        };

        abilityDelegator.waitAbilityStageMonitor(monitor, 6000, (err, data) => {
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0300 waitAbilityStageMonitor data: " +
              data
          );
        });

        abilityDelegator.removeAbilityStageMonitor(monitor, (err, data) => {
          expect(true).assertTrue();
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_CALLBACK_0300 removeAbilityStageMonitor pass"
          );
          done();
        });
      }
    );

    /**
     * @tc.number ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0100
     * @tc.name actsRemoveAbilityStageMonitorPromise0100
     * @tc.desc pass in a null monitor.
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 3
     */
    it(
      "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0100",
      0,
      async (done: Function) => {
        let monitor = null;
        try {
          await abilityDelegator.removeAbilityStageMonitor(monitor);
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0100"
          );
          expect().assertFail();
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0100 error"
          );
          done();
        } catch (e) {
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0100 code：" + e.code
          );
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0100 message:" +
            e.message
          );
          expect(errMsgStr.indexOf(e.message) > 0).assertTrue();
          expect(e.code).assertEqual(401);
          abilityDelegator.printSync(
            "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0100 pass"
          );
          done();
        }
      }
    );

    /**
     * @tc.number ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0200
     * @tc.name actsRemoveAbilityStageMonitorPromise0200
     * @tc.desc Pass in a stagemonitor and perform wait and remove operations, respectively.(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it(
      "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0200",
      0,
      async (done: Function) => {
        const want = factoryWant(
          "com.example.delegatortest",
          "FeatureassistAbility",
          "featureassist"
        );
        let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
          moduleName: "featureassist",
          srcEntrance: "./ets/Application/AbilityStage.ts",
        };

        abilityDelegator
          .waitAbilityStageMonitor(monitor)
          .then((data) => {
            abilityDelegator.printSync(
              "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0200 waitAbilityStageMonitor data: " +
                data
            );
          })
          .catch((error: BusinessError) => {
            abilityDelegator.printSync(
              "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0200 wait catch error" +
                error
            );
          });

        abilityDelegator
          .removeAbilityStageMonitor(monitor)
          .then((data) => {
            expect(true).assertTrue();
            abilityDelegator.printSync(
              "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0200 removeAbilityStageMonitor pass"
            );
            done();
          })
          .catch((error: BusinessError) => {
            abilityDelegator.printSync(
              "ACTS_REMOVE_ABILITY_STAGE_MONITOR_PROMISE_0200 remove catch error" +
                error
            );
          });
      }
    );

    /**
     * @tc.number ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0100
     * @tc.name actsWaitAbilityStageMonitorCallback0100
     * @tc.desc Pass in a null stagemonitor.
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 3
     */
    it(
      "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0100",
      0,
      async (done: Function) => {
        let monitor = null;
        try {
          abilityDelegator.waitAbilityStageMonitor(monitor, (err) => {
            expect().assertFail();
            abilityDelegator.printSync(
              "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0100 callback "
            );
            done();
          });
        } catch (e) {
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0100 code：" + e.code
          );
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0100 message:" + e.message
          );
          expect(errMsgStr.indexOf(e.message) > 0).assertTrue();
          expect(e.code).assertEqual(401);
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0100 monitor pass"
          );
          done();
        }
      }
    );

    /**
     * @tc.number ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0200
     * @tc.name actsWaitAbilityStageMonitorCallback0200
     * @tc.desc Pass in null monitor.
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 3
     */
    it(
      "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0200",
      0,
      async (done: Function) => {
        let monitor = null;
        try {
          abilityDelegator.waitAbilityStageMonitor(
            monitor,
            6000,
            (err) => {
              expect().assertFail();
              abilityDelegator.printSync(
                "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0200 error"
              );
              done();
            }
          );
        } catch (e) {
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0200 code：" + e.code
          );
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0200 message:" + e.message
          );
          expect(errMsgStr.indexOf(e.message) > 0).assertTrue();
          expect(e.code).assertEqual(401);
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0200 pass "
          );
          done();
        }
        setTimeout(() => {
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0200 timeout"
          );
          done();
        }, 3000);
      }
    );

    /**
     * @tc.number ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0300
     * @tc.name actsWaitAbilityStageMonitorCallback0300
     * @tc.desc Pass in a stage monitor and perform the wait operation.(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it(
      "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0300",
      0,
      async (done: Function) => {
        const want = factoryWant(
          "com.example.delegatortest",
          "FeatureassistAbility",
          "featureassist"
        );
        let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
          moduleName: "featureassist",
          srcEntrance: "./ets/Application/AbilityStage.ts",
        };
        abilityDelegator.waitAbilityStageMonitor(monitor, (err, data) => {
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0300 err code: " +
            err.code
          );
          expect(err.code).assertEqual(16000100);
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0300 pass"
          );
          done();
        });
      }
    );

    /**
     * @tc.number ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0400
     * @tc.name actsWaitAbilityStageMonitorCallback0400
     * @tc.desc Pass in a stage monitor and perform the wait operation(6 seconds).(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it(
      "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0400",
      0,
      async (done: Function) => {
        const want = factoryWant(
          "com.example.delegatortest",
          "FeatureassistAbility",
          "featureassist"
        );
        let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
          moduleName: "featureassist",
          srcEntrance: "./ets/Application/AbilityStage.ts",
        };
        abilityDelegator.waitAbilityStageMonitor(monitor, 6000, (err, data) => {
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0400 err code: " +
            err.code
          );
          expect(err.code).assertEqual(16000100);
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_CALLBACK_0400 pass"
          );
          done();
        });
      }
    );
    /**
     * @tc.number ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0100
     * @tc.name actsWaitAbilityStageMonitorPromise0100
     * @tc.desc pass in a null monitor.
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 3
     */
    it(
      "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0100",
      0,
      async (done: Function) => {
        let monitor = null;
        try {
          await abilityDelegator.waitAbilityStageMonitor(monitor);
          expect().assertFail();
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0100  error"
          );
          done();
        } catch (e) {
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0100 code：" + e.code
          );
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0100 message:" + e.message
          );
          expect(errMsgStr.indexOf(e.message) > 0).assertTrue();
          expect(e.code).assertEqual(401);
          abilityDelegator.printSync(
            "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0100  pass"
          );
          done();
        }
      }
    );

    /**
     * @tc.number ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0200
     * @tc.name actsWaitAbilityStageMonitorPromise0200
     * @tc.desc Pass in a stage monitor and perform the wait operation.(incomplete)
     * @tc.size      : MediumTest
     * @tc.type      : Method
     * @tc.level     : Level 2
     */
    it(
      "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0200",
      0,
      async (done: Function) => {
        const want = factoryWant(
          "com.example.delegatortest",
          "FeatureassistAbility",
          "featureassist"
        );
        let monitor: AbilityDelegatorRegistry.AbilityStageMonitor = {
          moduleName: "featureassist",
          srcEntrance: "./ets/Application/AbilityStage.ts",
        };
        abilityDelegator
          .waitAbilityStageMonitor(monitor)
          .then((data) => {
            abilityDelegator.printSync(
              "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0200 pass data: " + data
            );
          })
          .catch((error: BusinessError) => {
            abilityDelegator.printSync(
              "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0200 error: " + error
            );
            expect(error.code).assertEqual(16000100);
            abilityDelegator.printSync(
              "ACTS_WAIT_ABILITY_STAGE_MONITOR_PROMISE_0200 pass"
            );
            done();
          });
      }
    );
  });
}
