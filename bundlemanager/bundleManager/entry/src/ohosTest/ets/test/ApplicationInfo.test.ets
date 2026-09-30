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
const MODULE_NAME = "entry";
const METADATA_NAME = "MetaData1";
const METADATA_VALUE = "MetaDataValue";
const METADATA_RESOURCE = "$profile:shortcuts_config";

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function findModuleMetadata(metadataArray: Array<bundleManager.ModuleMetadata>,
  moduleName: string): bundleManager.ModuleMetadata | undefined {
  for (let i = 0; i < metadataArray.length; i++) {
    if (metadataArray[i].moduleName === moduleName) {
      return metadataArray[i];
    }
  }
  return undefined;
}

export default function applicationInfoTest() {
  describe('ApplicationInfoTest', () => {
    beforeEach(async () => {
      await sleep(AWAIT_SLEEP_MS_2000);
    })

    /**
     * @tc.number ARKUIX_BundleManager_ApplicationInfo_Name_Callback_0100
     * @tc.name ARKUIX_BundleManager_ApplicationInfo_Name_Callback_0100
     * @tc.desc Test the readonly name field of ApplicationInfo by callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ApplicationInfo_Name_Callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
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
          expect(data.appInfo != null).assertTrue();
          expect(data.appInfo.name).assertEqual(BUNDLE_NAME);
          expect(data.appInfo.metadataArray.length).assertEqual(0);
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
     * @tc.number ARKUIX_BundleManager_ApplicationInfo_Name_Promise_0100
     * @tc.name ARKUIX_BundleManager_ApplicationInfo_Name_Promise_0100
     * @tc.desc Test the readonly name field of ApplicationInfo by promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ApplicationInfo_Name_Promise_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          expect(data.appInfo != null).assertTrue();
          expect(data.appInfo.name).assertEqual(BUNDLE_NAME);
          expect(data.appInfo.metadataArray.length).assertEqual(0);
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
     * @tc.number ARKUIX_BundleManager_ApplicationInfo_Name_Sync_0100
     * @tc.name ARKUIX_BundleManager_ApplicationInfo_Name_Sync_0100
     * @tc.desc Test the readonly name field of ApplicationInfo in sync mode
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ApplicationInfo_Name_Sync_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        expect(data.appInfo != null).assertTrue();
        expect(data.appInfo.name).assertEqual(BUNDLE_NAME);
        expect(data.appInfo.metadataArray.length).assertEqual(0);
        console.log('BundleInfo: ' + JSON.stringify(data));
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_ModuleMetadata_ModuleName_Callback_0100
     * @tc.name ARKUIX_BundleManager_ModuleMetadata_ModuleName_Callback_0100
     * @tc.desc Test the readonly moduleName field of ModuleMetadata in ApplicationInfo.metadataArray by callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ModuleMetadata_ModuleName_Callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;
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
          expect(data.appInfo != null).assertTrue();
          expect(data.appInfo.metadataArray.length).assertLarger(0);
          let moduleMetadata = findModuleMetadata(data.appInfo.metadataArray, MODULE_NAME);
          console.log('ModuleMetadata: ' + JSON.stringify(moduleMetadata));
          expect(moduleMetadata != undefined).assertTrue();
          expect(moduleMetadata?.moduleName).assertEqual(MODULE_NAME);
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
     * @tc.number ARKUIX_BundleManager_ModuleMetadata_ModuleName_Promise_0100
     * @tc.name ARKUIX_BundleManager_ModuleMetadata_ModuleName_Promise_0100
     * @tc.desc Test the readonly moduleName field of ModuleMetadata in ApplicationInfo.metadataArray by promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ModuleMetadata_ModuleName_Promise_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          expect(data.appInfo != null).assertTrue();
          expect(data.appInfo.metadataArray.length).assertLarger(0);
          let moduleMetadata = findModuleMetadata(data.appInfo.metadataArray, MODULE_NAME);
          console.log('ModuleMetadata: ' + JSON.stringify(moduleMetadata));
          expect(moduleMetadata != undefined).assertTrue();
          expect(moduleMetadata?.moduleName).assertEqual(MODULE_NAME);
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
     * @tc.number ARKUIX_BundleManager_ModuleMetadata_ModuleName_Sync_0100
     * @tc.name ARKUIX_BundleManager_ModuleMetadata_ModuleName_Sync_0100
     * @tc.desc Test the readonly moduleName field of ModuleMetadata in ApplicationInfo.metadataArray in sync mode
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ModuleMetadata_ModuleName_Sync_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        expect(data.appInfo != null).assertTrue();
        expect(data.appInfo.metadataArray.length).assertLarger(0);
        let moduleMetadata = findModuleMetadata(data.appInfo.metadataArray, MODULE_NAME);
        console.log('ModuleMetadata: ' + JSON.stringify(moduleMetadata));
        expect(moduleMetadata != undefined).assertTrue();
        expect(moduleMetadata?.moduleName).assertEqual(MODULE_NAME);
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_ModuleMetadata_Metadata_Callback_0100
     * @tc.name ARKUIX_BundleManager_ModuleMetadata_Metadata_Callback_0100
     * @tc.desc Test the readonly metadata field of ModuleMetadata in ApplicationInfo.metadataArray by callback
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ModuleMetadata_Metadata_Callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;
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
          expect(data.appInfo != null).assertTrue();
          expect(data.appInfo.metadataArray.length).assertLarger(0);
          let moduleMetadata = findModuleMetadata(data.appInfo.metadataArray, MODULE_NAME);
          console.log('ModuleMetadata: ' + JSON.stringify(moduleMetadata));
          expect(moduleMetadata != undefined).assertTrue();
          expect(moduleMetadata?.metadata.length).assertEqual(1);
          expect(moduleMetadata?.metadata[0].name).assertEqual(METADATA_NAME);
          expect(moduleMetadata?.metadata[0].value).assertEqual(METADATA_VALUE);
          expect(moduleMetadata?.metadata[0].resource).assertEqual(METADATA_RESOURCE);
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
     * @tc.number ARKUIX_BundleManager_ModuleMetadata_Metadata_Promise_0100
     * @tc.name ARKUIX_BundleManager_ModuleMetadata_Metadata_Promise_0100
     * @tc.desc Test the readonly metadata field of ModuleMetadata in ApplicationInfo.metadataArray by promise
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ModuleMetadata_Metadata_Promise_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          expect(data.appInfo != null).assertTrue();
          expect(data.appInfo.metadataArray.length).assertLarger(0);
          let moduleMetadata = findModuleMetadata(data.appInfo.metadataArray, MODULE_NAME);
          console.log('ModuleMetadata: ' + JSON.stringify(moduleMetadata));
          expect(moduleMetadata != undefined).assertTrue();
          expect(moduleMetadata?.metadata.length).assertEqual(1);
          expect(moduleMetadata?.metadata[0].name).assertEqual(METADATA_NAME);
          expect(moduleMetadata?.metadata[0].value).assertEqual(METADATA_VALUE);
          expect(moduleMetadata?.metadata[0].resource).assertEqual(METADATA_RESOURCE);
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
     * @tc.number ARKUIX_BundleManager_ModuleMetadata_Metadata_Sync_0100
     * @tc.name ARKUIX_BundleManager_ModuleMetadata_Metadata_Sync_0100
     * @tc.desc Test the readonly metadata field of ModuleMetadata in ApplicationInfo.metadataArray in sync mode
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ARKUIX_BundleManager_ModuleMetadata_Metadata_Sync_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        expect(data.appInfo != null).assertTrue();
        expect(data.appInfo.metadataArray.length).assertLarger(0);
        let moduleMetadata = findModuleMetadata(data.appInfo.metadataArray, MODULE_NAME);
        console.log('ModuleMetadata: ' + JSON.stringify(moduleMetadata));
        expect(moduleMetadata != undefined).assertTrue();
        expect(moduleMetadata?.metadata.length).assertEqual(1);
        expect(moduleMetadata?.metadata[0].name).assertEqual(METADATA_NAME);
        expect(moduleMetadata?.metadata[0].value).assertEqual(METADATA_VALUE);
        expect(moduleMetadata?.metadata[0].resource).assertEqual(METADATA_RESOURCE);
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })
  })
}
