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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from "@ohos/hypium"
import { AbilityLifecycleCallback, common, Want } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";

const moduleName = 'entry';
const otherBundle = 'com.example.commontestabilityapp'
const otherModuleName = 'featureassista';

function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}

export default function lifecycleTest() {
  describe('LifeCycleTest', () => {

    beforeEach(async (done: Function) => {
      console.info('LifeCycleTest before each called');
      await sleep(1000);
      done();
    });

    afterEach(async (done: Function) => {
      console.info('LifeCycleTest after each called');
      if ("Crossplatform_Singlehap_LifeCycleTest_0200" === TAG || "Crossplatform_Singlehap_LifeCycleTest_0300" === TAG
        || "Crossplatform_Singlehap_LifeCycleTest_0500" === TAG || "Crossplatform_Singlehap_LifeCycleTest_0600" === TAG
        || "Crossplatform_Singlehap_LifeCycleTest_0800" === TAG ||
        "Crossplatform_Singlehap_LifeCycleTest_0900" === TAG) {
        let para: common.AbilityResult = {
          resultCode: 2,
          want: {
            "abilityName": "Main1Ability",
            "bundleName": "com.example.lifecycle",
            "moduleName": moduleName
          }
        }
        console.log("LifeCycleTest terminateSelfwithresult para: " + JSON.stringify(para));

        await globalThis.ability1context.terminateSelf()
          .then((data: ESObject) => {
            console.log("LifeCycleTest terminateSelfwithresult successful data: " + JSON.stringify(data));
          }).catch((error: BusinessError) => {
            console.log("LifeCycleTest terminateSelfwithresult error: " + JSON.stringify(error));
          });
      } else if ("Singlehap_LifeCycleTest_2000" === TAG) {
        let para1: common.AbilityResult = {
          resultCode: 2,
          want: {
            "abilityName": "Main12Ability",
            "bundleName": "com.example.lifecycle",
            "moduleName": moduleName
          }
        }
        console.log("LifeCycleTest terminateSelfwithresult para: " + JSON.stringify(para1));

        await globalThis.ability12.terminateSelf()
          .then((data: ESObject) => {
            console.log("LifeCycleTest terminateSelfwithresult successful data: " + JSON.stringify(data));
          }).catch((error: BusinessError) => {
            console.log("LifeCycleTest terminateSelfwithresult error: " + JSON.stringify(error));
          });
      }
      done();
    });

    afterAll(async (done: Function) => {
      await sleep(1000);
      done();
    });

    let TAG = "";
    let listKeyTemp: Array<string>;
    let tempCallbackId: number;

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0100
     * @tc.name    Register in abilitystage,listen to the lifecycle of abilityA,deregister after listening
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0100", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0100 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0100";
      let code: number;
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main2Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      setTimeout(() => {
        console.log(TAG + " registerAbilityLifecycleCallback listKey : " + JSON.stringify(globalThis.list));
        console.log(TAG + " registerAbilityLifecycleCallback callbackid : " + JSON.stringify(globalThis.callbackid));
        tempCallbackId = globalThis.callbackid;
        console.log(TAG + " registerAbilityLifecycleCallback tempCallbackId : " + JSON.stringify(tempCallbackId));
        let listTemp = JSON.stringify(globalThis.list);
        console.log(TAG + " listTemp is :" + listTemp);
        globalThis.applicationContext.off('abilityLifecycle', tempCallbackId, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + error);
          code = error ? error.code : 0;
        });
        setTimeout(() => {
          console.log("start expect");
          expect(listTemp.indexOf("Main2Ability onAbilityCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityForeground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityBackground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageDestroy") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityDestroy") !== -1).assertTrue();
          expect(code).assertEqual(0);
          console.log("------------Crossplatform_Singlehap_LifeCycleTest_0100 END-------------");
          done();
        }, 1000);
      }, 3000);
    })

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0200
     * @tc.name    Register in abilityA,listen to the lifecycle of abilityB,deregister after listening
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0200", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0200 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0200";
      let code: number;
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });

      }, 500);
      setTimeout(() => {
        console.log(TAG + " registerAbilityLifecycleCallback listKey : " + JSON.stringify(globalThis.list1));
        console.log(TAG + " registerAbilityLifecycleCallback callbackid : " + JSON.stringify(globalThis.callbackid1));
        let listTemp = JSON.stringify(globalThis.list1);
        console.log(TAG + " listTemp is :" + listTemp);

        globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + error);
          code = error ? error.code : 0;
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, errcode: " + code);
        })
        setTimeout(() => {
          expect(listTemp.indexOf("Main1Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.split("Main1Ability onAbilityForeground").length - 1).assertEqual(2);
          expect(listTemp.indexOf("Main1Ability onAbilityBackground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityForeground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityBackground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageDestroy") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityDestroy") !== -1).assertTrue();
          expect(code).assertEqual(0);
          console.log("------------Crossplatform_Singlehap_LifeCycleTest_0200 END-------------");
          done();
        }, 1000);
      }, 4000);
    });

    /*
    * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0300
    * @tc.name    Register in abilityA,listening the lifecycle of abilityB,deregister,repeat the unregister
    * @tc.desc    Function test
    * @tc.level   0
    */
    it("Crossplatform_Singlehap_LifeCycleTest_0300", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0300 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0300";
      let code: number;
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });

      }, 500);
      setTimeout(() => {
        console.log(TAG + " registerAbilityLifecycleCallback listKey : " + JSON.stringify(globalThis.list1));
        console.log(TAG + " registerAbilityLifecycleCallback callbackid : " + JSON.stringify(globalThis.callbackid1));
        let listTemp = JSON.stringify(globalThis.list1);
        console.log(TAG + " listTemp is :" + listTemp);

        globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: ");
        })
        setTimeout(() => {
          console.log(TAG + " secondunregister callbackid : " + JSON.stringify(globalThis.callbackid1));

          globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
            console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
            code = error ? error.code : 0;
          })
        }, 500);
        setTimeout(() => {
          expect(listTemp.indexOf("Main1Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.split("Main1Ability onAbilityForeground").length - 1).assertEqual(2);
          expect(listTemp.indexOf("Main1Ability onAbilityBackground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityForeground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityBackground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageDestroy") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityDestroy") !== -1).assertTrue();
          expect(code).assertEqual(401);
          console.log("------------Crossplatform_Singlehap_LifeCycleTest_0300 END-------------");
          done();
        }, 2000);
      }, 4000);
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0400
     * @tc.name    Register in abilityA,listening the lifecycle of abilityB,terminate abilityA,unregister
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0400", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0400 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0400";
      let code: number;
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main3Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start3 failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start3 successful. Data: ' + data);
        }
      });

      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start2 failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start2 successful. Data: ' + data);
          }
        });

      }, 500);
      setTimeout(() => {
        console.log(TAG + " registerAbilityLifecycleCallback listKey : " + JSON.stringify(globalThis.list3));
        console.log(TAG + " registerAbilityLifecycleCallback callbackid : " + JSON.stringify(globalThis.callbackid3));
        let listTemp = JSON.stringify(globalThis.list3);
        console.log(TAG + " listTemp is :" + listTemp);
        let para: common.AbilityResult = {
          resultCode: 1,
          want: {
            "abilityName": "Main3Ability",
            "bundleName": "com.example.lifecycle",
            "moduleName": moduleName
          }
        }
        console.log(TAG + " terminateSelfwithresult para: " + JSON.stringify(para));
        globalThis.ability3.terminateSelf()
          .then((data: ESObject) => {
            console.log(TAG + " terminateSelfwithresult successful data: " + JSON.stringify(data));
          }).catch((error: BusinessError) => {
          console.log(TAG + " terminateSelfwithresult error: " + JSON.stringify(error));
        });
        setTimeout(() => {
          globalThis.applicationContext3.off('abilityLifecycle', globalThis.callbackid3, (error: ESObject) => {
            console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
            code = error ? error.code : 0;
          })
        }, 500);
        setTimeout(() => {
          expect(listTemp.indexOf("Main3Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.split("Main3Ability onAbilityForeground").length - 1).assertEqual(2);
          expect(listTemp.indexOf("Main3Ability onAbilityBackground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityForeground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityBackground") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onWindowStageDestroy") !== -1).assertTrue();
          expect(listTemp.indexOf("Main2Ability onAbilityDestroy") !== -1).assertTrue();
          expect(code).assertEqual(0);
          console.log("------------Crossplatform_Singlehap_LifeCycleTest_0400 END-------------");
          done();
        }, 1000);
      }, 4000);
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0500
     * @tc.name    Register in abilityA and abilityB,unregister MainabilityB,then Register in ManinabilityC
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0500", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0500 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0500";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start1 failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start1 successful. Data: ' + data);
        }
      });

      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main3Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start3 failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start3 successful. Data: ' + data);
          }
        });

      }, 500);
      setTimeout(() => {
        console.log(TAG + " start after callbackid3 : " + JSON.stringify(globalThis.callbackid3));

        globalThis.applicationContext3.off('abilityLifecycle', globalThis.callbackid3, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        })
        let str2: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main4Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str2, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start4 failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start4 successful. Data: ' + data);
          }
        });

      }, 2800);
      setTimeout(() => {
        console.log(TAG + " listKey1 : " + JSON.stringify(globalThis.list1));
        console.log(TAG + " callbackid1 : " + JSON.stringify(globalThis.callbackid1));
        console.log(TAG + " listKey3 : " + JSON.stringify(globalThis.list3));
        console.log(TAG + " callbackid3 : " + JSON.stringify(globalThis.callbackid3));
        let id3: number = globalThis.callbackid3;
        console.log(TAG + " listKey4 : " + JSON.stringify(globalThis.list4));
        console.log(TAG + " callbackid4 : " + JSON.stringify(globalThis.callbackid4));
        let id4: number = globalThis.callbackid4;
        expect(id3 + 1).assertEqual(id4);

        globalThis.applicationContext4.off('abilityLifecycle', globalThis.callbackid4, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        })

        globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
          done();
        })
      }, 5000);
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0600
     * @tc.name    Register in abilityA,start abilityB、abilityC,terminate abilityB 、abilityC
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0600", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0600 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0600";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start1 failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start1 successful. Data: ' + data);
        }
      });

      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main5Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start5 failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start5 successful. Data: ' + data);
          }
        });

      }, 500);
      setTimeout(() => {
        let str2: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str2, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start2 failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start2 successful. Data: ' + data);
          }
        });

      }, 1100);
      setTimeout(() => {
        console.log(TAG + " listKey1 : " + JSON.stringify(globalThis.list1));
        console.log(TAG + " callbackid1 : " + JSON.stringify(globalThis.callbackid1));
        let listTemp = JSON.stringify(globalThis.list1);
        console.log(TAG + " listTemp is :" + listTemp);
        expect(listTemp.indexOf("Main2Ability onAbilityCreate") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onWindowStageCreate") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onAbilityForeground") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onAbilityBackground") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onWindowStageDestroy") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onAbilityDestroy") !== -1).assertTrue();
        expect(listTemp.indexOf("Main5Ability onAbilityCreate") !== -1).assertTrue();
        expect(listTemp.indexOf("Main5Ability onWindowStageCreate") !== -1).assertTrue();
        expect(listTemp.indexOf("Main5Ability onAbilityForeground") !== -1).assertTrue();
        expect(listTemp.indexOf("Main5Ability onAbilityBackground") !== -1).assertTrue();
        expect(listTemp.indexOf("Main5Ability onWindowStageDestroy") !== -1).assertTrue();
        expect(listTemp.indexOf("Main5Ability onAbilityDestroy") !== -1).assertTrue();

        globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
          done();
        })
      }, 5200);
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0700
     * @tc.name    Multiple registration/unregistration
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0700", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0700 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0700";
      let code1: number;
      let code2: number;
      let code3: number;
      let id1: number;
      let id2: number;
      let id3: number;
      let listKey8: Array<string> = [];
      let abilityLifecycleCallback: AbilityLifecycleCallback = {
        onAbilityCreate(ability) {
          console.log(TAG + " onAbilityCreate ability:" + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " onAbilityCreate abilityname:" + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityCreate");
          listKey8.push(abilityname + " onAbilityCreate");
        },
        onWindowStageCreate(ability, windowStage) {
          console.log(TAG + " onWindowStageCreate ability:" + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " onWindowStageCreate abilityname:" + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onWindowStageCreate");
          listKey8.push(abilityname + " onWindowStageCreate");
        },
        onWindowStageActive(ability, windowStage) {
          let abilityname = ability.context.abilityInfo.name;
          console.log(abilityname + " onWindowStageActive")
        },
        onWindowStageInactive(ability, windowStage) {
          let abilityname = ability.context.abilityInfo.name;
          console.log(abilityname + " onWindowStageInactive")
        },
        onWindowStageDestroy(ability, windowStage) {
          console.log(TAG + " AbilityLifecycleCallback1 onWindowStageDestroy ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onWindowStageDestroy abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onWindowStageDestroy");
          listKey8.push(abilityname + " onWindowStageDestroy");
        },
        onAbilityDestroy(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityDestroy ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityDestroy abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityDestroy");
          listKey8.push(abilityname + " onAbilityDestroy");
        },
        onAbilityForeground(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityForeground ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityForeground abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityForeground");
          listKey8.push(abilityname + " onAbilityForeground");
        },
        onAbilityBackground(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityBackground ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityBackground abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityBackground");
          listKey8.push(abilityname + " onAbilityBackground");
        },
        onAbilityContinue(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityContinue ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityContinue abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityContinue");
          listKey8.push(abilityname + " onAbilityContinue");
        }
      }
      let applicationContext: common.ApplicationContext =
        globalThis.abilityContext.getApplicationContext() as common.ApplicationContext;
      id1 = applicationContext.on('abilityLifecycle', abilityLifecycleCallback);
      console.log(TAG + " registerAbilityLifecycleCallback1 number: " + JSON.stringify(id1));

      applicationContext.off('abilityLifecycle', id1, (error: ESObject) => {
        console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        code1 = error ? error.code : 0;
      })
      setTimeout(() => {
        id2 = applicationContext.on('abilityLifecycle', abilityLifecycleCallback);
        console.log(TAG + " registerAbilityLifecycleCallback2 number: " + JSON.stringify(id2));
        applicationContext.off('abilityLifecycle', id2, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
          code2 = error ? error.code : 0;
        })
      }, 1000);
      setTimeout(() => {
        id3 = applicationContext.on('abilityLifecycle', abilityLifecycleCallback);
        console.log(TAG + " registerAbilityLifecycleCallback3 number: " + JSON.stringify(id3));

        applicationContext.off('abilityLifecycle', id3, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback3 success, err: " + JSON.stringify(error));
          code3 = error ? error.code : 0;
          expect(id1 > 0).assertTrue();
          expect(id2).assertEqual(id1 + 1);
          expect(id3).assertEqual(id2 + 1);
          expect(code1).assertEqual(0);
          expect(code2).assertEqual(0);
          expect(code3).assertEqual(0);
          console.log("------------Crossplatform_Singlehap_LifeCycleTest_0700 END-------------");
          done();
        })

      }, 3000);
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0800
     * @tc.name    Maninability1 Register listening, Repeat starting and termination Ability2
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0800", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0800 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0800";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });

      }, 1500);
      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });

      }, 4500);

      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });
      }, 7500);

      setTimeout(() => {
        console.log(TAG + " registerAbilityLifecycleCallback listKey : " + JSON.stringify(globalThis.list1));
        console.log(TAG + " registerAbilityLifecycleCallback callbackid : " + JSON.stringify(globalThis.callbackid1));
        let listTemp = JSON.stringify(globalThis.list1);
        console.log(TAG + " listTemp is :" + listTemp);
        try {
          expect(listTemp.indexOf("Main1Ability onWindowStageCreate") !== -1).assertTrue();
          expect(listTemp.split("Main1Ability onAbilityForeground").length - 1).assertEqual(3);
          expect(listTemp.split("Main1Ability onAbilityBackground").length - 1).assertEqual(3);
          expect(listTemp.split("Main2Ability onAbilityCreate").length - 1).assertEqual(3);
          expect(listTemp.split("Main2Ability onWindowStageCreate").length - 1).assertEqual(3);
          expect(listTemp.split("Main2Ability onAbilityForeground").length - 1).assertEqual(3);
          expect(listTemp.split("Main2Ability onAbilityBackground").length - 1).assertEqual(2);
          expect(listTemp.split("Main2Ability onWindowStageDestroy").length - 1).assertEqual(2);
          expect(listTemp.split("Main2Ability onAbilityDestroy").length - 1).assertEqual(2);
        } catch (error) {
          console.error(`${TAG} startRunning failed: ${JSON.stringify(error)}`);
          done();
        }

        globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
          done();
        })

      }, 9000);
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_0900
     * @tc.name    Repeat switching Ability1 between front and back
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_0900", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_0900 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_0900";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });
      }, 500);
      setTimeout(() => {
        let str1: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });
      }, 3000);
      setTimeout(() => {
        console.log(TAG + " registerAbilityLifecycleCallback listKey : " + JSON.stringify(globalThis.list1));
        console.log(TAG + " registerAbilityLifecycleCallback callbackid : " + JSON.stringify(globalThis.callbackid1));
        let listTemp = JSON.stringify(globalThis.list1);
        console.log(TAG + " listTemp is :" + listTemp);
        expect(listTemp.indexOf("Main1Ability onWindowStageCreate") !== -1).assertTrue();
        expect(listTemp.split("Main1Ability onAbilityForeground").length - 1).assertEqual(3);
        expect(listTemp.split("Main1Ability onAbilityBackground").length - 1).assertEqual(2);
        expect(listTemp.split("Main2Ability onAbilityCreate").length - 1).assertEqual(2);
        expect(listTemp.split("Main2Ability onWindowStageCreate").length - 1).assertEqual(2);
        expect(listTemp.split("Main2Ability onAbilityForeground").length - 1).assertEqual(2);
        expect(listTemp.split("Main2Ability onAbilityBackground").length - 1).assertEqual(2);
        expect(listTemp.split("Main2Ability onWindowStageDestroy").length - 1).assertEqual(2);
        expect(listTemp.split("Main2Ability onAbilityDestroy").length - 1).assertEqual(2);

        globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
          done();
        })
      }, 5500);
    });


    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_1000
     * @tc.name    Register listening in abilityA foreground,repeat the registration (standard)
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_1000", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_1000 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_1000";
      let id1: number;
      let id2: number;
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main8Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      setTimeout(() => {
        console.log(TAG + " firstCallback listKey : " + JSON.stringify(globalThis.list8));
        console.log(TAG + " firstCallback callbackid : " + JSON.stringify(globalThis.callbackid8));
        id1 = globalThis.callbackid8;
        console.log(TAG + " firstCallback id : " + JSON.stringify(id1));
        let str: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main8Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });
      }, 2000);
      setTimeout(() => {
        console.log(TAG + " secondCallback listKey : " + JSON.stringify(globalThis.list8));
        console.log(TAG + " secondCallback callbackid : " + JSON.stringify(globalThis.callbackid8));
        id2 = globalThis.callbackid8;
        console.log(TAG + " secondCallback id : " + JSON.stringify(id2));
        expect(id1 + 1).assertEqual(id2);

        globalThis.applicationContext8.off('abilityLifecycle', globalThis.callbackid8, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        })
        let para: common.AbilityResult = {
          resultCode: 1,
          want: {
            abilityName: "Main8Ability",
            bundleName: "com.test.lifecycle_crossplatform_xts",
            moduleName: moduleName,
          },
        };
        console.log(TAG + " terminateSelfwithresult para: " + JSON.stringify(para));

        globalThis.ability8.terminateSelf((error: ESObject, data: ESObject) => {
          console.log(TAG + " terminateSelfwithresult success, err: " + JSON.stringify(error) +
            ",data: " + JSON.stringify(data));
          console.log("------------Crossplatform_Singlehap_LifeCycleTest_1200 END-------------");
          done();
        });

      }, 4000);
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_1100
     * @tc.name    The ability of HAP A listens to the ability lifecycle callback of HAP B (standard)
     * @tc.desc    Function test
     * @tc.level   0
     */
    it("Crossplatform_Singlehap_LifeCycleTest_1100", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_1100 start-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_1100";
      listKeyTemp = [];
      globalThis.abilityContext.startAbility({
        bundleName: "com.example.lifecycle",
        abilityName: "Main9Ability",
        moduleName: moduleName
      }, (error: ESObject, data: ESObject) => {
        console.log(TAG + ": Main9Ability startAbility success, err: " + JSON.stringify(error) +
          ",data: " + JSON.stringify(data));
      });
      await sleep(500);
      globalThis.abilityContext.startAbility({
        bundleName: "com.example.lifecycle",
        abilityName: "Hap1Main2Ability",
        moduleName: moduleName
      }, (error: ESObject, data: ESObject) => {
        console.log(TAG + ":first Hap1Main2Ability startAbility success, err: " + JSON.stringify(error) +
          ",data: " + JSON.stringify(data));
      });
      await sleep(500);
      globalThis.abilityContext.startAbility({
        bundleName: "com.example.lifecycle",
        abilityName: "Hap1Main2Ability",
        moduleName: moduleName
      }, (error: ESObject, data: ESObject) => {
        setTimeout(() => {
          console.log(TAG + ": second Hap1Main2Ability startAbility success, err: " + JSON.stringify(error) +
            ",data: " + JSON.stringify(data));
          for (let i = 0; i < globalThis.Main9AbilityListKey.length; i++) {
            if (globalThis.Main9AbilityListKey[i].substring(0, 16) == "Hap1Main2Ability") {
              listKeyTemp.push(globalThis.Main9AbilityListKey[i]);
            }
          }
          let listTemp = JSON.stringify(globalThis.Main9AbilityListKey);
          console.log(TAG + "listTemp is :" + listTemp);
          console.log(TAG + "globalThis.Main9AbilityCallBackId is :" + globalThis.Main9AbilityCallBackId);
          expect(listTemp.split("Hap1Main2Ability onAbilityCreate").length - 1).assertEqual(2);
          expect(listTemp.split("Hap1Main2Ability onWindowStageCreate").length - 1).assertEqual(2);
          expect(listTemp.split("Hap1Main2Ability onAbilityForeground").length - 1).assertEqual(2);
          expect(listTemp.split("Hap1Main2Ability onAbilityBackground").length - 1).assertEqual(2);
          expect(listTemp.split("Hap1Main2Ability onWindowStageDestroy").length - 1).assertEqual(2);
          expect(listTemp.split("Hap1Main2Ability onAbilityDestroy").length - 1).assertEqual(2);

          globalThis.applicationContext9.off('abilityLifecycle', globalThis.Main9AbilityCallBackId,
            (error: ESObject) => {
              console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
              done();
            })
        }, 3000)
      });
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_1100 end-------------");
    });


    let callbackid_NA = 100
    let callbackid_errorNum = -1

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_1200
     * @tc.name    input Nonexistent callbackid for unregisterAbilityLifecycleCallback parameter
     * @tc.desc    Function test
     * @tc.level   1
     */
    it("Crossplatform_Singlehap_LifeCycleTest_1200", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_1200 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_1200";
      let code: number;

      globalThis.abilityContext.getApplicationContext().off('abilityLifecycle', callbackid_NA, (error: ESObject) => {
        console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        code = error.code;
        sleep(1000);
        expect(code).assertEqual(401);
        done();
      })
    });

    /*
     * @tc.number  Crossplatform_Singlehap_LifeCycleTest_1300
     * @tc.name    input error callbackid for unregisterAbilityLifecycleCallback parameter
     * @tc.desc    Function test
     * @tc.level   1
     */
    it("Crossplatform_Singlehap_LifeCycleTest_1300", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_1300 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_1300";
      let code: number;

      globalThis.abilityContext.getApplicationContext()
        .off('abilityLifecycle', callbackid_errorNum, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
          code = error.code;
          sleep(1000);
          expect(code).assertEqual(401);
          done();
        })
    });

    /*
    * @tc.number  Crossplatform_Singlehap_LifeCycleTest_1400
    * @tc.name    Register in abilityA,register in abilityB, starting and termination abilityC,
                  termination abilityB、abilityA, Re-register in abilityA、abilityB
    * @tc.desc    Function test
    * @tc.level   0
    */
    it("Crossplatform_Singlehap_LifeCycleTest_1400", 0, async (done: Function) => {
      console.log("------------Crossplatform_Singlehap_LifeCycleTest_1400 START-------------");
      TAG = "Crossplatform_Singlehap_LifeCycleTest_1400";
      let id1: number;
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      setTimeout(() => {
        let str2: Want = {
          "bundleName": "com.example.lifecycle",
          "abilityName": "Main2Ability",
          "moduleName": moduleName
        }

        globalThis.abilityContext.startAbility(str2, (error: ESObject, data: ESObject) => {
          if (error.code) {
            console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
          } else {
            console.info(TAG + ' start successful. Data: ' + data);
          }
        });
      }, 1000);
      setTimeout(() => {
        console.log(TAG + " firstCallback listKey1 : " + JSON.stringify(globalThis.list1));
        console.log(TAG + " firstCallback callbackid1 : " + JSON.stringify(globalThis.callbackid1));
        id1 = globalThis.callbackid1;
        console.log(TAG + " firstCallback id1 : " + JSON.stringify(id1));
        let para: common.AbilityResult = {
          resultCode: 2100,
          want: {
            abilityName: "Main1Ability",
            bundleName: "com.test.lifecycle_crossplatform_xts",
            moduleName: moduleName,
          },
        };
        console.log(TAG + " terminateSelfwithresult para: " + JSON.stringify(para));

        globalThis.ability1context.terminateSelf()
          .then((data: ESObject) => {
            console.log(TAG + " terminateSelfwithresult successful data: " + JSON.stringify(data));
          }).catch((error: BusinessError) => {
          console.log(TAG + " terminateSelfwithresult error: " + JSON.stringify(error));
        });
      }, 4500);
      setTimeout(() => {
        let listTemp = JSON.stringify(globalThis.list1);
        console.log(TAG + " listTemp is :" + listTemp);
        expect(listTemp.indexOf("Main2Ability onAbilityCreate") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onWindowStageCreate") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onAbilityForeground") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onAbilityBackground") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onWindowStageDestroy") !== -1).assertTrue();
        expect(listTemp.indexOf("Main2Ability onAbilityDestroy") !== -1).assertTrue();

        globalThis.applicationContext1
          .off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
            console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
            done();
          })
      }, 7000);
    });

    /*
     * @tc.number  Crossplatform_AbilityStage_onCreate_Test_0100
     * @tc.name    Crossplatform_AbilityStage_onCreate_Test_0100
     * @tc.desc    Start Main2Ability, test stage ability onCreate
     * @tc.level   0
     */
    it("Crossplatform_AbilityStage_onCreate_Test_0100", 0, async (done: Function) => {
      console.log(
        "------------Crossplatform_AbilityStage_onCreate_Test_0100 START-------------");
      TAG = "Crossplatform_AbilityStage_onCreate_Test_0100";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main2Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      setTimeout(() => {
        // abilitystage的onCreatre里注册了globalThis.applicationContext，globalThis.applicationContext不为null
        // 则oncreate触发成功。
        expect(globalThis.applicationContext != null).assertTrue();
        done();
      }, 3000);
    })

    /*
     * @tc.number  Crossplatform_AbilityStage_Context_Test_0100
     * @tc.name    Crossplatform_AbilityStage_Context_Test_0100
     * @tc.desc    Start Main2Ability, test stage ability context
     * @tc.level   0
    */
    it("Crossplatform_AbilityStage_Context_Test_0100", 0, async (done: Function) => {
      console.log("------------Crossplatform_AbilityStage_Context_Test_0100 START-------------");
      TAG = "Crossplatform_AbilityStage_Context_Test_0100";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main2Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      setTimeout(() => {
        // abilitystage的onCreatre里注册了globalThis.applicationContext，globalThis.applicationContext不为null
        // 则oncreate触发成功,且context能够获取。
        console.log('Crossplatform_AbilityStage_Context_Test_0100 1000');
        expect(globalThis.ability2 != null).assertTrue();
        console.log('Crossplatform_AbilityStage_Context_Test_0100 1001');
        expect(globalThis.ability2.currentHapModuleInfo != null).assertTrue();
        console.log('Crossplatform_AbilityStage_Context_Test_0100 1002');
        expect(globalThis.ability2.config != null).assertTrue();
        done();
      }, 1000);
    })

    /*
     * @tc.number  Crossplatform_Multi_LifeCycleTest_0200
     * @tc.name    Crossplatform_Multi_LifeCycleTest_0200
     * @tc.desc    start multi ability1, then start multi ability1, check life cycle
     * @tc.level   0
    */
    it("Crossplatform_Multi_LifeCycleTest_0200", 0, async (done: Function) => {
      console.log("------------Crossplatform_Multi_LifeCycleTest_0200 START-------------");
      TAG = "Crossplatform_Multi_LifeCycleTest_0200";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "MultiMainAbility",
        "moduleName": moduleName
      }

      // 第一次起MultiMainAbility
      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      await sleep(1500);

      let listtemp: Array<string> = [];
      for (let i = 0; i < globalThis.mlist1.length; i++) {
        let item: string = globalThis.mlist1[i];
        if (item.indexOf('MultiMainAbility') != -1) {
          listtemp.push(item);
        }
      }
      console.info(TAG + 'list:' + listtemp);

      expect(listtemp).assertContain('MultiMainAbility onWindowStageCreate');
      expect(listtemp).assertContain('MultiMainAbility onAbilityForeground');

      // 第二次起MultiMainAbility
      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });
      await sleep(1500);

      for (let i = 0; i < globalThis.mlist1.length; i++) {
        let item: string = globalThis.mlist1[i];
        if (item.indexOf('MultiMainAbility') != -1) {
          listtemp.push(item);
        }
      }
      console.info(TAG + 'list:' + listtemp);
      expect(listtemp).assertContain('MultiMainAbility onAbilityCreate');
      expect(listtemp).assertContain('MultiMainAbility onWindowStageCreate');
      done();

    })

    /*
     * @tc.number  Crossplatform_LifeCycleTest_on_0100
     * @tc.name    Crossplatform_LifeCycleTest_on_0100
     * @tc.desc    on abilityLifecycle twice in mainability13
     * @tc.level   0
    */
    it("Crossplatform_LifeCycleTest_on_0100", 0, async (done: Function) => {
      console.log("------------Crossplatform_LifeCycleTest_on_0100 START-------------");
      TAG = "Crossplatform_LifeCycleTest_on_0100";
      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main13Ability",
        "moduleName": moduleName
      }

      // 第一次起MultiMainAbility
      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      await sleep(2500);
      console.log(TAG + 'list1:' + globalThis.list13);
      let list1: Array<string> = globalThis.list13;
      console.log(TAG + 'list2:' + globalThis.otherList13);
      let list2: Array<string> = globalThis.otherList13;

      expect(list1[0]).assertEqual(list2[0]);
      expect(list1[1]).assertEqual(list2[1]);
      expect(list1[2]).assertEqual(list2[2]);
      globalThis.ability13.terminateSelf();
      done();
    });

    /*
      * @tc.number  Crossplatform_LifeCycleTest_on_0200
      * @tc.name    Crossplatform_LifeCycleTest_on_0200
      * @tc.desc    Function test
      * @tc.level   0
      */
    it("Crossplatform_LifeCycleTest_on_0200", 0, async (done: Function) => {
      console.log("------------Crossplatform_LifeCycleTest_on_0200 START-------------");
      TAG = "Crossplatform_LifeCycleTest_on_0200";
      let listKey14: Array<string> = [];
      let abilityLifecycleCallback: AbilityLifecycleCallback = {
        onAbilityCreate(ability) {
          console.log(TAG + " onAbilityCreate ability:" + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " onAbilityCreate abilityname:" + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityCreate");
          listKey14.push(abilityname + " onAbilityCreate");
        },
        onWindowStageCreate(ability, windowStage) {
          console.log(TAG + " onWindowStageCreate ability:" + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " onWindowStageCreate abilityname:" + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onWindowStageCreate");
          listKey14.push(abilityname + " onWindowStageCreate");
        },
        onWindowStageActive(ability, windowStage) {
          let abilityname = ability.context.abilityInfo.name;
          console.log(abilityname + " onWindowStageActive")
        },
        onWindowStageInactive(ability, windowStage) {
          let abilityname = ability.context.abilityInfo.name;
          console.log(abilityname + " onWindowStageInactive")
        },
        onWindowStageDestroy(ability, windowStage) {
          console.log(TAG + " AbilityLifecycleCallback1 onWindowStageDestroy ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onWindowStageDestroy abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onWindowStageDestroy");
          listKey14.push(abilityname + " onWindowStageDestroy");
        },
        onAbilityDestroy(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityDestroy ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityDestroy abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityDestroy");
          listKey14.push(abilityname + " onAbilityDestroy");
        },
        onAbilityForeground(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityForeground ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityForeground abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityForeground");
          listKey14.push(abilityname + " onAbilityForeground");
        },
        onAbilityBackground(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityBackground ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityBackground abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityBackground");
          listKey14.push(abilityname + " onAbilityBackground");
        },
        onAbilityContinue(ability) {
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityContinue ability:"
            + JSON.stringify(ability));
          let abilityname = ability.context.abilityInfo.name;
          console.log(TAG + " AbilityLifecycleCallback1 onAbilityContinue abilityname:"
            + JSON.stringify(abilityname));
          console.log(TAG + " " + abilityname + " onAbilityContinue");
          listKey14.push(abilityname + " onAbilityContinue");
        }
      }

      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main14Ability",
        "moduleName": moduleName
      }

      // 第一次起MultiMainAbility
      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      await sleep(1000);
      let applicationContext: common.ApplicationContext =
        globalThis.ability14.getApplicationContext() as common.ApplicationContext;

      for (let i = 0; i < 10; i++) {
        const tempId = applicationContext.on('abilityLifecycle', abilityLifecycleCallback);
        console.log(TAG + " registerAbilityLifecycleCallback1 number: " + JSON.stringify(tempId));

        applicationContext.off('abilityLifecycle', tempId, (error: ESObject) => {
          console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        })
      }

      applicationContext.on('abilityLifecycle', abilityLifecycleCallback);
      await sleep(1000);
      globalThis.ability14.terminateSelf();
      await sleep(1000);
      let listTemp = JSON.stringify(listKey14);
      console.info(TAG + "list:" + listTemp);

      expect(listTemp.indexOf("Main14Ability onAbilityBackground") !== -1).assertTrue();
      expect(listTemp.indexOf("Main14Ability onWindowStageDestroy") !== -1).assertTrue();
      expect(listTemp.indexOf("Main14Ability onAbilityDestroy") !== -1).assertTrue();
      done();
    });

    /*
     * @tc.number  Crossplatform_LifeCycleTest_on_0300
     * @tc.name    Crossplatform_LifeCycleTest_on_0300
     * @tc.desc    unregister callback id which is not exists.
     * @tc.level   0
    */
    it("Crossplatform_LifeCycleTest_on_0300", 0, async (done: Function) => {
      console.log("------------Crossplatform_LifeCycleTest_on_0300 START-------------");
      TAG = "Crossplatform_LifeCycleTest_on_0300";

      let applicationContext: common.ApplicationContext =
        globalThis.abilityContext.getApplicationContext() as common.ApplicationContext;
      applicationContext.off('abilityLifecycle', 100, (error: ESObject) => {
        expect(error.code).assertEqual(401);
        console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        done();
      })
    });

    /*
     * @tc.number  Crossplatform_LifeCycleTest_on_0400
     * @tc.name    Crossplatform_LifeCycleTest_on_0400
     * @tc.desc    unregister callback twice.
     * @tc.level   0
    */
    it("Crossplatform_LifeCycleTest_on_0400", 0, async (done: Function) => {
      console.log("------------Crossplatform_LifeCycleTest_on_0400 START-------------");
      TAG = "Crossplatform_LifeCycleTest_on_0400";

      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      await sleep(3000);
      console.info(TAG + 'list:' + globalThis.list1);

      globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
        console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
      });

      await sleep(500);

      globalThis.applicationContext1.off('abilityLifecycle', globalThis.callbackid1, (error: ESObject) => {
        console.log(TAG + ": unregisterAbilityLifecycleCallback success, err: " + JSON.stringify(error));
        expect(error.code).assertEqual(401);
        done();
      });

    });

    /*
     * @tc.number  Crossplatform_LifeCycleTest_on_0500
     * @tc.name    Crossplatform_LifeCycleTest_on_0500
     * @tc.desc    start other hap's ability in the same app, and register this lifecycle.
     * @tc.level   0
    */
    it("Crossplatform_LifeCycleTest_on_0500", 0, async (done: Function) => {
      console.log("------------Crossplatform_LifeCycleTest_on_0500 START-------------");
      TAG = "Crossplatform_LifeCycleTest_on_0500";

      let str: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "FeatureassistaAbility",
        "moduleName": otherModuleName
      }

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      await sleep(2000);
      console.info(TAG + 'list:' + globalThis.featureList1);

      expect(globalThis.featureList1).assertContain('FeatureassistaAbility onWindowStageCreate');
      expect(globalThis.featureList1).assertContain('FeatureassistaAbility onAbilityForeground');

      globalThis.featureAbilityContext.terminateSelf();
      await sleep(1000);
      done();
    });

    /*
     * @tc.number  Crossplatform_Multi_LifeCycleTest_0100
     * @tc.name    Register in abilitystage,listen to the lifecycle of abilityA, then start other bundle's ablilty
     * @tc.desc    Function test
     * @tc.level   0
    */
    it("Crossplatform_Multi_LifeCycleTest_0100", 0, async (done: Function) => {
      console.log("------------Crossplatform_Multi_LifeCycleTest_0100 START-------------");
      TAG = "Crossplatform_Multi_LifeCycleTest_0100";
      let str1: Want = {
        "bundleName": "com.example.lifecycle",
        "abilityName": "Main1Ability",
        "moduleName": moduleName
      }

      globalThis.abilityContext.startAbility(str1, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
        }
      });

      await sleep(1000);

      let str: Want = {
        "bundleName": otherBundle,
        "abilityName": "EntryAbility",
        "moduleName": 'entry'
      }

      let otherAppResult = 0;

      globalThis.abilityContext.startAbility(str, (error: ESObject, data: ESObject) => {
        if (error.code) {
          console.error(TAG + ' start failed. Cause: ' + JSON.stringify(error));
        } else {
          console.info(TAG + ' start successful. Data: ' + data);
          otherAppResult = 1;
        }
      });
      await sleep(1000);
      expect(otherAppResult == 1).assertTrue();
      let list1: Array<string> = globalThis.list1;
      console.info(TAG + 'list: ' + list1);
      done();
    })


  })
}