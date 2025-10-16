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
import { Driver, MatchPattern, ON } from '@ohos.UiTest';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';

const WAIT_READY_MS_500 = 500;
const WAIT_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_3000 = 3000;
const WAIT_PAGE_READY_MS_10000 = 10000;
const WAIT_PAGE_READY_MS_15000 = 15000;
const WAIT_PAGE_READY_MS_25000 = 25000;
let driver = Driver.create();
const delegator = abilityDelegatorRegistry.getAbilityDelegator();

function sleep(ms: number): Promise<void> {
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

export default function onOverrideUrlLoadingTest() {
  describe('OnOverrideUrlLoadingTest', () => {
    beforeAll(async () =>{
      await startAbility("com.example.webxts3", "EntryAbility")
      await sleep(WAIT_PAGE_READY_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("onOverrideUrlLoading"));
      await button_goPage.click();
      await sleep(WAIT_READY_MS_1000);
    })
    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.text("返回主页"));
      await button_goPage.click();
      await sleep(WAIT_READY_MS_1000);
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_500);
      let button_goPage = await driver.findComponent(ON.text("Back"));
      if (button_goPage) {
        await button_goPage.click();
      }
      await sleep(WAIT_READY_MS_1000);
    })

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Regular_0100
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Regular_0100
     * @tc.desc Test Web_OnOverrideUrlLoading.regular function with callback return false
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Regular_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('false'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("regularTest"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_25000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("iana.org/help/example-domains");
          expect(result).assertContain("是否拦截：否");
          expect(result).assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Regular_0200
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Regular_0200
     * @tc.desc Test Web_OnOverrideUrlLoading.regular function with callback return true
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Regular_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('true'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("regularTest"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_3000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("iana.org/domains/example");
          expect(result).assertContain("是否拦截：是");
          expect(result).not().assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Regular_0300
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Regular_0300
     * @tc.desc Test Web_OnOverrideUrlLoading.regular function with callback return undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Regular_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('undefined'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("regularTest"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_15000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("iana.org/help/example-domains");
          expect(result).assertContain("是否拦截：否");
          expect(result).assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Regular_0400
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Regular_0400
     * @tc.desc Test Web_OnOverrideUrlLoading.regular function with callback return null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Regular_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('null'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("regularTest"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_15000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("iana.org/help/example-domains");
          expect(result).assertContain("是否拦截：否");
          expect(result).assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0100
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0100
     * @tc.desc Test Web_OnOverrideUrlLoading.loadUrl function with callback return false
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('false'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("loadUrlTest"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("rawfile/blank.html");
          expect(result).assertContain("不触发onOverrideUrlLoading回调");
          expect(result).assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0200
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0200
     * @tc.desc Test Web_OnOverrideUrlLoading.loadUrl function with callback return true
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('true'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("loadUrlTest"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("rawfile/blank.html");
          expect(result).assertContain("不触发onOverrideUrlLoading回调");
          expect(result).assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0300
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0300
     * @tc.desc Test Web_OnOverrideUrlLoading.loadUrl function with callback return undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('undefined'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("loadUrlTest"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("rawfile/blank.html");
          expect(result).assertContain("不触发onOverrideUrlLoading回调");
          expect(result).assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0400
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0400
     * @tc.desc Test Web_OnOverrideUrlLoading.loadUrl function with callback return null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_LoadUrl_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          await (await driver.findComponent(ON.id("Test"))).click();
          await sleep(WAIT_READY_MS_1000);
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('null'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("loadUrlTest"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("rawfile/blank.html");
          expect(result).assertContain("不触发onOverrideUrlLoading回调");
          expect(result).assertContain("页面加载完成");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0100
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0100
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodGET with callback return false
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0100', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL0, async (done: Function) => {
        try {
          let button_goPage = await driver.findComponent(ON.id("MethodTest"));
          await button_goPage.click();
          await sleep(WAIT_READY_MS_1000);

          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('false'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendGetRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("请求方法为: GET");
          expect(result).assertContain("是否拦截：否");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0200
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0200
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodGET with callback return true
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0200', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL0, async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('true'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendGetRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("请求方法为: GET");
          expect(result).assertContain("是否拦截：是");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0300
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0300
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodGET with callback return undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0300', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('undefined'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendGetRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("请求方法为: GET");
          expect(result).assertContain("是否拦截：否");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0400
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0400
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodGET with callback return null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0400', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('null'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendGetRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("请求方法为: GET");
          expect(result).assertContain("是否拦截：否");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0500
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0500
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodPOST with callback return false
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0500', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('false'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendPostRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).not().assertContain("触发回调");
          expect(result).assertContain("等待请求...");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0600
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0600
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodPOST with callback return true
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0600', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('true'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendPostRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).not().assertContain("触发回调");
          expect(result).assertContain("等待请求...");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0700
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0700
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodPOST with callback return undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0700', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('undefined'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendPostRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).not().assertContain("触发回调");
          expect(result).assertContain("等待请求...");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0800
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0800
     * @tc.desc Test Web_OnOverrideUrlLoading.GetMethodRequest function methodPOST with callback return null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_GetMethodRequest_0800', TestType.FUNCTION | Size.MEDIUMTEST |
      Level.LEVEL2, async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('null'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button_GET = await driver.findComponent(ON.text("sendPostRequest"));
          await button_GET.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("requestInfo"))).getText();
          expect(result).not().assertContain("触发回调");
          expect(result).assertContain("等待请求...");

          let button_goPage = await driver.findComponent(ON.text("返回"));
          await button_goPage.click();
          await sleep(WAIT_READY_MS_1000);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0100
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0100
     * @tc.desc Test Web_OnOverrideUrlLoading.Iframe function with callback return false
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button_goPage = await driver.findComponent(ON.id("iFrameTest"));
          await button_goPage.click();
          await sleep(WAIT_PAGE_READY_MS_3000);

          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('false'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("test"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("非HTTP(s)协议");
          expect(result).not().assertContain("HTTPS协议");
          expect(result).not().assertContain("about协议");
          expect(result).assertContain("是否拦截：否");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0200
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0200
     * @tc.desc Test Web_OnOverrideUrlLoading.Iframe function with callback return true
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('true'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("test"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_10000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("非HTTP(s)协议");
          expect(result).not().assertContain("HTTPS协议");
          expect(result).not().assertContain("about协议");
          expect(result).assertContain("是否拦截：是");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0300
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0300
     * @tc.desc Test Web_OnOverrideUrlLoading.Iframe function with callback return undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('undefined'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("test"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("非HTTP(s)协议");
          expect(result).not().assertContain("HTTPS协议");
          expect(result).not().assertContain("about协议");
          expect(result).assertContain("是否拦截：否");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0400
     * @tc.name ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0400
     * @tc.desc Test Web_OnOverrideUrlLoading.Iframe function with callback return null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnOverrideUrlLoading_Iframe_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let selector = await driver.findComponent(ON.text('是否拦截跳转Url:',MatchPattern.CONTAINS));
          await selector.click();
          await sleep(WAIT_READY_MS_500);
          let option = await driver.findComponent(ON.text('null'));
          await option.click();
          await sleep(WAIT_READY_MS_500);

          let button = await driver.findComponent(ON.id("test"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("触发回调");
          expect(result).assertContain("非HTTP(s)协议");
          expect(result).not().assertContain("HTTPS协议");
          expect(result).not().assertContain("about协议");
          expect(result).assertContain("是否拦截：否");

          let button_goPage = await driver.findComponent(ON.text("返回"));
          await button_goPage.click();
          await sleep(WAIT_READY_MS_1000);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });
  })
}