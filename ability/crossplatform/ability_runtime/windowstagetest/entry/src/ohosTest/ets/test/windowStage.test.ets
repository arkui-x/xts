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
import { describe, beforeAll, it, expect, Level, TestType, Size,afterEach } from '@ohos/hypium';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import Want from '@ohos.app.ability.Want';
let windowStage: window.WindowStage;
let context: common.UIAbilityContext;
const entryName: string = 'EntryNamedRouter';
async function sleep(time: number) {
  return new Promise<void>((resolve) => setTimeout(resolve, time));
}
export default function windowStageTest() {
  describe('windowStageTest', () => {
    beforeAll(() => {
      windowStage = globalThis.windowStage;
      context = AppStorage.get<common.UIAbilityContext>('testAbilityContext') as common.UIAbilityContext;
    })
    afterEach(async () => {
      console.info('afterEach case');
      globalThis.list1 = [];
      globalThis.parameters = null;
      await sleep(500);
    });
    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0100
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0100
     * @tc.desc Verify the scenario of getMainWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0100';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string | undefined;
      try {
        const window: window.Window = await windowStage.getMainWindow();
        const data = window.getWindowProperties();
        hilog.info(0x0000, 'testTag', '%{public}s', 'windowStage.getMainWindow success!');
        expect(data.brightness != null).assertTrue();
        done();
      } catch (err) {
        msg = `windowStage getMainWindow failed: ${JSON.stringify(err)}`;
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.getMainWindow failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0200
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0200
     * @tc.desc Verify the scenario of getMainWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0200';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string | undefined;
      try {
        windowStage.getMainWindow((err: BusinessError<void>, window: window.Window) => {
          if (err.code !== 0) {
            msg = JSON.stringify(err);
            expect().assertFail();
            done();
            return;
          }
          const data = window.getWindowProperties();
          hilog.info(0x0000, 'testTag', '%{public}s', 'windowStage.getMainWindow success!');
          expect(data.brightness != null).assertTrue();
          done();
        })
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.getMainWindow failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0300
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0300
     * @tc.desc Verify the scenario of getMainWindowSync
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0300';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string | undefined;
      try {
        let win: window.Window | undefined = await windowStage.getMainWindowSync();
        const data = win.getWindowProperties();
        expect(data.brightness != null).assertTrue();
        hilog.info(0x0000, 'testTag', '%{public}s', 'windowStage.getMainWindowSync success!');
        done();
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.getMainWindowSync failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0400
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0400
     * @tc.desc Verify the scenario of createSubWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0400", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0400';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string | undefined;
      try {
        let win: window.Window = await windowStage.createSubWindow('mySubWindow');
        const data = win.getWindowProperties();
        expect(data.brightness != null).assertTrue();
        hilog.info(0x0000, 'testTag', '%{public}s', 'windowStage.getMainWindowSync success!');
        done();
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.createSubWindow failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0500
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0500
     * @tc.desc Verify the scenario of createSubWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0500", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0500';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string | undefined;
      try {
        windowStage.createSubWindow('mySubWindow2',
          (err: BusinessError<void>, window: window.Window) => {
            if (err.code !== 0) {
              msg = JSON.stringify(err);
              expect().assertFail();
              done();
              return;
            }
            const data = window.getWindowProperties();
            expect(data.brightness != null).assertTrue();
            hilog.info(0x0000, 'testTag', '%{public}s', 'windowStage.createSubWindow success!');
            done();
          })
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.createSubWindow failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0600
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0600
     * @tc.desc Verify the scenario of getSubWindow
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0600", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0600';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string;
      try {
        windowStage.getSubWindow(
          (err: BusinessError<void>, windows: Array<window.Window>) => {
            if (err.code !== 0) {
              msg = `windowStage getSubWindow_callback error: ${JSON.stringify(err)}`;
            } else {
              let names: string = '';
              windows.forEach((win: window.Window) => {
                names += win.getWindowProperties().brightness + ',';
              });
              hilog.info(0x0000, 'testTag', '%{public}s', msg);
              expect(names != null).assertTrue();
              done();
            }
          })
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          ` windowStage.getSubWindow failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0700
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0700
     * @tc.desc Verify the scenario of loadContent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0700", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0700';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let storage: LocalStorage = new LocalStorage();
      try {
        windowStage.loadContent('testability/pages/Index', storage)
          .then((data) => {
            hilog.info(0x0000, 'testTag', '%{public}s', 'windowStage.loadContent success!');
            expect(JSON.stringify(data)).assertEqual(undefined);
            done();
          })
          .catch((err: BusinessError<void>) => {
            hilog.info(0x0000, 'testTag', '%{public}s',
              `windowStage.loadContent failed, error.code: ${err.code}, error.message: ${err.message}`);
            expect().assertFail();
            done();
          });
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.loadContent failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0800
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0800
     * @tc.desc Verify the scenario of loadContent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0800", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0800';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string;
      let storage: LocalStorage = new LocalStorage();
      try {
        windowStage.loadContent('testability/pages/Index', storage,
          (err: BusinessError<void>) => {
            if (err.code !== 0) {
              msg = `windowStage loadContent_storage_callback error: ${JSON.stringify(err)}`;
            } else {
              msg = `windowStage loadContent_storage_callback success`;
            }
            hilog.info(0x0000, 'testTag', '%{public}s', msg);
            expect(err.code).assertEqual(0);
            done();
          })
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.loadContent failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0900
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0900
     * @tc.desc Verify the scenario of loadContent
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0900", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_0900';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string;
      try {
        windowStage.loadContent('testability/pages/Index',
          (err: BusinessError<void>) => {
            if (err.code !== 0) {
              msg = `windowStage loadContent_callback error: ${JSON.stringify(err)}`;
            } else {
              msg = `windowStage loadContent_callback success`;
            }
            hilog.info(0x0000, 'testTag', '%{public}s', msg);
            expect(err.code).assertEqual(0);
            done();
          })
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.loadContent failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1000
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1000
     * @tc.desc Verify the scenario of loadContentByName
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1000", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1000';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string;
      let storage: LocalStorage = new LocalStorage();
      try {
        windowStage.loadContentByName(entryName, storage,
          (err: BusinessError<void>) => {
            if (err.code !== 0) {
              msg = `windowStage.loadContentByName error: ${JSON.stringify(err)}`;
            } else {
              msg = `windowStage.loadContentByName success`;
            }
            hilog.info(0x0000, 'testTag', '%{public}s', msg);
            expect(err.code).assertEqual(0);
            done();
          })
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.loadContentByName failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1100
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1100
     * @tc.desc Verify the scenario of loadContentByName
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1100';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string;
      try {
        windowStage.loadContentByName(entryName,
          (err: BusinessError<void>) => {
            if (err.code !== 0) {
              msg = `windowStage loadContentByName_callback error: ${JSON.stringify(err)}`;
            } else {
              msg = `windowStage loadContentByName_callback success`;
            }
            hilog.info(0x0000, 'testTag', '%{public}s', msg);
            expect(err.code).assertEqual(0);
            done();
          })
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.loadContentByName failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1200
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1200
     * @tc.desc Verify the scenario of loadContentByName
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1200';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string;
      let storage: LocalStorage = new LocalStorage();
      try {
        windowStage.loadContentByName(entryName, storage)
          .then((data) => {
            msg = `windowStage loadContentByName_storage_promise success`;
            hilog.info(0x0000, 'testTag', '%{public}s',msg);
            expect(JSON.stringify(data)).assertEqual(undefined)
            done();
          })
          .catch((err: BusinessError<void>) => {
            msg = `windowStage loadContentByName_storage_promise error: ${JSON.stringify(err)}`;
            hilog.info(0x0000, 'testTag', msg);
            expect().assertFail();
            done();
          });
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage.loadContentByName promise failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1300
     * @tc.name ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1300
     * @tc.desc Verify the scenario of off
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level0
     * @tc.require
     */
    it("ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let tag = 'ArkUIX_SUB_Ability_AbilityRuntime_windowStage_1300';
      hilog.info(0x0000, 'testTag', '%{public}s', `${tag}, it begin`);
      let msg: string;
      try {
        let data = await windowStage.off('windowStageEvent');
        hilog.info(0x0000, 'testTag', '%{public}s', 'windowStage.off success!');
        expect(JSON.stringify(data)).assertEqual(undefined);
        done();
      } catch (err) {
        hilog.info(0x0000, 'testTag', '%{public}s',
          `windowStage off_windowStageEvent_callback failed, error.code: ${err.code}, error.message: ${err.message}`);
        expect().assertFail();
        done();
      }
    });
  })
}
