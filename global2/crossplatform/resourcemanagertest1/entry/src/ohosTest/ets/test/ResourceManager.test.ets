/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import resourceManager from '@ohos.resourceManager';
import { BusinessError } from '@ohos.base';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import ndk from 'libentry.so'
import common from '@ohos.app.ability.common';
import { DrawableDescriptor, LayeredDrawableDescriptor } from '@ohos.arkui.drawableDescriptor'
DrawableDescriptor.length;
let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");

export default function resourceManagerTest() {
  describe('resourceManagerTest', () => {

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0100
     * @tc.name : test isRawDir method
     * @tc.desc : test single input path is rawfile dir
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0100', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test"
      try {
        let result: Boolean = resMgr.isRawDir(testPath);
        expect(result).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0110
     * @tc.name : test isRawDir method
     * @tc.desc : test multi input path is rawfile dir
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0110', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test/testDir";
      try {
        let result: Boolean = resMgr.isRawDir(testPath);
        expect(result).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0120
     * @tc.name : test isRawDir method
     * @tc.desc : test multi input path isn't rawfile dir
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0120', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test/testDir/test.txt";
      try {
        let result: Boolean = resMgr.isRawDir(testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0130
     * @tc.name : test isRawDir method
     * @tc.desc : test multi input path not exist return 9001005
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0130', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "tesd/tttt";
      try {
        resMgr.isRawDir(testPath);
        expect().assertFail();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect(code == 9001005).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0140
     * @tc.name : test isRawDir method
     * @tc.desc : test input path undefined return 401
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0140', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        resMgr.isRawDir(undefined)
        expect().assertFail()
        done()
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message)
        expect(code == 401).assertTrue()
        done()
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0150
     * @tc.name : test isRawDir method
     * @tc.desc : test multi not exist file path return 9001005
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0150', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        resMgr.isRawDir("/test/test.txt");
        expect().assertFail();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect(code == 9001005).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0160
     * @tc.name : test isRawDir method
     * @tc.desc : test not null path return 401
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0160', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        resMgr.isRawDir(null);
        expect().assertFail();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect(code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0170
     * @tc.name : test isRawDir method
     * @tc.desc : test single not exist file path return 9001005
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0170', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        resMgr.isRawDir("test1.txt");
        expect().assertFail();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect(code == 9001005).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0180
     * @tc.name : test isRawDir method
     * @tc.desc : test single input path not exist
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0180', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "tttt";
      try {
        resMgr.isRawDir(testPath);
        expect().assertFail();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect(code == 9001005).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_IsRawDirTest_Func_0190
     * @tc.name : test isRawDir method
     * @tc.desc : test single input path isn't rawfile dir
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_IsRawDirTest_Func_0190', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test.txt";
      try {
        let result: Boolean = resMgr.isRawDir(testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0100
     * @tc.name : test OH_ResourceManager_IsRawDir NDK method
     * @tc.desc : test OH_ResourceManager_IsRawDir single input path is rawfile dir
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0100', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test"
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0110
     * @tc.name : test OH_ResourceManager_IsRawDir NDK method
     * @tc.desc : test OH_ResourceManager_IsRawDir multi input path is rawfile dir
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0110', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test/testDir";
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0120
     * @tc.name : test OH_ResourceManager_IsRawDir NDK method
     * @tc.desc : test OH_ResourceManager_IsRawDir multi input path isn't rawfile dir
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0120', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test/testDir/test.txt";
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
    * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0130
    * @tc.name : test OH_ResourceManager_IsRawDir NDK method
    * @tc.desc : test OH_ResourceManager_IsRawDir multi input path not exist
    * @tc.level : Level 2
    */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0130', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "tesd/tttt";
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0140
     * @tc.name : test OH_ResourceManager_IsRawDir NDK method
     * @tc.desc : test OH_ResourceManager_IsRawDir NDK method multi not exist file path
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0140', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "/test/test.txt";
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0150
     * @tc.name : test OH_ResourceManager_IsRawDir NDK method
     * @tc.desc : test OH_ResourceManager_IsRawDir NDK method single not exist file path
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0150', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test1.txt";
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0160
     * @tc.name : test OH_ResourceManager_IsRawDir NDK method
     * @tc.desc : test OH_ResourceManager_IsRawDir NDK method single input path not exist
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0160', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "tttt";
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0170
     * @tc.name : test OH_ResourceManager_IsRawDir NDK method
     * @tc.desc : test OH_ResourceManager_IsRawDir NDK method single input path isn't rawfile dir
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_OH_ResourceManager_IsRawDir_Func_0170', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let testPath = "test.txt";
      try {
        let result: Boolean = ndk.isRawDir(resMgr, testPath);
        expect(result == false).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testIsRawDirErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_GetOverrideConfigurationTest_Func_0100
     * @tc.name : test getOverrideConfiguration method
     * @tc.desc : test get default configuration by resMgr
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_GetOverrideConfigurationTest_Func_0100', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let configuration: resourceManager.Configuration = resMgr.getOverrideConfiguration();
        let defaultConfig: resourceManager.Configuration = {
          mcc: 0,
          mnc: 0,
          locale: '',
          direction: -1,
          deviceType: -1,
          colorMode: -1,
          screenDensity: 0
        };
        let result: Boolean = (configuration.direction == defaultConfig.direction &&
          configuration.locale == defaultConfig.locale &&
          configuration.deviceType == defaultConfig.deviceType &&
          configuration.screenDensity == defaultConfig.screenDensity &&
          configuration.colorMode == defaultConfig.colorMode &&
          configuration.mcc == defaultConfig.mcc &&
          configuration.mnc == defaultConfig.mnc);
        expect(result).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testGetOverrideConfigurationErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_GetOverrideConfigurationTest_Func_0200
     * @tc.name : test getOverrideConfiguration method
     * @tc.desc : test get override configuration by overrideResMgr
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_GetOverrideConfigurationTest_Func_0200', 0, async (done: Function) => {
      let completeOverrideConfig: resourceManager.Configuration = {
        mcc: 460,
        mnc: 101,
        locale: 'en_Latn_US',
        direction: resourceManager.Direction.DIRECTION_HORIZONTAL,
        deviceType: resourceManager.DeviceType.DEVICE_TYPE_PHONE,
        colorMode: resourceManager.ColorMode.DARK,
        screenDensity: resourceManager.ScreenDensity.SCREEN_SDPI
      };
      let resMgr = context.resourceManager;
      let overrideResMgr = resMgr.getOverrideResourceManager(completeOverrideConfig);
      try {
        let configuration: resourceManager.Configuration = overrideResMgr.getOverrideConfiguration()
        let result: Boolean = (configuration.direction == completeOverrideConfig.direction &&
          configuration.locale == completeOverrideConfig.locale &&
          configuration.deviceType == completeOverrideConfig.deviceType &&
          configuration.screenDensity == completeOverrideConfig.screenDensity &&
          configuration.colorMode == completeOverrideConfig.colorMode &&
          configuration.mcc == completeOverrideConfig.mcc &&
          configuration.mnc == completeOverrideConfig.mnc);
        expect(result).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testGetOverrideResourceMChangeErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_GetOverrideResourceManager_Func_0100
     * @tc.name : test getOverrideResourceManager method
     * @tc.desc : test get default overrideResMgr
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_GetOverrideResourceManager_Func_0100', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let overrideResMgr = resMgr.getOverrideResourceManager();
        console.info("print overrideResMgr" + overrideResMgr);
        expect(overrideResMgr != null).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testGetOverrideResourceManagerChangeErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_GetOverrideResourceManager_Func_0200
     * @tc.name : test getOverrideResourceManager method
     * @tc.desc : test get overrideResMgr by custom config
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_GetOverrideResourceManager_Func_0200', 0, async (done: Function) => {
      let completeOverrideConfig: resourceManager.Configuration = {
        mcc: 460,
        mnc: 101,
        locale: 'en_Latn_US',
        direction: resourceManager.Direction.DIRECTION_HORIZONTAL,
        deviceType: resourceManager.DeviceType.DEVICE_TYPE_PHONE,
        colorMode: resourceManager.ColorMode.DARK,
        screenDensity: resourceManager.ScreenDensity.SCREEN_SDPI
      };
      let resMgr = context.resourceManager;
      try {
        let overrideResMgr = resMgr.getOverrideResourceManager(completeOverrideConfig);
        expect(overrideResMgr != null).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testGetOverrideResourceManagerChangeErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_GetOverrideResourceManager_Func_0210
     * @tc.name : test getOverrideResourceManager method
     * @tc.desc : test get override by wrong config return 401
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_GetOverrideResourceManager_Func_0210', 0, async (done: Function) => {
      let completeOverrideConfig: resourceManager.Configuration = {
        mcc: 460,
        mnc: 101,
        locale: 'wrong_test',
        direction: resourceManager.Direction.DIRECTION_HORIZONTAL,
        deviceType: resourceManager.DeviceType.DEVICE_TYPE_PHONE,
        colorMode: resourceManager.ColorMode.DARK,
        screenDensity: resourceManager.ScreenDensity.SCREEN_SDPI
      };
      let resMgr = context.resourceManager;
      try {
        resMgr.getOverrideResourceManager(completeOverrideConfig);
        expect().assertFail();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testGetOverrideResourceManagerChangeErrorParam, code =" + code + ", message=" + message);
        expect(code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_GetOverrideResourceManager_Func_0220
     * @tc.name : test getOverrideResourceManager method
     * @tc.desc : test get override by undefined
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_GetOverrideResourceManager_Func_0220', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let overrideResMgr = resMgr.getOverrideResourceManager(undefined);
        expect(overrideResMgr != null).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testGetOverrideResourceManagerChangeErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_GetOverrideResourceManager_Func_0230
     * @tc.name : test getOverrideResourceManager method
     * @tc.desc : test get override by null
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_GetOverrideResourceManager_Func_0230', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let overrideResMgr = resMgr.getOverrideResourceManager(null);
        expect(overrideResMgr != null).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testGetOverrideResourceManagerChangeErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_UpdateOverrideConfigurationTest_Func_0100
     * @tc.name : test updateOverrideConfiguration method
     * @tc.desc : test update overrideConfiguration
     * @tc.level : Level 0
     */
    it('SUB_ResourceManagement_UpdateOverrideConfigurationTest_Func_0100', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      let completeOverrideConfig: resourceManager.Configuration = {
        mcc: 460,
        mnc: 101,
        locale: 'en_Latn_US',
        direction: resourceManager.Direction.DIRECTION_HORIZONTAL,
        deviceType: resourceManager.DeviceType.DEVICE_TYPE_PHONE,
        colorMode: resourceManager.ColorMode.DARK,
        screenDensity: resourceManager.ScreenDensity.SCREEN_SDPI
      };
      let rawConfig: resourceManager.Configuration = resMgr.getOverrideConfiguration();
      let overrideResMgr = resMgr.getOverrideResourceManager(completeOverrideConfig);
      try {
        overrideResMgr.updateOverrideConfiguration(rawConfig);
        let finalConfig: resourceManager.Configuration = overrideResMgr.getOverrideConfiguration();
        let result: Boolean = (finalConfig.direction == rawConfig.direction &&
          finalConfig.locale == rawConfig.locale &&
          finalConfig.deviceType == rawConfig.deviceType &&
          finalConfig.screenDensity == rawConfig.screenDensity &&
          finalConfig.colorMode == rawConfig.colorMode &&
          finalConfig.mcc == rawConfig.mcc &&
          finalConfig.mnc == rawConfig.mnc);
        expect(result).assertTrue();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testUpdateOverrideConfigurationErrorParam, code =" + code + ", message=" + message);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_UpdateOverrideConfigurationTest_Func_0110
     * @tc.name : test updateOverrideConfiguration method
     * @tc.desc : test update overrideConfiguration by wrong config return 401
     * @tc.level : Level 2
     */
    it('SUB_ResourceManagement_UpdateOverrideConfigurationTest_Func_0110', 0, async (done: Function) => {
      let completeOverrideConfig: resourceManager.Configuration = {
        mcc: 460,
        mnc: 101,
        locale: 'wrong_test',
        direction: resourceManager.Direction.DIRECTION_HORIZONTAL,
        deviceType: resourceManager.DeviceType.DEVICE_TYPE_PHONE,
        colorMode: resourceManager.ColorMode.DARK,
        screenDensity: resourceManager.ScreenDensity.SCREEN_SDPI
      };
      let resMgr = context.resourceManager;
      let overrideResMgr = resMgr.getOverrideResourceManager();
      try {
        overrideResMgr.updateOverrideConfiguration(completeOverrideConfig);
        expect().assertFail();
        done();
      } catch (error) {
        let code: Number = (error as BusinessError).code;
        let message: string = (error as BusinessError).message;
        console.info("testUpdateOverrideConfigurationErrorParam, code =" + code + ", message=" + message);
        expect(code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0100
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with normal pic
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0100', 0, async (done: Function) => {
      try {
        let resMgr = context.resourceManager;
        let value: DrawableDescriptor = resMgr.getDrawableDescriptor($r('app.media.icon').id);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0100 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0100 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0100 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0110
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with undefined density
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0110', 0, async (done: Function) => {
      try {
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor($r('app.media.icon').id, undefined);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0110 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0110 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0110 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0120
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with normal pic and density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0120', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.icon').id, 120);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0120 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0120 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0120 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0130
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with json style pic
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0130', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.drawable').id);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0130 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0130 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0130 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number SUB_ResourceManagement_getDrawableDescriptor_Func_0140
     * @tc.name test the getDrawableDescriptor method
     * @tc.desc getDrawableDescriptor with json style pic and density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0140', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.drawable').id, 240);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0140 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0140 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0140 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0150
     * @tc.name : test the getDrawableDescriptor method return 9001001
     * @tc.desc : getDrawableDescriptor with not exist resource id
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0150', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor(0x01110000);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0150 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0150 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0150 ' + error.message);
        expect(error.code == 9001001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0160
     * @tc.name : test the getDrawableDescriptor method return 401
     * @tc.desc : getDrawableDescriptor with not exist density
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0160', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.drawable').id, 130);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0160 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0160 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0160 ' + error.message);
        expect(error.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0170
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with 0 density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0170', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.drawable').id, 0);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0170 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0170 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0170 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0180
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with 0 type
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0180', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.drawable').id, 320, 0);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0180 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0180 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0180 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0190
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with 1 type
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0190', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.drawable').id, 480, 1);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0190 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0190 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0190 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0200
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with Random numbers that are not 0 and 1
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0200', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor($r('app.media.drawable').id, 640, 66);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0200 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0200 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0200 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0210
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with normal pic
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0210', 0, async (done: Function) => {
      try {
        let icon_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.icon').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(icon_resource);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0210 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0210 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0210 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0220
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with undefined density
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0220', 0, async (done: Function) => {
      try {
        let icon_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.icon').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(icon_resource, undefined);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0220 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0220 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0220 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0230
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with normal pic and density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0230', 0, async (done: Function) => {
      try {
        let icon_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.icon').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(icon_resource, 120);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0230 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0230 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0230 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0240
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with json style pic
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0240', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.drawable').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0240 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0240 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0240 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number SUB_ResourceManagement_getDrawableDescriptor_Func_0250
     * @tc.name test the getDrawableDescriptor method
     * @tc.desc getDrawableDescriptor with json style pic and density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0250', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.drawable').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource, 240);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0250 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0250 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0250 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0260
     * @tc.name : test the getDrawableDescriptor method return 9001001
     * @tc.desc : getDrawableDescriptor with not exist resource id
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0260', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: 0x01110000
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0260 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0260 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0260 ' + error.message);
        expect(error.code == 9001001).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0270
     * @tc.name : test the getDrawableDescriptor method return 401
     * @tc.desc : getDrawableDescriptor with not exist density
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0270', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.drawable').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource, 130);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0270 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0270 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0270 ' + error.message);
        expect(error.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0280
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with 0 density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0280', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.drawable').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource, 0);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0280 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0280 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0280 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0290
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with 0 type
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0290', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.drawable').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource, 320, 0);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0290 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0290 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0290 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0300
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with 1 type
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0300', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.drawable').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource, 480, 1);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0300 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0300 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0300 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0310
     * @tc.name : test the getDrawableDescriptor method
     * @tc.desc : getDrawableDescriptor with Random numbers that are not 0 and 1
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0310', 0, async (done: Function) => {
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: $r('app.media.drawable').id
        };
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptor(json_resource, 640, 66);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0310 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0310 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0310 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0320
     * @tc.name : test the getDrawableDescriptor method return 9001002
     * @tc.desc : getDrawableDescriptor returned error code 9001002
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0320', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptor(125829859);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0320 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0320 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0320 ' + error.message);
        expect(error.code == 9001002).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptor_Func_0330
     * @tc.name : test the getDrawableDescriptor method return 9001002
     * @tc.desc : getDrawableDescriptor returned error code 9001002
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptor_Func_0330', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let json_resource: resourceManager.Resource = {
          bundleName: "com.example.resourcemanagertest1",
          moduleName: "entry_test",
          id: 125829859
        };
        let value = resMgr.getDrawableDescriptor(json_resource);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0330 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0330 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptor_Func_0330 ' + error.message);
        expect(error.code == 9001002).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0100
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with normal pic
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0100', 0, async (done: Function) => {
      try {
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptorByName('icon');
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0100' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0100' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0100' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0110
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with undefined density
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0110', 0, async (done: Function) => {
      try {
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptorByName('icon', undefined);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0110 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0110 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0110 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0120
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with null density
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0120', 0, async (done: Function) => {
      try {
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptorByName('icon', null);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0120 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0120 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0120 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0130
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with normal pic and density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0130', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('icon', 120);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0130 ' + JSON.stringify(value));
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0130 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0130 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0140
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with json style pic
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0140', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('drawable');
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0140 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0140 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0140 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0150
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with json style pic and density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0150', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('drawable', 240);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0150 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0150 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0150 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0160
     * @tc.name : test the getDrawableDescriptorByName method return 9001003
     * @tc.desc : getDrawableDescriptorByName with not exist pic name
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0160', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('stratify');
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0160 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0160 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0160 ' + error.message);
        expect(error.code == 9001003).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0170
     * @tc.name : test the getDrawableDescriptorByName method return 401
     * @tc.desc : getDrawableDescriptorByName with not exist density
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0170', 0, async (done: Function) => {
      try {
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptorByName('drawable', 130);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0170 ' + value);
        expect().assertFail();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0170 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0170 ' + error.message);
        expect(error.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0180
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with 0 density
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0180', 0, async (done: Function) => {
      try {
        let resMgr = context.resourceManager;
        let value = resMgr.getDrawableDescriptorByName('drawable', 0);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0180 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0180 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0180 ' + error.message);
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0190
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with 0 type
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0190', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('drawable', 320, 0);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0190 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0190 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0190 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0200
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with 1 type
     * @tc.level : level 0
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0200', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('drawable', 480, 1);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0200 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0200 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0200 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0210
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with Random numbers that are not 0 and 1
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0210', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('drawable', 640, 66);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0210 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0210 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0210 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0220
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with null type
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0220', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('drawable', 640, null);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0220 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0220 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0220 ' + error.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ResourceManagement_getDrawableDescriptorByName_Func_0230
     * @tc.name : test the getDrawableDescriptorByName method
     * @tc.desc : getDrawableDescriptorByName with undefined type
     * @tc.level : level 2
     */
    it('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0230', 0, async (done: Function) => {
      let resMgr = context.resourceManager;
      try {
        let value = resMgr.getDrawableDescriptorByName('drawable', 640, undefined);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0230 ' + value);
        expect(value != null).assertTrue();
      } catch (error) {
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0230 ' + error.code);
        console.log('SUB_ResourceManagement_getDrawableDescriptorByName_Func_0230 ' + error.message);
        expect().assertFail();
      }
      done();
    })
  })
}