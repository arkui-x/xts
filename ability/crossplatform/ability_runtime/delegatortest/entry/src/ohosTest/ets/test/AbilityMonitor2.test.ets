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

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function AbilityMonitor2Test() {
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

  describe("AbilityMonitor2Test", () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_CALLBACK_0100
     * @tc.name ACTS_AddAbilityMonitor_Callback_0100
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the callback function (onAbilityForeground) CallBack when the ability status becomes foreground
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_CALLBACK_0100", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main2Ability",
        "entry"
      );
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityForegroundCallback = (data: ESObject) => {
        expect(data != null).assertTrue();
        abilityDelegator.printSync("ACTS_AddAbilityMonitor_Callback_0100 pass");
        abilityDelegator.getCurrentTopAbility((err, ability1) => {
          abilityDelegator.printSync(
            "ACTS_AddAbilityMonitor_Callback_0100 getCurrentTopAbility err:" +
            ability1.context.abilityInfo.name
          );
          abilityDelegator.removeAbilityMonitor(monitor);
          ability1.context.terminateSelf();
        });
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main2Ability",
        onAbilityForeground: onAbilityForegroundCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync(
          "ACTS_AddAbilityMonitor_Callback_0100 addAbilityMonitor:" +
          JSON.stringify(err)
        );
      });
      abilityDelegator.startAbility(want, (err) => {
        abilityDelegator.printSync(
          "ACTS_AddAbilityMonitor_Callback_0100 startAbility:" +
          JSON.stringify(err)
        );
      });
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_CALLBACK_0200
     * @tc.name ACTS_AddAbilityMonitor_Callback_0200
     * @tc.desc Verify that addAbilityMonitor enters the normal value of the monitor parameter and executes the callback function (onWindowStageCreate) CallBack when the window stage is created
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_CALLBACK_0200", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main3Ability",
        "entry"
      );
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onWindowStageCreateCallBack = (data: ESObject) => {
        expect(data != null).assertTrue();
        abilityDelegator.printSync("ACTS_AddAbilityMonitor_Callback_0200 pass");
        abilityDelegator.getCurrentTopAbility((err, ability1) => {
          abilityDelegator.printSync(
            "ACTS_AddAbilityMonitor_Callback_0200 getCurrentTopAbility :" +
            ability1.context.abilityInfo.name
          );
          abilityDelegator.removeAbilityMonitor(monitor);
          ability1.context.terminateSelf();
        });
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main3Ability",
        onWindowStageCreate: onWindowStageCreateCallBack,
      };
      abilityDelegator.addAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync(
          "ACTS_AddAbilityMonitor_Callback_0200 addAbilityMonitor:" +
          JSON.stringify(err)
        );
      });
      abilityDelegator.startAbility(want, (err) => {
        abilityDelegator.printSync(
          "ACTS_AddAbilityMonitor_Callback_0200 startAbility:" +
          JSON.stringify(err)
        );
      });
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_CALLBACK_0300
     * @tc.name ACTS_AddAbilityMonitor_Callback_0300
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the callback function (onWindowStageCreate) Promise when the window stage is created
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_CALLBACK_0300", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityBackgroundCallback = (data: ESObject) => {
        expect(data != null).assertTrue();
        console.info("ACTS_AddAbilityMonitor_Callback_0300 pass");
        abilityDelegator.removeAbilityMonitor(monitor);
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityBackground: onAbilityBackgroundCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor, (err) => {
        console.log(
          "ACTS_AddAbilityMonitor_Callback_0300 err:" + JSON.stringify(err)
        );
      });
      abilityDelegator.startAbility(want, (err) => {
        console.log(
          "ACTS_AddAbilityMonitor_Callback_0300 err:" + JSON.stringify(err)
        );
        setTimeout(() => {
          abilityDelegator.getCurrentTopAbility((err, ability1) => {
            console.log(
              "ACTS_AddAbilityMonitor_Callback_0300 getCurrentTopAbility err:" +
              JSON.stringify(err)
            );
            abilityDelegator.printSync(
              "ACTS_AddAbilityMonitor_Callback_0300 getCurrentTopAbility err:" +
              ability1.context.abilityInfo.name
            );
            abilityDelegator.doAbilityBackground(ability1, (err) => {
              console.log(
                "ACTS_AddAbilityMonitor_Callback_0300 doAbilityBackground err:" +
                JSON.stringify(err)
              );
            });
          });
        }, 2000);
      });
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_CALLBACK_0400
     * @tc.name ACTS_AddAbilityMonitor_Callback_0400
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the onAbilityBackground Promise when the ability status becomes background
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_CALLBACK_0400", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "MainAbility",
        "entry"
      );
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onWindowStageDestroyCallBack = (data: ESObject) => {
        expect(data != null).assertTrue();
        console.info("ACTS_AddAbilityMonitor_Callback_0400 pass");
        abilityDelegator.removeAbilityMonitor(monitor);
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "MainAbility",
        onWindowStageDestroy: onWindowStageDestroyCallBack,
      };
      abilityDelegator.addAbilityMonitor(monitor, (err) => {
        console.log(
          "ACTS_AddAbilityMonitor_Callback_0400 err:" + JSON.stringify(err)
        );
      });
      setTimeout(() => {
        abilityDelegator.startAbility(want, (err) => {
          console.log(
            "ACTS_AddAbilityMonitor_Callback_0400 err:" + JSON.stringify(err)
          );
          setTimeout(() => {
            abilityDelegator.getCurrentTopAbility((err, ability1) => {
              abilityDelegator.printSync(
                "ACTS_AddAbilityMonitor_Callback_0400 getCurrentTopAbility err:" +
                JSON.stringify(err)
              );
              abilityDelegator.printSync(
                "ACTS_AddAbilityMonitor_Callback_0400 getCurrentTopAbility err:" +
                ability1.context.abilityInfo.name
              );
              ability1.context.terminateSelf();
            });
          }, 2000);
        });
      }, 2000);
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_CALLBACK_0500
     * @tc.name ACTS_AddAbilityMonitor_Callback_0500
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the onAbilityDestroy callBack function before the ability is destroyed
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_CALLBACK_0500", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main3Ability",
        "entry"
      );
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityDestroyCallback = (data: ESObject) => {
        console.log(
          "ACTS_AddAbilityMonitor_Callback_0500 data1: " +
          JSON.stringify(data.context.abilityInfo)
        );
        expect(data != null).assertTrue();
        abilityDelegator.printSync("ACTS_AddAbilityMonitor_Callback_0500 pass");
        abilityDelegator.removeAbilityMonitor(monitor);
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main3Ability",
        onAbilityDestroy: onAbilityDestroyCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync(
          "ACTS_AddAbilityMonitor_Callback_0500 addAbilityMonitor:" +
          JSON.stringify(err)
        );
      });
      setTimeout(() => {
        abilityDelegator.startAbility(want, (err) => {
          console.log(
            "ACTS_AddAbilityMonitor_Callback_0500 startAbility:" +
            JSON.stringify(err)
          );
          setTimeout(() => {
            abilityDelegator.getCurrentTopAbility((err, ability1) => {
              abilityDelegator.printSync(
                "ACTS_AddAbilityMonitor_Callback_0500 getCurrentTopAbility:" +
                JSON.stringify(err)
              );
              abilityDelegator.printSync(
                "ACTS_AddAbilityMonitor_Callback_0500 getCurrentTopAbility:" +
                ability1.context.abilityInfo.name
              );
              ability1.context.terminateSelf();
            });
          }, 2000);
        });
      }, 2000);
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_PROMISE_0100
     * @tc.name ACTS_AddAbilityMonitor_Promise_0100
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the onAbilityForeground Promise when the ability status becomes foreground
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_PROMISE_0100", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );

      let onAbilityForegroundPromise = (data: ESObject) => {
        expect(data != null).assertTrue();
        abilityDelegator.printSync("ACTS_AddAbilityMonitor_Promise_0100 pass");
        abilityDelegator.getCurrentTopAbility((err, ability1) => {
          abilityDelegator.printSync(
            "ACTS_AddAbilityMonitor_Promise_0100 getCurrentTopAbility :" +
            ability1.context.abilityInfo.name
          );
          abilityDelegator.removeAbilityMonitor(monitor);
          ability1.context.terminateSelf();
        });
        done();
      }

      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityForeground: onAbilityForegroundPromise,
      };
      abilityDelegator
        .addAbilityMonitor(monitor)
        .then(() => {
          abilityDelegator.printSync("ACTS_AddAbilityMonitor_Promise_0100 add");
          abilityDelegator.startAbility(want);
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_AddAbilityMonitor_Promise_0100 error"
          );
          done();
        });
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_PROMISE_0200
     * @tc.name ACTS_AddAbilityMonitor_Promise_0200
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the callback function (onWindowStageCreate) Promise when the window stage is created
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_PROMISE_0200", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main2Ability",
        "entry"
      );

      let onWindowStageCreatePromise = (data: ESObject) => {
        expect(data != null).assertTrue();
        abilityDelegator.printSync("ACTS_AddAbilityMonitor_Promise_0200 pass");
        abilityDelegator.getCurrentTopAbility((err, ability1) => {
          abilityDelegator.printSync(
            "ACTS_AddAbilityMonitor_Promise_0200 getCurrentTopAbility :" +
            ability1.context.abilityInfo.name
          );
          abilityDelegator.removeAbilityMonitor(monitor);
          ability1.context.terminateSelf();
        });
        done();
      }

      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main2Ability",
        onWindowStageCreate: onWindowStageCreatePromise,
      };
      abilityDelegator
        .addAbilityMonitor(monitor)
        .then(async () => {
          abilityDelegator.printSync("ACTS_AddAbilityMonitor_Promise_0200 add");
          setTimeout(() => {
            abilityDelegator.startAbility(want).then(async () => {
              abilityDelegator.printSync(
                "ACTS_AddAbilityMonitor_Promise_0200 start"
              );
            });
          }, 2000);
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_AddAbilityMonitor_Promise_0200 error"
          );
          done();
        });
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_PROMISE_0300
     * @tc.name ACTS_AddAbilityMonitor_Promise_0300
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the onAbilityBackground Promise when the ability status becomes background     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_PROMISE_0300", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main3Ability",
        "entry"
      );

      let onAbilityBackgroundPromise = (data: ESObject) => {
        expect(data != null).assertTrue();
        console.log("ACTS_AddAbilityMonitor_Promise_0300 pass");
        abilityDelegator.removeAbilityMonitor(monitor);
        data.context.terminateSelf();
        done();
      }

      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main3Ability",
        onAbilityBackground: onAbilityBackgroundPromise,
      };
      abilityDelegator
        .addAbilityMonitor(monitor)
        .then(async () => {
          console.info("ACTS_AddAbilityMonitor_Promise_0300 add");
        })
        .catch((err: BusinessError) => {
          console.info("ACTS_AddAbilityMonitor_Promise_0300 error");
          done();
        });
      setTimeout(() => {
        abilityDelegator
          .startAbility(want)
          .then(async () => {
            console.info("ACTS_AddAbilityMonitor_Promise_0300 start");
            setTimeout(() => {
              abilityDelegator.getCurrentTopAbility().then((ability) => {
                console.info(
                  "ACTS_AddAbilityMonitor_Promise_0300 ability" +
                  JSON.stringify(ability)
                );
                abilityDelegator.doAbilityBackground(ability).then(async () => {
                  console.info(
                    "ACTS_AddAbilityMonitor_Promise_0300 doAbilityBackground."
                  );
                });
              });
            }, 2000);
          })
          .catch((err: BusinessError) => {
            console.info(
              "ACTS_AddAbilityMonitor_Promise_0300 startability error"
            );
            done();
          });
      }, 2000);
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_PROMISE_0400
     * @tc.name ACTS_AddAbilityMonitor_Promise_0400
     * @tc.desc Verify that addAbilityMonitor enters the parameter monitor to pass in the normal value, and executes the callback function (onWindowStageDestroy) Promise before the window stage is destroyed
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_PROMISE_0400", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );

      let onWindowStageDestroyPromise = (data: ESObject) => {
        expect(data != null).assertTrue();
        console.log("ACTS_AddAbilityMonitor_Promise_0400 pass");
        abilityDelegator.removeAbilityMonitor(monitor);
        done();
      }

      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onWindowStageDestroy: onWindowStageDestroyPromise,
      };
      abilityDelegator
        .addAbilityMonitor(monitor)
        .then(async () => {
          console.info("ACTS_AddAbilityMonitor_Promise_0400 add");
        })
        .catch((err: BusinessError) => {
          console.info("ACTS_AddAbilityMonitor_Promise_0400 error");
          expect().assertFail();
          done();
        });
      setTimeout(() => {
        abilityDelegator.startAbility(want, (err) => {
          console.log(
            "ACTS_AddAbilityMonitor_Promise_0400 err:" + JSON.stringify(err)
          );
          setTimeout(() => {
            abilityDelegator.getCurrentTopAbility((err, ability1) => {
              abilityDelegator.printSync(
                "ACTS_AddAbilityMonitor_Promise_0400 top err:" +
                JSON.stringify(err)
              );
              abilityDelegator.printSync(
                "ACTS_AddAbilityMonitor_Promise_0400 getCurrentTopAbility :" +
                ability1.context.abilityInfo.name
              );
              ability1.context.terminateSelf();
            });
          }, 2000);
        });
      }, 2000);
    });

    /**
     * @tc.number ACTS_ADD_ABILITY_MONITOR_PROMISE_0500
     * @tc.name ACTS_AddAbilityMonitor_Promise_0500
     * @tc.desc Verify that the addAbilityMonitor parameter monitor passes in the normal value, and execute the onAbilityDestroy Promise before the ability is destroyed
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_ADD_ABILITY_MONITOR_PROMISE_0500", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main3Ability",
        "entry"
      );

      let onAbilityDestroyPromise = (data: ESObject) => {
        expect(data != null).assertTrue();
        abilityDelegator.printSync("ACTS_AddAbilityMonitor_Promise_0500 pass");
        abilityDelegator.removeAbilityMonitor(monitor);
        done();
      }

      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main3Ability",
        onAbilityDestroy: onAbilityDestroyPromise,
      };
      abilityDelegator
        .addAbilityMonitor(monitor)
        .then(async () => {
          abilityDelegator.printSync("ACTS_AddAbilityMonitor_Promise_0500 add");
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_AddAbilityMonitor_Promise_0500 error"
          );
          done();
        });
      abilityDelegator.startAbility(want, (err) => {
        console.log(
          "ACTS_AddAbilityMonitor_Promise_0500 err:" + JSON.stringify(err)
        );
        setTimeout(() => {
          abilityDelegator.getCurrentTopAbility((err, ability1) => {
            abilityDelegator.printSync(
              "ACTS_AddAbilityMonitor_Promise_0500 top err:" +
              JSON.stringify(err)
            );
            abilityDelegator.printSync(
              "ACTS_AddAbilityMonitor_Promise_0500 top ability:" +
              ability1.context.abilityInfo.name
            );
            ability1.context.terminateSelf();
          });
        }, 2000);
      });
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0100
     * @tc.name ACTS_RemoveABILITY_MONITOR_CALLBACK_0100
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to the onAbilityForeground callback CallBack
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0100", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 0;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityForegroundCallback = () => {
        result = 1;
        abilityDelegator.printSync(
          "ACTS_RemoveABILITY_MONITOR_CALLBACK_0100 error"
        );
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityForeground: onAbilityForegroundCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator.removeAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync("ACTS_RemoveABILITY_MONITOR_CALLBACK_0100.");
      });
      await abilityDelegator.startAbility(want);
      setTimeout(() => {
        expect(result).assertEqual(0);
        abilityDelegator.printSync(
          "ACTS_RemoveABILITY_MONITOR_CALLBACK_0100 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0200
     * @tc.name ACTS_RemoveABILITY_MONITOR_CALLBACK_0200
     * @tc.desc After validating removeAbilityMonitor, you cannot listen to the onWindowStageCreate callback CallBack
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0200", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 0;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onWindowStageCreateCallback = () => {
        result = 1;
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0200 error"
        );
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onWindowStageCreate: onWindowStageCreateCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator.removeAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0200 ."
        );
      });
      await abilityDelegator.startAbility(want);
      setTimeout(() => {
        expect(result).assertEqual(0);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0200 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0300
     * @tc.name ACTS_RemoveABILITY_MONITOR_CALLBACK_0300
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to the onAbilityBackground callback callback
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0300", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 0;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityBackgroundCallback = () => {
        result = 1;
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0300 error"
        );
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityBackground: onAbilityBackgroundCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator.removeAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0300 ."
        );
      });
      abilityDelegator.startAbility(want, (err) => {
        console.log(
          "ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0300 err:" + JSON.stringify(err)
        );
        setTimeout(() => {
          abilityDelegator.getCurrentTopAbility((err, ability1) => {
            abilityDelegator.printSync(
              "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0300 getCurrentTopAbility err:" +
              JSON.stringify(err)
            );
            abilityDelegator.printSync(
              "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0300 top ability:" +
              ability1.context.abilityInfo.name
            );
            abilityDelegator.doAbilityBackground(ability1, (err) => {
              abilityDelegator.printSync(
                "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0300 doAbilityBackground err:" +
                JSON.stringify(err)
              );
            });
          });
        }, 2000);
      });
      setTimeout(() => {
        expect(result).assertEqual(0);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0300 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0400
     * @tc.name ACTS_RemoveABILITY_MONITOR_CALLBACK_0400
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to the onAbilityDestroy callback CallBack
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0400", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 0;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityDestroyCallback = () => {
        result = 1;
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0400 error"
        );
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityDestroy: onAbilityDestroyCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator.removeAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0400. "
        );
      });
      abilityDelegator.startAbility(want, (err) => {
        console.log(
          "ACTS_AddAbilityMonitor_Callback_0600 err:" + JSON.stringify(err)
        );
        setTimeout(() => {
          abilityDelegator.getCurrentTopAbility((err, ability1) => {
            abilityDelegator.printSync(
              "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0400 getCurrentTopAbility err:" +
              JSON.stringify(err)
            );
            ability1.context.terminateSelf();
          });
        }, 2000);
      });
      setTimeout(() => {
        expect(result).assertEqual(0);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0400 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0500
     * @tc.name ACTS_RemoveABILITY_MONITOR_CALLBACK_0500
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to the onWindowStageDestroy callback CallBack
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_CALLBACK_0500", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 0;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onWindowStageDestroyCallback = () => {
        result = 1;
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0500 error"
        );
        done();
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onWindowStageDestroy: onWindowStageDestroyCallback,
      };
      abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator.removeAbilityMonitor(monitor, (err) => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0500 ."
        );
      });
      abilityDelegator.startAbility(want, (err) => {
        console.log(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0500 err:" + JSON.stringify(err)
        );
        setTimeout(() => {
          abilityDelegator.getCurrentTopAbility((err, ability1) => {
            abilityDelegator.printSync(
              "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0500 getCurrentTopAbility err:" +
              JSON.stringify(err)
            );
            ability1.context.terminateSelf();
          });
        }, 2000);
      });
      setTimeout(() => {
        expect(result).assertEqual(0);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_CALLBACK_0500 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0100
     * @tc.name Acts_RemoveAbility_Monitor_Promise_0100
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to onAbilityForeground callback promises
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0100", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 1;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityForegroundPromise = () => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0100 error "
        );
        result = 0;
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityForeground: onAbilityForegroundPromise,
      };
      await abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator
        .removeAbilityMonitor(monitor)
        .then(() => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0100 callback"
          );
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0100 error"
          );
          expect().assertFail();
          done();
        });
      await abilityDelegator.startAbility(want);
      setTimeout(() => {
        expect(result).assertEqual(1);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0100 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0200
     * @tc.name Acts_RemoveAbility_Monitor_Promise_0200
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to the onWindowStageCreate callback Promise
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0200", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 1;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onWindowStageCreatePromise = () => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0200 error "
        );
        result = 0;
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onWindowStageCreate: onWindowStageCreatePromise,
      };
      await abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator
        .removeAbilityMonitor(monitor)
        .then(() => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0200 promise"
          );
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0200 error"
          );
          expect().assertFail();
          done();
        });
      await abilityDelegator.startAbility(want);
      setTimeout(() => {
        expect(result).assertEqual(1);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0200 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0300
     * @tc.name Acts_RemoveAbility_Monitor_Promise_0300
     * @tc.desc After validating removeAbilityMonitor, you cannot listen to the onAbilityBackground callback Promise
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0300", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 1;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityBackgroundPromise = () => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 error "
        );
        result = 0;
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityBackground: onAbilityBackgroundPromise,
      };
      await abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator
        .removeAbilityMonitor(monitor)
        .then(() => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 promise"
          );
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 error"
          );
          expect().assertFail();
          done();
        });
      abilityDelegator
        .startAbility(want)
        .then(async () => {
          console.info("ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 start");
          abilityDelegator.getCurrentTopAbility().then((ability) => {
            console.info(
              "ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 ability" +
              JSON.stringify(ability)
            );
            abilityDelegator.doAbilityBackground(ability).then(async () => {
              console.info(
                "ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 doAbilityBackground succeed."
              );
            });
          });
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 start error"
          );
          expect().assertFail();
          done();
        });
      setTimeout(() => {
        expect(result).assertEqual(1);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0300 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0400
     * @tc.name Acts_RemoveAbility_Monitor_Promise_0400
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to onAbilityDestroy callback promises
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0400", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 1;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onAbilityDestroyPromise = () => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0400 error "
        );
        result = 0;
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onAbilityDestroy: onAbilityDestroyPromise,
      };
      await abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator
        .removeAbilityMonitor(monitor)
        .then(() => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0400 promise"
          );
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0400 error"
          );
          expect().assertFail();
          done();
        });
      abilityDelegator
        .startAbility(want)
        .then(async () => {
          console.info("ACTS_REMOVEABILITY_MONITOR_PROMISE_0400 start");
          abilityDelegator.getCurrentTopAbility().then((ability) => {
            console.info(
              "ACTS_REMOVEABILITY_MONITOR_PROMISE_0400 ability" +
              JSON.stringify(ability)
            );
            ability.context.terminateSelf();
          });
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0400 start error"
          );
          expect().assertFail();
          done();
        });
      setTimeout(() => {
        expect(result).assertEqual(1);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0400 pass "
        );
        done();
      }, 3000);
    });

    /**
     * @tc.number ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0500
     * @tc.name Acts_RemoveAbility_Monitor_Promise_0500
     * @tc.desc After verifying removeAbilityMonitor, you cannot listen to the onWindowStageDestroy callback Promise
     * @tc.type Function
     * @tc.level Level 2
     */
    it("ACTS_REMOVE_ABILITY_MONITOR_PROMISE_0500", 0, async (done: Function) => {
      const want = factoryWant(
        "com.example.delegatortest",
        "Main4Ability",
        "entry"
      );
      let result = 1;
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();

      let onWindowStageDestroyPromise = () => {
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0500 error "
        );
        result = 0;
      }

      let monitor: AbilityDelegatorRegistry.AbilityMonitor = {
        abilityName: "Main4Ability",
        onWindowStageDestroy: onWindowStageDestroyPromise,
      };
      await abilityDelegator.addAbilityMonitor(monitor);
      abilityDelegator
        .removeAbilityMonitor(monitor)
        .then(() => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0500 promise"
          );
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0500 error"
          );
          expect().assertFail();
          done();
        });
      abilityDelegator
        .startAbility(want)
        .then(async () => {
          console.info("ACTS_REMOVEABILITY_MONITOR_PROMISE_0500 start");
          abilityDelegator.getCurrentTopAbility().then((ability) => {
            console.info(
              "ACTS_REMOVEABILITY_MONITOR_PROMISE_0500 ability" +
              JSON.stringify(ability)
            );
            ability.context.terminateSelf();
          });
        })
        .catch((err: BusinessError) => {
          abilityDelegator.printSync(
            "ACTS_REMOVEABILITY_MONITOR_PROMISE_0500 start error"
          );
          expect().assertFail();
          done();
        });
      setTimeout(() => {
        expect(result).assertEqual(1);
        abilityDelegator.printSync(
          "ACTS_REMOVEABILITY_MONITOR_PROMISE_0500 pass "
        );
        done();
      }, 3000);
    });
  });
}
