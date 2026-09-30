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

import { describe, it, expect, Level, beforeEach, TestType, Size } from '@ohos/hypium';
import { bundleManager } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

const AWAIT_SLEEP_MS_2000: number = 2000
const BUNDLE_NAME = "com.example.bundlemanager";
const ABILITY_NAME = "EntryAbility";

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function abilityInfoTest() {
  describe('AbilityInfoTest', () => {
    beforeEach(async () => {
      await sleep(AWAIT_SLEEP_MS_2000);
    })

    /**
     * @tc.number ARKUIX_BundleManager_AbilityInfo_BundleName_Callback_0100
     * @tc.name ARKUIX_BundleManager_AbilityInfo_BundleName_Callback_0100
     * @tc.desc Test the readonly bundleName field of AbilityInfo by callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_AbilityInfo_BundleName_Callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
        await (async (): Promise<bundleManager.BundleInfo> => {
          return new Promise((resolve, reject) => {
            bundleManager.getBundleInfoForSelf(bundleFlags, (err, data) => {
              if (!err) {
                console.log('BundleInfo: ' + JSON.stringify(data));
                resolve(data);
              } else {
                reject(err);
                console.log('err.code: ' + err.code + 'err.message: ' + err.message);
              }
            });
          });
        })().then(async (data) => {
          expect(data != null).assertTrue();
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertLarger(0);
          expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].bundleName).assertEqual(BUNDLE_NAME);
        }).catch((err: BusinessError) => {
          console.error(' fail:' + JSON.stringify(err));
          expect().assertFail();
        });
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_AbilityInfo_BundleName_Promise_0100
     * @tc.name ARKUIX_BundleManager_AbilityInfo_BundleName_Promise_0100
     * @tc.desc Test the readonly bundleName field of AbilityInfo by promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_AbilityInfo_BundleName_Promise_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertLarger(0);
          expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].bundleName).assertEqual(BUNDLE_NAME);
          console.log('BundleInfo: ' + JSON.stringify(data));
        }).catch((err: BusinessError) => {
          console.error(' fail:' + JSON.stringify(err));
          expect().assertFail();
        });
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_AbilityInfo_BundleName_Sync_0100
     * @tc.name ARKUIX_BundleManager_AbilityInfo_BundleName_Sync_0100
     * @tc.desc Test the readonly bundleName field of AbilityInfo in sync mode
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_AbilityInfo_BundleName_Sync_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        expect(data.appInfo).assertEqual(null);
        expect(data.hapModulesInfo.length).assertLarger(0);
        expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
        expect(data.hapModulesInfo[0].abilitiesInfo[0].bundleName).assertEqual(BUNDLE_NAME);
        console.log('BundleInfo: ' + JSON.stringify(data));
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_AbilityInfo_Name_Callback_0100
     * @tc.name ARKUIX_BundleManager_AbilityInfo_Name_Callback_0100
     * @tc.desc Test the readonly name field of AbilityInfo by callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_AbilityInfo_Name_Callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
        await (async (): Promise<bundleManager.BundleInfo> => {
          return new Promise((resolve, reject) => {
            bundleManager.getBundleInfoForSelf(bundleFlags, (err, data) => {
              if (!err) {
                console.log('BundleInfo: ' + JSON.stringify(data));
                resolve(data);
              } else {
                reject(err);
                console.log('err.code: ' + err.code + 'err.message: ' + err.message);
              }
            });
          });
        })().then(async (data) => {
          expect(data != null).assertTrue();
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertLarger(0);
          expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].name).assertEqual(ABILITY_NAME);
        }).catch((err: BusinessError) => {
          console.error(' fail:' + JSON.stringify(err));
          expect().assertFail();
        });
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_AbilityInfo_Name_Promise_0100
     * @tc.name ARKUIX_BundleManager_AbilityInfo_Name_Promise_0100
     * @tc.desc Test the readonly name field of AbilityInfo by promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_AbilityInfo_Name_Promise_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertLarger(0);
          expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].name).assertEqual(ABILITY_NAME);
          console.log('BundleInfo: ' + JSON.stringify(data));
        }).catch((err: BusinessError) => {
          console.error(' fail:' + JSON.stringify(err));
          expect().assertFail();
        });
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_AbilityInfo_Name_Sync_0100
     * @tc.name ARKUIX_BundleManager_AbilityInfo_Name_Sync_0100
     * @tc.desc Test the readonly name field of AbilityInfo in sync mode
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_AbilityInfo_Name_Sync_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        expect(data.appInfo).assertEqual(null);
        expect(data.hapModulesInfo.length).assertLarger(0);
        expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
        expect(data.hapModulesInfo[0].abilitiesInfo[0].name).assertEqual(ABILITY_NAME);
        console.log('BundleInfo: ' + JSON.stringify(data));
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })
  })
}
