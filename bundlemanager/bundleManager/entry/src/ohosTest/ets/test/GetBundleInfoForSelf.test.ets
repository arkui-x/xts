/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import deviceInfo from '@ohos.deviceInfo';

const AWAIT_SLEEP_MS_2000: number = 2000
const BUNDLE_NAME = "com.example.bundlemanager";
const VENDOR = "example";
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function getBundleInfoForSelfTest() {
  describe('GetBundleInfoForSelfTest', () => {
    beforeEach(async () => {
      await sleep(AWAIT_SLEEP_MS_2000);
    })

    /**
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0100
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0100
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_DEFAULT
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0100', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT;
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
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.versionCode).assertEqual(1000000);
          expect(data.versionName).assertEqual("1.0.0");
          expect(data.minCompatibleVersionCode).assertEqual(1000000);
          expect(data.targetVersion).assertLarger(0);
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          expect(data.signatureInfo).assertEqual(null);
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0200
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0200
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_WITH_APPLICATION
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0200', TestType.FUNCTION |
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
          expect(data.appInfo.debug).assertTrue();
          expect(data.appInfo.enabled).assertTrue();
          expect(data.appInfo.process).assertEqual(BUNDLE_NAME);
          expect(data.appInfo.metadataArray.length).assertEqual(0);
          expect(data.appInfo.appDistributionType).assertEqual("none");
          expect(data.appInfo.permissions.length).assertEqual(0);
          expect(data.appInfo.systemApp).assertFalse();
          expect(data.appInfo.dataUnclearable).assertFalse();
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          expect(data.signatureInfo).assertEqual(null);
          expect(data.appInfo.releaseType).assertEqual("Release");
          expect(data.appInfo.nativeLibraryPath.length).assertEqual(0);
          if (platform.startsWith('OpenHarmony')) {
            expect(data.appInfo.removable).assertTrue();
            expect(data.appInfo.accessTokenId).assertLarger(0);
            expect(data.appInfo.uid).assertLarger(0);
            expect(data.appInfo.iconResource.bundleName).assertEqual(BUNDLE_NAME);
            expect(data.appInfo.iconResource.moduleName).assertEqual("entry");
            expect(data.appInfo.iconResource.id).assertEqual(data.appInfo.iconId);
            expect(data.appInfo.labelResource.bundleName).assertEqual(BUNDLE_NAME);
            expect(data.appInfo.labelResource.moduleName).assertEqual("entry");
            expect(data.appInfo.labelResource.id).assertEqual(data.appInfo.labelId);
            expect(data.appInfo.descriptionResource.bundleName).assertEqual(BUNDLE_NAME);
            expect(data.appInfo.descriptionResource.moduleName).assertEqual("entry");
            expect(data.appInfo.descriptionResource.id).assertEqual(data.appInfo.descriptionId);
            expect(data.appInfo.appProvisionType).assertEqual("debug");
          } else if (platform === 'Android' || platform === 'iOS') {
            expect(data.appInfo.removable).assertFalse();
            expect(data.appInfo.accessTokenId).assertEqual(0);
            expect(data.appInfo.uid).assertEqual(-1);
            expect(data.appInfo.iconResource.bundleName).assertEqual("");
            expect(data.appInfo.iconResource.moduleName).assertEqual("");
            expect(data.appInfo.iconResource.id).assertEqual(0);
            expect(data.appInfo.labelResource.bundleName).assertEqual("");
            expect(data.appInfo.labelResource.moduleName).assertEqual("");
            expect(data.appInfo.labelResource.id).assertEqual(0);
            expect(data.appInfo.descriptionResource.bundleName).assertEqual("");
            expect(data.appInfo.descriptionResource.moduleName).assertEqual("");
            expect(data.appInfo.descriptionResource.id).assertEqual(0);
            expect(data.appInfo.appProvisionType).assertEqual("release");
          }
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0300
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0300
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_WITH_HAP_MODULE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0300', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE;
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
          expect(data.hapModulesInfo[0].installationFree).assertFalse();
          expect(data.hapModulesInfo[0].hashValue).assertEqual("");
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          expect(data.signatureInfo).assertEqual(null);
          expect(data.appInfo).assertEqual(null);
          if (platform.startsWith('OpenHarmony')) {
            expect(data.hapModulesInfo[0].deviceTypes.length).assertEqual(2);
            expect(data.hapModulesInfo[0].deviceTypes[0]).assertEqual("default");
            expect(data.hapModulesInfo[0].deviceTypes[1]).assertEqual("tablet");
            expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(0);
            expect(data.hapModulesInfo[0].type).assertEqual(bundleManager.ModuleType.ENTRY);
            expect(data.hapModulesInfo[1].type).assertEqual(bundleManager.ModuleType.FEATURE);
          } else if (platform === 'Android' || platform === 'iOS') {
            expect(data.hapModulesInfo[0].deviceTypes.length).assertEqual(1);
            expect(data.hapModulesInfo[0].deviceTypes[0]).assertEqual("default");
            let res : boolean = JSON.stringify(data.hapModulesInfo[0]).includes('abilitiesInfo')
            expect(res).assertFalse();
            expect(JSON.stringify(data.hapModulesInfo[0].type)).assertEqual("1");
            expect(JSON.stringify(data.hapModulesInfo[1].type)).assertEqual("2");
          }
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0400
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0400
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_WITH_ABILITY and
     *          GET_BUNDLE_INFO_WITH_HAP_MODULE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0400', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE;
        await (async (): Promise<bundleManager.BundleInfo> => {
          return new Promise((resolve, reject) => {
            bundleManager.getBundleInfoForSelf(bundleFlags, (err, data) => {
              if (!err) {
                console.info('BundleInfo: ' + JSON.stringify(data));
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
          expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].process).assertEqual("");
          expect(data.hapModulesInfo[0].abilitiesInfo[0].launchType).assertEqual(bundleManager.LaunchType.SINGLETON);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].permissions.length).assertEqual(0);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].enabled).assertTrue();
          expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes.length).assertEqual(3);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].orientation).assertEqual(0);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowRatio).assertEqual(0);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowRatio).assertEqual(0);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowWidth).assertEqual(0);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowWidth).assertEqual(0);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowHeight).assertEqual(0);
          expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowHeight).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          expect(data.signatureInfo).assertEqual(null);
          expect(data.appInfo).assertEqual(null);
          if (platform.startsWith('OpenHarmony')) {
            expect(data.hapModulesInfo[0].abilitiesInfo[0].exported).assertTrue();
            expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes.length).assertEqual(2);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[0]).assertEqual("default");
            expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[1]).assertEqual("tablet");
            expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[0])
              .assertEqual(bundleManager.SupportWindowMode.FULL_SCREEN);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[1])
              .assertEqual(bundleManager.SupportWindowMode.SPLIT);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[2])
              .assertEqual(bundleManager.SupportWindowMode.FLOATING);
          } else if (platform === 'Android' || platform === 'iOS') {
            expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes.length).assertEqual(1);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[0]).assertEqual("default");
            expect(data.hapModulesInfo[0].abilitiesInfo[0].exported).assertFalse();
            expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[0]))
              .assertEqual("0");
            expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[1]))
              .assertEqual("1");
            expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[2]))
              .assertEqual("2");
          }
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0500
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0500
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_WITH_METADATA、
     *          GET_BUNDLE_INFO_WITH_APPLICATION、GET_BUNDLE_INFO_WITH_HAP_MODULE、GET_BUNDLE_INFO_WITH_ABILITY
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0500', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
        bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
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
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.hapModulesInfo[0].metadata.length).assertEqual(1);
          expect(data.hapModulesInfo[0].metadata[0].name).assertEqual("MetaData1");
          expect(data.hapModulesInfo[0].metadata[0].value).assertEqual("MetaDataValue");
          expect(data.hapModulesInfo[0].metadata[0].resource).assertEqual("$profile:shortcuts_config");
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          expect(data.signatureInfo).assertEqual(null);
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0600
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0600
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION;
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
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.versionCode).assertEqual(1000000);
          expect(data.versionName).assertEqual("1.0.0");
          expect(data.minCompatibleVersionCode).assertEqual(1000000);
          expect(data.targetVersion).assertLarger(0);
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(1);
          expect(data.reqPermissionDetails[0].name).assertEqual("ohos.permission.INTERNET");
          expect(data.reqPermissionDetails[0].reason).assertEqual("");
          expect(data.reqPermissionDetails[0].reasonId).assertEqual(0);
          expect(data.reqPermissionDetails[0].usedScene.abilities.length).assertEqual(1);
          expect(data.reqPermissionDetails[0].usedScene.abilities[0]).assertEqual("FormAbility");
          expect(data.reqPermissionDetails[0].usedScene.when).assertEqual("inuse");
          expect(data.signatureInfo).assertEqual(null);
          if (platform.startsWith('OpenHarmony')) {
            expect(data.permissionGrantStates.length).assertEqual(1);
            expect(data.permissionGrantStates[0]).assertEqual(0);
          } else if (platform === 'Android' || platform === 'iOS') {
            expect(data.permissionGrantStates.length).assertEqual(0);
          }
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0700
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0700
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_WITH_DISABLE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_DISABLE;
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
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.versionCode).assertEqual(1000000);
          expect(data.versionName).assertEqual("1.0.0");
          expect(data.minCompatibleVersionCode).assertEqual(1000000);
          expect(data.targetVersion).assertLarger(0);
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          expect(data.signatureInfo).assertEqual(null);
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0800
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0800
     * @tc.desc Test GetBundleInfoForSelf_Callback with the parameter GET_BUNDLE_INFO_WITH_SIGNATURE_INFO
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;
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
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.versionCode).assertEqual(1000000);
          expect(data.versionName).assertEqual("1.0.0");
          expect(data.minCompatibleVersionCode).assertEqual(1000000);
          expect(data.targetVersion).assertLarger(0);
          expect((JSON.stringify(data.targetVersion))!=null).assertTrue();
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          if (platform.startsWith('OpenHarmony')) {
            expect(data.signatureInfo.appId).assertContain("com.example.bundlemanager");
            expect((JSON.stringify(data.signatureInfo.fingerprint))!=null).assertTrue();
          } else if (platform === 'Android' || platform === 'iOS') {
            expect(data.signatureInfo.appId).assertEqual("");
            expect(data.signatureInfo.fingerprint).assertEqual("");
          }
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
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0900
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0900
     * @tc.desc Test bundleFlags is undefined
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_0900', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bundleManager.getBundleInfoForSelf(undefined, (err, data) => {
          console.log('Ability BundleInfo: ' + JSON.stringify(data));
        });
        expect().assertFail();
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect(err.code === 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_1000
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_1000
     * @tc.desc Test bundleFlags is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Callback_1000', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bundleManager.getBundleInfoForSelf(null, (err, data) => {
          console.log('Ability BundleInfo: ' + JSON.stringify(data));
        });
        expect().assertFail();
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect(err.code === 401).assertTrue();
      }
      done();
    })

        /**
         * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0100
         * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0100
         * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_DEFAULT
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0100', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT;
            await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
              expect(data != null).assertTrue();
              expect(data.name).assertEqual(BUNDLE_NAME);
              expect(data.vendor).assertEqual(VENDOR);
              expect(data.versionCode).assertEqual(1000000);
              expect(data.versionName).assertEqual("1.0.0");
              expect(data.minCompatibleVersionCode).assertEqual(1000000);
              expect(data.targetVersion).assertLarger(0);
              expect(data.appInfo).assertEqual(null);
              expect(data.hapModulesInfo.length).assertEqual(0);
              expect(data.reqPermissionDetails.length).assertEqual(0);
              expect(data.permissionGrantStates.length).assertEqual(0);
              expect(data.signatureInfo).assertEqual(null);
              console.log('BundleInfo: ' + JSON.stringify(data));
            }).catch((err: BusinessError) => {
              console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            });
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0200
         * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0200
         * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_WITH_APPLICATION
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0200', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
            await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
              expect(data != null).assertTrue();
              expect(data.appInfo.debug).assertTrue();
              expect(data.appInfo.enabled).assertTrue();
              expect(data.appInfo.process).assertEqual(BUNDLE_NAME);
              expect(data.appInfo.metadataArray.length).assertEqual(0);
              expect(data.appInfo.appDistributionType).assertEqual("none");
              expect(data.appInfo.permissions.length).assertEqual(0);
              expect(data.appInfo.systemApp).assertFalse();
              expect(data.appInfo.dataUnclearable).assertFalse();
              expect(data.hapModulesInfo.length).assertEqual(0);
              expect(data.reqPermissionDetails.length).assertEqual(0);
              expect(data.permissionGrantStates.length).assertEqual(0);
              expect(data.signatureInfo).assertEqual(null);
              expect(data.appInfo.releaseType).assertEqual("Release");
              expect(data.appInfo.nativeLibraryPath.length).assertEqual(0);
              if (platform.startsWith('OpenHarmony')) {
                expect(data.appInfo.removable).assertTrue();
                expect(data.appInfo.accessTokenId).assertLarger(0);
                expect(data.appInfo.uid).assertLarger(0);
                expect(data.appInfo.iconResource.bundleName).assertEqual(BUNDLE_NAME);
                expect(data.appInfo.iconResource.moduleName).assertEqual("entry");
                expect(data.appInfo.iconResource.id).assertEqual(data.appInfo.iconId);
                expect(data.appInfo.labelResource.bundleName).assertEqual(BUNDLE_NAME);
                expect(data.appInfo.labelResource.moduleName).assertEqual("entry");
                expect(data.appInfo.labelResource.id).assertEqual(data.appInfo.labelId);
                expect(data.appInfo.descriptionResource.bundleName).assertEqual(BUNDLE_NAME);
                expect(data.appInfo.descriptionResource.moduleName).assertEqual("entry");
                expect(data.appInfo.descriptionResource.id).assertEqual(data.appInfo.descriptionId);
                expect(data.appInfo.appProvisionType).assertEqual("debug");

              } else if (platform === 'Android' || platform === 'iOS') {
                expect(data.appInfo.removable).assertFalse();
                expect(data.appInfo.accessTokenId).assertEqual(0);
                expect(data.appInfo.uid).assertEqual(-1);
                expect(data.appInfo.iconResource.bundleName).assertEqual("");
                expect(data.appInfo.iconResource.moduleName).assertEqual("");
                expect(data.appInfo.iconResource.id).assertEqual(0);
                expect(data.appInfo.labelResource.bundleName).assertEqual("");
                expect(data.appInfo.labelResource.moduleName).assertEqual("");
                expect(data.appInfo.labelResource.id).assertEqual(0);
                expect(data.appInfo.descriptionResource.bundleName).assertEqual("");
                expect(data.appInfo.descriptionResource.moduleName).assertEqual("");
                expect(data.appInfo.descriptionResource.id).assertEqual(0);
                expect(data.appInfo.appProvisionType).assertEqual("release");
              }
              console.log('BundleInfo: ' + JSON.stringify(data));
            }).catch((err: BusinessError) => {
              console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            });
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0300
         * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0300
         * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_WITH_HAP_MODULE
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0300', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE;
            await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
              expect(data != null).assertTrue();
              expect(data.appInfo).assertEqual(null);
              expect(data.hapModulesInfo.length).assertLarger(0);
              expect(data.hapModulesInfo[0].installationFree).assertFalse();
              expect(data.hapModulesInfo[0].hashValue).assertEqual("");
              expect(data.reqPermissionDetails.length).assertEqual(0);
              expect(data.permissionGrantStates.length).assertEqual(0);
              expect(data.signatureInfo).assertEqual(null);
              expect(data.appInfo).assertEqual(null);
              if (platform.startsWith('OpenHarmony')) {
                expect(data.hapModulesInfo[0].deviceTypes.length).assertEqual(2);
                expect(data.hapModulesInfo[0].deviceTypes[0]).assertEqual("default");
                expect(data.hapModulesInfo[0].deviceTypes[1]).assertEqual("tablet");
                expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(0);
                expect(data.hapModulesInfo[0].type).assertEqual(bundleManager.ModuleType.ENTRY);
                expect(data.hapModulesInfo[1].type).assertEqual(bundleManager.ModuleType.FEATURE);
              } else if (platform === 'Android' || platform === 'iOS') {
                expect(data.hapModulesInfo[0].deviceTypes.length).assertEqual(1);
                expect(data.hapModulesInfo[0].deviceTypes[0]).assertEqual("default");
                let res : boolean = JSON.stringify(data.hapModulesInfo[0]).includes('abilitiesInfo')
                expect(res).assertFalse();
                expect(JSON.stringify(data.hapModulesInfo[0].type)).assertEqual("1");
                expect(JSON.stringify(data.hapModulesInfo[1].type)).assertEqual("2");
              }
              console.log('BundleInfo: ' + JSON.stringify(data));
            }).catch((err: BusinessError) => {
              console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            });
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0400
         * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0400
         * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_WITH_ABILITY and
         *          GET_BUNDLE_INFO_WITH_HAP_MODULE
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0400', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE;
            await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
              expect(data != null).assertTrue();
              console.log('BundleInfo: ' + JSON.stringify(data));
              expect(data.appInfo).assertEqual(null);
              expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].process).assertEqual("");
              expect(data.hapModulesInfo[0].abilitiesInfo[0].launchType).assertEqual(bundleManager.LaunchType.SINGLETON);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].permissions.length).assertEqual(0);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].enabled).assertTrue();
              expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes.length).assertEqual(3);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].orientation).assertEqual(0);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowRatio).assertEqual(0);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowRatio).assertEqual(0);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowWidth).assertEqual(0);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowWidth).assertEqual(0);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowHeight).assertEqual(0);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowHeight).assertEqual(0);
              expect(data.reqPermissionDetails.length).assertEqual(0);
              expect(data.permissionGrantStates.length).assertEqual(0);
              expect(data.signatureInfo).assertEqual(null);
              expect(data.appInfo).assertEqual(null);
              if (platform.startsWith('OpenHarmony')) {
                expect(data.hapModulesInfo[0].abilitiesInfo[0].exported).assertTrue();
                expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes.length).assertEqual(2);
                expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[0]).assertEqual("default");
                expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[1]).assertEqual("tablet");
                expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[0])
                  .assertEqual(bundleManager.SupportWindowMode.FULL_SCREEN);
                expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[1])
                  .assertEqual(bundleManager.SupportWindowMode.SPLIT);
                expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[2])
                  .assertEqual(bundleManager.SupportWindowMode.FLOATING);
              } else if (platform === 'Android' || platform === 'iOS') {
                expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes.length).assertEqual(1);
                expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[0]).assertEqual("default");
                expect(data.hapModulesInfo[0].abilitiesInfo[0].exported).assertFalse();
                expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[0]))
                  .assertEqual("0");
                expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[1]))
                  .assertEqual("1");
                expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[2]))
                  .assertEqual("2");
              }
            }).catch((err: BusinessError) => {
              console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            });
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0500
         * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0500
         * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_WITH_METADATA、
         *          GET_BUNDLE_INFO_WITH_APPLICATION、GET_BUNDLE_INFO_WITH_HAP_MODULE、GET_BUNDLE_INFO_WITH_ABILITY
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0500', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
            await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
              expect(data != null).assertTrue();
              expect(data.name).assertEqual(BUNDLE_NAME);
              expect(data.vendor).assertEqual(VENDOR);
              expect(data.hapModulesInfo[0].metadata.length).assertEqual(1);
              expect(data.hapModulesInfo[0].metadata[0].name).assertEqual("MetaData1");
              expect(data.hapModulesInfo[0].metadata[0].value).assertEqual("MetaDataValue");
              expect(data.hapModulesInfo[0].metadata[0].resource).assertEqual("$profile:shortcuts_config");
              expect(data.reqPermissionDetails.length).assertEqual(0);
              expect(data.permissionGrantStates.length).assertEqual(0);
              expect(data.signatureInfo).assertEqual(null);
            }).catch((err: BusinessError) => {
              console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            });
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

    /**
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0600
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0600
     * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          console.log('BundleInfo: ' + JSON.stringify(data));
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.versionCode).assertEqual(1000000);
          expect(data.versionName).assertEqual("1.0.0");
          expect(data.minCompatibleVersionCode).assertEqual(1000000);
          expect(data.targetVersion).assertLarger(0);
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(1);
          expect(data.reqPermissionDetails[0].name).assertEqual("ohos.permission.INTERNET");
          expect(data.reqPermissionDetails[0].reason).assertEqual("");
          expect(data.reqPermissionDetails[0].reasonId).assertEqual(0);
          expect(data.reqPermissionDetails[0].usedScene.abilities.length).assertEqual(1);
          expect(data.reqPermissionDetails[0].usedScene.abilities[0]).assertEqual("FormAbility");
          expect(data.reqPermissionDetails[0].usedScene.when).assertEqual("inuse");
          expect(data.signatureInfo).assertEqual(null);
          if (platform.startsWith('OpenHarmony')) {
            expect(data.permissionGrantStates.length).assertEqual(1);
            expect(data.permissionGrantStates[0]).assertEqual(0);
          } else if (platform === 'Android' || platform === 'iOS') {
            expect(data.permissionGrantStates.length).assertEqual(0);
          }
        }).catch((err: BusinessError) => {
          console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        });
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0700
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0700
     * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_WITH_DISABLE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_DISABLE;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          console.log('BundleInfo: ' + JSON.stringify(data));
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.versionCode).assertEqual(1000000);
          expect(data.versionName).assertEqual("1.0.0");
          expect(data.minCompatibleVersionCode).assertEqual(1000000);
          expect(data.targetVersion).assertLarger(0);
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          expect(data.signatureInfo).assertEqual(null);
        }).catch((err: BusinessError) => {
          console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        });
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0800
     * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0800
     * @tc.desc Test GetBundleInfoForSelf_Promise with the parameter GET_BUNDLE_INFO_WITH_SIGNATURE_INFO
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;
        await bundleManager.getBundleInfoForSelf(bundleFlags).then((data) => {
          expect(data != null).assertTrue();
          console.log('BundleInfo: ' + JSON.stringify(data));
          expect(data.name).assertEqual(BUNDLE_NAME);
          expect(data.vendor).assertEqual(VENDOR);
          expect(data.versionCode).assertEqual(1000000);
          expect(data.versionName).assertEqual("1.0.0");
          expect(data.minCompatibleVersionCode).assertEqual(1000000);
          expect(data.targetVersion).assertLarger(0);
          expect(data.appInfo).assertEqual(null);
          expect(data.hapModulesInfo.length).assertEqual(0);
          expect(data.reqPermissionDetails.length).assertEqual(0);
          expect(data.permissionGrantStates.length).assertEqual(0);
          if (platform.startsWith('OpenHarmony')) {
            expect(data.signatureInfo.appId).assertContain("com.example.bundlemanager");
            expect((JSON.stringify(data.signatureInfo.fingerprint))!=null).assertTrue();
          } else if (platform === 'Android' || platform === 'iOS') {
            expect(data.signatureInfo.appId).assertEqual("");
            expect(data.signatureInfo.fingerprint).assertEqual("");
          }
        }).catch((err: BusinessError) => {
          console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        });
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

        /**
         * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0900
         * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0900
         * @tc.desc Test bundleFlags is undefined
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 2
         * @tc.require
         */
        it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_0900', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
          try {
            await bundleManager.getBundleInfoForSelf(undefined).then((data) => {
              console.log('Ability BundleInfo: ' + JSON.stringify(data));
              expect().assertFail();
            });
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect(err.code === 401).assertTrue();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_1000
         * @tc.name ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_1000
         * @tc.desc Test bundleFlags is null
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 2
         * @tc.require
         */
        it('ARKUIX_BundleManager_GetBundleInfoForSelf_Promise_1000', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
          try {
            await bundleManager.getBundleInfoForSelf(null).then((data) => {
              console.log('Ability BundleInfo: ' + JSON.stringify(data));
              expect().assertFail();
            });
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect(err.code === 401).assertTrue();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0100
         * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0100
         * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_DEFAULT
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0100', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT;
            let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
            expect(data != null).assertTrue();
            expect(data.name).assertEqual(BUNDLE_NAME);
            expect(data.vendor).assertEqual(VENDOR);
            expect(data.versionCode).assertEqual(1000000);
            expect(data.versionName).assertEqual("1.0.0");
            expect(data.minCompatibleVersionCode).assertEqual(1000000);
            expect(data.targetVersion).assertLarger(0);
            expect(data.appInfo).assertEqual(null);
            expect(data.hapModulesInfo.length).assertEqual(0);
            expect(data.reqPermissionDetails.length).assertEqual(0);
            expect(data.permissionGrantStates.length).assertEqual(0);
            expect(data.signatureInfo).assertEqual(null);
            console.log('BundleInfo: ' + JSON.stringify(data));
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0200
         * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0200
         * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_WITH_APPLICATION
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0200', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION;
            let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
            expect(data != null).assertTrue();
            expect(data.appInfo.debug).assertTrue();
            expect(data.appInfo.enabled).assertTrue();
            expect(data.appInfo.process).assertEqual(BUNDLE_NAME);
            expect(data.appInfo.metadataArray.length).assertEqual(0);
            expect(data.appInfo.appDistributionType).assertEqual("none");
            expect(data.appInfo.permissions.length).assertEqual(0);
            expect(data.appInfo.systemApp).assertFalse();
            expect(data.appInfo.dataUnclearable).assertFalse();
            expect(data.hapModulesInfo.length).assertEqual(0);
            expect(data.reqPermissionDetails.length).assertEqual(0);
            expect(data.permissionGrantStates.length).assertEqual(0);
            expect(data.signatureInfo).assertEqual(null);
            expect(data.appInfo.releaseType).assertEqual("Release");
            expect(data.appInfo.nativeLibraryPath.length).assertEqual(0);
            if (platform.startsWith('OpenHarmony')) {
              expect(data.appInfo.removable).assertTrue();
              expect(data.appInfo.accessTokenId).assertLarger(0);
              expect(data.appInfo.uid).assertLarger(0);
              expect(data.appInfo.iconResource.bundleName).assertEqual(BUNDLE_NAME);
              expect(data.appInfo.iconResource.moduleName).assertEqual("entry");
              expect(data.appInfo.iconResource.id).assertEqual(data.appInfo.iconId);
              expect(data.appInfo.labelResource.bundleName).assertEqual(BUNDLE_NAME);
              expect(data.appInfo.labelResource.moduleName).assertEqual("entry");
              expect(data.appInfo.labelResource.id).assertEqual(data.appInfo.labelId);
              expect(data.appInfo.descriptionResource.bundleName).assertEqual(BUNDLE_NAME);
              expect(data.appInfo.descriptionResource.moduleName).assertEqual("entry");
              expect(data.appInfo.descriptionResource.id).assertEqual(data.appInfo.descriptionId);
              expect(data.appInfo.appProvisionType).assertEqual("debug");

            } else if (platform === 'Android' || platform === 'iOS') {
              expect(data.appInfo.removable).assertFalse();
              expect(data.appInfo.accessTokenId).assertEqual(0);
              expect(data.appInfo.uid).assertEqual(-1);
              expect(data.appInfo.iconResource.bundleName).assertEqual("");
              expect(data.appInfo.iconResource.moduleName).assertEqual("");
              expect(data.appInfo.iconResource.id).assertEqual(0);
              expect(data.appInfo.labelResource.bundleName).assertEqual("");
              expect(data.appInfo.labelResource.moduleName).assertEqual("");
              expect(data.appInfo.labelResource.id).assertEqual(0);
              expect(data.appInfo.descriptionResource.bundleName).assertEqual("");
              expect(data.appInfo.descriptionResource.moduleName).assertEqual("");
              expect(data.appInfo.descriptionResource.id).assertEqual(0);
              expect(data.appInfo.appProvisionType).assertEqual("release");
            }
            console.log('BundleInfo: ' + JSON.stringify(data));
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0300
         * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0300
         * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_WITH_HAP_MODULE
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */
        it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0300', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE;
            let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
            expect(data != null).assertTrue();
            expect(data.appInfo).assertEqual(null);
            expect(data.hapModulesInfo.length).assertLarger(0);
            expect(data.hapModulesInfo[0].installationFree).assertFalse();
            expect(data.hapModulesInfo[0].hashValue).assertEqual("");
            expect(data.reqPermissionDetails.length).assertEqual(0);
            expect(data.permissionGrantStates.length).assertEqual(0);
            expect(data.signatureInfo).assertEqual(null);
            expect(data.appInfo).assertEqual(null);
            if (platform.startsWith('OpenHarmony')) {
              expect(data.hapModulesInfo[0].deviceTypes.length).assertEqual(2);
              expect(data.hapModulesInfo[0].deviceTypes[0]).assertEqual("default");
              expect(data.hapModulesInfo[0].deviceTypes[1]).assertEqual("tablet");
              expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(0);
              expect(data.hapModulesInfo[0].type).assertEqual(bundleManager.ModuleType.ENTRY);
              expect(data.hapModulesInfo[1].type).assertEqual(bundleManager.ModuleType.FEATURE);
            } else if (platform === 'Android' || platform === 'iOS') {
              expect(data.hapModulesInfo[0].deviceTypes.length).assertEqual(1);
              expect(data.hapModulesInfo[0].deviceTypes[0]).assertEqual("default");
              let res : boolean = JSON.stringify(data.hapModulesInfo[0]).includes('abilitiesInfo')
              expect(res).assertFalse();
              expect(JSON.stringify(data.hapModulesInfo[0].type)).assertEqual("1");
              expect(JSON.stringify(data.hapModulesInfo[1].type)).assertEqual("2");
            }
            console.log('BundleInfo: ' + JSON.stringify(data));
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0400
         * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0400
         * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_WITH_ABILITY and
         *          GET_BUNDLE_INFO_WITH_HAP_MODULE
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
         */

        it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0400', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE;
            let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
            expect(data != null).assertTrue();
            console.log('BundleInfo: ' + JSON.stringify(data));
            expect(data.appInfo).assertEqual(null);
            expect(data.hapModulesInfo[0].abilitiesInfo.length).assertEqual(1);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].process).assertEqual("");
            expect(data.hapModulesInfo[0].abilitiesInfo[0].launchType).assertEqual(bundleManager.LaunchType.SINGLETON);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].permissions.length).assertEqual(0);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].enabled).assertTrue();
            expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes.length).assertEqual(3);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].orientation).assertEqual(0);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowRatio).assertEqual(0);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowRatio).assertEqual(0);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowWidth).assertEqual(0);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowWidth).assertEqual(0);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.maxWindowHeight).assertEqual(0);
            expect(data.hapModulesInfo[0].abilitiesInfo[0].windowSize.minWindowHeight).assertEqual(0);
            expect(data.reqPermissionDetails.length).assertEqual(0);
            expect(data.permissionGrantStates.length).assertEqual(0);
            expect(data.signatureInfo).assertEqual(null);
            expect(data.appInfo).assertEqual(null);
            if (platform.startsWith('OpenHarmony')) {
              expect(data.hapModulesInfo[0].abilitiesInfo[0].exported).assertTrue();
              expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes.length).assertEqual(2);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[0]).assertEqual("default");
              expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[1]).assertEqual("tablet");
              expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[0])
                .assertEqual(bundleManager.SupportWindowMode.FULL_SCREEN);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[1])
                .assertEqual(bundleManager.SupportWindowMode.SPLIT);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[2])
                .assertEqual(bundleManager.SupportWindowMode.FLOATING);
            } else if (platform === 'Android' || platform === 'iOS') {
              expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes.length).assertEqual(1);
              expect(data.hapModulesInfo[0].abilitiesInfo[0].deviceTypes[0]).assertEqual("default");
              expect(data.hapModulesInfo[0].abilitiesInfo[0].exported).assertFalse();
              expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[0]))
                .assertEqual("0");
              expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[1]))
                .assertEqual("1");
              expect(JSON.stringify(data.hapModulesInfo[0].abilitiesInfo[0].supportWindowModes[2]))
                .assertEqual("2");
            }
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0500
         * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0500
         * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_WITH_METADATA、
         *          GET_BUNDLE_INFO_WITH_APPLICATION、GET_BUNDLE_INFO_WITH_HAP_MODULE、GET_BUNDLE_INFO_WITH_ABILITY
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 0
         * @tc.require
    k     */
        it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0500', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
          try {
            let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_HAP_MODULE |
            bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_ABILITY;
            let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
            expect(data != null).assertTrue();
            expect(data.name).assertEqual(BUNDLE_NAME);
            expect(data.vendor).assertEqual(VENDOR);
            expect(data.hapModulesInfo[0].metadata.length).assertEqual(1);
            expect(data.hapModulesInfo[0].metadata[0].name).assertEqual("MetaData1");
            expect(data.hapModulesInfo[0].metadata[0].value).assertEqual("MetaDataValue");
            expect(data.hapModulesInfo[0].metadata[0].resource).assertEqual("$profile:shortcuts_config");
            expect(data.reqPermissionDetails.length).assertEqual(0);
            expect(data.permissionGrantStates.length).assertEqual(0);
            expect(data.signatureInfo).assertEqual(null);
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect().assertFail();
          }
          done();
        })

    /**
     * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0600
     * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0600
     * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0600', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_REQUESTED_PERMISSION;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        console.log('BundleInfo: ' + JSON.stringify(data));
        expect(data.name).assertEqual(BUNDLE_NAME);
        expect(data.vendor).assertEqual(VENDOR);
        expect(data.versionCode).assertEqual(1000000);
        expect(data.versionName).assertEqual("1.0.0");
        expect(data.minCompatibleVersionCode).assertEqual(1000000);
        expect(data.targetVersion).assertLarger(0);
        expect(data.appInfo).assertEqual(null);
        expect(data.hapModulesInfo.length).assertEqual(0);
        expect(data.reqPermissionDetails.length).assertEqual(1);
        expect(data.reqPermissionDetails[0].name).assertEqual("ohos.permission.INTERNET");
        expect(data.reqPermissionDetails[0].reason).assertEqual("");
        expect(data.reqPermissionDetails[0].reasonId).assertEqual(0);
        expect(data.reqPermissionDetails[0].usedScene.abilities.length).assertEqual(1);
        expect(data.reqPermissionDetails[0].usedScene.abilities[0]).assertEqual("FormAbility");
        expect(data.reqPermissionDetails[0].usedScene.when).assertEqual("inuse");
        expect(data.signatureInfo).assertEqual(null);
        if (platform.startsWith('OpenHarmony')) {
          expect(data.permissionGrantStates.length).assertEqual(1);
          expect(data.permissionGrantStates[0]).assertEqual(0);
        } else if (platform === 'Android' || platform === 'iOS') {
          expect(data.permissionGrantStates.length).assertEqual(0);
        }
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0700
     * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0700
     * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_WITH_DISABLE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0700', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_DISABLE;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        console.log('BundleInfo: ' + JSON.stringify(data));
        expect(data.name).assertEqual(BUNDLE_NAME);
        expect(data.vendor).assertEqual(VENDOR);
        expect(data.versionCode).assertEqual(1000000);
        expect(data.versionName).assertEqual("1.0.0");
        expect(data.minCompatibleVersionCode).assertEqual(1000000);
        expect(data.targetVersion).assertLarger(0);
        expect(data.appInfo).assertEqual(null);
        expect(data.hapModulesInfo.length).assertEqual(0);
        expect(data.reqPermissionDetails.length).assertEqual(0);
        expect(data.permissionGrantStates.length).assertEqual(0);
        expect(data.signatureInfo).assertEqual(null);
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0800
     * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0800
     * @tc.desc Test GetBundleInfoForSelf_Sync with the parameter GET_BUNDLE_INFO_WITH_SIGNATURE_INFO
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0800', TestType.FUNCTION |
    Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let bundleFlags: number = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;
        let data = bundleManager.getBundleInfoForSelfSync(bundleFlags);
        expect(data != null).assertTrue();
        console.log('BundleInfo: ' + JSON.stringify(data));
        expect(data.name).assertEqual(BUNDLE_NAME);
        expect(data.vendor).assertEqual(VENDOR);
        expect(data.versionCode).assertEqual(1000000);
        expect(data.versionName).assertEqual("1.0.0");
        expect(data.minCompatibleVersionCode).assertEqual(1000000);
        expect(data.targetVersion).assertLarger(0);
        expect(data.appInfo).assertEqual(null);
        expect(data.hapModulesInfo.length).assertEqual(0);
        expect(data.reqPermissionDetails.length).assertEqual(0);
        expect(data.permissionGrantStates.length).assertEqual(0);
        if (platform.startsWith('OpenHarmony')) {
          expect(data.signatureInfo.appId).assertContain("com.example.bundlemanager");
          expect((JSON.stringify(data.signatureInfo.fingerprint))!=null).assertTrue();
        } else if (platform === 'Android' || platform === 'iOS') {
          expect(data.signatureInfo.appId).assertEqual("");
          expect(data.signatureInfo.fingerprint).assertEqual("");
        }
      } catch (err) {
        console.log('err.code: ' + err.code + 'err.message: ' + err.message);
        expect().assertFail();
      }
      done();
    })

        /**
         * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_0900
         * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_0900
         * @tc.desc Test bundleFlags is undefined
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 2
         * @tc.require
         */
        it('ARKUIX_BundleManager_getBundleInfoForSelfSync_0900', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
          try {
            let data = bundleManager.getBundleInfoForSelfSync(undefined);
            console.log('BundleInfo: ' + JSON.stringify(data));
            expect().assertFail();
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect(err.code === 401).assertTrue();
          }
          done();
        })

        /**
         * @tc.number ARKUIX_BundleManager_getBundleInfoForSelfSync_1000
         * @tc.name ARKUIX_BundleManager_getBundleInfoForSelfSync_1000
         * @tc.desc Test bundleFlags is null
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 2
         * @tc.require
         */
        it('ARKUIX_BundleManager_getBundleInfoForSelfSync_1000', TestType.FUNCTION |
        Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
          try {
            let data = bundleManager.getBundleInfoForSelfSync(null);
            console.log('BundleInfo: ' + JSON.stringify(data));
            expect().assertFail();
          } catch (err) {
            console.log('err.code: ' + err.code + 'err.message: ' + err.message);
            expect(err.code === 401).assertTrue();
          }
          done();
        })
  })
}