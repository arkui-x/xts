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

import { describe, beforeAll, afterEach, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import deviceInfo from '@ohos.deviceInfo';

const WAIT_MS_500 = 500;
const WAIT_MS_1000 = 1000;
const WAIT_MS_2000 = 2000;
const WAIT_MS_3000 = 3000;
const WAIT_MS_8000 = 8000;
const WAIT_MS_10000 = 10000;

let driver = Driver.create();
const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const osFullNameInfo: string = deviceInfo.osFullName ?? '';
const platform = osFullNameInfo.split(' ')[0] ?? '';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };
  await delegator.startAbility(want).then(result => {
    console.info(`start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`start abilityFailed: ${err}`)
  })
}

async function goToPage(pageId: string, timeoutMs: number): Promise<void> {
  const start = Date.now();
  let button: Component | null = null;
  while (Date.now() - start < timeoutMs) {
    try {
      button = await driver.findComponent(ON.id(pageId));
      if (button) break;
    } catch (e) {}
    await sleep(WAIT_MS_500);
  }
  if (!button) {
    console.error(`goToPage FAILED: cannot find id="${pageId}" after ${timeoutMs}ms`);
    return;
  }
  await button!.click();
  await sleep(WAIT_MS_2000);
}

async function clickButton_withId(buttonId: string, timeoutMs: number): Promise<void> {
  const start = Date.now();
  let button: Component | null = null;
  while (Date.now() - start < timeoutMs) {
    try {
      button = await driver.findComponent(ON.id(buttonId));
      if (button) break;
    } catch (e) {}
    await sleep(WAIT_MS_500);
  }
  if (!button) {
    console.error(`clickButton_withId FAILED: cannot find id="${buttonId}" after ${timeoutMs}ms`);
    return;
  }
  await button!.click();
  await sleep(WAIT_MS_500);
}

async function waitForText(id: string, expectedText: string, timeoutMs: number): Promise<boolean> {
  const start = Date.now();
  while (Date.now() - start < timeoutMs) {
    try {
      let comp = await driver.findComponent(ON.id(id));
      if (!comp) { await sleep(WAIT_MS_500); continue; }
      let text = await comp.getText();
      if (text.includes(expectedText)) return true;
    } catch (e) {}
    await sleep(WAIT_MS_500);
  }
  try {
    await driver.findComponent(ON.id(id));
  } catch (e) {
    console.warn(`waitForText timeout! id=${id}, error reading text`);
  }
  return false;
}

export default function webWindowXtsTest() {
  describe('WebWindowXtsTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_2000);
      await startAbility('com.example.webwindowxts', 'EntryAbility');
      await sleep(WAIT_MS_3000);
    });

    afterEach(async () => {
      await driver.pressBack();
      await sleep(WAIT_MS_1000);
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0100
     * @tc.name ArkUIX_WebView_onWindowNew_0100
     * @tc.desc Test web attribute setWebController is normal, multiWinAccess is true, allowWinOpenMethod is true
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m01", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-WinNew', 'event.targetUrl:https://www.baidu.com/', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0100, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0200
     * @tc.name ArkUIX_WebView_onWindowNew_0200
     * @tc.desc Test multiWinAccess is true, allowWinOpenMethod is true, callback is normal, handler not called, popup window default behavior
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m02", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-WinNew', 'event.targetUrl:https://www.baidu.com/', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0200, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0300
     * @tc.name ArkUIX_WebView_onWindowNew_0300
     * @tc.desc Test multiWinAccess is true, allowWinOpenMethod is true, callback is normal, setWebController(null), no popup window
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m03", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-WinNew', 'event.targetUrl:https://www.baidu.com/', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0300, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0400
     * @tc.name ArkUIX_WebView_onWindowNew_0400
     * @tc.desc Test multiWinAccess is true, allowWinOpenMethod is true, callback is normal, setWebController(undefined), no popup window
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m04", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-WinNew', 'event.targetUrl:https://www.baidu.com/', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0400, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0500
     * @tc.name ArkUIX_WebView_onWindowNew_0500
     * @tc.desc Test multiWinAccess is true, allowWinOpenMethod is false, callback is normal, setWebController is normal
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m05", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-WinNew', '窗口未弹出', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0500, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0600
     * @tc.name ArkUIX_WebView_onWindowNew_0600
     * @tc.desc Test multiWinAccess is true, allowWinOpenMethod is false, callback is normal, handler not called
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m06", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-WinNew', '窗口未弹出', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0600, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0700
     * @tc.name ArkUIX_WebView_onWindowNew_0700
     * @tc.desc Test multiWinAccess is true, allowWinOpenMethod is false, callback is normal, setWebController(null), no popup window
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m07", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-WinNew', '窗口未弹出', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0700, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0800
     * @tc.name ArkUIX_WebView_onWindowNew_0800
     * @tc.desc Test multiWinAccess is true, allowWinOpenMethod is false, callback is normal, setWebController(undefined), no popup window
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m08", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-WinNew', '窗口未弹出', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0800, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_0900
     * @tc.name ArkUIX_WebView_onWindowNew_0900
     * @tc.desc Test multiWinAccess is false, allowWinOpenMethod is false, callback not triggered, main web loads baidu directly
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m09", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-WinNew', '网页未加载', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_0900, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_1000
     * @tc.name ArkUIX_WebView_onWindowNew_1000
     * @tc.desc Test multiWinAccess is false, allowWinOpenMethod is true, callback not triggered, main web loads baidu directly
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m10", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        await sleep(WAIT_MS_8000);
        let found = await waitForText('result-WinNew', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_1000, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_1100
     * @tc.name ArkUIX_WebView_onWindowNew_1100
     * @tc.desc Test callback is set to null, no callback registered
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m11", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-WinNew', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_1100, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowNew_1200
     * @tc.name ArkUIX_WebView_onWindowNew_1200
     * @tc.desc Test callback is set to undefined, no callback registered
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowNew_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("onWindowNewTest", WAIT_MS_3000);
        await clickButton_withId("mode-m12", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-WinNew', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowNew_1200, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onWindowExit_0100
     * @tc.name ArkUIX_WebView_onWindowExit_0100
     * @tc.desc Test create child window via window.open, child window calls window.close, onWindowExit callback triggered
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level0
     * @tc.require
     */
    it('ArkUIX_WebView_onWindowExit_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("onWindowExitTest", WAIT_MS_3000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-WinExit', 'onWindowExit回调触发', WAIT_MS_10000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onWindowExit_0100, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_allowWindowOpenMethod_0100
     * @tc.name ArkUIX_WebView_allowWindowOpenMethod_0100
     * @tc.desc Test allowWindowOpenMethod is true, auto trigger window.open after 2s delay, callback triggered, popup window
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_allowWindowOpenMethod_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("allowOpenMethodTest", WAIT_MS_3000);
        await clickButton_withId("mode-true", WAIT_MS_1000);
        let found = await waitForText('result-AllowOpen', 'event.targetUrl:https://www.baidu.com', WAIT_MS_10000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_allowWindowOpenMethod_0100, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_allowWindowOpenMethod_0200
     * @tc.name ArkUIX_WebView_allowWindowOpenMethod_0200
     * @tc.desc Test allowWindowOpenMethod is false, window.open is blocked, callback not triggered
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_allowWindowOpenMethod_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("allowOpenMethodTest", WAIT_MS_3000);
        await clickButton_withId("mode-false", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-AllowOpen', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_allowWindowOpenMethod_0200, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_allowWindowOpenMethod_0300
     * @tc.name ArkUIX_WebView_allowWindowOpenMethod_0300
     * @tc.desc Test allowWindowOpenMethod is null, window.open is blocked
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_allowWindowOpenMethod_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("allowOpenMethodTest", WAIT_MS_3000);
        await clickButton_withId("mode-null", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-AllowOpen', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_allowWindowOpenMethod_0300, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_allowWindowOpenMethod_0400
     * @tc.name ArkUIX_WebView_allowWindowOpenMethod_0400
     * @tc.desc Test allowWindowOpenMethod is undefined, window.open is blocked
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_allowWindowOpenMethod_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("allowOpenMethodTest", WAIT_MS_3000);
        await clickButton_withId("mode-undefined", WAIT_MS_1000);
        await sleep(WAIT_MS_3000);
        let found = await waitForText('result-AllowOpen', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_allowWindowOpenMethod_0400, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_multiWindowAccess_0100
     * @tc.name ArkUIX_WebView_multiWindowAccess_0100
     * @tc.desc Test multiWindowAccess is null, window.open does not trigger callback, main web navigates to baidu
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_multiWindowAccess_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("multiAccessTest", WAIT_MS_3000);
        await clickButton_withId("mode-null", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-MultiAccess', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_multiWindowAccess_0100, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_multiWindowAccess_0200
     * @tc.name ArkUIX_WebView_multiWindowAccess_0200
     * @tc.desc Test multiWindowAccess is undefined, window.open does not trigger callback, main web navigates to baidu
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level1
     * @tc.require
     */
    it('ArkUIX_WebView_multiWindowAccess_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await goToPage("multiAccessTest", WAIT_MS_3000);
        await clickButton_withId("mode-undefined", WAIT_MS_1000);
        await clickButton_withId("triggerOpen", WAIT_MS_1000);
        let found = await waitForText('result-MultiAccess', '网页加载成功', WAIT_MS_8000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_multiWindowAccess_0200, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onRenderExited_0100
     * @tc.name ArkUIX_WebView_onRenderExited_0100
     * @tc.desc Test callback is normal, load crash URL, callback triggered
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_WebView_onRenderExited_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await goToPage("onRenderExitedTest", WAIT_MS_3000);
        await clickButton_withId("mode-normal", WAIT_MS_1000);
        await sleep(WAIT_MS_1000);
        await clickButton_withId("triggerRenderExit", WAIT_MS_1000);
        let found = false
        if (platform === 'iOS') {
          found = await waitForText('result-RenderExit', 'renderExitReason:4', WAIT_MS_10000);
          await sleep(WAIT_MS_2000);
        } else {
          found = await waitForText('result-RenderExit', 'renderExitReason:2', WAIT_MS_10000);
        }

        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onRenderExited_0100, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onRenderExited_0200
     * @tc.name ArkUIX_WebView_onRenderExited_0200
     * @tc.desc Test callback is set to null, render exit does not read property
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_WebView_onRenderExited_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await goToPage("onRenderExitedTest", WAIT_MS_3000);
        await clickButton_withId("mode-null", WAIT_MS_1000);
        await sleep(WAIT_MS_1000);
        await clickButton_withId("triggerRenderExit", WAIT_MS_1000);
        let found = await waitForText('result-RenderExit', '网页加载成功', WAIT_MS_10000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onRenderExited_0200, error: ${error}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_onRenderExited_0300
     * @tc.name ArkUIX_WebView_onRenderExited_0300
     * @tc.desc Test callback is set to undefined, render exit does not read property
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level2
     * @tc.require
     */
    it('ArkUIX_WebView_onRenderExited_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await goToPage("onRenderExitedTest", WAIT_MS_3000);
        await clickButton_withId("mode-undefined", WAIT_MS_1000);
        await sleep(WAIT_MS_1000);
        await clickButton_withId("triggerRenderExit", WAIT_MS_1000);
        let found = await waitForText('result-RenderExit', '网页加载成功', WAIT_MS_10000);
        expect(found).assertEqual(true);
      } catch (error) {
        console.error(`ArkUIX_WebView_onRenderExited_0300, error: ${error}`);
        expect().assertFail();
      }
      done();
    });
  })
}
