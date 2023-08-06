/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import aConstant from '@ohos.app.ability.AbilityConstant'

function sleep(time) {
  return new Promise((resolve) => setTimeout(resolve, time))
}

const moduleName = 'entry';
export default function abilityTest() {
  describe('ActsAbilityLifeCycleTest', function () {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(function () {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(function () {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(function () {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(function () {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    let TAG = '';
    const otherBundle = 'com.example.commontestabilityapp'

    /**
     *@tc.number    : UI_ABILITY_CONTEXT_TEST_0001
     *@tc.name      : UI_Ability_Context_Test_0001
     *@tc.desc      : Test context.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
    it('UI_Ability_Context_Test_0001',0, async (done) => {
      console.log("------------UI_ABILITY_CONTEXT_TEST_0001 START-------------");
      TAG = "UI_ABILITY_CONTEXT_TEST_0001";
      expect(globalThis.abilityContext != null).assertTrue();
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_CONTEXT_TEST_0002
     *@tc.name      : UI_Ability_Context_Test_0002
     *@tc.desc      : Test context.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
     it('UI_Ability_Context_Test_0002',0, async (done) => {
      console.log("------------UI_Ability_Context_Test_0002 START-------------");
      TAG = "UI_Ability_Context_Test_0002";
      expect(globalThis.abilityContext != null).assertTrue();
      expect(globalThis.abilityContext.startAbility != null).assertTrue();
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_CONTEXT_TEST_0003
     *@tc.name      : UIAbilityContextTest_0003
     *@tc.desc      : Test context.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
     it('UIAbilityContextTest_0003',0, async (done) => {
      console.log("------------UI_ABILITY_CONTEXT_TEST_0003 START-------------");
      TAG = "UI_ABILITY_CONTEXT_TEST_0003";
      expect(globalThis.abilityContext != null).assertTrue();
      expect(globalThis.abilityContext.terminateSelf != null).assertTrue();
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_LIFE_CYCLE_TEST_0001
     *@tc.name      : UIAbilityLifeCycleTest0001
     *@tc.desc      : Only start 'Main2Ability', Main2Ability will terminate self after 1.5 seconds.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
    it('UI_Ability_Life_Cycle_Test_0001',0, async (done) => {
      console.log("------------UI_ABILITY_LIFE_CYCLE_TEST_0001 START-------------");
      TAG = "UI_ABILITY_LIFE_CYCLE_TEST_0001";

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main2Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      // Main2Ability在1.5秒后，会终结自己，等待2.5s, 确保Main2Ability终结完自己
      await sleep(4000);

      const result2 = globalThis.list2;
      console.info('result2: ' + JSON.stringify(result2));
      
      expect(result2[0]).assertEqual('Main2Ability onCreate');
      expect(result2[1]).assertEqual('Main2Ability onWindowStageCreate');
      expect(result2[2]).assertEqual('Main2Ability onForeground');
      expect(result2[3]).assertEqual('Main2Ability onBackground');
      expect(result2[4]).assertEqual('Main2Ability onWindowStageDestroy');
      expect(result2[5]).assertEqual('Main2Ability onDestroy');
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_LIFE_CYCLE_TEST_0002
     *@tc.name      : UI_Ability_Life_Cycle_Test_0002
     *@tc.desc      : Only start 'Main1Ability'
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
     it('UI_Ability_Life_Cycle_Test_0002',0, async (done) => {
      console.log("------------UI_ABILITY_LIFE_CYCLE_TEST_0002 START-------------");
      TAG = "UI_ABILITY_LIFE_CYCLE_TEST_0002";

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(2500);

      const result1 = globalThis.list1;
      console.info('result1: ' + JSON.stringify(result1));
      
      expect(result1[0]).assertEqual('Main1Ability onCreate');
      expect(result1[1]).assertEqual('Main1Ability onWindowStageCreate');
      expect(result1[2]).assertEqual('Main1Ability onForeground');

      globalThis.ability1context.terminateSelf();
      await sleep(1000);
      expect(result1[3]).assertEqual('Main1Ability onBackground');
      expect(result1[4]).assertEqual('Main1Ability onWindowStageDestroy');
      expect(result1[5]).assertEqual('Main1Ability onDestroy');
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_LIFE_CYCLE_TEST_0003
     *@tc.name      : UI_Ability_Life_Cycle_Test_0003
     *@tc.desc      : start 'Main2Ability', after Main2Ability terminated, start Main1Ability, after 2 seconds, terminate Main1Ability.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
    it('UI_Ability_Life_Cycle_Test_0003',0, async (done) => {
      console.log("------------UI_ABILITY_LIFE_CYCLE_TEST_0003 START-------------");
      TAG = "UI_ABILITY_LIFE_CYCLE_TEST_0003";

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main2Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      // Main2Ability在1.5秒后，会终结自己，等待2.5s, 确保Main2Ability终结完自己
      await sleep(2500);

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start Main1Ability successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start Main1Ability failed. Cause: ' + JSON.stringify(error));
      })
      await sleep(2000);
      globalThis.ability1context.terminateSelf();
      await sleep(1000);

      const result1 = globalThis.list1;
      const result2 = globalThis.list2;
      console.info('result1: ' + JSON.stringify(result1));
      console.info('result2: ' + JSON.stringify(result2));
      
      expect(result2[0]).assertEqual('Main2Ability onCreate');
      expect(result2[1]).assertEqual('Main2Ability onWindowStageCreate');
      expect(result2[2]).assertEqual('Main2Ability onForeground');
      expect(result2[3]).assertEqual('Main2Ability onBackground');
      expect(result2[4]).assertEqual('Main2Ability onWindowStageDestroy');
      expect(result2[5]).assertEqual('Main2Ability onDestroy');

      expect(result1[0]).assertEqual('Main1Ability onCreate');
      expect(result1[1]).assertEqual('Main1Ability onWindowStageCreate');
      expect(result1[2]).assertEqual('Main1Ability onForeground');
      expect(result1[3]).assertEqual('Main1Ability onBackground');
      expect(result1[4]).assertEqual('Main1Ability onWindowStageDestroy');
      expect(result1[5]).assertEqual('Main1Ability onDestroy');
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_LIFE_CYCLE_TEST_0004
     *@tc.name      : UI_Ability_Life_Cycle_Test_0004
     *@tc.desc      : start Main3Ability, after 1.5 seconds, start Main2Ability, after 1.5 seconds, Main2Ability terminated.
                      after 1 seconds, terminate Main1Ability.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
    it('UIAbilityLifeCycleTest0004',0, async (done) => {
      console.log("------------UI_ABILITY_LIFE_CYCLE_TEST_0004 START-------------");
      TAG = "UI_ABILITY_LIFE_CYCLE_TEST_0004";

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main3Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      // 1.5秒后打开Main2Ability
      await sleep(1500);

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main2Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(1000);

      const result1 = globalThis.list3;
      console.info(TAG + 'result1: ' + JSON.stringify(result1));
      
      // 启动Main2Ability后，Main3Ability将会切到后台
      expect(result1[0]).assertEqual('Main3Ability onCreate');
      expect(result1[1]).assertEqual('Main3Ability onWindowStageCreate');
      expect(result1[2]).assertEqual('Main3Ability onForeground');
      expect(result1[3]).assertEqual('Main3Ability onBackground');

      // Main2Ability将会在1.5秒后，终结自己
      await sleep(2000);
      const result2 = globalThis.list2;
      console.info(TAG + 'result2: ' + JSON.stringify(result2));

      expect(result2[0]).assertEqual('Main2Ability onCreate');
      expect(result2[1]).assertEqual('Main2Ability onWindowStageCreate');
      expect(result2[2]).assertEqual('Main2Ability onForeground');
      expect(result2[3]).assertEqual('Main2Ability onBackground');
      expect(result2[4]).assertEqual('Main2Ability onWindowStageDestroy');
      expect(result2[5]).assertEqual('Main2Ability onDestroy');

      // Main3Ability将会重新唤起
      await sleep(1000);
      console.info(TAG + 'result1: ' + JSON.stringify(result1));
      expect(result1[2]).assertEqual('Main3Ability onForeground');

      await sleep(1000);
      globalThis.ability3context.terminateSelf();
      await sleep(1500);
      console.info(TAG + 'result1: ' + JSON.stringify(result1));
      expect(result1[5]).assertEqual('Main3Ability onBackground');
      expect(result1[6]).assertEqual('Main3Ability onWindowStageDestroy');
      expect(result1[7]).assertEqual('Main3Ability onDestroy');
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_LIFE_CYCLE_TEST_0005
     *@tc.name      : UI_Ability_Life_Cycle_Test_0005
     *@tc.desc      : start Main1Ability, after 1seconds, start other app Main1Ability.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
     it('UI_Ability_Life_Cycle_Test_0005',0, async (done) => {
      console.log("------------UI_ABILITY_LIFE_CYCLE_TEST_0005 START-------------");
      TAG = "UI_ABILITY_LIFE_CYCLE_TEST_0005";

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(1000);

      const result1 = globalThis.list1;
      console.info(TAG + 'result1: ' + JSON.stringify(result1));
      
      expect(result1[0]).assertEqual('Main1Ability onCreate');
      expect(result1[1]).assertEqual('Main1Ability onWindowStageCreate');
      expect(result1[2]).assertEqual('Main1Ability onForeground');

      var want = {
        "bundleName": otherBundle,
        "abilityName": "EntryAbility",
        "moduleName": moduleName
      }
      let otherAppResult = 0
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
          otherAppResult = 1;
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(2000);
      expect(otherAppResult == 1).assertTrue();
      done();
    });

    /**
     *@tc.number    : UI_ABILITY_LIFE_CYCLE_TEST_0006
     *@tc.name      : UI_Ability_Life_Cycle_Test_0006
     *@tc.desc      : start Main3Ability, after start Main3Ability twice, Main3Ability is a standard ability.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
     it('UI_Ability_Life_Cycle_Test_0006',0, async (done) => {
      console.log("------------UI_ABILITY_LIFE_CYCLE_TEST_0006 START-------------");
      TAG = "UI_ABILITY_LIFE_CYCLE_TEST_0006";

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main3Ability",
        "moduleName": moduleName
      }
      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(1000);

      const result1 = globalThis.list3;
      console.info(TAG + 'result1: ' + JSON.stringify(result1));
      
      expect(result1[0]).assertEqual('Main3Ability onCreate');
      expect(result1[1]).assertEqual('Main3Ability onWindowStageCreate');
      expect(result1[2]).assertEqual('Main3Ability onForeground');

      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(1000);
      const result2 = globalThis.list3;
      console.info(TAG + 'result2: ' + JSON.stringify(result2));
      expect(result2[0]).assertEqual('Main3Ability onCreate');
      expect(result2[1]).assertEqual('Main3Ability onWindowStageCreate');
      expect(result2[2]).assertEqual('Main3Ability onForeground');

      globalThis.ability3context.terminateSelf();
      await sleep(500);
      done();
    })

    /**
     *@tc.number    : UI_ABILITY_LIFE_CYCLE_TEST_0007
     *@tc.name      : UIAbilityLifeCycleTest0007
     *@tc.desc      : start Main1Ability, after start Main1Ability twice, Main1Ability is a single ability.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
    it('UI_ABILITY_LIFE_CYCLE_TEST_0007',0, async (done) => {
      console.log("------------UI_ABILITY_LIFE_CYCLE_TEST_0007 START-------------");
      TAG = "UI_ABILITY_LIFE_CYCLE_TEST_0007";

      var want = {
        "bundleName": "com.example.uiabilitylifecycle",
        "abilityName": "Main1Ability",
        "moduleName": 'entry'
      }
      await globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(2000);

      globalThis.abilityContext.startAbility(want)
        .then((data) => {
          console.info(TAG + ' start successful. Data: ' + data);
        }).catch((error) => {
        console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
      })

      await sleep(2000);
      const result = globalThis.onNewWantStr;
      console.info(TAG + 'result: ' + JSON.stringify(result));
      expect(result).assertEqual('Main1Ability onNewWant');

      globalThis.ability1context.terminateSelf();
      await sleep(500);
      done();
    })

    /**
     *@tc.number    : UI_Ability_Constant_Test_0100
     *@tc.name      : UI_Ability_Constant_Test_0100
     *@tc.desc      : start Main1Ability, check ability constant.
     *@tc.size      : MediumTest
     *@tc.type      : Function
     *@tc.level     : Level 1
    */
     it("UI_Ability_Constant_Test_0100", 0, async (done) => {
      console.log("------------UI_Ability_Constant_Test_0100 START-------------");
      TAG = "UI_Ability_Constant_Test_0100";

      var want = {
        bundleName: "com.example.uiabilitylifecycle",
        abilityName: "Main1Ability",
        moduleName: moduleName,
      };
      globalThis.abilityContext
        .startAbility(want)
        .then((data) => {
          console.info(TAG + " start successful. Data: " + data);
        })
        .catch((error) => {
          console.error(TAG + " start failed. Cause: " + JSON.stringify(error));
        });

      await sleep(1000);

      console.log('UI_Ability_Constant_Test_0100:' + globalThis.launchParam1.lastExitReason)
      expect(globalThis.launchParam1.launchReason == 0).assertTrue();
      expect(globalThis.launchParam1.lastExitReason == 0).assertTrue();
      expect(aConstant.LaunchReason.UNKNOWN == 0).assertTrue();
      expect(aConstant.LastExitReason.UNKNOWN == 0).assertTrue();
      done();
    });

  })
}