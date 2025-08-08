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
import { DisplayRotation, Driver, MatchPattern, ON, ResizeDirection, WindowMode } from '@ohos.UiTest'
import deviceInfo from '@ohos.deviceInfo';

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

const WAIT_READY_MS_100 = 100;
const WAIT_READY_MS_500 = 500;
const WAIT_PAGE_READY_MS_3000 = 3000;
let driver = Driver.create();
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];

export default function RunJavaScriptExtTest() {
  describe('RunJavaScriptExtTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_PAGE_READY_MS_3000);
      let button_goPage = await driver.findComponent(ON.id("runJavaScriptExt测试"));
      await button_goPage.click();
      await sleep(WAIT_PAGE_READY_MS_3000);
    })
    afterAll(async () => {
      let button_goPage = await driver.findComponent(ON.id("Back"));
      await button_goPage.click();
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_100);
    })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0100
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0100
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button_sendString = await driver.findComponent(ON.id("runJavaScript getString_withString"));
          await button_sendString.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertContain("String:");
          expect(result).assertContain("stringFromHTML");
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0200
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0200
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendNumber = await driver.findComponent(ON.id("runJavaScript getNumber_withString"));
          await button_sendNumber.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Number:123")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0300
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0300
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendBoolean = await driver.findComponent(ON.id("runJavaScript getBoolean_withString"));
          await button_sendBoolean.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Boolean:true")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0400
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0400
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendArray = await driver.findComponent(ON.id("runJavaScript getArray_number_withString"));
          await button_sendArray.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Array:1,2,3")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0500
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0500
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendArray = await driver.findComponent(ON.id("runJavaScript getArray_string_withString"));
          await button_sendArray.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual('Array:1,2,3');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0600
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0600
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_sendArray = await driver.findComponent(ON.id("runJavaScript getArray_boolean_withString"));
          await button_sendArray.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Array:true,false,true")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0700
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0700
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_null = await driver.findComponent(ON.id("runJavaScript Null"));
          await button_null.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0800
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0800
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_undefined = await driver.findComponent(ON.id("runJavaScript Undefined"));
          await button_undefined.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0900
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0900
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_null = await driver.findComponent(ON.id("runJavaScript NullCallback"));
          await button_null.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1000
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1000
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_undefined = await driver.findComponent(ON.id("runJavaScript UndefinedCallback"));
          await button_undefined.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1100
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1100
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_sendString = await driver.findComponent(ON.id("runJavaScript getString_withString"));
          await button_sendString.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertContain("String:");
          expect(result).assertContain("stringFromHTML");
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1200
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1200
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_sendNumber = await driver.findComponent(ON.id("runJavaScript getNumber_withString"));
          await button_sendNumber.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Number:123")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1300
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1300
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_sendBoolean = await driver.findComponent(ON.id("runJavaScript getBoolean_withString"));
          await button_sendBoolean.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Boolean:true")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1400
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1400
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_sendArray = await driver.findComponent(ON.id("runJavaScript getArray_number_withString"));
          await button_sendArray.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Array:1,2,3")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1500
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1500
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_sendArray = await driver.findComponent(ON.id("runJavaScript getArray_string_withString"));
          await button_sendArray.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual('Array:1,2,3');
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1600
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1600
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        if (platform == 'Android') {
          done();
          return;
        }
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_sendArray = await driver.findComponent(ON.id("runJavaScript getArray_boolean_withString"));
          await button_sendArray.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("Array:true,false,true")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1700
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1700
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_null = await driver.findComponent(ON.id("runJavaScript Null"));
          await button_null.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1800
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1800
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_promise = await driver.findComponent(ON.id("switch promise"));
          await button_promise.click();
          let button_undefined = await driver.findComponent(ON.id("runJavaScript Undefined"));
          await button_undefined.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:401")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1900
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1900
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_goPage = await driver.findComponent(ON.id("runJavaScriptExt withoutWeb"));
          await button_goPage.click();
          await sleep(WAIT_PAGE_READY_MS_3000);
          let button_callback = await driver.findComponent(ON.id("runJavaScript callback"));
          await button_callback.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:17100001")
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_2000
     * @tc.name   : ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_2000
     * @tc.desc   : Test WebviewController.runJavaScriptExt function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('ACTS_ArkUIX_WebviewController_runJavaScriptExt_Func_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let button_callback = await driver.findComponent(ON.id("runJavaScript promise"));
          await button_callback.click();
          await sleep(WAIT_READY_MS_500);
          let result = await (await driver.findComponent(ON.id("runJavaScriptResult"))).getText();
          expect(result).assertEqual("ErrorCode:17100001")
          let button_back = await driver.findComponent(ON.id("Back"));
          await button_back.click();
          await sleep(WAIT_PAGE_READY_MS_3000);
        } catch (error) {
          expect().assertFail();
        }
        done();
      })

  })
}