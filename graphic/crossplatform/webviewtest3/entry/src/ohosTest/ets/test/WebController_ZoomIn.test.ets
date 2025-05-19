/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import { describe, it, expect, beforeAll, beforeEach, afterEach, afterAll, } from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import { startAbility, stopAbility, waitUiReadyMs } from '../utils/index';

export default function WebController_ZoomIn() {
  describe('WebController_ZoomIn', () => {
    /**
     * beforeAll: PrePageControlTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      await startAbility('com.example.webviewtest3', 'EntryAbility');
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PrePageControlTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const Page: Component = await driver.findComponent(ON.text('WebController_Index'));
      await Page.click();
      await driver.delayMs(waitUiReadyMs);
      const TAB: Component = await driver.findComponent(ON.text('WebController_ZoomIn'));
      await TAB.click();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(() => {
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll(async () => {
      const driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * @tc.number: SUB_Web_WebView_Stop_Func_0100
     * @tc.name  : SUB_Web_WebView_Stop_Func_0100
     * @tc.desc  : 触发17100001 异常
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_ZoomIn_Func_0100', 0, async () => {
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0100 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(600);

      // 直接点击按钮，触发异常
      const errorButton: Component = await driver.findComponent(ON.id('error-17100001'));
      await errorButton.click();
      await driver.delayMs(600);
      const callMsgTextComponent: Component = await driver.findComponent(ON.id('callMsg'));
      const callMsgTextValue: string = await callMsgTextComponent.getText();
      expect(callMsgTextValue).assertContain("17100001");
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0100 success');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0100 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_WebController_ZoomIn_Func_0200
     * @tc.name  : SUB_Web_WebView_WebController_ZoomIn_Func_0200
     * @tc.desc  : 触发17100004 异常
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_ZoomIn_Func_0200', 0, async () => {
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0200 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(3000);

      // 不点击zoomAccess_true，然后点击zoomIn
      const zoomInButton: Component = await driver.findComponent(ON.id('zoomIn'));
      await zoomInButton.click();
      await driver.delayMs(2000);
      const callMsgTextComponent: Component = await driver.findComponent(ON.id('callMsg'));
      const callMsgTextValue: string = await callMsgTextComponent.getText();
      expect(callMsgTextValue).assertContain("17100004");
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0200 success');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0200 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_WebController_ZoomIn_Func_0300
     * @tc.name  : SUB_Web_WebView_WebController_ZoomIn_Func_0300
     * @tc.desc  : 测试正常的zoomIn执行逻辑
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_ZoomIn_Func_0300', 0, async () => {
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0300 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(1000);

      // 点击 zoomAccess_true， 然后点击zoomIn； 结果是callMsg = zoomAccess 执行成功
      const zoomAccessTrueButton: Component = await driver.findComponent(ON.id('zoomAccess_true'));
      await zoomAccessTrueButton.click();
      await driver.delayMs(3000);
      const callMsgTextComponent: Component = await driver.findComponent(ON.id('callMsg'));
      const callMsgTextValue: string = await callMsgTextComponent.getText();
      expect(callMsgTextValue).assertContain('zoomAccess_true执行成功');
      const zoomInButton: Component = await driver.findComponent(ON.id('zoomIn'));
      await zoomInButton.click();
      await driver.delayMs(2000);
      const scaleModeComponent: Component = await driver.findComponent(ON.id('scaleMode'));
      const scaleModeTextValue: string = await scaleModeComponent.getText();

      // 判断是否放大
      expect(scaleModeTextValue).assertContain('magnify');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0300 success');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0300 test end');
    });


    /**
     * @tc.number: SUB_Web_WebView_WebController_ZoomIn_Func_0400
     * @tc.name  : SUB_Web_WebView_WebController_ZoomIn_Func_0400
     * @tc.desc  : 关闭zoomAccess场景
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_ZoomIn_Func_0400', 0, async () => {
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0400 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(600);
      const zoomAccessFalseButton: Component = await driver.findComponent(ON.id('zoomAccess_false'));
      await zoomAccessFalseButton.click();
      await driver.delayMs(3000);
      const zoomInButton: Component = await driver.findComponent(ON.id('zoomIn'));
      await zoomInButton.click();
      await driver.delayMs(1000);
      const callMsgTextComponent: Component = await driver.findComponent(ON.id('callMsg'));
      const callMsgTextValue: string = await callMsgTextComponent.getText();
      expect(callMsgTextValue).assertContain('17100004');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0400 success');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0400 test end');
    });

    /**
     * @tc.number: SUB_Web_WebView_WebController_ZoomIn_Stop_Func_0500
     * @tc.name  : SUB_Web_WebView_WebController_ZoomIn_Stop_Func_0500
     * @tc.desc  : w3c场景
     * @tc.size  : MediumTest
     * @tc.type  : Func
     * @tc.level : 0
     */
    it('SUB_Web_WebView_WebController_ZoomIn_Func_0500', 0, async () => {
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0500 test start');
      const driver: Driver = Driver.create();
      await driver.delayMs(1500);

      // 切换到验证 w3c
      const switchW3cButton: Component = await driver.findComponent(ON.id('w3c'));
      await switchW3cButton.click();
      await driver.delayMs(500);

      // 输入w3c标签
      // step1: userScale
      let textInputUserScale: Component = await driver.findComponent(ON.id('userScale'))
      await driver.delayMs(500)
      expect(textInputUserScale != null).assertTrue()
      await textInputUserScale.click()
      await driver.delayMs(500)
      await textInputUserScale.inputText('yes')

      // step2: maxScale
      let maxScaleTextInput: Component = await driver.findComponent(ON.id('maxScale'))
      await driver.delayMs(500)
      expect(maxScaleTextInput != null).assertTrue()
      await maxScaleTextInput.click()
      await driver.delayMs(500)
      await maxScaleTextInput.inputText('2.0')

      // 点击重置
      const resetW3cButton: Component = await driver.findComponent(ON.id('resetW3c'));
      await resetW3cButton.click();
      await driver.delayMs(600);

      // 点击 zoomAccess_true， 结果是callMsg = zoomAccess 执行成功
      const zoomAccessTrueButton: Component = await driver.findComponent(ON.id('zoomAccess_true'));
      await zoomAccessTrueButton.click();
      await driver.delayMs(1500);
      const callMsgTextComponent: Component = await driver.findComponent(ON.id('callMsg'));
      const callMsgTextValue: string = await callMsgTextComponent.getText();
      expect(callMsgTextValue).assertContain('zoomAccess_true执行成功');

      // 然后点击zoomIn
      const zoomInButton: Component = await driver.findComponent(ON.id('zoomIn'));
      await zoomInButton.click();
      await driver.delayMs(1000);

      // 判断是否放大
      const scaleModeComponent: Component = await driver.findComponent(ON.id('scaleMode'));
      const scaleModeTextValue: string = await scaleModeComponent.getText();
      expect(scaleModeTextValue).assertContain('magnify');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0500 success');
      console.log('SUB_Web_WebView_WebController_ZoomIn_Func_0500 test end');
    });
  });
}
