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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { Driver, ON } from '@ohos.UiTest';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';

const WAIT_MS_1000 = 1000;
const WAIT_MS_2000 = 2000;
const WAIT_MS_3000 = 3000;
let driver = Driver.create();
const delegator = abilityDelegatorRegistry.getAbilityDelegator();

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
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

async function goToPage(pageId: string) {
  let button = await driver.findComponent(ON.id(pageId));
  await button.click();
  await sleep(WAIT_MS_2000);
}

async function clickButton_withId(buttonId: string) {
  let button = await driver.findComponent(ON.id(buttonId));
  await button.click();
  await sleep(WAIT_MS_1000);
}

export default function textZoomRatioTest() {
  describe('TextZoomRatioTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_2000);
      await startAbility('com.example.webxts3', 'EntryAbility');
      await sleep(WAIT_MS_3000);
    });
    afterAll(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await sleep(WAIT_MS_1000);
    });
    afterEach(async () => {
      await goToPage("返回");
    });

    /**
     * @tc.number ArkUIX_WebView_TextZoomRatio_0100
     * @tc.name ArkUIX_WebView_TextZoomRatio_0100
     * @tc.desc Test the Web component's textZoomRatio property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_TextZoomRatio_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("设置textZoomRatio");

        await clickButton_withId("设置1");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置50");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置100");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置150");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置2147483647");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_TextZoomRatio_0100, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_TextZoomRatio_0200
     * @tc.name ArkUIX_WebView_TextZoomRatio_0200
     * @tc.desc Test the Web component's textZoomRatio property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_TextZoomRatio_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await goToPage("设置textZoomRatio");

        await clickButton_withId("设置-100");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置0");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置150.5");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置9999999999");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置null");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("设置undefined");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_TextZoomRatio_0200, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });
  })
}