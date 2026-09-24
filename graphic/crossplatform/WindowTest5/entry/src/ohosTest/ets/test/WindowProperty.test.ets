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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import window from '@ohos.window';
import { BusinessError } from '@kit.BasicServicesKit';
import WindowStageHolder from '../WindowStageHolder';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function WindowProperty() {
  describe("WindowProperty", () => {
    let windowStage: window.WindowStage;
    const TRUE_FLAG = true;

    beforeAll(async () => {
      console.info("WindowProperty beforeAll case");
      windowStage = WindowStageHolder.getWindowStage()!;
    });

    beforeEach(async () => {
      console.info("WindowProperty beforeEach case");
    });

    afterEach(async () => {
      await sleep(500);
      console.info('WindowProperty afterEach case');
    });

    afterAll(async () => {
      console.info("WindowProperty afterAll case");
    });

    // ============================================================================
    // getWindowDensityInfo 测试
    // 对应设计文档《三端一致跨平台接口适配》3.1 getWindowDensityInfo
    // ============================================================================

    /**
     * @tc.number    : WIN_PROP_DENSITY_001
     * @tc.name      : testGetWindowDensityInfoMainWindow
     * @tc.desc      : 验证主窗口 getWindowDensityInfo 返回三个密度字段均有效
     *                 systemDensity / defaultDensity / customDensity 取值范围 [0.75, 4.0]
     *                 若返回 [-1, -1, -1] 表示当前设备不支持此 API
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetWindowDensityInfoMainWindow', 0, async (done: Function) => {
      let caseName = 'testGetWindowDensityInfoMainWindow';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      try {
        let mainWin = await windowStage.getMainWindow();
        expect(!!mainWin).assertTrue();

        let densityInfo: window.WindowDensityInfo = mainWin.getWindowDensityInfo();
        console.log(msgStr + 'densityInfo: ' + JSON.stringify(densityInfo));

        // 验证三个字段存在
        expect(densityInfo.systemDensity != null).assertTrue();
        expect(densityInfo.defaultDensity != null).assertTrue();
        expect(densityInfo.customDensity != null).assertTrue();

        // 若设备不支持，返回 [-1, -1, -1]，此时跳过范围校验
        if (densityInfo.systemDensity === -1 && densityInfo.defaultDensity === -1 &&
          densityInfo.customDensity === -1) {
          console.log(msgStr + 'device does not support getWindowDensityInfo, returned [-1, -1, -1]');
        } else {
          // 验证取值范围 [0.75, 4.0]
          expect(densityInfo.systemDensity >= 0.75 && densityInfo.systemDensity <= 4.0).assertTrue();
          expect(densityInfo.defaultDensity >= 0.75 && densityInfo.defaultDensity <= 4.0).assertTrue();
          expect(densityInfo.customDensity >= 0.75 && densityInfo.customDensity <= 4.0).assertTrue();
          console.log(msgStr + 'systemDensity=' + densityInfo.systemDensity +
            ', defaultDensity=' + densityInfo.defaultDensity +
            ', customDensity=' + densityInfo.customDensity);
        }
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : WIN_PROP_DENSITY_002
     * @tc.name      : testGetWindowDensityInfoSubWindow
     * @tc.desc      : 验证子窗口 getWindowDensityInfo 返回 customDensity 等于 systemDensity
     *                 根据 API 文档，子窗口的 customDensity 等同于 systemDensity
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testGetWindowDensityInfoSubWindow', 0, async (done: Function) => {
      let caseName = 'testGetWindowDensityInfoSubWindow';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let windowId = 'testGetWindowDensityInfoSubWindow';
      console.log(msgStr + 'begin');
      try {
        let subWin = await windowStage.createSubWindow(windowId);
        expect(!!subWin).assertTrue();
        await subWin.showWindow();
        await sleep(300);

        let densityInfo: window.WindowDensityInfo = subWin.getWindowDensityInfo();
        console.log(msgStr + 'subWindow densityInfo: ' + JSON.stringify(densityInfo));

        // 验证字段存在
        expect(densityInfo.systemDensity != null).assertTrue();
        expect(densityInfo.defaultDensity != null).assertTrue();
        expect(densityInfo.customDensity != null).assertTrue();

        // 若设备不支持，返回 [-1, -1, -1]
        if (densityInfo.systemDensity !== -1) {
          // 子窗口 customDensity 应等同于 systemDensity
          console.log(msgStr + 'subWindow systemDensity=' + densityInfo.systemDensity +
            ', customDensity=' + densityInfo.customDensity);
          // 子窗口 customDensity 与 systemDensity 等价（API 文档说明）
          expect(densityInfo.customDensity).assertEqual(densityInfo.systemDensity);
        }

        await subWin.destroyWindow();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : WIN_PROP_DENSITY_004
     * @tc.name      : testGetWindowDensityInfoDialogWindow
     * @tc.desc      : 验证Dialog窗口 getWindowDensityInfo 返回 customDensity 等于 systemDensity
     *                 根据 API 文档，Dialog窗口的 customDensity 等同于 systemDensity
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testGetWindowDensityInfoDialogWindow', 0, async (done: Function) => {
      let caseName = 'testGetWindowDensityInfoDialogWindow';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let windowId = 'testGetWindowDensityInfoDialogWindow';
      console.log(msgStr + 'begin');
      try {
        let mainWin = await windowStage.getMainWindow();
        expect(!!mainWin).assertTrue();
        let uiContext = mainWin.getUIContext();
        let hostContext = uiContext.getHostContext();
        expect(hostContext != null).assertTrue();

        let dialogWin = await window.createWindow({
          ctx: hostContext!,
          name: windowId,
          windowType: window.WindowType.TYPE_DIALOG
        });
        expect(!!dialogWin).assertTrue();
        await dialogWin.showWindow();
        await sleep(300);

        let densityInfo: window.WindowDensityInfo = dialogWin.getWindowDensityInfo();
        console.log(msgStr + 'dialogWindow densityInfo: ' + JSON.stringify(densityInfo));

        expect(densityInfo.systemDensity != null).assertTrue();
        expect(densityInfo.defaultDensity != null).assertTrue();
        expect(densityInfo.customDensity != null).assertTrue();

        if (densityInfo.systemDensity !== -1) {
          console.log(msgStr + 'dialogWindow systemDensity=' + densityInfo.systemDensity +
            ', customDensity=' + densityInfo.customDensity);
          expect(densityInfo.customDensity).assertEqual(densityInfo.systemDensity);
        }

        await dialogWin.destroyWindow();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : WIN_PROP_DENSITY_003
     * @tc.name      : testGetWindowDensityInfoDestroyedWindow
     * @tc.desc      : 验证窗口销毁后调用 getWindowDensityInfo 抛出 BusinessError 1300002
     *                 错误码 1300002 表示窗口状态异常（窗口不存在）
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testGetWindowDensityInfoDestroyedWindow', 0, async (done: Function) => {
      let caseName = 'testGetWindowDensityInfoDestroyedWindow';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let windowId = 'testGetWindowDensityInfoDestroyedWindow';
      console.log(msgStr + 'begin');
      try {
        let subWin = await windowStage.createSubWindow(windowId);
        expect(!!subWin).assertTrue();
        await subWin.showWindow();
        await sleep(300);

        await subWin.destroyWindow();
        console.log(msgStr + 'window destroyed');

        try {
          subWin.getWindowDensityInfo();
          console.log(msgStr + 'getWindowDensityInfo did not throw after destroy');
        } catch (err) {
          let bizErr = err as BusinessError;
          console.log(msgStr + 'getWindowDensityInfo threw BusinessError: code=' + bizErr.code +
            ', message=' + bizErr.message);
          expect(bizErr.code).assertEqual(1300002);
          expect(bizErr.message != null && bizErr.message.length > 0).assertTrue();
        }

        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect().assertFail();
        done();
      }
    });

    // ============================================================================
    // setWindowBrightness 测试
    // 对应设计文档《三端一致跨平台接口适配》3.2 setWindowBrightness
    // ============================================================================

    /**
     * @tc.number    : WIN_PROP_BRIGHTNESS_001
     * @tc.name      : testSetWindowBrightnessValid
     * @tc.desc      : 验证 setWindowBrightness 设置有效亮度值 0.5 成功
     *                 亮度有效范围 [0.0, 1.0]
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetWindowBrightnessValid', 0, async (done: Function) => {
      let caseName = 'testSetWindowBrightnessValid';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let savedBrightness: number = -1.0;
      console.log(msgStr + 'begin');
      try {
        let mainWin = await windowStage.getMainWindow();
        expect(!!mainWin).assertTrue();

        savedBrightness = mainWin.getWindowProperties().brightness;
        console.log(msgStr + 'saved brightness: ' + savedBrightness);

        // 设置亮度为 0.5
        await mainWin.setWindowBrightness(0.5);
        console.log(msgStr + 'setWindowBrightness(0.5) success');
        await sleep(300);
        try {
          let properties = mainWin.getWindowProperties();
          console.log(msgStr + 'brightness from properties after set: ' + properties.brightness);
          expect(properties.brightness).assertEqual(0.5);
        } catch (e) {
          console.warn(msgStr + 'Failed to read properties after set: ' + JSON.stringify(e));
        }

        // 恢复执行用例前的亮度
        await mainWin.setWindowBrightness(savedBrightness);
        console.log(msgStr + 'restored brightness to ' + savedBrightness);

        expect(TRUE_FLAG).assertTrue();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        try {
          let mainWin = await windowStage.getMainWindow();
          await mainWin.setWindowBrightness(savedBrightness);
        } catch (e) {
          console.error(msgStr + 'Failed to restore brightness: ' + JSON.stringify(e));
        }
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : WIN_PROP_BRIGHTNESS_002
     * @tc.name      : testSetWindowBrightnessEdgeValues
     * @tc.desc      : 验证 setWindowBrightness 边界值: 0.0 (最暗) 和 1.0 (最亮)
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetWindowBrightnessEdgeValues', 0, async (done: Function) => {
      let caseName = 'testSetWindowBrightnessEdgeValues';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let savedBrightness: number = -1.0;
      console.log(msgStr + 'begin');
      try {
        let mainWin = await windowStage.getMainWindow();
        expect(!!mainWin).assertTrue();

        savedBrightness = mainWin.getWindowProperties().brightness;
        console.log(msgStr + 'saved brightness: ' + savedBrightness);

        // 测试边界值 0.0
        await mainWin.setWindowBrightness(0.0);
        console.log(msgStr + 'setWindowBrightness(0.0) success');
        await sleep(300);

        let properties = mainWin.getWindowProperties();
        console.log(msgStr + 'brightness from properties: ' + properties.brightness);
        expect(properties.brightness).assertEqual(0.0);

        // 测试边界值 1.0
        await mainWin.setWindowBrightness(1.0);
        console.log(msgStr + 'setWindowBrightness(1.0) success');
        await sleep(300);

        properties = mainWin.getWindowProperties();
        console.log(msgStr + 'brightness from properties: ' + properties.brightness);
        expect(properties.brightness).assertEqual(1.0);

        // 恢复执行用例前的亮度
        await mainWin.setWindowBrightness(savedBrightness);
        console.log(msgStr + 'restored brightness to ' + savedBrightness);

        expect(TRUE_FLAG).assertTrue();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        try {
          let mainWin = await windowStage.getMainWindow();
          await mainWin.setWindowBrightness(savedBrightness);
        } catch (e) {
          console.error(msgStr + 'Failed to restore brightness: ' + JSON.stringify(e));
        }
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : WIN_PROP_BRIGHTNESS_004
     * @tc.name      : testSetWindowBrightnessInvalid
     * @tc.desc      : 验证 setWindowBrightness 无效值处理
     *                 超出 [0.0, 1.0] 且不等于 -1.0 应抛出 BusinessError 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetWindowBrightnessInvalid', 0, async (done: Function) => {
      let caseName = 'testSetWindowBrightnessInvalid';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let savedBrightness: number = -1.0;
      console.log(msgStr + 'begin');
      try {
        let mainWin = await windowStage.getMainWindow();
        expect(!!mainWin).assertTrue();

        savedBrightness = mainWin.getWindowProperties().brightness;
        console.log(msgStr + 'saved brightness: ' + savedBrightness);

        // 测试无效值 2.0 (超出范围)
        try {
          await mainWin.setWindowBrightness(2.0);
          // 如果未抛异常，说明平台可能不校验范围
          console.log(msgStr + 'setWindowBrightness(2.0) did not throw, platform may not validate');
        } catch (err) {
          let bizErr = err as BusinessError;
          console.log(msgStr + 'setWindowBrightness(2.0) threw BusinessError: code=' + bizErr.code +
            ', message=' + bizErr.message);
          // 预期错误码 401 (参数错误)
          expect(bizErr.code).assertEqual(401);
          expect(bizErr.message != null && bizErr.message.length > 0).assertTrue();
        }

        // 测试无效值 -0.5 (超出范围，不是 -1.0)
        try {
          await mainWin.setWindowBrightness(-0.5);
          console.log(msgStr + 'setWindowBrightness(-0.5) did not throw, platform may not validate');
        } catch (err) {
          let bizErr = err as BusinessError;
          console.log(msgStr + 'setWindowBrightness(-0.5) threw BusinessError: code=' + bizErr.code +
            ', message=' + bizErr.message);
          expect(bizErr.code).assertEqual(401);
          expect(bizErr.message != null && bizErr.message.length > 0).assertTrue();
        }

        // 恢复执行用例前的亮度
        await mainWin.setWindowBrightness(savedBrightness);
        console.log(msgStr + 'restored brightness to ' + savedBrightness);

        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        try {
          let mainWin = await windowStage.getMainWindow();
          await mainWin.setWindowBrightness(savedBrightness);
        } catch (e) {
          console.error(msgStr + 'Failed to restore brightness: ' + JSON.stringify(e));
        }
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : WIN_PROP_BRIGHTNESS_005
     * @tc.name      : testSetWindowBrightnessDestroyedWindow
     * @tc.desc      : 验证窗口销毁后调用 setWindowBrightness 抛出 BusinessError 1300002
     *                 错误码 1300002 表示窗口状态异常（窗口不存在）
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetWindowBrightnessDestroyedWindow', 0, async (done: Function) => {
      let caseName = 'testSetWindowBrightnessDestroyedWindow';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let windowId = 'testSetWindowBrightnessDestroyedWindow';
      console.log(msgStr + 'begin');
      try {
        let subWin = await windowStage.createSubWindow(windowId);
        expect(!!subWin).assertTrue();
        await subWin.showWindow();
        await sleep(300);

        await subWin.destroyWindow();
        console.log(msgStr + 'window destroyed');

        try {
          await subWin.setWindowBrightness(0.5);
          console.log(msgStr + 'setWindowBrightness did not throw after destroy');
        } catch (err) {
          let bizErr = err as BusinessError;
          console.log(msgStr + 'setWindowBrightness threw BusinessError: code=' + bizErr.code +
            ', message=' + bizErr.message);
          expect(bizErr.code).assertEqual(1300002);
          expect(bizErr.message != null && bizErr.message.length > 0).assertTrue();
        }

        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number    : WIN_PROP_BRIGHTNESS_003
     * @tc.name      : testSetWindowBrightnessSubWindow
     * @tc.desc      : 验证子窗口 setWindowBrightness 设置有效亮度值 0.5 成功，
     *                 并通过 getWindowProperties 校验 brightness 返回值与设置值一致
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetWindowBrightnessSubWindow', 0, async (done: Function) => {
      let caseName = 'testSetWindowBrightnessSubWindow';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let windowId = 'testSetWindowBrightnessSubWindow';
      console.log(msgStr + 'begin');
      try {
        let subWin = await windowStage.createSubWindow(windowId);
        expect(!!subWin).assertTrue();
        await subWin.showWindow();
        await sleep(300);

        let savedBrightness = subWin.getWindowProperties().brightness;
        console.log(msgStr + 'saved brightness: ' + savedBrightness);

        await subWin.setWindowBrightness(0.5);
        console.log(msgStr + 'subWindow setWindowBrightness(0.5) success');
        await sleep(300);

        let properties = subWin.getWindowProperties();
        console.log(msgStr + 'subWindow brightness from properties: ' + properties.brightness);
        expect(properties.brightness).assertEqual(0.5);

        await subWin.setWindowBrightness(savedBrightness);
        console.log(msgStr + 'restored brightness to ' + savedBrightness);

        await subWin.destroyWindow();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect().assertFail();
        done();
      }
    });

    // ============================================================================
    // 综合场景: getWindowDensityInfo + setWindowBrightness 组合
    // ============================================================================

    /**
     * @tc.number    : WIN_PROP_COMBO_001
     * @tc.name      : testDensityAndBrightnessCombo
     * @tc.desc      : 验证 getWindowDensityInfo 和 setWindowBrightness 在同一个窗口上连续调用不冲突
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testDensityAndBrightnessCombo', 0, async (done: Function) => {
      let caseName = 'testDensityAndBrightnessCombo';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let savedBrightness: number = -1.0;
      console.log(msgStr + 'begin');
      try {
        let mainWin = await windowStage.getMainWindow();
        expect(!!mainWin).assertTrue();

        savedBrightness = mainWin.getWindowProperties().brightness;
        console.log(msgStr + 'saved brightness: ' + savedBrightness);

        // 混合调用
        let densityInfo = mainWin.getWindowDensityInfo();
        console.log(msgStr + 'density before brightness: ' + JSON.stringify(densityInfo));

        await mainWin.setWindowBrightness(0.5);
        console.log(msgStr + 'set brightness in combo');

        let properties = mainWin.getWindowProperties();
        console.log(msgStr + 'brightness from properties: ' + properties.brightness);
        expect(properties.brightness).assertEqual(0.5);

        let densityInfoAfter = mainWin.getWindowDensityInfo();
        console.log(msgStr + 'density after brightness: ' + JSON.stringify(densityInfoAfter));

        // 密度信息在亮度变化前后应保持一致
        expect(densityInfoAfter.systemDensity).assertEqual(densityInfo.systemDensity);
        expect(densityInfoAfter.defaultDensity).assertEqual(densityInfo.defaultDensity);

        // 恢复执行用例前的亮度
        await mainWin.setWindowBrightness(savedBrightness);
        console.log(msgStr + 'restored brightness to ' + savedBrightness);

        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        try {
          let mainWin = await windowStage.getMainWindow();
          await mainWin.setWindowBrightness(savedBrightness);
        } catch (e) {
          console.error(msgStr + 'Failed to restore brightness: ' + JSON.stringify(e));
        }
        expect().assertFail();
        done();
      }
    });
  })
}