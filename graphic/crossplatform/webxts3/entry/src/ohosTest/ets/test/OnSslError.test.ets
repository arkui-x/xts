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
const WAIT_MS_6000 = 6000;
const WAIT_MS_10000 = 10000;
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

async function clickButton_withName(buttonName: string) {
  let button = await driver.findComponent(ON.text(buttonName));
  await button.click();
  await sleep(WAIT_MS_1000);
}

export default function onSslErrorTest() {
  describe('OnSslErrorTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_MS_2000);
    });
    afterAll(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await sleep(WAIT_MS_1000);
    });
    afterEach(async () => {
      await goToPage("返回主页");
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0100
     * @tc.name ArkUIX_WebView_OnSslError_0100
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("证书过期网址测试");

        await sleep(WAIT_MS_10000);
        await clickButton_withName("取消连接");
        await clickButton_withName("取消连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_url"))).getText())
          .assertEqual("https://expired.badssl.com/");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_originalUrl"))).getText())
          .assertEqual("https://expired.badssl.com/");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEvent_error"))).getText()))
          .assertEqual(SslError.DateInvalid);
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_referrer"))).getText()).assertEqual(" ");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_isMainFrame"))).getText()).assertEqual("true");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEventReceive_error"))).getText()))
          .assertEqual(SslError.DateInvalid);
        if (platform === "Android") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("1");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("1");
        } else if (platform === "iOS") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("3");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("3");
        } else {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("0");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("3");
        }
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0100, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0200
     * @tc.name ArkUIX_WebView_OnSslError_0200
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("证书过期网址测试");

        await sleep(WAIT_MS_6000);
        await clickButton_withName("确认连接");
        await clickButton_withName("确认连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0200, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0300
     * @tc.name ArkUIX_WebView_OnSslError_0300
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("域名不匹配网址测试");

        await sleep(WAIT_MS_6000);
        await clickButton_withName("取消连接");
        await clickButton_withName("取消连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_url"))).getText())
          .assertEqual("https://wrong.host.badssl.com/");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_originalUrl"))).getText())
          .assertEqual("https://wrong.host.badssl.com/");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEvent_error"))).getText()))
          .assertEqual(SslError.HostMismatch);
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_referrer"))).getText()).assertEqual(" ");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_isMainFrame"))).getText()).assertEqual("true");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEventReceive_error"))).getText()))
          .assertEqual(SslError.HostMismatch);
        if (platform === "Android") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("1");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("1");
        } else if (platform === "iOS") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("3");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("3");
        } else {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("0");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("3");
        }
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0300, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0400
     * @tc.name ArkUIX_WebView_OnSslError_0400
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("域名不匹配网址测试");

        await sleep(WAIT_MS_6000);
        await clickButton_withName("确认连接");
        await clickButton_withName("确认连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0400, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0500
     * @tc.name ArkUIX_WebView_OnSslError_0500
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("自签名证书网址测试");

        await sleep(WAIT_MS_6000);
        await clickButton_withName("取消连接");
        await clickButton_withName("取消连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_url"))).getText())
          .assertEqual("https://self-signed.badssl.com/");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_originalUrl"))).getText())
          .assertEqual("https://self-signed.badssl.com/");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEvent_error"))).getText()))
          .assertEqual(SslError.Untrusted);
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_referrer"))).getText()).assertEqual(" ");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_isMainFrame"))).getText()).assertEqual("true");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEventReceive_error"))).getText()))
          .assertEqual(SslError.Untrusted);
        if (platform === "Android" || platform === "iOS") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("1");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("1");
        } else {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("0");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("1");
        }
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0500, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0600
     * @tc.name ArkUIX_WebView_OnSslError_0600
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("自签名证书网址测试");

        await sleep(WAIT_MS_6000);
        await clickButton_withName("确认连接");
        await clickButton_withName("确认连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0600, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0700
     * @tc.name ArkUIX_WebView_OnSslError_0700
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("不受信任的根证书网址测试");

        await sleep(WAIT_MS_6000);
        await clickButton_withName("取消连接");
        await clickButton_withName("取消连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_url"))).getText())
          .assertEqual("https://untrusted-root.badssl.com/");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_originalUrl"))).getText())
          .assertEqual("https://untrusted-root.badssl.com/");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEvent_error"))).getText()))
          .assertEqual(SslError.Untrusted);
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_referrer"))).getText()).assertEqual(" ");
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_isMainFrame"))).getText()).assertEqual("true");
        expect(Number(await (await driver.findComponent(ON.id("onSslErrorEventReceive_error"))).getText()))
          .assertEqual(SslError.Untrusted);
        if (platform === "Android") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("1");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("1");
        } else if (platform === "iOS") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("2");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("2");
        } else {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_certChainData_length"))).getText())
            .assertEqual("0");
          expect(await (await driver.findComponent(ON.id("onSslErrorEventReceive_certChainData_length"))).getText())
            .assertEqual("2");
        }
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0700, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0800
     * @tc.name ArkUIX_WebView_OnSslError_0800
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("不受信任的根证书网址测试");

        await sleep(WAIT_MS_6000);
        await clickButton_withName("确认连接");
        await clickButton_withName("确认连接");

        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertEqual("未产生异常");
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0800, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_0900
     * @tc.name ArkUIX_WebView_OnSslError_0900
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("子资源错误网址测试");

        await sleep(WAIT_MS_10000);
        expect(await (await driver.findComponent(ON.id("result"))).getText()).assertContain("onSslErrorEvent触发");
        expect(await (await driver.findComponent(ON.id("result"))).getText()).not()
          .assertContain("onSslErrorEventReceive触发");
        if (platform !== "iOS") {
          expect(await (await driver.findComponent(ON.id("onSslErrorEvent_referrer"))).getText())
            .assertEqual("https://badssl.com/");
        }
        expect(await (await driver.findComponent(ON.id("onSslErrorEvent_isMainFrame"))).getText()).assertEqual("false");
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_0900, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_1000
     * @tc.name ArkUIX_WebView_OnSslError_1000
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("callback为null测试");

        await sleep(WAIT_MS_3000);
        expect(await (await driver.findComponent(ON.id("result"))).getText())
          .assertEqual("这是测试onSslErrorEvent与onSslErrorEventReceive接口callback为null的界面");
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_1000, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number ArkUIX_WebView_OnSslError_1100
     * @tc.name ArkUIX_WebView_OnSslError_1100
     * @tc.desc Test the Web component's onSslErrorEvent and onSslErrorEventReceive function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnSslError_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await goToPage("调用OnSslErrorEvent与onSslErrorEventReceive");
        await goToPage("callback为undefined测试");

        await sleep(WAIT_MS_3000);
        expect(await (await driver.findComponent(ON.id("result"))).getText())
          .assertEqual("这是测试onSslErrorEvent与onSslErrorEventReceive接口callback为undefined的界面");
      } catch (error) {
        console.error(`ArkUIX_WebView_OnSslError_1100, code: ${error.code}, message: ${error.message}`);
        expect().assertFail();
      }
      done();
    });
  })
}