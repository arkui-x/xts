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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from "@ohos/hypium";
import data_preferences from "@ohos.data.preferences";
import { BusinessError } from '@ohos.base';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const NAME = "test_preferences_promise_with_error";
const KEY_TEST_INT_ELEMENT = "key_test_int";
const KEY_TEST_STRING_ELEMENT = "key_test_string";
let mPreference: data_preferences.Preferences;

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function preferencesPromiseWithErrorTest() {
  describe("preferencesPromiseWithErrorTest", () => {
    beforeAll(async () => {
      console.info("beforeAll");
      mPreference = await data_preferences.getPreferences(context, NAME);
    });
    afterAll(async () => {
      console.info("afterAll");
      await data_preferences.deletePreferences(context, NAME);
    });
    beforeEach(async () => {
      console.info("beforeEach");
      await mPreference.clear();
      await mPreference.flush();
    });
    afterEach(async () => {
      await sleep(1000)
    })

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_JSAPITest_0100
     * @tc.name   : testPreferencesPromiseWithError0001
     * @tc.desc   : Clear、Delete、Put、Get、Flush promise interface test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testPreferencesPromiseWithError0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testPreferencesPromiseWithError0001 begin.");
        try {
          if (mPreference === undefined) {
            console.log("mPreference undefined");
          }
          mPreference
            .clear()
            .then(async () => {
              mPreference
                .put(KEY_TEST_INT_ELEMENT, 123)
                .then(async (ret) => {
                  mPreference
                    .get(KEY_TEST_INT_ELEMENT, 123)
                    .then(async (pre) => {
                      expect(123).assertEqual(pre);
                      mPreference
                        .flush()
                        .then(async () => {
                          mPreference
                            .delete(KEY_TEST_INT_ELEMENT)
                            .then(async () => {
                              console.log("Succeeded in deleting .");
                              let per = await mPreference.get(KEY_TEST_INT_ELEMENT, 0);
                              expect(0).assertEqual(per);
                              done();
                              console.log("testPreferencesPromiseWithError0001 end.");
                            })
                            .catch((err: BusinessError) => {
                              console.log("delete err =" + err + ", code =" + err.code + ", message =" + err.message);
                              expect(!err).assertTrue();
                            });
                        })
                        .catch((err: BusinessError) => {
                          console.log("flush err =" + err + ", code =" + err.code + ", message =" + err.message);
                          expect(!err).assertTrue();
                        });
                    })
                    .catch((err: BusinessError) => {
                      console.log("get err =" + err + ", code =" + err.code + ", message =" + err.message);
                      expect(!err).assertTrue();
                    });
                })
                .catch((err: BusinessError) => {
                  console.log("put err =" + err + ", code =" + err.code + ", message =" + err.message);
                  expect(!err).assertTrue();
                });
            })
            .catch((err: BusinessError) => {
              console.log("clear err =" + err + ", code =" + err.code + ", message =" + err.message);
              expect(!err).assertTrue();
            });
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
        }
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_GetJSAPITest_1200
     * @tc.name   : testMpreferencesGetPromise0003
     * @tc.desc   : mPreference.get promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesGetPromise0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log("testMpreferencesGetPromise0003 begin.");
      try {
        await mPreference.put(KEY_TEST_STRING_ELEMENT, "123");
        mPreference
          .get(KEY_TEST_INT_ELEMENT, "default")
          .then((ret) => {
            expect(ret !== "123").assertTrue();
            done();
            console.log("testMpreferencesGetPromise0003 end." + JSON.stringify(ret));
          })
          .catch((err: BusinessError) => {
            console.log("get err =" + err + ", code =" + err.code + ", message =" + err.message);
            expect(!err).assertTrue();
          });
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
        expect(!err).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_GetJSAPITest_2900
     * @tc.name   : testMpreferencesGetSyncWithError0003
     * @tc.desc   : mPreference.getSync test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesGetSyncWithError0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesGetSyncWithError0003 begin.");
        try {
          await mPreference.put(KEY_TEST_STRING_ELEMENT, "123");
          let ret = mPreference.getSync(KEY_TEST_INT_ELEMENT, "default");
          expect(ret !== "123").assertTrue();
          done();
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
          done();
        }
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_GetJSAPITest_1300
     * @tc.name   : testMpreferencesGetALLPromise0001
     * @tc.desc   : mPreference.getAll promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesGetALLPromise0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesGetALLPromise0001 begin.");
        try {
          mPreference
            .getAll()
            .then((ret) => {
              console.log("getAll val = " + JSON.stringify(ret));
              done();
              console.log("testMpreferencesGetALLPromise0001 end.");
            })
            .catch((err: BusinessError) => {
              console.log("getAll err =" + err + ", code =" + err.code + ", message =" + err.message);
              expect(!err).assertTrue();
            });
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
        }
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_HasJSAPITest_0700
     * @tc.name   : testMpreferencesHasPromise0002
     * @tc.desc   : mPreference.has promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesHasPromise0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log("testMpreferencesHasPromise0002 begin.");
      try {
        mPreference
          .has(KEY_TEST_STRING_ELEMENT)
          .then((val) => {
            done();
            console.log("testMpreferencesHasPromise0002 end.");
          })
          .catch((err: BusinessError) => {
            console.log("has err =" + err + ", code =" + err.code + ", message =" + err.message);
            expect(!err).assertTrue();
          });
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
        expect(!err).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_PutJSAPITest_0400
     * @tc.name   : testMpreferencesPutPromise0002
     * @tc.desc   : mPreference.put promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesPutPromise0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log("testMpreferencesPutPromise0002 begin.");
      try {
        mPreference
          .put(KEY_TEST_STRING_ELEMENT, "")
          .then(async () => {
            let per = await mPreference.get(KEY_TEST_STRING_ELEMENT, "defaultvalue");
            expect("").assertEqual(per);
            done();
            console.log("testMpreferencesPutPromise0002 end.");
          })
          .catch((err: BusinessError) => {
            console.log("put err =" + err + ", code =" + err.code + ", message =" + err.message);
            expect(!err).assertTrue();
            done();
          });
      } catch (err) {
        console.log("trycatch err =1" + err + ", code =" + err.code + ", message =" + err.message);
        expect(!err).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_PutJSAPITest_0300
     * @tc.name   : testMpreferencesPutPromise0003
     * @tc.desc   : mPreference.put promise test   space
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesPutPromise0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log("testMpreferencesPutPromise0003 begin.");
      try {
        mPreference
          .put(KEY_TEST_STRING_ELEMENT, " ")
          .then(async () => {
            let per = await mPreference.get(KEY_TEST_STRING_ELEMENT, "defaultvalue");
            expect(" ").assertEqual(per);
            done();
            console.log("testMpreferencesPutPromise0003 end.");
          })
          .catch((err: BusinessError) => {
            console.log("put err =" + err + ", code =" + err.code + ", message =" + err.message);
            expect(!err).assertTrue();
            done();
          });
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
        expect(!err).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_PutJSAPITest_0500
     * @tc.name   : testMpreferencesPutPromise0005
     * @tc.desc   : mPreference.put promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesPutPromise0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.log("testMpreferencesPutPromise0005 begin.");
      try {
        mPreference
          .put(KEY_TEST_STRING_ELEMENT, null)
          .then(() => {
            expect(mPreference !== null).assertFail();
            done();
            console.log("testMpreferencesPutPromise0005 end.");
          })
          .catch((err: BusinessError) => {
            console.log("put err =" + err + ", code =" + err.code + ", message =" + err.message);
            expect(!err).assertFail();
            done();
          });
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
        expect("401").assertEqual(err.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_PutJSAPITest_1700
     * @tc.name   : testMpreferencesPutSyncWithError0002
     * @tc.desc   : mPreference.putSync test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesPutSyncWithError0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesPutSyncWithError0002 begin.");
        try {
          mPreference.putSync(KEY_TEST_STRING_ELEMENT, "");
          let per = mPreference.getSync(KEY_TEST_STRING_ELEMENT, "defaultvalue");
          expect("").assertEqual(per);
          done();
          console.log("testMpreferencesPutSyncWithError0002 end.");
        } catch (err) {
          console.log("trycatch err =1" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
          done();
        }
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_PutJSAPITest_1600
     * @tc.name   : testMpreferencesPutSyncWithError0003
     * @tc.desc   : mPreference.putSync test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesPutSyncWithError0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesPutSyncWithError0003 begin.");
        try {
          mPreference.putSync(KEY_TEST_STRING_ELEMENT, " ");
          let per = mPreference.getSync(KEY_TEST_STRING_ELEMENT, "defaultvalue");
          expect(" ").assertEqual(per);
          done();
          console.log("testMpreferencesPutSyncWithError0003 end.");
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
          done();
        }
      });
    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_PutJSAPITest_1800
     * @tc.name   : testMpreferencesPutSyncWithError0005
     * @tc.desc   : mPreference.putSync test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesPutSyncWithError0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesPutSyncWithError0005 begin.");
        try {
          mPreference.putSync(KEY_TEST_STRING_ELEMENT, null);
          expect(mPreference !== null).assertFail();
          done();
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect("401").assertEqual(err.code);
          done();
        }
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_DeleteJSAPITest_0200
     * @tc.name   : testMpreferencesDeletePromise0002
     * @tc.desc   : mPreference.delete promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesDeletePromise0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesDeletePromise0002 begin.");
        try {
          mPreference
            .delete(KEY_TEST_STRING_ELEMENT)
            .then(async () => {
              done();
              console.log("testMpreferencesDeletePromise0002 end.");
            })
            .catch((err: BusinessError) => {
              console.log("delete err =" + err + ", code =" + err.code + ", message =" + err.message);
              expect(!err).assertTrue();
            });
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
        }
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_ClearJSAPITest_0100
     * @tc.name   : testMpreferencesClearPromise0001
     * @tc.desc   : mPreference.clear promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesClearPromise0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesClearPromise0001 begin.");
        try {
          mPreference
            .clear()
            .then(() => {
              done();
              console.log("testMpreferencesClearPromise0001 end.");
            })
            .catch((err: BusinessError) => {
              console.log("clear err =" + err + ", code =" + err.code + ", message =" + err.message);
              expect(!err).assertTrue();
            });
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
        }
      });

    /**
     * @tc.number : SUB_DistributeData_CrossPlatform_SDK_Preferences_FlushJSAPITest_0100
     * @tc.name   : testMpreferencesFlushPromise0001
     * @tc.desc   : mPreference.flush promise test
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("testMpreferencesFlushPromise0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.log("testMpreferencesFlushPromise0001 begin.");
        try {
          mPreference
            .flush()
            .then(() => {
              done();
              console.log("testMpreferencesFlushPromise0001 end.");
            })
            .catch((err: BusinessError) => {
              console.log("flush err =" + err + ", code =" + err.code + ", message =" + err.message);
              expect(!err).assertTrue();
            });
        } catch (err) {
          console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message);
          expect(!err).assertTrue();
        }
      });
  });
}
