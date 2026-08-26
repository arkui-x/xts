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
import { WindowEnvHolder } from '../WindowEnvHolder';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

interface SizeLike {
  width: number;
  height: number;
}

interface RectLike {
  left?: number;
  top?: number;
  right?: number;
  bottom?: number;
  width?: number;
  height?: number;
}

interface SizeLikeExt {
  width?: number;
  height?: number;
}

interface RectLikeExt {
  left?: number;
  top?: number;
  right?: number;
  bottom?: number;
  width?: number;
  height?: number;
  x?: number;
  y?: number;
}

function approxEqual(actual: number, expected: number, tolerance: number = 1): boolean {
  return Math.abs(actual - expected) <= tolerance;
}

function readSizeFromProperties(properties: Object): SizeLike | null {
  const sizeValue = Reflect.get(properties, 'size') as SizeLikeExt | undefined;
  if (sizeValue !== undefined && sizeValue !== null && sizeValue.width !== undefined && sizeValue.height !== undefined) {
    return { width: sizeValue.width, height: sizeValue.height };
  }

  const rectCandidates: Array<string> = ['windowRect', 'screenRect', 'rect'];
  for (let i = 0; i < rectCandidates.length; i++) {
    const rectValue = Reflect.get(properties, rectCandidates[i]) as SizeLikeExt | undefined;
    if (rectValue !== undefined && rectValue !== null && rectValue.width !== undefined && rectValue.height !== undefined) {
      return { width: rectValue.width, height: rectValue.height };
    }
  }

  const widthValue = Reflect.get(properties, 'width') as number | undefined;
  const heightValue = Reflect.get(properties, 'height') as number | undefined;
  if (widthValue !== undefined && heightValue !== undefined) {
    return { width: widthValue, height: heightValue };
  }

  return null;
}

function readRect(value: Object | null | undefined): RectLike | null {
  if (value === null || value === undefined) {
    return null;
  }
  const rect = value as RectLikeExt;
  const left = rect.left !== undefined ? rect.left : rect.x;
  const top = rect.top !== undefined ? rect.top : rect.y;
  const width = rect.width;
  const height = rect.height;
  if (width === undefined && height === undefined && left === undefined && top === undefined && rect.right === undefined && rect.bottom === undefined) {
    return null;
  }
  return { left: left, top: top, right: rect.right, bottom: rect.bottom, width: width, height: height };
}

export default function WindowEnvBasic() {
  describe("WindowEnvBasic", () => {
    let windowStage: window.WindowStage;
    const TRUE_FLAG = true;

    beforeAll(async () => {
      console.info("WindowEnvBasic beforeAll case");
      windowStage = WindowStageHolder.getWindowStage()!;
    });

    beforeEach(async () => {
      console.info("WindowEnvBasic beforeEach case");
    });

    afterEach(async () => {
      await sleep(500);
      console.info('WindowEnvBasic afterEach case');
    });

    afterAll(async () => {
      console.info("WindowEnvBasic afterAll case");
    });

    // ============================================================================
    // @Env 装饰器测试: 验证 @Env(SystemProperties.xxx) 在组件中的绑定和赋值
    // ============================================================================

    /**
     * @tc.number    : ENV_DECORATOR_001
     * @tc.name      : testEnvDecoratorWindowSizeVP
     * @tc.desc      : 验证 @Env(SystemProperties.WINDOW_SIZE) 装饰器绑定 window.SizeInVP 类型
     *                 且与主窗口 getWindowProperties().size 通过 px -> vp 转换后保持一致
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testEnvDecoratorWindowSizeVP', 0, async (done: Function) => {
      let caseName = 'testEnvDecoratorWindowSizeVP';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      try {
        let maxRetry = 20;
        let sizeVp = WindowEnvHolder.getSizeVP();
        while ((!sizeVp || sizeVp.width <= 0 || sizeVp.height <= 0) && maxRetry > 0) {
          await sleep(300);
          sizeVp = WindowEnvHolder.getSizeVP();
          maxRetry--;
          console.log(msgStr + 'waiting for @Env WINDOW_SIZE, retry left: ' + maxRetry);
        }
        expect(sizeVp != null).assertTrue();
        const mainWin = await windowStage.getMainWindow();
        const properties = mainWin.getWindowProperties();
        const propertiesSize = readSizeFromProperties(properties);
        expect(propertiesSize != null).assertTrue();
        const expectedVp: SizeLike = {
          width: px2vp(propertiesSize!.width),
          height: px2vp(propertiesSize!.height)
        };
        console.log(msgStr + '@Env WINDOW_SIZE: ' + JSON.stringify(sizeVp) + ', expected px->vp: ' + JSON.stringify(expectedVp));
        expect(approxEqual(sizeVp!.width, expectedVp.width)).assertTrue();
        expect(approxEqual(sizeVp!.height, expectedVp.height)).assertTrue();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number    : ENV_DECORATOR_002
     * @tc.name      : testEnvDecoratorWindowSizePX
     * @tc.desc      : 验证 @Env(SystemProperties.WINDOW_SIZE_PX) 装饰器绑定 window.Size 类型
     *                 且与主窗口 getWindowProperties().size 完全一致
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testEnvDecoratorWindowSizePX', 0, async (done: Function) => {
      let caseName = 'testEnvDecoratorWindowSizePX';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      try {
        let maxRetry = 20;
        let sizePx = WindowEnvHolder.getSizePX();
        while ((!sizePx || sizePx.width <= 0 || sizePx.height <= 0) && maxRetry > 0) {
          await sleep(300);
          sizePx = WindowEnvHolder.getSizePX();
          maxRetry--;
          console.log(msgStr + 'waiting for @Env WINDOW_SIZE_PX, retry left: ' + maxRetry);
        }
        expect(sizePx != null).assertTrue();
        const mainWin = await windowStage.getMainWindow();
        const properties = mainWin.getWindowProperties();
        const propertiesSize = readSizeFromProperties(properties);
        console.log(msgStr + '@Env WINDOW_SIZE_PX: ' + JSON.stringify(sizePx) + ', getWindowProperties size: ' + JSON.stringify(propertiesSize));
        expect(propertiesSize != null).assertTrue();
        expect(sizePx!.width).assertEqual(propertiesSize!.width);
        expect(sizePx!.height).assertEqual(propertiesSize!.height);
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number    : ENV_DECORATOR_001_SUB
     * @tc.name      : testEnvDecoratorWindowSizeSubWindow
     * @tc.desc      : 验证子窗口场景中，窗口属性和环境变量维度一致，且 px/vp 需满足转换关系
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testEnvDecoratorWindowSizeSubWindow', 0, async (done: Function) => {
      let caseName = 'testEnvDecoratorWindowSizeSubWindow';
      let msgStr = 'jsunittest ' + caseName + ' ';
      let subWindowId = 'WindowEnvSizeSubWindow';
      console.log(msgStr + 'begin');
      try {
        const subWindow = await windowStage.createSubWindow(subWindowId);
        expect(!!subWindow).assertTrue();
        await subWindow.showWindow();
        await sleep(400);

        const subWindowProperties = subWindow.getWindowProperties();
        const subWinSize = readSizeFromProperties(subWindowProperties);
        const envSizeVp = WindowEnvHolder.getSizeVP();
        const envSizePx = WindowEnvHolder.getSizePX();
        if (subWinSize && envSizeVp) {
          console.log(msgStr + 'subWindow size: ' + JSON.stringify(subWinSize) + ', env sizeVp: ' + JSON.stringify(envSizeVp));
          expect(approxEqual(envSizeVp.width, px2vp(subWinSize.width))).assertTrue();
          expect(approxEqual(envSizeVp.height, px2vp(subWinSize.height))).assertTrue();
        }
        if (subWinSize && envSizePx) {
          console.log(msgStr + 'subWindow size: ' + JSON.stringify(subWinSize) + ', env sizePx: ' + JSON.stringify(envSizePx));
          expect(envSizePx.width).assertEqual(subWinSize.width);
          expect(envSizePx.height).assertEqual(subWinSize.height);
        }

        await subWindow.destroyWindow();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        try {
          const subWindow = await windowStage.getMainWindow();
          console.log(msgStr + 'cleanup mainWindow check ok: ' + !!subWindow);
        } catch (err) {
          console.error(msgStr + 'cleanup error: ' + JSON.stringify(err));
        }
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number    : ENV_DECORATOR_003
     * @tc.name      : testEnvDecoratorAvoidAreaVP
     * @tc.desc      : 验证 @Env(SystemProperties.WINDOW_AVOID_AREA) 装饰器绑定
     *                 且其值与 mainWindow.getWindowAvoidArea() 结果按 px -> vp 转换后保持一致
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testEnvDecoratorAvoidAreaVP', 0, async (done: Function) => {
      let caseName = 'testEnvDecoratorAvoidAreaVP';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      try {
        let maxRetry = 20;
        let avoidVp = WindowEnvHolder.getAvoidAreaVP();
        while (!avoidVp && maxRetry > 0) {
          await sleep(300);
          avoidVp = WindowEnvHolder.getAvoidAreaVP();
          maxRetry--;
          console.log(msgStr + 'waiting for @Env WINDOW_AVOID_AREA, retry left: ' + maxRetry);
        }
        expect(avoidVp != null).assertTrue();
        const mainWin = await windowStage.getMainWindow();
        const systemAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
        const cutoutAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_CUTOUT);
        const keyboardAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_KEYBOARD);
        const navAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
        console.log(msgStr + '@Env WINDOW_AVOID_AREA: ' + JSON.stringify(avoidVp));
        console.log(msgStr + 'systemAvoidAreaPx: ' + JSON.stringify(systemAvoidAreaPx));
        console.log(msgStr + 'cutoutAvoidAreaPx: ' + JSON.stringify(cutoutAvoidAreaPx));
        console.log(msgStr + 'keyboardAvoidAreaPx: ' + JSON.stringify(keyboardAvoidAreaPx));
        console.log(msgStr + 'navAvoidAreaPx: ' + JSON.stringify(navAvoidAreaPx));

        const statusBarVp = avoidVp == null ? null : readRect(Reflect.get(avoidVp as Object, 'statusBar') as Object | null | undefined);
        const statusBarPx = readRect(systemAvoidAreaPx as Object | null | undefined);
        const cutoutVp = avoidVp == null ? null : readRect(Reflect.get(avoidVp as Object, 'cutout') as Object | null | undefined);
        const cutoutPx = readRect(cutoutAvoidAreaPx as Object | null | undefined);
        const keyboardVp = avoidVp == null ? null : readRect(Reflect.get(avoidVp as Object, 'keyboard') as Object | null | undefined);
        const keyboardPx = readRect(keyboardAvoidAreaPx as Object | null | undefined);
        const navVp = avoidVp == null ? null : readRect(Reflect.get(avoidVp as Object, 'navigationIndicator') as Object | null | undefined);
        const navPx = readRect(navAvoidAreaPx as Object | null | undefined);

        if (statusBarVp && statusBarPx) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (statusBarVp as Record<string, number | undefined>)[key];
            const pxValue = (statusBarPx as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(approxEqual(envValue, px2vp(pxValue))).assertTrue();
            }
          }
        }
        if (cutoutVp && cutoutPx) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (cutoutVp as Record<string, number | undefined>)[key];
            const pxValue = (cutoutPx as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(approxEqual(envValue, px2vp(pxValue))).assertTrue();
            }
          }
        }
        if (keyboardVp && keyboardPx) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (keyboardVp as Record<string, number | undefined>)[key];
            const pxValue = (keyboardPx as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(approxEqual(envValue, px2vp(pxValue))).assertTrue();
            }
          }
        }
        if (navVp && navPx) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (navVp as Record<string, number | undefined>)[key];
            const pxValue = (navPx as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(approxEqual(envValue, px2vp(pxValue))).assertTrue();
            }
          }
        }
        expect(avoidVp!.statusBar != null).assertTrue();
        expect(avoidVp!.cutout != null).assertTrue();
        expect(avoidVp!.keyboard != null).assertTrue();
        expect(avoidVp!.navigationIndicator != null).assertTrue();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number    : ENV_DECORATOR_004
     * @tc.name      : testEnvDecoratorAvoidAreaPX
     * @tc.desc      : 验证 @Env(SystemProperties.WINDOW_AVOID_AREA_PX) 装饰器绑定
     *                 且其值与 mainWindow.getWindowAvoidArea() 完全一致
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testEnvDecoratorAvoidAreaPX', 0, async (done: Function) => {
      let caseName = 'testEnvDecoratorAvoidAreaPX';
      let msgStr = 'jsunittest ' + caseName + ' ';
      console.log(msgStr + 'begin');
      try {
        let maxRetry = 20;
        let avoidPx = WindowEnvHolder.getAvoidAreaPX();
        while (!avoidPx && maxRetry > 0) {
          await sleep(300);
          avoidPx = WindowEnvHolder.getAvoidAreaPX();
          maxRetry--;
          console.log(msgStr + 'waiting for @Env WINDOW_AVOID_AREA_PX, retry left: ' + maxRetry);
        }
        expect(avoidPx != null).assertTrue();
        const mainWin = await windowStage.getMainWindow();
        const systemAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
        const cutoutAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_CUTOUT);
        const keyboardAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_KEYBOARD);
        const navAvoidAreaPx = mainWin.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
        const pxStatus = readRect(systemAvoidAreaPx as Object | null | undefined);
        const pxCutout = readRect(cutoutAvoidAreaPx as Object | null | undefined);
        const pxKeyboard = readRect(keyboardAvoidAreaPx as Object | null | undefined);
        const pxNav = readRect(navAvoidAreaPx as Object | null | undefined);
        const envStatus = avoidPx == null ? null : readRect(Reflect.get(avoidPx as Object, 'statusBar') as Object | null | undefined);
        const envCutout = avoidPx == null ? null : readRect(Reflect.get(avoidPx as Object, 'cutout') as Object | null | undefined);
        const envKeyboard = avoidPx == null ? null : readRect(Reflect.get(avoidPx as Object, 'keyboard') as Object | null | undefined);
        const envNav = avoidPx == null ? null : readRect(Reflect.get(avoidPx as Object, 'navigationIndicator') as Object | null | undefined);
        console.log(msgStr + '@Env WINDOW_AVOID_AREA_PX: ' + JSON.stringify(avoidPx));
        console.log(msgStr + 'systemAvoidAreaPx: ' + JSON.stringify(systemAvoidAreaPx));
        console.log(msgStr + 'cutoutAvoidAreaPx: ' + JSON.stringify(cutoutAvoidAreaPx));
        console.log(msgStr + 'keyboardAvoidAreaPx: ' + JSON.stringify(keyboardAvoidAreaPx));
        console.log(msgStr + 'navAvoidAreaPx: ' + JSON.stringify(navAvoidAreaPx));

        if (envStatus && pxStatus) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (envStatus as Record<string, number | undefined>)[key];
            const pxValue = (pxStatus as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(envValue).assertEqual(pxValue);
            }
          }
        }
        if (envCutout && pxCutout) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (envCutout as Record<string, number | undefined>)[key];
            const pxValue = (pxCutout as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(envValue).assertEqual(pxValue);
            }
          }
        }
        if (envKeyboard && pxKeyboard) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (envKeyboard as Record<string, number | undefined>)[key];
            const pxValue = (pxKeyboard as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(envValue).assertEqual(pxValue);
            }
          }
        }
        if (envNav && pxNav) {
          const compareKeys: Array<'left' | 'top' | 'right' | 'bottom' | 'width' | 'height'> = ['left', 'top', 'right', 'bottom', 'width', 'height'];
          for (let i = 0; i < compareKeys.length; i++) {
            const key = compareKeys[i];
            const envValue = (envNav as Record<string, number | undefined>)[key];
            const pxValue = (pxNav as Record<string, number | undefined>)[key];
            if (envValue !== undefined && pxValue !== undefined) {
              expect(envValue).assertEqual(pxValue);
            }
          }
        }
        expect(avoidPx!.statusBar != null).assertTrue();
        expect(avoidPx!.cutout != null).assertTrue();
        expect(avoidPx!.keyboard != null).assertTrue();
        expect(avoidPx!.navigationIndicator != null).assertTrue();
        done();
      } catch (exception) {
        console.error(msgStr + 'Failed: ' + JSON.stringify(exception));
        expect(false).assertTrue();
        done();
      }
    });
  })
}