/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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
import { describe, beforeAll, afterAll, it, expect, TestType, Level, Size } from "@ohos/hypium";
import dataPreferences from "@ohos.data.preferences";
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

const delegator = AbilityDelegatorRegistry.getAbilityDelegator();
const context = delegator.getAppContext().getApplicationContext();
const NAME_SYNC = "test_preferences_sync";
const NAME_FLUSH = "test_preferences_flushsync";
const KEY_TEST_STRING_ELEMENT = "key_test_string";
const TAG = "[PREFERENCES_SYNC_JSUNIT_TEST]";
let mPreferences: dataPreferences.Preferences;

export default function preferencesSyncTest() {
  describe("preferencesSyncTest", () => {
    beforeAll(async () => {
      console.info(`${TAG} beforeAll`);
    });
    afterAll(async () => {
      console.info(`${TAG} afterAll`);
      await dataPreferences.deletePreferences(context, NAME_SYNC);
      await dataPreferences.deletePreferences(context, NAME_FLUSH);
    });

    /**
     * @tc.name   testGetPreferencesSyncinterface001
     * @tc.number SUB_DistributedData_Preference_SDK_PreferenceHelperEtsTest_3100
     * @tc.desc   getPreferencesSync interface test
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('testGetPreferencesSyncinterface001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      mPreferences = dataPreferences.getPreferencesSync(context, {
        name: NAME_SYNC
      });
      mPreferences.putSync("test", 2);
      mPreferences.flushSync();
      let value = mPreferences.getSync('test', 0);
      expect(value).assertEqual(2);
    });

    /**
     * @tc.name   testPreferenceFlushSync0100
     * @tc.number testPreferenceFlushSync0100
     * @tc.desc   flushSync interface test: put value, flushSync, remove cache and reload to verify persistence
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL2
     */
    it('testPreferenceFlushSync0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let options: dataPreferences.Options = { name: NAME_FLUSH };
      try {
        mPreferences = dataPreferences.getPreferencesSync(context, options);
        mPreferences.clearSync();
        mPreferences.putSync(KEY_TEST_STRING_ELEMENT, 'TEST');
        let pre = mPreferences.getSync(KEY_TEST_STRING_ELEMENT, 'default');
        expect('TEST').assertEqual(pre);
        mPreferences.flushSync();
        dataPreferences.removePreferencesFromCacheSync(context, NAME_FLUSH);
        mPreferences = dataPreferences.getPreferencesSync(context, options);
        let pre2 = mPreferences.getSync(KEY_TEST_STRING_ELEMENT, 'default');
        expect('TEST').assertEqual(pre2);
        done();
      } catch (e) {
        console.info(`${TAG} testPreferenceFlushSync0100 failed, code: ${e.code}`);
        expect().assertFail();
        done();
      }
    });
  })
}
