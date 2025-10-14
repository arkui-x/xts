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

const WAIT_READY_MS_500 = 500;
const WAIT_READY_MS_1000 = 1000;
const WAIT_PAGE_READY_MS_3000 = 3000;
let driver = Driver.create();
const delegator = abilityDelegatorRegistry.getAbilityDelegator();

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function delayMock(): Promise<string> {
  return new Promise((resolve) => {
    setTimeout(() => resolve('success'), 10000);
  });
}

export default function onInterceptRequest() {
  describe('OnInterceptRequest', () => {
    beforeAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("onInterceptRequest"));
      await button_goPage.click();
      await sleep(WAIT_READY_MS_1000);
    })
    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.text("返回"));
      await button_goPage.click();
      await sleep(WAIT_READY_MS_1000);
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_500);
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_500);
      let button_goPage = await driver.findComponent(ON.text("返回"));
      await button_goPage.click();
      await sleep(WAIT_READY_MS_1000);
    })

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0100
     * @tc.name ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0100
     * @tc.desc Test Web_OnInterceptRequest.callback function with regular param
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id("onInterceptRequest-WebResourceRequest"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_3000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[RequestUrl] https://www.openharmony.cn/");
          expect(result).assertContain("<body>\n<h1>intercept test</h1>\n</body>\n");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0200
     * @tc.name ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0200
     * @tc.desc Test Web_OnInterceptRequest.callback function with null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id("onInterceptRequest-callback-null"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_3000);

          let currenUrl = await (await driver.findComponent(ON.id("currentUrl"))).getText();
          let originUrl = await (await driver.findComponent(ON.id("originUrl"))).getText();
          expect(currenUrl).assertContain(originUrl);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0300
     * @tc.name ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0300
     * @tc.desc Test Web_OnInterceptRequest.callback function with undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_CallbackEvent_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id("onInterceptRequest-callback-undefined"));
          await button.click();
          await sleep(WAIT_PAGE_READY_MS_3000);

          let currenUrl = await (await driver.findComponent(ON.id("currentUrl"))).getText();
          let originUrl = await (await driver.findComponent(ON.id("originUrl"))).getText();
          expect(currenUrl).assertContain(originUrl);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0100
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0100
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseMimeType with text/html and
     *     setResponseEncoding with utf-8
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button01 = await driver.findComponent(ON.id("onInterceptRequest-MimeType-Encoding"));
          await button01.click();
          await sleep(WAIT_READY_MS_1000);
          let button02 = await driver.findComponent(ON.id("text-html"));
          await button02.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Encoding] utf-8\n[MimeType] text/html");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0200
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0200
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseMimeType with application/json and
     *     setResponseEncoding with utf-8
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id("application-json"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Encoding] utf-8\n[MimeType] application/json");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0300
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0300
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseMimeType with image/png and
     *     setResponseEncoding with binary
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id("onInterceptRequest-data-array"));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Encoding] binary\n[MimeType] image/png");

          let button_back = await driver.findComponent(ON.text("返回"));
          await button_back.click();
          await sleep(WAIT_READY_MS_1000);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0400
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0400
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseCode with 204 and setReasonMessage with
     *     No Content
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.text('ResponseCode和ReasonMessage'));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let button_in = await driver.findComponent(ON.text('204和“No Content”'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Code] 204\n[ReasonMessage] No Content\n");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0500
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0500
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseCode with 400 and setReasonMessage with
     *     Bad Request
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.text('400和“Bad Request”'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Code] 400\n[ReasonMessage] Bad Request\n");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0600
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0600
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseCode with 404 and setReasonMessage with
     *     Not Found
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.text('404和“Not Found”'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Code] 404\n[ReasonMessage] Not Found\n");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0700
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0700
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseCode with 500 and setReasonMessage with
     *     Internal Server Error
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.text('500和“Internal Server Error”'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Code] 500\n[ReasonMessage] Internal Server Error\n");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0800
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0800
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseCode with 503 and setReasonMessage with
     *     Service Unavailable
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.text('503和“Service Unavailable”'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[Code] 503\n[ReasonMessage] Service Unavailable\n");

          let button_back = await driver.findComponent(ON.text("返回"));
          await button_back.click();
          await sleep(WAIT_READY_MS_1000);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0900
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0900
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseData with string type
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button = await driver.findComponent(ON.id('onInterceptRequest-data'));
          await button.click();
          await sleep(WAIT_READY_MS_1000);

          let button_in = await driver.findComponent(ON.id('onInterceptRequest-data-string'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[responseData] <!DOCTYPE html>\n");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1000
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1000
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseData with ArrayBuffer type
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.id('onInterceptRequest-data-array'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain("[responseData] [object ArrayBuffer]\n");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1100
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1100
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseData with empty string
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.id('onInterceptRequest-data-empty-string'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain(">>> response日志 <<<\n[responseData] ");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1200
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1200
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseData with null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.id('onInterceptRequest-data-null'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain(">>> response日志 <<<\n[responseData] null");
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1300
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1300
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse.setResponseData with undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.id('onInterceptRequest-data-undefined'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          let result = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertContain(">>> response日志 <<<\n[responseData] undefined");

          let button_back = await driver.findComponent(ON.text("返回"));
          await button_back.click();
          await sleep(WAIT_READY_MS_1000);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1400
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1400
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse param with null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.id('onInterceptRequest-no-response'));
          await button_in.click();
          await sleep(WAIT_PAGE_READY_MS_3000);

          let currenUrl = await (await driver.findComponent(ON.id("currentUrl"))).getText();
          let originUrl = await (await driver.findComponent(ON.id("originUrl"))).getText();
          expect(currenUrl).assertContain(originUrl);
        } catch (error) {
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1500
     * @tc.name ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1500
     * @tc.desc Test Web_OnInterceptRequest.WebResourceResponse function setTimeout with 10000
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_WebView_OnInterceptRequest_WebResourceResponse_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_in = await driver.findComponent(ON.id('onInterceptRequest-mock-delay'));
          await button_in.click();
          await sleep(WAIT_READY_MS_1000);

          const timeOut = delayMock();
          const result = await timeOut;
          await expect(timeOut).assertPromiseIsResolved();
          let webData = await (await driver.findComponent(ON.id("callbackLogs"))).getText();
          expect(result).assertEqual('success');
          expect(webData).assertContain('intercept test');
        } catch (error) {
          expect().assertFail();
        }
        done();
      });
  })
}