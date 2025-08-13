/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from "@ohos/hypium";
import dataPreferences from "@ohos.data.preferences";
import { BusinessError } from '@ohos.base';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const NAME = "test_preferences";
const KEY_TEST_STRING_ELEMENT = "key_test_string";
const KEY_TEST_INT_ELEMENT = "key_test_int";
let mPreferences: dataPreferences.Preferences;

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function preferencesHelperTest() {
  describe("preferencesHelperTest", () => {
    beforeAll(async () => {
      console.info("beforeAll");
      mPreferences = await dataPreferences.getPreferences(context, NAME);
    });
    afterAll(async () => {
      console.info("afterAll");
      await dataPreferences.deletePreferences(context, NAME);
    });
    afterEach(async () => {
      await sleep(1000);
    })

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_GetPreferencesJSAPITest_1300
     * @tc.name   : testGetPreferencesHelper0001
     * @tc.desc   : GetPreferencesSync interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testGetPreferencesHelper0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      mPreferences = await dataPreferences.getPreferences(context, NAME);
      await mPreferences.put(KEY_TEST_STRING_ELEMENT, "test");
      await mPreferences.flush();
      let value = await mPreferences.get(KEY_TEST_STRING_ELEMENT, 0);
      expect(value).assertEqual("test");
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_GetPreferencesJSAPITest_1200
     * @tc.name   : testGetPreferencesHelper0002
     * @tc.desc   : GetPreferences interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testGetPreferencesHelper0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const promise = dataPreferences.getPreferences(context, NAME);
      let preferences: dataPreferences.Preferences | null = null;
      promise
        .then(async (pref) => {
          preferences = pref;
          await preferences.put(KEY_TEST_STRING_ELEMENT, "test");
          preferences.get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, ret) => {
            expect("test").assertEqual(ret);
          });
          await dataPreferences.deletePreferences(context, NAME);
          console.info("Succeeded in getting preferences.");
          done();
        })
        .catch((err: BusinessError) => {
          expect(!err).assertTrue();
        });
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_RemoveJSAPITest_1300
     * @tc.name   : testRemovePreferencesFromCacheHelper0001
     * @tc.desc   : RemovePreferencesFromCache interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testRemovePreferencesFromCacheHelper0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, NAME);
        const promise = dataPreferences.removePreferencesFromCache(context, NAME);
        promise
          .then(() => {
            console.info("Succeeded in removing preferences.");
            expect("{}").assertEqual(JSON.stringify(preferences));
            done();
          })
          .catch((err: BusinessError) => {
            expect(!err).assertTrue();
          });
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_RemoveJSAPITest_0600
     * @tc.name   : testRemovePreferencesFromCacheHelper0004
     * @tc.desc   : RemovePreferencesFromCache interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testRemovePreferencesFromCacheHelper0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, NAME);
        await preferences.put(KEY_TEST_STRING_ELEMENT, "test");
        preferences.get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, ret) => {
          expect("test").assertEqual(ret);
        });
        dataPreferences
          .removePreferencesFromCache(context, "test_preferences1")
          .then(() => {
            console.info("Succeeded in removing preferences.");
            (preferences as dataPreferences.Preferences).get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, pre) => {
              expect("test").assertEqual(pre);
              done();
            });
          })
          .catch((err: BusinessError) => {
            console.info("Remove preferences from cache error: " + err);
            expect(!err).assertTrue();
            done();
          });
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_RemoveJSAPITest_0800
     * @tc.name   : testRemovePreferencesFromCacheHelper0005
     * @tc.desc   : RemovePreferencesFromCache interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testRemovePreferencesFromCacheHelper0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, {
          name: NAME
        });
        const promise = dataPreferences.removePreferencesFromCache(context, {
          name: NAME
        });
        promise
          .then(() => {
            console.info("Succeeded in removing preferences.");
            expect("{}").assertEqual(JSON.stringify(preferences));
            done();
          })
          .catch((err: BusinessError) => {
            expect(!err).assertTrue();
          });
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_RemoveJSAPITest_0700
     * @tc.name   : testRemovePreferencesFromCacheHelper0006
     * @tc.desc   : RemovePreferencesFromCache interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testRemovePreferencesFromCacheHelper0006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, {
          name: NAME
        });
        await preferences.put(KEY_TEST_STRING_ELEMENT, "test");
        preferences.get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, ret) => {
          expect("test").assertEqual(ret);
        });
        dataPreferences
          .removePreferencesFromCache(context, {
            name: "test_preferences1"
          })
          .then(() => {
            console.info("Succeeded in removing preferences.");
            (preferences as dataPreferences.Preferences).get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, pre) => {
              expect("test").assertEqual(pre);
              done();
            });
          })
          .catch((err: BusinessError) => {
            console.info("Remove preferences from cache error: " + err);
            expect(!err).assertTrue();
            done();
          });
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_DeleteJSAPITest_1800
     * @tc.name   : testPreferencesDeleteHelper0001
     * @tc.desc   : DeletePreferences interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testPreferencesDeleteHelper0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, NAME);
        const promise = dataPreferences.deletePreferences(context, NAME);
        promise
          .then(() => {
            console.info("Succeeded in deleting preferences.");
            expect("{}").assertEqual(JSON.stringify(preferences));
            done();
          })
          .catch((err: BusinessError) => {
            console.info("Delete preferences err: " + err);
            expect(!err).assertTrue();
          });
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_DeleteJSAPITest_0700
     * @tc.name   : testPreferencesDeleteHelper0004
     * @tc.desc   : DeletePreferences interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testPreferencesDeleteHelper0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, NAME);
        await preferences.put(KEY_TEST_STRING_ELEMENT, "test");
        preferences.get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, ret) => {
          expect("test").assertEqual(ret);
        });
        dataPreferences
          .deletePreferences(context, "test_preferences1")
          .then(() => {
            console.info("Succeeded in deleting preferences.");
            (preferences as dataPreferences.Preferences).get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, pre) => {
              expect("test").assertEqual(pre);
              done();
            });
          })
          .catch((err: BusinessError) => {
            console.info("Delete preferences err: " + err);
            expect(!err).assertTrue();
            done();
          });
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_DeleteJSAPITest_0900
     * @tc.name   : testPreferencesDeleteHelper0005
     * @tc.desc   : DeletePreferences interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testPreferencesDeleteHelper0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, {
          name: NAME
        });
        const promise = dataPreferences.deletePreferences(context, {
          name: NAME
        });
        promise
          .then(() => {
            console.info("Succeeded in deleting preferences.");
            expect("{}").assertEqual(JSON.stringify(preferences));
            done();
          })
          .catch((err: BusinessError) => {
            console.info("Delete preferences err: " + err);
            expect(!err).assertTrue();
          });
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_DeleteJSAPITest_0800
     * @tc.name   : testPreferencesDeleteHelper0006
     * @tc.desc   : DeletePreferences interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testPreferencesDeleteHelper0006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let preferences: dataPreferences.Preferences | null = null;
        preferences = await dataPreferences.getPreferences(context, {
          name: NAME
        });
        await preferences.put(KEY_TEST_STRING_ELEMENT, "test");
        preferences.get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, ret) => {
          expect("test").assertEqual(ret);
        });
        dataPreferences
          .deletePreferences(context, {
            name: "test_preferences1"
          })
          .then(() => {
            console.info("Succeeded in deleting preferences.");
            (preferences as dataPreferences.Preferences).get(KEY_TEST_STRING_ELEMENT, "defaultvalue", (err, pre) => {
              expect("test").assertEqual(pre);
              done();
            });
          })
          .catch((err: Function) => {
            console.info("Delete preferences err: " + err);
            expect(!err).assertTrue();
            done();
          });
      });

    /**
     * @tc.number  : SUB_DistributeData_CrossPlatform_SDK_Preferences_JSAPITest_0400
     * @tc.name    : testMaxKeyLength001
     * @tc.desc    : Test key length
     * @tc.size    : MediumTest
     * @tc.type    : Constant
     * @tc.level   : Level 0
     */
    it("testMaxKeyLength001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(dataPreferences.MAX_KEY_LENGTH == 1024).assertTrue();
    });

    /**
     * @tc.number  : SUB_DistributeData_CrossPlatform_SDK_Preferences_JSAPITest_0500
     * @tc.name    : testMaxValueLength001
     * @tc.desc    : Test value length
     * @tc.size    : MediumTest
     * @tc.type    : Constant
     * @tc.level   : Level 0
     */
    it("testMaxValueLength001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(dataPreferences.MAX_VALUE_LENGTH == 16 * 1024 * 1024).assertTrue();
    });

    /**
     * @tc.number  : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0800
     * @tc.name    : testPreferencesOn001
     * @tc.desc    : Test on interface
     * @tc.size    : MediumTest
     * @tc.type    : Constant
     * @tc.level   : Level 0
     */
    it("testPreferencesOn001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      try {
        await mPreferences.clear();
        let observer = (key: string) => {
          console.info("testPreferencesOn001 key " + key);
          expect(KEY_TEST_STRING_ELEMENT).assertEqual(key);
        };
        mPreferences.on("change", observer);
        await mPreferences.put(KEY_TEST_STRING_ELEMENT, "abcd");
        await mPreferences.flush();
      } catch (err) {
        console.info("Failed to testPreferencesOn001. code =" + err.code + ", message =" + err.message);
        expect(!err).assertTrue();
      }
    });

    /**
     * @tc.number  : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0400
     * @tc.name    : testPreferencesOn003
     * @tc.desc    : Test on interface
     * @tc.size    : MediumTest
     * @tc.type    : Constant
     * @tc.level   : Level 0
     */
    it("testPreferencesOn003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      try {
        await mPreferences.clear();
        let observer = (key: string) => {
          console.info("testPreferencesOn003 key " + key);
          expect(KEY_TEST_STRING_ELEMENT).assertEqual(key);
        };
        mPreferences.on(null, observer);
        expect().assertFail();
      } catch (err) {
        console.info("Failed to testPreferencesOn003. code =" + err.code + ", message =" + err.message);
        expect("401").assertEqual(err.code);
      }
    });

    /**
     * @tc.number  : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0200
     * @tc.name    : testPreferencesOff001
     * @tc.desc    : Test off interface
     * @tc.size    : MediumTest
     * @tc.type    : Constant
     * @tc.level   : Level 0
     */
    it("testPreferencesOff001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      try {
        await mPreferences.clear();
        let isTrigger = false;
        let observer = (key: string) => {
          console.info("testPreferencesOff001 key" + key);
          isTrigger = true;
        };
        mPreferences.on("change", observer);
        mPreferences.off("change", observer);
        await mPreferences.put(KEY_TEST_STRING_ELEMENT, "abc");
        await mPreferences.flush();
        await sleep(1000);
        expect(isTrigger === false).assertTrue();
      } catch (err) {
        console.info("Failed to testPreferencesOff001. code =" + err.code + ", message =" + err.message);
        expect(!err).assertTrue();
      }
    });

    /**
     * @tc.number  : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0100
     * @tc.name    : testPreferencesOff002
     * @tc.desc    : Test off interface
     * @tc.size    : MediumTest
     * @tc.type    : Constant
     * @tc.level   : Level 0
     */
    it("testPreferencesOff002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      try {
        await mPreferences.clear();
        let isTrigger = false;
        let observer = (key: string) => {
          console.info("testPreferencesOff001 key" + key);
          isTrigger = true;
        };
        mPreferences.on("change", observer);
        mPreferences.off("change");
        await mPreferences.put(KEY_TEST_STRING_ELEMENT, "abc");
        await mPreferences.flush();
        await sleep(1000);
        expect(isTrigger === false).assertTrue();
      } catch (err) {
        console.info("Failed to testPreferencesOff001. code =" + err.code + ", message =" + err.message);
        expect(!err).assertTrue();
      }
    });

    /**
     * @tc.number  : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0700
     * @tc.name    : testPreferencesOff003
     * @tc.desc    : Test off interface
     * @tc.size    : MediumTest
     * @tc.type    : Constant
     * @tc.level   : Level 0
     */
    it("testPreferencesOff003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      try {
        await mPreferences.clear();
        let isTrigger = false;
        let observer = (key: string) => {
          console.info("testPreferencesOff003 key" + key);
          isTrigger = true;
        };
        mPreferences.on("change", observer);
        mPreferences.off(null);
        expect().assertFail();
      } catch (err) {
        console.info("Failed to testPreferencesOff003. code =" + err.code + ", message =" + err.message);
        expect("401").assertEqual(err.code);
      }
    });
  });
}
