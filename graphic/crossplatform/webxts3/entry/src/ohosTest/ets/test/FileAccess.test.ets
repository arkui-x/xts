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
import deviceInfo from '@ohos.deviceInfo';
import Want from '@ohos.app.ability.Want';

const WAIT_MS_1000 = 1000;
const WAIT_MS_2000 = 2000;
const WAIT_MS_3000 = 3000;
let driver = Driver.create();
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];
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
    console.info(`UiTestCase, start abilityFinished: ${result}`);
  }).catch((err: object) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`);
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

async function clickButton_withName(buttonName: string) {
  let button = await driver.findComponent(ON.text(buttonName));
  await button.click();
  await sleep(WAIT_MS_1000);
}

export default function fileAccessTest() {
  describe('FileAccessTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_2000);
      await startAbility('com.example.webxts3', 'EntryAbility');
      await sleep(WAIT_MS_3000);
    });
    afterAll(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
    });
    afterEach(async () => {
      await goToPage("返回");
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0100
     * @tc.name ArkUIX_WebView_FileAccess_0100
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("写文件到沙箱");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择false");

        await clickButton_withId("加载沙箱网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0100, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0200
     * @tc.name ArkUIX_WebView_FileAccess_0200
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择false");

        await clickButton_withId("加载rawfile网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0200, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0300
     * @tc.name ArkUIX_WebView_FileAccess_0300
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择true");

        await clickButton_withId("加载沙箱网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载沙箱图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载沙箱视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0300, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0400
     * @tc.name ArkUIX_WebView_FileAccess_0400
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择true");

        await clickButton_withId("加载rawfile网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0400, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0500
     * @tc.name ArkUIX_WebView_FileAccess_0500
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择null");

        await clickButton_withId("加载沙箱网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0500, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0600
     * @tc.name ArkUIX_WebView_FileAccess_0600
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择null");

        await clickButton_withId("加载rawfile网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0600, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0700
     * @tc.name ArkUIX_WebView_FileAccess_0700
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择undefined");

        await clickButton_withId("加载沙箱网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0700, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0800
     * @tc.name ArkUIX_WebView_FileAccess_0800
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("设置fileAccess");
        await clickButton_withId("切换fileAccess属性");
        await clickButton_withName("选择undefined");

        await clickButton_withId("加载rawfile网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0800, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_0900
     * @tc.name ArkUIX_WebView_FileAccess_0900
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("不设置fileAccess");

        await clickButton_withId("加载沙箱网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
        await clickButton_withId("加载沙箱视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载失败");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_0900, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_FileAccess_1000
     * @tc.name ArkUIX_WebView_FileAccess_1000
     * @tc.desc Test the Web component's fileAccess property
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_FileAccess_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        if (platform === "iOS") {
          done();
          return;
        }
        await goToPage("不设置fileAccess");

        await clickButton_withId("加载rawfile网页");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile图片");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
        await clickButton_withId("加载rawfile视频");
        expect(await (await driver.findComponent(ON.id('result'))).getText()).assertEqual("网页加载成功");
      } catch (error) {
        console.error(`ArkUIX_WebView_FileAccess_1000, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });
  })
}