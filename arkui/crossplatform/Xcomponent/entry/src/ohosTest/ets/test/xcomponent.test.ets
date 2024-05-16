/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { Driver, ON } from '@ohos.UiTest'
import { describe, afterEach, it, expect } from '@ohos/hypium';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();

async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await abilityDelegatorRegistry.getAbilityDelegator().startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function xcomponent() {
  describe('ActsAbilityTest', () => {

    const WAIT_TIME = 2000;
    afterEach(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(WAIT_TIME);
    })

    /**
     * @tc.number : XComponent_Test_Func_0100
     * @tc.name   : onload
     * @tc.desc   : Test XComponent onload interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0100', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button != null).assertTrue();
      let result = await driver.findComponent(ON.id('result'));
      const text = await result.getText();
      console.info('XComponent_Test_Func_0100 result id' + text);
      expect(text).assertEqual('onload:已加载');
      done();
    })

    /**
     * @tc.number : XComponent_Test_Func_0200
     * @tc.name   : XComponentSurfaceId
     * @tc.desc   : Test XComponent GetXComponentSurfaceId interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0200', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      let Button1 = await driver.findComponent(ON.id('GetXComponentSurfaceId'));
      await Button1.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button1 != null).assertTrue();
      let XComponentResult = await driver.findComponent(ON.id('result'));
      const text = await XComponentResult.getText();
      console.info('XComponent_Test_Func_0200 result id' + text);
      expect(text).assertLargerOrEqual(0);
      done();
    })

    /**
     * @tc.number : XComponent_Test_Func_0300
     * @tc.name   : XComponentContext
     * @tc.desc   : Test XComponent XComponentContext interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0300', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      let Button1 = await driver.findComponent(ON.id('GetXComponentContext'));
      await Button1.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button1 != null).assertTrue();
      let XComponentResult = await driver.findComponent(ON.id('result'));
      const text = await XComponentResult.getText();
      console.info('XComponent_Test_Func_0300 result id' + text);
      expect(text).assertEqual('xcomponent_napi');
      done();
    })

    /**
     * @tc.number : XComponent_Test_Func_0400
     * @tc.name   : XComponentSize
     * @tc.desc   : Test XComponent XComponentSize interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0400', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      let Button1 = await driver.findComponent(ON.id('GetXComponentSize'));
      await Button1.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button1 != null).assertTrue();
      let XComponentHeight = await driver.findComponent(ON.id('XComponentHeight'));
      let XComponentWidth = await driver.findComponent(ON.id('XComponentWidth'));
      const XComponent_Width = await XComponentWidth.getText();
      const XComponent_Height = await XComponentHeight.getText();
      expect(XComponent_Width).assertEqual('400');
      expect(XComponent_Height).assertEqual('400');
      done();
    })
    /**
     * @tc.number : XComponent_Test_Func_0500
     * @tc.name   : XComponentOffset
     * @tc.desc   : Test XComponent XComponentOffset interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0500', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      let Button1 = await driver.findComponent(ON.id('GetXComponentOffset'));
      await Button1.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button1 != null).assertTrue();
      let XComponentOffsetX = await driver.findComponent(ON.id('XComponentOffsetX'));
      let XComponentOffsetY = await driver.findComponent(ON.id('XComponentOffsetY'));
      const XComponent_OffsetX = await XComponentOffsetX.getText();
      const XComponent_Offsety = await XComponentOffsetY.getText();
      expect(XComponent_OffsetX).assertEqual('0');
      expect(XComponent_Offsety).assertEqual('0');
      done();
    })

    /**
     * @tc.number : XComponent_Test_Func_0600
     * @tc.name   : TouchEvent
     * @tc.desc   : Test XComponent TouchEvent interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0600', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      let Button1 = await driver.findComponent(ON.id('GetXComponent_TouchEvent'));
      await Button1.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button1 != null).assertTrue();
      let XComponentResult = await driver.findComponent(ON.id('result'));
      const text = await XComponentResult.getText();
      console.info('XComponent_Test_Func_0600 result id' + text);
      expect(text).assertEqual('未获取TouchEvent');
      done();
    })

    /**
     * @tc.number : XComponent_Test_Func_0700
     * @tc.name   : TouchEvent
     * @tc.desc   : Test XComponent TouchEvent interface
     * @tc.level  : Level 2
     */
    it('XComponent_Test_Func_0700', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      let xComponent = await driver.findComponent(ON.id('xComponent'));
      await xComponent.click();
      await driver.delayMs(WAIT_TIME);
      expect(xComponent != null).assertTrue();
      let Button1 = await driver.findComponent(ON.id('GetXComponent_TouchEvent'));
      await Button1.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button1 != null).assertTrue();
      let XComponentResult = await driver.findComponent(ON.id('result'));
      const text = await XComponentResult.getText();
      console.info('XComponent_Test_Func_0700 result id' + text);
      expect(text).assertEqual('TouchEvent success');
      done();
    })

    /**
     * @tc.number : XComponent_Test_Func_0800
     * @tc.name   : onDestroy
     * @tc.desc   : Test XComponent onDestroy interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0800', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button != null).assertTrue();
      let result = await driver.findComponent(ON.id('result'));
      const text = await result.getText();
      console.info('XComponent_Test_Func_0800 result id' + text);
      expect(text).assertEqual('onload:已加载');
      await driver.delayMs(WAIT_TIME);
      let input2 = await driver.findComponent(ON.id('onDestroy'));
      await input2.click();
      await driver.delayMs(WAIT_TIME);
      console.info('XComponent_Test_Func_0800 XComponent onDestroy success');
      done();
    })

    /**
     * @tc.number : XComponent_Test_Func_0900
     * @tc.name   : XComponentSurfaceId
     * @tc.desc   : Test XComponent XComponentSurfaceId interface
     * @tc.level  : Level 1
     */
    it('XComponent_Test_Func_0900', 0, async (done: Function) => {
      await startAbility('com.example.xcomponenttestdemo', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(WAIT_TIME);
      let Button = await driver.findComponent(ON.text('Test Surface mode'));
      await Button.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button != null).assertTrue();
      let input = await driver.findComponent(ON.id('onDestroy'));
      await input.click();
      await driver.delayMs(WAIT_TIME);
      console.info('XComponent_Test_Func_0900 XComponent onDestroy success');
      let Button1 = await driver.findComponent(ON.text('Test Surface mode'));
      await Button1.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button1 != null).assertTrue();
      let Button2 = await driver.findComponent(ON.id('GetXComponentSurfaceId'));
      await Button2.click();
      await driver.delayMs(WAIT_TIME);
      expect(Button2 != null).assertTrue();
      let XComponentResult = await driver.findComponent(ON.id('result'));
      const text = await XComponentResult.getText();
      console.info('XComponent_Test_Func_0900 result id' + text);
      expect(text).assertLargerOrEqual(0);
      done();
    })
  })
}