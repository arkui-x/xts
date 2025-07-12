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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from "@ohos/hypium";
import dataPreferences from "@ohos.data.preferences";
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

type ValueType = number | string | boolean | Array<number> | Array<string> | Array<boolean> | Uint8Array | object
  | bigint;

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const NAME = "test_preferences";
let mPreference: dataPreferences.Preferences;

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function preferencesOnDatachangeTest() {
  describe('preferencesOnDatachangeTest', () => {
    beforeAll(async () => {
      console.info("beforeAll");
      mPreference = await dataPreferences.getPreferences(context, NAME);
    });

    afterAll(async () => {
      console.info("afterAll");
      await dataPreferences.deletePreferences(context, NAME);
    });

    afterEach(async () => {
      await sleep(1000);
    })

    /**
     * @tc.name      : testPreferencesDataChange001
     * @tc.number    : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0100
     * @tc.desc      : test on dataChange with an empty array key
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testPreferencesDataChange001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log("testPreferencesDataChange001 begin.")
      await mPreference.clear();
      try {
        let observer = (data: Record<string, ValueType>) => {
        };
        mPreference.on('dataChange', [], observer);
        expect().assertFail()
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message)
      }
    })

    /**
     * @tc.name      : testPreferencesDataChange002
     * @tc.number    : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0200
     * @tc.desc      : test the subscription callback of on dataChange
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testPreferencesDataChange002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log("testPreferencesDataChange002 begin.")
      await mPreference.clear();
      try {
        let obj1: Record<string, ValueType> = {
          "key1": "value1"
        }
        let obj2: Record<string, ValueType> = {
          "key1": "value1",
          "key2": 222
        }
        let observer1 = (data: Record<string, ValueType>) => {
          Object.keys(data).forEach((key) => {
            console.log(`ob1 Key: ${key}, Value: ${data[key]}`)
            if (data[key] != obj1[key]) {
              console.log(`Not as expected act: ${data[key]}, exc: ${obj1[key]}`)
            }
          });
          expect(Object.keys(data).length).assertEqual(Object.keys(obj1).length)
        }
        let observer2 = (data: Record<string, ValueType>) => {
          Object.keys(data).forEach((key) => {
            console.log(`ob2 Key: ${key}, Value: ${data[key]}`)
            if (data[key] != obj2[key]) {
              console.log(`Not as expected act: ${data[key]}, exc: ${obj2[key]}`)
            }
          });
          expect(Object.keys(data).length).assertEqual(Object.keys(obj2).length)
        }
        mPreference.on('dataChange', ['key1'], observer1);
        mPreference.on('dataChange', ['key1', 'key2', 'key3'], observer2);
        await mPreference.put("key2", "value2")
        await mPreference.put("key1", "value1")
        await mPreference.put("key2", 222)
        await mPreference.flush()
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message)
        expect().assertFail()
      } finally {
        mPreference.off('dataChange', ['key1'])
        mPreference.off('dataChange', ['key1', 'key2', 'key4'])
        mPreference.off('dataChange', ['key2', 'key3'])

      }
    })

    /**
     * @tc.name      : testPreferencesDataChange003
     * @tc.number    : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0300
     * @tc.desc      : test off dataChange with an empty key and callback1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testPreferencesDataChange003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log("testPreferencesDataChange003 begin.")
      await mPreference.clear();
      try {
        let observer1 = (data: Record<string, ValueType>) => {
          console.log("observer1")
          expect().assertFail()
        }
        let observer2 = (data: Record<string, ValueType>) => {
          console.log("observer2")
        }
        let observer3 = (data: Record<string, ValueType>) => {
          console.log("observer3")
        }
        let keys = ['key1', 'key2', 'key3']
        mPreference.on('dataChange', keys, observer1);
        mPreference.on('dataChange', keys, observer2);
        mPreference.on('dataChange', keys, observer3);
        mPreference.off('dataChange', [], observer1)
        await mPreference.put("key2", "value2")
        await mPreference.put("key1", "value1")
        await mPreference.flush()
        mPreference.off('dataChange', [])
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message)
        expect().assertFail()
      }
    })

    /**
     * @tc.name      : testPreferencesDataChange004
     * @tc.number    : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0400
     * @tc.desc      : test off dataChange with array keys1 and without callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testPreferencesDataChange004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log("testPreferencesDataChange004 begin.")
      await mPreference.clear();
      try {
        let obj: Record<string, ValueType> = {
          "key2": "value2"
        }
        let observer1 = (data: Record<string, ValueType>) => {
          console.log("observer1")
          expect(Object.keys(data).length).assertEqual(Object.keys(obj).length)
        }
        let observer2 = (data: Record<string, ValueType>) => {
          console.log("observer2")
          expect(Object.keys(data).length).assertEqual(Object.keys(obj).length)
        }
        let keys = ['key1', 'key2', 'key3']
        mPreference.on('dataChange', keys, observer1);
        mPreference.on('dataChange', keys, observer2);
        await mPreference.put("key1", "value1")
        await mPreference.put("key2", "value2")
        await mPreference.put("key3", "value3")
        mPreference.off('dataChange', ['key1', 'key3'])
        await mPreference.flush()
        mPreference.off('dataChange', [])
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message)
        expect().assertFail()
      }
    })

    /**
     * @tc.name      : testPreferencesDataChange005
     * @tc.number    : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0500
     * @tc.desc      : test off dataChange with an empty array key without callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testPreferencesDataChange005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log("testPreferencesDataChange005 begin.")
      await mPreference.clear();
      try {
        let observer1 = (data: Record<string, ValueType>) => {
          console.log("observer1")
          expect().assertFail()
        }
        let observer2 = (data: Record<string, ValueType>) => {
          console.log("observer2")
          expect().assertFail()
        }
        let observer3 = (data: Record<string, ValueType>) => {
          console.log("observer3")
          expect().assertFail()
        }
        let keys = ['key1', 'key2', 'key3']
        mPreference.on('dataChange', keys, observer1);
        mPreference.on('dataChange', keys, observer2);
        mPreference.on('dataChange', keys, observer3);
        mPreference.off('dataChange', [])
        await mPreference.put("key2", "value2")
        await mPreference.put("key1", "value1")
        await mPreference.flush()

      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message)
        expect().assertFail()
      }
    })

    /**
     * @tc.name      : testPreferencesDataChange006
     * @tc.number    : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0600
     * @tc.desc      : test off dataChange with array keys1, callback1 and array keys2, callback2
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testPreferencesDataChange006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log("testPreferencesDataChange006 begin.")
      await mPreference.clear();
      try {
        let obj1: Record<string, ValueType> = {
          "key2": "value2"
        }
        let observer1 = (data: Record<string, ValueType>) => {
          console.log("observer1")
        }
        let observer2 = (data: Record<string, ValueType>) => {
          console.log("observer2")
          expect().assertFail()
        }
        mPreference.on('dataChange', ['key1', 'key2'], observer1);
        mPreference.on('dataChange', ['key1', 'key3'], observer2);
        await mPreference.put("key2", "value2")
        await mPreference.put("key1", "value1")
        await mPreference.put("key3", "value3")
        mPreference.off('dataChange', ['key1', 'key3'], observer1);
        mPreference.off('dataChange', ['key1', 'key3'], observer2);
        await mPreference.flush()
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message)
        expect().assertFail()
      } finally {
        mPreference.off('dataChange', [])

      }
    })

    /**
     * @tc.name      : testPreferencesDataChange007
     * @tc.number    : SUB_DistributeData_CrossPlatform_SDK_Preferences_OnOFFJSAPITest_0700
     * @tc.desc      : test put then delete and on dataChange subscribe to callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testPreferencesDataChange007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      console.log("testPreferencesDataChange007 begin.")
      await mPreference.clear();
      try {
        let obj1: Record<string, ValueType> = {
          "key1": "value1",
          "key2": 1
        }
        let observer1 = (data: Record<string, ValueType>) => {
          Object.keys(data).forEach((key) => {
            console.log(`ob1 Key: ${key}, Value: ${data[key]}`)
            if (data[key] != obj1[key]) {
              console.log(`Not as expected act: ${data[key]}, exc: ${obj1[key]}`)
            }
          });
          expect(Object.keys(data).length).assertEqual(Object.keys(obj1).length)
        }
        mPreference.on('dataChange', ['key1', 'key2'], observer1);
        await mPreference.put("key2", 222)
        await mPreference.put("key1", "value1")
        await mPreference.delete("key2", (err) => {
          if (err) {
            console.log("delete err =" + err + ", code =" + err.code + ", message =" + err.message)
            expect().assertFail()
          }
          console.log("delete err")
        });
        await mPreference.flush()
      } catch (err) {
        console.log("trycatch err =" + err + ", code =" + err.code + ", message =" + err.message)
        expect().assertFail()
      } finally {
        mPreference.off('dataChange', [])
      }
    })
  })
}




