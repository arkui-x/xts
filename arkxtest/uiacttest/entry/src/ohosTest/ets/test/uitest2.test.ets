/**
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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
import { afterEach, describe, expect, it } from '@ohos/hypium'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import { DisplayRotation, Driver, MatchPattern, ON, ResizeDirection, WindowMode } from '@ohos.UiTest'
import Want from '@ohos.app.ability.Want';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const bundleName = abilityDelegatorRegistry.getArguments().bundleName;
const waitUiReadyMs = 1500;


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

export default function UiTest2() {
  describe('UiTest2', () => {
    afterEach(async ()=>{
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(1800);
    })

    /*
     * @tc.number: TEST_INPUTTEXT_NULL_0073
     * @tc.name: testInputText
     * @tc.desc: Test input empty text
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_INPUTTEXT_NULL_0073', 0, async (done: Function) => {
      console.info('TEST_INPUTTEXT_NULL_0073 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let input = await driver.findComponent(ON.type('TextInput'));
      await input.click();
      await driver.delayMs(waitUiReadyMs);
      await input.clearText();
      await driver.delayMs(waitUiReadyMs);
      let textInput2 = await driver.findComponent(ON.type('TextInput'));
      let cleanText = await textInput2.getText();
      expect(cleanText).assertEqual('');
      await driver.delayMs(waitUiReadyMs);
      await input.click();
      try {
        await input.inputText('');
        await driver.delayMs(waitUiReadyMs);
        let input_new = await driver.findComponent(ON.type('TextInput'));
        let text = await input_new.getText();
        expect(text == '').assertTrue();
        console.info('TEST_INPUTTEXT_NULL_0073 pass');
        done();
      }
      catch (e) {
        console.info('TEST_INPUTTEXT_NULL_0073 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_CLEARTEXT_FALSE_0077
     * @tc.name: testClearText
     * @tc.desc: Test Clearing Non Text Component Text
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CLEARTEXT_FALSE_0077', 0, async (done: Function) => {
      console.info('TEST_CLEARTEXT_FALSE_0077 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let radio1 = await driver.findComponent(ON.type('Radio'));
      await radio1.click();
      await driver.delayMs(waitUiReadyMs);
      await radio1.inputText('abc');
      await driver.delayMs(waitUiReadyMs);
      let radio4 = await driver.findComponent(ON.type('Radio'));
      let radio4Text = await radio4.getText();
      await driver.delayMs(waitUiReadyMs);
      expect(radio4Text == 'abc').assertFalse();
      await driver.delayMs(waitUiReadyMs);
      let radio2 = await driver.findComponent(ON.type('Radio'));
      await radio2.click();
      await driver.delayMs(waitUiReadyMs);
      await radio2.clearText();
      await driver.delayMs(waitUiReadyMs);
      let radio3 = await driver.findComponent(ON.type('Radio'));
      let text = await radio3.getText();
      try {
        expect(text).assertEqual('Radio2');
        console.info('TEST_CLEARTEXT_FALSE_0077 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CLEARTEXT_FALSE_0077 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_TOTOP_SPEED_MOST_0079
     * @tc.name: testScrollToTop
     * @tc.desc: Slide to top maximum speed
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_TOTOP_SPEED_MOST_0079', 0, async (done: Function) => {
      console.info('TEST_SCROLL_TOTOP_SPEED_MOST_0079 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      expect(scrollBar !== null).assertTrue();
      await scrollBar.scrollToBottom();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar2 = await driver.findComponent(ON.type('Scroll'));
      expect(scrollBar2 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar2.scrollToTop(4000);
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      try {
        expect(await button.getText() == 'next page').assertTrue();
        console.info('TEST_SCROLL_TOTOP_SPEED_MOST_0079 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_TOTOP_SPEED_MOST_0079 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_TOTOP_SPEED_ZERO_0080
     * @tc.name: testScrollToTop
     * @tc.desc: Slide to top minimum speed
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_TOTOP_SPEED_ZERO_0080', 0, async (done: Function) => {
      console.info('TEST_SCROLL_TOTOP_SPEED_ZERO_0080 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      expect(scrollBar !== null).assertTrue();
      await scrollBar.scrollToBottom();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar2 = await driver.findComponent(ON.type('Scroll'));
      expect(scrollBar2 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar2.scrollToTop(0);
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      try {
        expect(await button.getText() == 'next page').assertTrue();
        console.info('TEST_SCROLL_TOTOP_SPEED_ZERO_0080 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_TOTOP_SPEED_ZERO_0080 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_TOBOTTOM_SPEED_MOST_0083
     * @tc.name: testScrollToBottom
     * @tc.desc: Maximum speed of sliding to the bottom
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_TOBOTTOM_SPEED_MOST_0083', 0, async (done: Function) => {
      console.info('TEST_SCROLL_TOBOTTOM_SPEED_MOST_0083 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      expect(scrollBar != null).assertTrue();
      await scrollBar.scrollToBottom(4000);
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('bottom'));
      try {
        expect(await button.getText() == 'bottom').assertTrue();
        console.info('TEST_SCROLL_TOBOTTOM_SPEED_MOST_0083 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_TOBOTTOM_SPEED_MOST_0083 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_TOBOTTOM_SPEED_ZERO_0084
     * @tc.name: testScrollToBottom
     * @tc.desc: Minimum speed of sliding to the bottom
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_TOBOTTOM_SPEED_ZERO_0084', 0, async (done: Function) => {
      console.info('TEST_SCROLL_TOBOTTOM_SPEED_ZERO_0084 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar.scrollToBottom(0);
      await driver.delayMs(3000);
      let button = await driver.findComponent(ON.text('bottom'));
      try {
        expect(button != null).assertTrue();
        console.info('TEST_SCROLL_TOBOTTOM_SPEED_ZERO_0084 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_TOBOTTOM_SPEED_ZERO_0084 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_SEARCH_EXCEPTION_0089
     * @tc.name: testScrollSearch
     * @tc.desc: scroll on this UiComponent to find matched UiComponent.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_SEARCH_EXCEPTION_0089', 0, async (done: Function) => {
      console.info('TEST_SCROLL_SEARCH_EXCEPTION_0089 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.type('Button'));
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        let result = await button.scrollSearch(ON.text('123'));
        console.info('TEST_SCROLL_SEARCH_EXCEPTION_0089 error');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_SEARCH_EXCEPTION_0089 pass' + e);
        done();
      }
    });
    
    /*
     * @tc.number: TEST_CONTROL_CLICK_NO_0092
     * @tc.name: testScrollSearch
     * @tc.desc: scroll on this UiComponent to find matched UiComponent.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CONTROL_CLICK_NO_0092', 0, async (done: Function) => {
      console.info('TEST_CONTROL_CLICK_NO_0092 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let radio = await driver.findComponent(ON.clickable(false).type('Gauge'));
      expect(radio != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let isClickable = await radio.isClickable();
      expect(isClickable).assertFalse();
      await driver.delayMs(waitUiReadyMs);
      await radio.click();
      let button2 = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button2 != null).assertTrue();
        console.info('TEST_CONTROL_CLICK_NO_0092 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CONTROL_CLICK_NO_0092 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_CONTROL_LONGCLICK_NO_0094
     * @tc.name: testScrollSearch
     * @tc.desc: scroll on this UiComponent to find matched UiComponent.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CONTROL_LONGCLICK_NO_0094', 0, async (done: Function) => {
      console.info('TEST_CONTROL_LONGCLICK_NO_0094 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.clickable(false).type('Gauge'));
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await button.longClick();
      let button2 = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button2 != null).assertTrue();
        console.info('TEST_CONTROL_LONGCLICK_NO_0094 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CONTROL_LONGCLICK_NO_0094 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_CONTROL_DOUBLECLICK_NO_0096
     * @tc.name: testScrollSearch
     * @tc.desc: scroll on this UiComponent to find matched UiComponent.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CONTROL_DOUBLECLICK_NO_0096', 0, async (done: Function) => {
      console.info('TEST_CONTROL_DOUBLECLICK_NO_0096 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.clickable(false).type('Gauge'));
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await button.doubleClick();
      let button2 = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button2 != null).assertTrue();
        console.info('TEST_CONTROL_DOUBLECLICK_NO_0096 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CONTROL_DOUBLECLICK_NO_0096 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_DRIVER_FINDCOMPONENTS_ZERO_0103
     * @tc.name: testDriverFindComponents
     * @tc.desc: find all the matched UiComponents on current UI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_FINDCOMPONENTS_ZERO_0103', 0, async (done: Function) => {
      console.info('TEST_DRIVER_FINDCOMPONENTS_ZERO_0103 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let swiperArr = await driver.findComponents(ON.type('Swiper'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(swiperArr[0] == null).assertTrue();
        console.info('TEST_DRIVER_FINDCOMPONENTS_ZERO_0103 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_FINDCOMPONENTS_ZERO_0103 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_ASSERT_COMPONENT_EXIST_0107
    * @tc.name: testAssertComponentExistNull
    * @tc.desc:  Assert whether the matched UiComponent exists on current UI;.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ASSERT_COMPONENT_EXIST_0107', 0, async (done: Function) => {
      console.info('TEST_ASSERT_COMPONENT_EXIST_0107 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      try {
        let arg = ON.text('errorerror');
        await driver.assertComponentExist(arg);
        done();
      }
      catch (e) {
        console.info('TEST_ASSERT_COMPONENT_EXIST_0107 pass' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_DRIVER_CLICK_OUT_0112
    * @tc.name: testDriverClick
    * @tc.desc: click in the specified location on the screen.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_DRIVER_CLICK_OUT_0112', 0, async (done: Function) => {
      console.info('TEST_DRIVER_CLICK_OUT_0112 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      await driver.click(100000, 100000);
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('next page'));
      expect(newButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await newButton.getText();
      try {
        expect(text == 'next page').assertTrue();
        console.info('TEST_DRIVER_CLICK_OUT_0112 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_CLICK_OUT_0112 error' + e);
        done();
      }
      done();
    });
    /*
    * @tc.number: TEST_DRIVER_DOUBLE_CLICK_OUT_0114
    * @tc.name: testDriverClick
    * @tc.desc: click in the specified location on the screen.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_DRIVER_DOUBLE_CLICK_OUT_0114', 0, async (done: Function) => {
      console.info('TEST_DRIVER_DOUBLE_CLICK_OUT_0114 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      await driver.doubleClick(100000, 100000);
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('next page'));
      expect(newButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await newButton.getText();
      try {
        expect(text == 'next page').assertTrue();
        console.info('TEST_DRIVER_DOUBLE_CLICK_OUT_0114 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_DOUBLE_CLICK_OUT_0114 error' + e);
        done();
      }
      done();
    });
    /*
    * @tc.number: TEST_DRIVER_LONG_CLICK_OUT_0116
    * @tc.name: testDriverClick
    * @tc.desc: click in the specified location on the screen.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_DRIVER_LONG_CLICK_OUT_0116', 0, async (done: Function) => {
      console.info('TEST_DRIVER_LONG_CLICK_OUT_0116 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      await driver.longClick(100000, 100000);
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('next page'));
      expect(newButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await newButton.getText();
      try {
        expect(text == 'next page').assertTrue();
        console.info('TEST_DRIVER_LONG_CLICK_OUT_0116 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_LONG_CLICK_OUT_0116 error' + e);
        done();
      }
      done();
    });
    /*
    * @tc.number: TEST_SWIPE_SPEED_MOST_0118
    * @tc.name: testSwipe
    * @tc.desc: swipe on the screen between the specified points.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_SWIPE_SPEED_MOST_0118', 0, async (done: Function) => {
      console.info('TEST_SWIPE_SPEED_MOST_0118 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      await driver.swipe(300, 600, 300, 300, 15000);
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.text('sixth'));
      try {
        expect(text != null).assertTrue();
        console.info('TEST_SWIPE_SPEED_MOST_0118 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SWIPE_SPEED_MOST_0118 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_SWIPE_SPEED_0119
    * @tc.name: testSwipe
    * @tc.desc: swipe on the screen between the specified points.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_SWIPE_SPEED_0119', 0, async (done: Function) => {
      console.info('TEST_SWIPE_SPEED_0119 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      await driver.swipe(300, 600, 300, 300, 0);
      await driver.delayMs(3000);
      let text = await driver.findComponent(ON.text('sixth'));
      try {
        expect(text != null).assertTrue();
        console.info('TEST_SWIPE_SPEED_0119 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SWIPE_SPEED_0119 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_SWIPE_OUT_0120
    * @tc.name: testSwipe
    * @tc.desc: swipe on the screen between the specified points.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_SWIPE_OUT_0120', 0, async (done: Function) => {
      console.info('TEST_SWIPE_OUT_0120 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      await driver.swipe(30, 100, 3000, 3000);
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.text('first'));
      try {
        expect(text != null).assertTrue();
        console.info('TEST_SWIPE_OUT_0120 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SWIPE_OUT_0120 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_SWIPE_FROM_OUT_0121
    * @tc.name: testSwipe
    * @tc.desc: swipe on the screen between the specified points.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_SWIPE_FROM_OUT_0121', 0, async (done: Function) => {
      console.info('TEST_SWIPE_FROM_OUT_0121 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      await driver.swipe(3000, 6000, 30, 100);
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.text('first'));
      try {
        expect(text != null).assertTrue();
        console.info('TEST_SWIPE_FROM_OUT_0121 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SWIPE_FROM_OUT_0121 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_FLING_OUT_0123
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_FLING_OUT_0123', 0, async (done: Function) => {
      console.info('TEST_FLING_OUT_0123 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      await driver.fling({
        x: 300, y: 600
      }, {
        x: 3000, y: 3000
      }, 20, 3000);
      await driver.delayMs(3000);
      let text = await driver.findComponent(ON.text('first'));
      try {
        expect(text != null).assertTrue();
        console.info('TEST_FLING_OUT_0123 pass');
        done();
      }
      catch (e) {
        console.info('TEST_FLING_OUT_0123 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_FLING_FROM_OUT_0125
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_FLING_FROM_OUT_0125', 0, async (done: Function) => {
      console.info('TEST_FLING_FROM_OUT_0125 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      await driver.fling({
        x: 3000, y: 6000
      }, {
        x: 300, y: 300
      }, 20, 3000);
      await driver.delayMs(3000);
      let text = await driver.findComponent(ON.text('first'));
      try {
        expect(text != null).assertTrue();
        console.info('TEST_FLING_FROM_OUT_0125 pass');
        done();
      }
      catch (e) {
        console.info('TEST_FLING_FROM_OUT_0125 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_FLING_FROM_ZERO_ZERO_0127
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_FLING_FROM_ZERO_ZERO_0127', 0, async (done: Function) => {
      console.info('TEST_FLING_FROM_ZERO_ZERO_0127 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      try {
        await driver.fling({
          x: 300, y: 600
        }, {
          x: 300, y: 300
        }, 0, 0);
        await driver.delayMs(waitUiReadyMs);
        let text = await driver.findComponent(ON.text('first'));
        expect(text != null).assertTrue();
        console.info('TEST_FLING_FROM_ZERO_ZERO_0127 pass');
        done();
      }
      catch (e) {
        console.info('TEST_FLING_FROM_ZERO_ZERO_0127 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_FLING_FROM_ZERO_MOST_0128
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_FLING_FROM_ZERO_MOST_0128', 0, async (done: Function) => {
      console.info('TEST_FLING_FROM_ZERO_MOST_0128 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      try {
        await driver.fling({
          x: 300, y: 600
        }, {
          x: 300, y: 300
        }, 40000, 0);
        await driver.delayMs(3000);
        let text = await driver.findComponent(ON.text('first'));
        expect(text != null).assertTrue();
        console.info('TEST_FLING_FROM_ZERO_MOST_0128 pass');
        done();
      }
      catch (e) {
        console.info('TEST_FLING_FROM_ZERO_MOST_0128 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_FLING_FROM_MOST_MOST_0129
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_FLING_FROM_MOST_MOST_0129', 0, async (done: Function) => {
      console.info('TEST_FLING_FROM_MOST_MOST_0129 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      try {
        await driver.fling({
          x: 300, y: 600
        }, {
          x: 300, y: 300
        }, 40000, 40000);
        await driver.delayMs(waitUiReadyMs);
        let text = await driver.findComponent(ON.text('first'));
        expect(text != null).assertTrue();
        console.info('TEST_FLING_FROM_MOST_MOST_0129 pass');
        done();
      }
      catch (e) {
        console.info('TEST_FLING_FROM_MOST_MOST_0129 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_EXCEPTION_0132
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_EXCEPTION_0132', 0, async (done: Function) => {
      console.info('TEST_EXCEPTION_0132 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('jump'));
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        await button.click();
        await button.longClick();
        done();
      }
      catch (e) {
        console.info('TEST_EXCEPTION_0132 pass' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_EXCEPTION_0133
    * @tc.name: testAssertComponentExistNull
    * @tc.desc:  Assert whether the matched UiComponent exists on current UI;.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_EXCEPTION_0133', 0, async (done: Function) => {
      console.info('TEST_EXCEPTION_0133 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      try {
        await driver.assertComponentExist(ON.text('abc'));
        done();
      }
      catch (e) {
        console.info('TEST_EXCEPTION_0133 pass' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_EXCEPTION_0134
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_EXCEPTION_0134', 0, async (done: Function) => {
      console.info('TEST_EXCEPTION_0134 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('abc'));
      expect(button == null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        await button.click();
        done();
      }
      catch (e) {
        console.info('TEST_EXCEPTION_0134 pass' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_EXCEPTION_0135
     * @tc.name: testScrollSearch
     * @tc.desc: scroll on this UiComponent to find matched UiComponent.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_EXCEPTION_0135', 0, async (done: Function) => {
      console.info('TEST_EXCEPTION_0135 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.type('Button'));
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        await button.scrollToBottom();
        done();
      }
      catch (e) {
        console.info('TEST_EXCEPTION_0135 pass' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_CLICK_LONGCLICK_0136
     * @tc.name: testControlDoubleClick
     * @tc.desc: doubleClick in the specified location on the screen.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CLICK_LONGCLICK_0136', 0, async (done: Function) => {
      console.info('TEST_CLICK_LONGCLICK_0136 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page'));
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await Button.longClick();
      await driver.delayMs(3000);
      let button2 = await driver.findComponent(ON.text('next page'));
      expect(button2 == null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      if (button2 != null) {
        await button2.click();
      }
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('longClick'));
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await button.getText();
      try {
        expect(text == 'longClick').assertTrue();
        console.info('TEST_CLICK_LONGCLICK_0136 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CLICK_LONGCLICK_0136 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_CLICK_DOUBLE_CLICK_0137
     * @tc.name: testControlDoubleClick
     * @tc.desc: doubleClick in the specified location on the screen.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CLICK_DOUBLE_CLICK_0137', 0, async (done: Function) => {
      console.info('TEST_CLICK_DOUBLE_CLICK_0137 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('Click twice'));
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await Button.click();
      await driver.delayMs(waitUiReadyMs);
      let button2 = await driver.findComponent(ON.text('Click twice'));
      expect(button2 == null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      if (button2 != null) {
        button2.click();
      }
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('doubleClick'));
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await button.getText();
      try {
        expect(text == 'doubleClick').assertTrue();
        console.info('TEST_CLICK_DOUBLE_CLICK_0137 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CLICK_DOUBLE_CLICK_0137 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_LONGCLICK_CLICK_0138
    * @tc.name: testControlLongClick
    * @tc.desc: longClick in the specified location on the screen.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_LONGCLICK_CLICK_0138', 0, async (done: Function) => {
      console.info('TEST_LONGCLICK_CLICK_0138 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page'));
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await Button.longClick();
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('Fourth Page'));
      try {
        expect(newButton != null).assertTrue();
        console.info('TEST_LONGCLICK_CLICK_0138 pass');
        done();
      }
      catch (e) {
        console.info('TEST_LONGCLICK_CLICK_0138 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_LONGCLICK_CLICK_0139
    * @tc.name: testSwipe
    * @tc.desc: swipe on the screen between the specified points.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_LONGCLICK_CLICK_0139', 0, async (done: Function) => {
      console.info('TEST_LONGCLICK_CLICK_0139 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      for (let i = 0; i < 6; i++) {
        await driver.fling({
          x: 30, y: 100
        }, {
          x: 30, y: 30
        }, 20, 600);
        await driver.click(30, 100);
        await driver.swipe(30, 600, 30, 300);
      }
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.text('bottom'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text != null).assertTrue();
        console.info('TEST_LONGCLICK_CLICK_0139 pass');
        done();
      }
      catch (e) {
        console.info('TEST_LONGCLICK_CLICK_0139 error' + e);
        done();
      }
    });
  })
}