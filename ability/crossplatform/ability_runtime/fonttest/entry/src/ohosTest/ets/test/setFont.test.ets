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

import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, it, expect, Level, TestType, Size, beforeAll } from '@ohos/hypium';
import { abilityDelegatorRegistry } from '@kit.TestKit';
import { BusinessError } from '@kit.BasicServicesKit';
import common from '@ohos.app.ability.common';

const TAG = 'testTag';
let context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext().createModuleContext('entry_test');
let applicationContext = context.getApplicationContext();
let testAbilityContext: common.UIAbilityContext;
function sleep(ms: number) {
  return new Promise<string>(resolve => setTimeout(resolve, ms));
}

export default function setFontTest() {
  describe('setFontTest', () => {
    beforeAll(() => {
      testAbilityContext = AppStorage.get<common.UIAbilityContext>('TestAbilityContext') as common.UIAbilityContext;
    })

    /**
     * @tc.number ArkUIX_SetFont_Test_0100
     * @tc.name ArkUIX_SetFont_Test_0100
     * @tc.desc Passing null to the setFont interface results in a 401 error code
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it("ArkUIX_SetFont_Test_0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SetFont_Test_0100';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      try {
        applicationContext.setFont(null);
        hilog.info(0x0000, 'testTag', '%{public}s', 'applicationContext.setFont success!');
        expect().assertFail();
        done();
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `applicationContext.setFont failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.number ArkUIX_SetFont_Test_0200
     * @tc.name ArkUIX_SetFont_Test_0200
     * @tc.desc Passing undefined to the setFont interface results in a 401 error code
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it("ArkUIX_SetFont_Test_0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SetFont_Test_0200';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      try {
        applicationContext.setFont(undefined);
        hilog.info(0x0000, 'testTag', '%{public}s', 'applicationContext.setFont success!');
        expect().assertFail();
        done();
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `applicationContext.setFont failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.number ArkUIX_setFontSizeScale_Test_0300
     * @tc.name ArkUIX_setFontSizeScale_Test_0300
     * @tc.desc Passing -1 to the setFontSizeScale interface results in a 401 error code
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it("ArkUIX_setFontSizeScale_Test_0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let tag = 'ArkUIX_setFontSizeScale_Test_0300';
        hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
        try {
          applicationContext.setFontSizeScale(-1);
          hilog.info(0x0000, 'testTag', '%{public}s', 'applicationContext.setFontSizeScale success!');
          expect().assertFail();
          done();
        } catch (err) {
          hilog.info(0x0000, 'testTag', '%{public}s',
            `applicationContext.setFontSizeScale failed, error.code: ${err.code}, error.message: ${err.message}`);
          expect(err.code).assertEqual(401);
          done();
        }
      })

    /**
     * @tc.number ArkUIX_setFontSizeScale_Test_0400
     * @tc.name ArkUIX_setFontSizeScale_Test_0400
     * @tc.desc Passing null to the setFontSizeScale interface results in a 401 error code
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it("ArkUIX_setFontSizeScale_Test_0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let tag = 'ArkUIX_setFontSizeScale_Test_0400';
        hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
        try {
          applicationContext.setFontSizeScale(null);
          hilog.info(0x0000, 'testTag', '%{public}s', 'applicationContext.setFontSizeScale success!');
          expect().assertFail();
          done();
        } catch (err) {
          hilog.info(0x0000, 'testTag', '%{public}s',
            `applicationContext.setFontSizeScale failed, error.code: ${err.code}, error.message: ${err.message}`);
          expect(err.code).assertEqual(401);
          done();
        }
      })

    /**
     * @tc.number ArkUIX_setFontSizeScale_Test_0500
     * @tc.name ArkUIX_setFontSizeScale_Test_0500
     * @tc.desc Passing undefined to the setFontSizeScale interface results in a 401 error code
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it("ArkUIX_setFontSizeScale_Test_0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let tag = 'ArkUIX_setFontSizeScale_Test_0500';
        hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
        try {
          applicationContext.setFontSizeScale(undefined);
          hilog.info(0x0000, 'testTag', '%{public}s', 'applicationContext.setFontSizeScale success!');
          expect().assertFail();
          done();
        } catch (err) {
          hilog.info(0x0000, 'testTag', '%{public}s',
            `applicationContext.setFontSizeScale failed, error.code: ${err.code}, error.message: ${err.message}`);
          expect(err.code).assertEqual(401);
          done();
        }
      })

    /**
     * @tc.number ArkUIX_setLanguage_Test_0600
     * @tc.name ArkUIX_setLanguage_Test_0600
     * @tc.desc Passing null to the setLanguage interface results in a 401 error code
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it("ArkUIX_setLanguage_Test_0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_setLanguage_Test_0600';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      try {
        applicationContext.setLanguage(null);
        hilog.info(0x0000, 'testTag', '%{public}s', 'applicationContext.setLanguage success!');
        expect().assertFail();
        done();
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `applicationContext.setLanguage failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.number ArkUIX_setLanguage_Test_0700
     * @tc.name ArkUIX_setLanguage_Test_0700
     * @tc.desc Passing undefined to the setLanguage interface results in a 401 error code
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it("ArkUIX_setLanguage_Test_0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_setLanguage_Test_0700';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      try {
        applicationContext.setLanguage(undefined);
        hilog.info(0x0000, 'testTag', '%{public}s', 'applicationContext.setLanguage success!');
        expect().assertFail();
        done();
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `applicationContext.setLanguage failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect(err.code).assertEqual(401);
        done();
      }
    })
  })
}