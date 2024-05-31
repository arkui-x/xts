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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import { DisplayRotation, Driver, MatchPattern, ON, ResizeDirection, WindowMode } from '@ohos.UiTest'
import hilog from '@ohos.hilog';
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

  await delegator.startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function UiTest() {

  describe('UiTest', () => {
    afterEach(async ()=>{
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(1800);
    })

    /*
    * @tc.number: TEST_DRIVER_POINT_0001
    * @tc.name: testDriverClick
    * @tc.desc: click in the specified location on the screen.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_DRIVER_POINT_0001', 0, async (done: Function) => {
      console.info('TEST_DRIVER_POINT_0001 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(Button != null).assertTrue();
      let center = await Button.getBoundsCenter();
      await driver.delayMs(waitUiReadyMs);
      expect(center != null).assertTrue();
      await driver.click(center.x, center.y);
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('back to index'));
      await driver.delayMs(waitUiReadyMs);
      expect(newButton != null).assertTrue();
      let text = await newButton.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'back to index').assertTrue();
        console.info('TEST_DRIVER_POINT_0001 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_POINT_0001 error');
        done();
      }
    });
    /*
     * @tc.number: TEST_ON_TEXT_0002
     * @tc.name: testOnText
     * @tc.desc: longClick this UiComponentClick.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_ON_TEXT_0002', 0, async (done: Function) => {
      console.info('TEST_ON_TEXT_0002 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      expect(button != null).assertTrue();
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'next page').assertTrue();
        console.info('TEST_ON_TEXT_0002 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_TEXT_0002 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_ON_TEXT_NULL_0003
    * @tc.name: testOnTextNull
    * @tc.desc: Determine if the result obtained by the text interface is null
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_TEXT_NULL_0003', 0, async (done: Function) => {
      console.info('TEST_ON_TEXT_NULL_0003 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next again'));
      console.info('TEST_ON_TEXT_NULL_0003 button', button);
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button == null).assertTrue();
        console.info('TEST_ON_TEXT_NULL_0003 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_TEXT_NULL_0003 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_ON_ID_0004
    * @tc.name: testOnId
    * @tc.desc: find UiComponent by key attribute and get it's key attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_ID_0004', 0, async (done: Function) => {
      console.info('TEST_ON_ID_0004 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.id('my-key'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      try {
        expect(await button.getId() == 'my-key').assertTrue();
        console.info('TEST_ON_ID_0004 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_ID_0004 error' + e);
        done();
      }
    });
    /*
   * @tc.number: TEST_ON_ID_NULL_0005
   * @tc.name: test_on_id_null
   * @tc.desc: find UiComponent by key attribute and get it's key attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_ON_ID_NULL_0005', 0, async (done: Function) => {
      console.info('TEST_ON_ID_NULL_0005 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.id('her-key'));
      console.info('TEST_ON_ID_NULL_0005 button', button);
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await button == null).assertTrue();
        console.info('TEST_ON_ID_NULL_0005 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_ID_NULL_0005 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_ON_TYPE_0006
    * @tc.name: testOnType
    * @tc.desc: find UiComponent by type attribute and get it's type attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_TYPE_0006', 0, async (done: Function) => {
      console.info('TEST_ON_TYPE_0006 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.type('Text'));
      await driver.delayMs(waitUiReadyMs);
      expect(text != null).assertTrue();
      let type = await text.getType();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(type == 'Text').assertTrue();
        console.info('TEST_ON_TYPE_0006 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_TYPE_0006 error' + e);
        done();
      }
    });
    /*
   * @tc.number: TEST_ON_TYPE_NULL_0007
   * @tc.name: testOnTypeNull
   * @tc.desc: find UiComponent by type attribute and get it's type attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_ON_TYPE_NULL_0007', 0, async (done: Function) => {
      console.info('TEST_ON_TYPE_NULL_0007 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let type = await driver.findComponent(ON.type('stepper'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(type == null).assertTrue();
        console.info('TEST_ON_TYPE_NULL_0007 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_TYPE_NULL_0007 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_ON_CLICKABLE_0008
    * @tc.name: TestOnClickable
    * @tc.desc: find UiComponent by clickable attribute and get it's clickable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_CLICKABLE_0008', 0, async (done: Function) => {
      console.info('TEST_ON_CLICKABLE_0008 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.clickable(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let clickable = await button.isClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(clickable == false).assertTrue();
        console.info('TEST_ON_CLICKABLE_0008 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_CLICKABLE_0008 error' + e);
        done();
      }
    });
    /*
   * @tc.number: TEST_ON_CLICKABLE_TRUE_0009
   * @tc.name: testOnClickableTrue
   * @tc.desc: find UiComponent by clickable attribute and get it's clickable attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_ON_CLICKABLE_TRUE_0009', 0, async (done: Function) => {
      console.info('TEST_ON_CLICKABLE_TRUE_0009 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let radio = await driver.findComponent(ON.clickable(true).type('Text'));
      await driver.delayMs(waitUiReadyMs);
      expect(radio != null).assertTrue();
      let RadioClickable = await radio.isClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(RadioClickable === true).assertTrue();
        console.info('TEST_ON_CLICKABLE_TRUE_0009 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_CLICKABLE_TRUE_0009 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_ON_LONG_CLICKABLE_0010
    * @tc.name: testOnLongClickable
    * @tc.desc: find UiComponent by longClickable attribute and get it's longClickable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_LONG_CLICKABLE_0010', 0, async (done: Function) => {
      console.info('TEST_ON_LONG_CLICKABLE_0010 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.longClickable(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let longClickable = await button.isLongClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(longClickable == false).assertTrue();
        console.info('TEST_ON_LONG_CLICKABLE_0010 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_LONG_CLICKABLE_0010 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_ON_LONG_CLICKABLE_TRUE_0011
    * @tc.name: testOnLongClickableTrue
    * @tc.desc: find UiComponent by longClickable attribute and get it's longClickable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_LONG_CLICKABLE_TRUE_0011', 0, async (done: Function) => {
      console.info('TEST_ON_LONG_CLICKABLE_TRUE_0011 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.longClickable(true));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let longClickable = await button.isLongClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(longClickable == true).assertTrue();
        console.info('TEST_ON_LONG_CLICKABLE_TRUE_0011 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_LONG_CLICKABLE_TRUE_0011 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_ON_SCROLLABLE_0012
    * @tc.name: testOnScrollable
    * @tc.desc: find UiComponent by scrollable attribute and get it's scrollable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_SCROLLABLE_0012', 0, async (done: Function) => {
      console.info('TEST_ON_SCROLLABLE_0012 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.scrollable(true));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      let scrollable = await scrollBar.isScrollable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(scrollable == true).assertTrue();
        console.info('TEST_ON_SCROLLABLE_0012 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_SCROLLABLE_0012 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_ON_SCROLLABLE_FALSE_0013
    * @tc.name: testOnScrollableFalse
    * @tc.desc: find UiComponent by scrollable attribute and get it's scrollable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_SCROLLABLE_FALSE_0013', 0, async (done: Function) => {
      console.info('TEST_ON_SCROLLABLE_FALSE_0013 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.scrollable(false).type('Button'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      let scrollable = await scrollBar.isScrollable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(scrollable == false).assertTrue();
        console.info('TEST_ON_SCROLLABLE_FALSE_0013 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_SCROLLABLE_FALSE_0013 error' + e);
        done();
      }
    });
    // 通过
    /*
     * @tc.number: TEST_ON_ENABLED_0014
     * @tc.name: testOnEnabled
     * @tc.desc: find UiComponent by enabled attribute and get it's enabled attribute.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_ON_ENABLED_0014', 0, async (done: Function) => {
      console.info('TEST_ON_ENABLED_0014 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.enabled(true).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let enable = await button.isEnabled();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(enable == true).assertTrue();
        console.info('TEST_ON_ENABLED_0014 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_ENABLED_0014 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_ON_ENABLED_FALSE_0015
     * @tc.name: testOnEnabledFalse
     * @tc.desc: find UiComponent by enabled attribute and get it's enabled attribute.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_ON_ENABLED_FALSE_0015', 0, async (done: Function) => {
      console.info('TEST_ON_ENABLED_FALSE_0015 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.enabled(false).type('Radio'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let enable = await button.isEnabled();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(enable == false).assertTrue();
        console.info('TEST_ON_ENABLED_FALSE_0015 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_ENABLED_FALSE_0015 error' + e);
        done();
      }
    });
    // 通过
    /*
     * @tc.number: TEST_ON_FOCUSED_0016
     * @tc.name: testOnFocused
     * @tc.desc: find UiComponent by focused attribute and get it's focused attribute.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_ON_FOCUSED_0016', 0, async (done: Function) => {
      console.info('TEST_ON_FOCUSED_0016 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.focused(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let focused = await button.isFocused();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(focused == false).assertTrue();
        console.info('TEST_ON_FOCUSED_0016 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_FOCUSED_0016 start');
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_ON_FOCUSED_TRUE_0017
    * @tc.name: testOnFocusedTrue
    * @tc.desc: find UiComponent by focused attribute and get it's focused attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ON_FOCUSED_TRUE_0017', 0, async (done: Function) => {
      console.info('TEST_ON_FOCUSED_TRUE_0017 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.focused(true));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let focused = await button.isFocused();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(focused == true).assertTrue();
        console.info('TEST_ON_FOCUSED_TRUE_0017 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_FOCUSED_TRUE_0017 start');
        done();
      }
    });
    // 通过
    /*
     * @tc.number: TEST_ON_SELECTED_0018
     * @tc.name: testOnSelected
     * @tc.desc: find UiComponent by selected attribute and get it's selected attribute.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_ON_SELECTED_0018', 0, async (done: Function) => {
      console.info('TEST_ON_SELECTED_0018 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.selected(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let selected = await button.isSelected();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(selected == false).assertTrue();
        console.info('TEST_ON_SELECTED_0018 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_SELECTED_0018 error' + e);
        done();
      }
    });
    // 不通过
    /*
      * @tc.number: TEST_ON_CHECKED_0020
      * @tc.name: testOnChecked
      * @tc.desc: Test the selected state interface of the radio
      * @tc.size: MediumTest
      * @tc.type: Function
      * @tc.level:2
      */
    it('TEST_ON_CHECKED_0020', 0, async (done: Function) => {
      console.info('TEST_ON_CHECKED_0020 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let radio = await driver.findComponent(ON.checked(true).type('Radio'));
      await driver.delayMs(waitUiReadyMs);
      expect(radio != null).assertTrue();
      let RadioChecked = await radio.isChecked();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(RadioChecked === true).assertTrue();
        console.info('TEST_ON_CHECKED_0020 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_CHECKED_0020 error' + e);
        done();
      }
    });
    // 通过
    /*
      * @tc.number: TEST_ON_CHECKED_FALSE_0021
      * @tc.name: testOnCheckedFalse
      * @tc.desc: Test the selected state interface of the radio
      * @tc.size: MediumTest
      * @tc.type: Function
      * @tc.level:2
      */
    it('TEST_ON_CHECKED_FALSE_0021', 0, async (done: Function) => {
      console.info('TEST_ON_CHECKED_FALSE_0021 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let radio = await driver.findComponent(ON.checked(false).type('Toggle'));
      await driver.delayMs(waitUiReadyMs);
      expect(radio != null).assertTrue();
      let RadioChecked = await radio.isChecked();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(RadioChecked === false).assertTrue();
        console.info('TEST_ON_CHECKED_FALSE_0021 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_CHECKED_FALSE_0021 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_ON_CHECKABLE_0022
    * @tc.name: testOnCheckable
    * @tc.desc: find UiComponent by checkable attribute and get it's checkable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_ON_CHECKABLE_0022', 0, async (done: Function) => {
      console.info('TEST_ON_CHECKABLE_0022 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.checkable(true).type('Checkbox'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let checkable = await button.isCheckable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(checkable == true).assertTrue();
        console.info('TEST_ON_CHECKABLE_0022 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_CHECKABLE_0022 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_ON_CHECKABLE_FALSE_0023
    * @tc.name: testOnCheckableFalse
    * @tc.desc: find UiComponent by checkable attribute and get it's checkable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_ON_CHECKABLE_FALSE_0023', 0, async (done: Function) => {
      console.info('TEST_ON_CHECKABLE_FALSE_0023 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let DataPanel = await driver.findComponent(ON.checkable(false));
      await driver.delayMs(waitUiReadyMs);
      expect(DataPanel != null).assertTrue();
      let dataPanelCheckable = await DataPanel.isCheckable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(dataPanelCheckable === false).assertTrue();
        console.info('TEST_ON_CHECKABLE_FALSE_0023 pass');
        done();
      }
      catch (e) {
        console.info('TEST_ON_CHECKABLE_FALSE_0023 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_GET_ID_0024
    * @tc.name: testGetId
    * @tc.desc: find UiComponent by key attribute and get it's key attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_GET_ID_0024', 0, async (done: Function) => {
      console.info('TEST_GET_ID_0024 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.id('my-key'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await button.getId() == 'my-key').assertTrue();
        console.info('TEST_GET_ID_0024 pass');
        done();
      }
      catch (e) {
        console.info('TEST_GET_ID_0024 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_GET_ID_FALSE_0025
    * @tc.name: testGetIdFalse
    * @tc.desc: find UiComponent by key attribute and get it's key attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_GET_ID_FALSE_0025', 0, async (done: Function) => {
      console.info('TEST_GET_ID_FALSE_0025 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.id('my-key'));
      await driver.delayMs(waitUiReadyMs);
      // let ButtonId = await button.getId()
      try {
        expect(await button.getId() == 'her-key').assertFalse();
        console.info('TEST_GET_ID_FALSE_0025 pass');
        done();
      }
      catch (e) {
        console.info('TEST_GET_ID_FALSE_0025 error' + e);
        done();
      }
    });
    // 通过
    /*
         * @tc.number: TEST_GETTEXT_0026
         * @tc.name: testUiComponentClick
         * @tc.desc: click this UiComponentClick.
         * @tc.size: MediumTest
         * @tc.type: Function
         * @tc.level:2
         */
    it('TEST_GETTEXT_0026', 0, async (done: Function) => {
      console.info('TEST_GETTEXT_0026 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'next page').assertTrue();
        console.info('TEST_GETTEXT_0026 pass');
        done();
      }
      catch (e) {
        console.info('TEST_GETTEXT_0026 error' + e);
        done();
      }
    });
    // 通过
    /*
     * @tc.number: TEST_GETTEXT_FALSE_0027
     * @tc.name: testGettextFalse
     * @tc.desc: click this UiComponentClick.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_GETTEXT_FALSE_0027', 0, async (done: Function) => {
      console.info('TEST_GETTEXT_FALSE_0027 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'next again').assertFalse();
        console.info('TEST_GETTEXT_FALSE_0027 pass');
        done();
      }
      catch (e) {
        console.info('TEST_GETTEXT_FALSE_0027 error' + e);
        done();
      }
    });
    // 通过
    /*
   * @tc.number: TEST_GET_TYPE_0028
   * @tc.name: testGetType
   * @tc.desc: find UiComponent by type attribute and get it's type attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_GET_TYPE_0028', 0, async (done: Function) => {
      console.info('TEST_GET_TYPE_0028 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.type('Text'));
      await driver.delayMs(waitUiReadyMs);
      expect(text != null).assertTrue();
      let type = await text.getType();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(type == 'Text').assertTrue();
        console.info('TEST_GET_TYPE_0028 pass');
        done();
      }
      catch (e) {
        console.info('TEST_GET_TYPE_0028 error' + e);
        done();
      }
    });
    // 通过
    /*
  * @tc.number: TEST_GET_TYPE_FALSE_0029
  * @tc.name: testGetTypeFalse
  * @tc.desc: find UiComponent by type attribute and get it's type attribute.
  * @tc.size: MediumTest
  * @tc.type: Function
  * @tc.level:2
  */
    it('TEST_GET_TYPE_FALSE_0029', 0, async (done: Function) => {
      console.info('TEST_GET_TYPE_FALSE_0029 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.type('Text'));
      await driver.delayMs(waitUiReadyMs);
      expect(text != null).assertTrue();
      let type = await text.getType();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(type == 'Button').assertFalse();
        console.info('TEST_GET_TYPE_FALSE_0029 pass');
        done();
      }
      catch (e) {
        console.info('TEST_GET_TYPE_FALSE_0029 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_IS_CLICKABLE_0030
    * @tc.name: testIsClickable
    * @tc.desc: find UiComponent by clickable attribute and get it's clickable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_IS_CLICKABLE_0030', 0, async (done: Function) => {
      console.info('TEST_IS_CLICKABLE_0030 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.clickable(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let clickable = await button.isClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(clickable == false).assertTrue();
        console.info('TEST_IS_CLICKABLE_0030 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_CLICKABLE_0030 error' + e);
        done();
      }
    });
    // 通过
    /*
   * @tc.number: TEST_IS_CLICKABLE_TRUE_0031
   * @tc.name: testIsClickableTrue
   * @tc.desc: find UiComponent by clickable attribute and get it's clickable attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_IS_CLICKABLE_TRUE_0031', 0, async (done: Function) => {
      console.info('TEST_IS_CLICKABLE_TRUE_0031 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.type('Toggle'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let clickable = await button.isClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(clickable == true).assertTrue();
        console.info('TEST_IS_CLICKABLE_TRUE_0031 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_CLICKABLE_TRUE_0031 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_IS_LONG_CLICKABLE_0032
    * @tc.name: testIsLongClickable
    * @tc.desc: find UiComponent by longClickable attribute and get it's longClickable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_IS_LONG_CLICKABLE_0032', 0, async (done: Function) => {
      console.info('TEST_IS_LONG_CLICKABLE_0032 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.longClickable(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let longClickable = await button.isLongClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(longClickable == false).assertTrue();
        console.info('TEST_IS_LONG_CLICKABLE_0032 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_LONG_CLICKABLE_0032 error' + e);
        done();
      }
    });
    // 通过
    /*
   * @tc.number: TEST_IS_LONG_CLICKABLE_TRUE_0033
   * @tc.name: testIsLongClickableTrue
   * @tc.desc: find UiComponent by longClickable attribute and get it's longClickable attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_IS_LONG_CLICKABLE_TRUE_0033', 0, async (done: Function) => {
      console.info('TEST_IS_LONG_CLICKABLE_TRUE_0033 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.longClickable(true));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      let longClickable = await button.isLongClickable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(longClickable == true).assertTrue();
        console.info('TEST_IS_LONG_CLICKABLE_TRUE_0033 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_LONG_CLICKABLE_TRUE_0033 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_IS_SCROLLABLE_0034
    * @tc.name: testIsScrollable
    * @tc.desc: find UiComponent by scrollable attribute and get it's scrollable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_IS_SCROLLABLE_0034', 0, async (done: Function) => {
      console.info('TEST_IS_SCROLLABLE_0034 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.scrollable(true));
      expect(scrollBar != null).assertTrue();
      let scrollable = await scrollBar.isScrollable();
      try {
        expect(scrollable == true).assertTrue();
        console.info('TEST_IS_SCROLLABLE_0034 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_SCROLLABLE_0034 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_IS_SCROLLABLE_FALSE_0035
    * @tc.name: testIsScrollableFalse
    * @tc.desc: find UiComponent by scrollable attribute and get it's scrollable attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_IS_SCROLLABLE_FALSE_0035', 0, async (done: Function) => {
      console.info('TEST_IS_SCROLLABLE_0035 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.scrollable(false).type('Button'));
      let scrollable = await scrollBar.isScrollable();
      try {
        expect(scrollable == false).assertTrue();
        console.info('TEST_IS_SCROLLABLE_0035 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_SCROLLABLE_0035 error' + e);
        done();
      }
    });
    //   通过
    //
    /*
  * @tc.number: TEST_IS_ENABLED_0036
  * @tc.name: testIsEnabled
  * @tc.desc: find UiComponent by enabled attribute and get it's enabled attribute.
  * @tc.size: MediumTest
  * @tc.type: Function
  * @tc.level:2
  */
    it('TEST_IS_ENABLED_0036', 0, async (done: Function) => {
      console.info('TEST_IS_ENABLED_0036 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.enabled(true).text('next page'));
      let enable = await button.isEnabled();
      try {
        expect(enable == true).assertTrue();
        console.info('TEST_IS_ENABLED_0036 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_ENABLED_0036 error' + e);
        done();
      }
    });
    // 通过
    /*
   * @tc.number: TEST_IS_ENABLED_FALSE_0037
   * @tc.name: testIsEnabledFalse
   * @tc.desc: find UiComponent by enabled attribute and get it's enabled attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_IS_ENABLED_FALSE_0037', 0, async (done: Function) => {
      console.info('TEST_IS_ENABLED_FALSE_0037 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.enabled(false).type('Radio'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let enable = await button.isEnabled();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(enable == false).assertTrue();
        console.info('TEST_IS_ENABLED_FALSE_0037 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_ENABLED_FALSE_0037 error' + e);
        done();
      }
    });
    // 通过
    /*
  * @tc.number: TEST_IS_FOCUSED_0038
  * @tc.name: testIsFocused
  * @tc.desc: find UiComponent by focused attribute and get it's focused attribute.
  * @tc.size: MediumTest
  * @tc.type: Function
  * @tc.level:2
  */
    it('TEST_IS_FOCUSED_0038', 0, async (done: Function) => {
      console.info('TEST_IS_FOCUSED_0038 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.focused(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let focused = await button.isFocused();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(focused == false).assertTrue();
        console.info('TEST_IS_FOCUSED_0038 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_FOCUSED_0038 start');
        done();
      }
    });
    // 通过
    /*
   * @tc.number: TEST_IS_FOCUSED_TRUE_0039
   * @tc.name: testIsFocusedTrue
   * @tc.desc: find UiComponent by focused attribute and get it's focused attribute.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:2
   */
    it('TEST_IS_FOCUSED_TRUE_0039', 0, async (done: Function) => {
      console.info('TEST_IS_FOCUSED_TRUE_0039 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.focused(true));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let focused = await button.isFocused();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(focused == true).assertTrue();
        console.info('TEST_IS_FOCUSED_TRUE_0039 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_FOCUSED_TRUE_0039 start');
        done();
      }
    });
    // 通过
    /*
     * @tc.number: TEST_IS_SELECTED_0040
     * @tc.name: testIsSelected
     * @tc.desc: find UiComponent by selected attribute and get it's selected attribute.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_IS_SELECTED_0040', 0, async (done: Function) => {
      console.info('TEST_IS_SELECTED_0040 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.selected(false).text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let selected = await button.isSelected();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(selected == false).assertTrue();
        console.info('TEST_IS_SELECTED_0040 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_SELECTED_0040 error' + e);
        done();
      }
    });
    // 测试通过
    /*
    * @tc.number: TEST_IS_CHECKED_0042
    * @tc.name: testIsChecked
    * @tc.desc: find UiComponent by checked attribute and get it's checked attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_IS_CHECKED_0042', 0, async (done: Function) => {
      console.info('TEST_IS_CHECKED_0042 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Toggle = await driver.findComponent(ON.checked(false).type('Toggle'));
      await driver.delayMs(waitUiReadyMs);
      expect(Toggle != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let checked = await Toggle.isChecked();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(checked == false).assertTrue();
        console.info('TEST_IS_CHECKED_0042 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_CHECKED_0042 error' + e);
        done();
      }
    });
    // 测试通过
    /*
    * @tc.number: TEST_IS_CHECKED_TRUE_0043
    * @tc.name: testIsCheckedTrue
    * @tc.desc: find UiComponent by checked attribute and get it's checked attribute.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:0
    */
    it('TEST_IS_CHECKED_TRUE_0043', 0, async (done: Function) => {
      console.info('TEST_IS_CHECKED_0022 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.checked(true).type('Checkbox'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let checked = await button.isChecked();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(checked == true).assertTrue();
        console.info('TEST_IS_CHECKED_TRUE_0043 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_CHECKED_TRUE_0043 error' + e);
        done();
      }
    });
    // 通过
    /*
    * @tc.number: TEST_IS_CHECKABLE_0044
    * @tc.name: testIsCheckable
    * @tc.desc: Test the checkable state interface of the toggle
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_IS_CHECKABLE_0044', 0, async (done: Function) => {
      console.info('TEST_IS_CHECKABLE_0044 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.checked(true).type('Radio'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let checked = await button.isChecked();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(checked == true).assertTrue();
        console.info('TEST_IS_CHECKABLE_0044 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_CHECKABLE_0044 error' + e);
        done();
      }
    });
    // 通过
    /*
  * @tc.number: TEST_IS_CHECKABLE_FALSE_0045
  * @tc.name: testIsCheckableFalse
  * @tc.desc: Test the checkable state interface of the toggle
  * @tc.size: MediumTest
  * @tc.type: Function
  * @tc.level:2
  */
    it('TEST_IS_CHECKABLE_FALSE_0045', 0, async (done: Function) => {
      console.info('TEST_IS_CHECKABLE_FALSE_0045 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let toggleButton = await driver.findComponent(ON.type('Button'));
      await driver.delayMs(waitUiReadyMs);
      expect(toggleButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let toggleCheckable = await toggleButton.isCheckable();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(toggleCheckable == false).assertTrue;
        console.info('TEST_IS_CHECKABLE_FALSE_0045 pass');
        done();
      }
      catch (e) {
        console.info('TEST_IS_CHECKABLE_FALSE_0045 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_INPUTTEXT_0046
    * @tc.name: testInputText
    * @tc.desc: inject text to the target UiComponent
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_INPUTTEXT_0046', 0, async (done: Function) => {
      console.info('TEST_IS_CHECKABLE_FALSE_0045 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let input = await driver.findComponent(ON.type('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      expect(input != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await input.click();
      await driver.delayMs(waitUiReadyMs);
      await input.clearText();
      await driver.delayMs(3000);
      let input2 = await driver.findComponent(ON.type('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      expect(input2 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text2 = await input2.getText();
      await driver.delayMs(waitUiReadyMs);
      expect(text2 == '').assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await input2.inputText('abc123');
      await driver.delayMs(waitUiReadyMs);
      let input_new = await driver.findComponent(ON.type('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      expect(input_new != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await input_new.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'abc123').assertTrue();
        console.info('TEST_INPUTTEXT_0046 pass');
        done();
      }
      catch (e) {
        console.info('TEST_INPUTTEXT_0046 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_INPUTTEXT_FALSE_0047
     * @tc.name: testInputTextFalse
     * @tc.desc: inject text to the target UiComponent
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_INPUTTEXT_FALSE_0047', 0, async (done: Function) => {
      console.info('TEST_INPUTTEXT_FALSE_0047 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Radio = await driver.findComponent(ON.type('Radio'));
      await driver.delayMs(waitUiReadyMs);
      expect(Radio != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await Radio.inputText('123');
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await Radio.getText() == '123').assertFalse();
        console.info('TEST_INPUTTEXT_FALSE_0047 pass');
        done();
      }
      catch (e) {
        console.info('TEST_INPUTTEXT_FALSE_0047 error' + e);
        done();
      }
    });
    // 测试通过
    /*
     * @tc.number: TEST_CLEARTEXT_0048
     * @tc.name: testClearText
     * @tc.desc: clear text of the target UiComponent
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CLEARTEXT_0048', 0, async (done: Function) => {
      console.info('TEST_CLEARTEXT_0048 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let input1 = await driver.findComponent(ON.type('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      expect(input1 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await input1.click();
      await input1.clearText();
      await driver.delayMs(waitUiReadyMs);
      let input6 = await driver.findComponent(ON.type('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      expect(input6 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text6 = await input6.getText();
      await driver.delayMs(waitUiReadyMs);
      expect(text6 == '').assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await input6.inputText('abc');
      await driver.delayMs(waitUiReadyMs);
      let input2 = await driver.findComponent(ON.type('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      expect(input2 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text2 = await input2.getText();
      await driver.delayMs(waitUiReadyMs);
      expect(text2 == 'abc').assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await input2.click();
      await input2.clearText();
      await driver.delayMs(waitUiReadyMs);
      let input_new = await driver.findComponent(ON.type('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      expect(input_new != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await input_new.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text).assertEqual('');
        console.info('TEST_CLEARTEXT_0048 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CLEARTEXT_0048 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_TOTOP_0049
     * @tc.name: testScrollToTop
     * @tc.desc: scroll on this UiComponent to the top.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_TOTOP_0049', 0, async (done: Function) => {
      console.info('TEST_SCROLL_TOTOP_0049 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar.scrollToBottom();
      await driver.delayMs(3000);
      let scroll2 = await driver.findComponent(ON.type('Scroll'));
      await driver.delayMs(waitUiReadyMs);
      expect(scroll2 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scroll2.scrollToTop();
      await driver.delayMs(3000);
      let button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await button.getText() == 'next page').assertTrue();
        console.info('TEST_SCROLL_TOTOP_0049 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_TOTOP_0049 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_SCROLL_TOTOP_FALSE_0050
    * @tc.name: testScrollTotopFalse
    * @tc.desc: scroll on this UiComponent to the top.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_SCROLL_TOTOP_FALSE_0050', 0, async (done: Function) => {
      console.info('TEST_SCROLL_TOTOP_FALSE_0050 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Radio'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar.scrollToTop();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button != null).assertTrue();
        console.info('TEST_SCROLL_TOTOP_FALSE_0050 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_TOTOP_FALSE_0050 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_TOBOTTOM_0051
     * @tc.name: testScrollToBottom
     * @tc.desc: scroll on this UiComponent to the bottom.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_TOBOTTOM_0051', 0, async (done: Function) => {
      console.info('TEST_SCROLL_TOBOTTOM_0051 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar.scrollToBottom();
      await driver.delayMs(3000);
      let button = await driver.findComponent(ON.text('bottom'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await button.getText() == 'bottom').assertTrue();
        console.info('TEST_SCROLL_TOBOTTOM_0051 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_TOBOTTOM_0051 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_SEARCH_0053
     * @tc.name: testScrollSearch
     * @tc.desc: scroll on this UiComponent to find matched UiComponent.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_SEARCH_0053', 0, async (done: Function) => {
      console.info('TEST_SCROLL_SEARCH_0053 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let button = await scrollBar.scrollSearch(ON.text('sixth'));
      await driver.delayMs(3000);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await button.getText() == 'sixth').assertTrue();
        console.info('TEST_SCROLL_SEARCH_0053 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_SEARCH_0053 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SCROLL_SEARCH_NULL_0054
     * @tc.name: testScrollSearchNull
     * @tc.desc: scroll on this UiComponent to find matched UiComponent.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SCROLL_SEARCH_NULL_0054', 0, async (done: Function) => {
      console.info('TEST_SCROLL_SEARCH_NULL_0054 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let button = await scrollBar.scrollSearch(ON.text('next again'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button == null).assertTrue();
        console.info('TEST_SCROLL_SEARCH_NULL_0054 pass');
        done();
      }
      catch (e) {
        console.info('TEST_SCROLL_SEARCH_NULL_0054 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_GET_BOUNDS_CENTER_0055
    * @tc.name: testGetBoundsCenter
    * @tc.desc: get the boundsCenter of this @link UiComponent.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_GET_BOUNDS_CENTER_0055', 0, async (done: Function) => {
      console.info('TEST_GET_BOUNDS_CENTER_0055 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let point = await button.getBoundsCenter();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(point != null).assertTrue();
        console.info('TEST_GET_BOUNDS_CENTER_0055 pass');
        done();
      }
      catch (e) {
        console.info('TEST_GET_BOUNDS_CENTER_0055 error' + e);
        done();
      }
    });
    /*
   * @tc.number: TEST_CONTROL_CLICK_0056
   * @tc.name: testControlClick
   * @tc.desc: click in the specified location on the screen.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:0
   */
    it('TEST_CONTROL_CLICK_0056', 0, async (done: Function) => {
      console.info('TEST_CONTROL_CLICK_0056 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await Button.click();
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('back to index'));
      await driver.delayMs(waitUiReadyMs);
      expect(newButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await newButton.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'back to index').assertTrue();
        console.info('TEST_CONTROL_CLICK_0056 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CONTROL_CLICK_0056 error');
        done();
      }
      done();
    });
    /*
     * @tc.number: TEST_CONTROL_DOUBLE_CLICK_0057
     * @tc.name: testControlDoubleClick
     * @tc.desc: doubleClick in the specified location on the screen.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_CONTROL_DOUBLE_CLICK_0057', 0, async (done: Function) => {
      console.info('TEST_CONTROL_DOUBLE_CLICK_0057 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('Click twice'));
      await driver.delayMs(waitUiReadyMs);
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await Button.doubleClick();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('doubleClick'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'doubleClick').assertTrue();
        console.info('TEST_CONTROL_DOUBLE_CLICK_0057 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CONTROL_DOUBLE_CLICK_0057 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_CONTROL_LONG_CLICK_0058
    * @tc.name: testControlLongClick
    * @tc.desc: longClick in the specified location on the screen.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_CONTROL_LONG_CLICK_0058', 0, async (done: Function) => {
      console.info('TEST_CONTROL_LONG_CLICK_0058 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await Button.longClick();
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('longClick'));
      await driver.delayMs(waitUiReadyMs);
      expect(newButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await newButton.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'longClick').assertTrue();
        console.info('TEST_CONTROL_LONG_CLICK_0058 pass');
        done();
      }
      catch (e) {
        console.info('TEST_CONTROL_LONG_CLICK_0058 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_DRIVER_CREATE_0059
     * @tc.name: testDriverCreate
     * @tc.desc: click this UiComponentClick.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_CREATE_0059', 0, async (done: Function) => {
      console.info('TEST_DRIVER_CREATE_0059 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'next page').assertTrue();
        console.info('TEST_DRIVER_CREATE_0059 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_CREATE_0059 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_DRIVER_DELAYMS_0060
     * @tc.name: testDriverDelayms
     * @tc.desc: click this UiComponentClick.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_DELAYMS_0060', 0, async (done: Function) => {
      console.info('TEST_DRIVER_DELAYMS_0060 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(3000);
      let button = await driver.findComponent(ON.text('first'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'first').assertTrue();
        console.info('TEST_DRIVER_DELAYMS_0060 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_DELAYMS_0060 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_DRIVER_FINDCOMPONENT_0061
     * @tc.name: testDriverFindComponent
     * @tc.desc: click this UiComponentClick.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_FINDCOMPONENT_0061', 0, async (done: Function) => {
      console.info('TEST_DRIVER_FINDCOMPONENT_0061 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('jump'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'jump').assertTrue();
        console.info('TEST_DRIVER_FINDCOMPONENT_0061 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_FINDCOMPONENT_0061 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_DRIVER_FINDCOMPONENT_NULL_0062
     * @tc.name: testDriverFindComponentNull
     * @tc.desc: click this UiComponentClick.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_FINDCOMPONENT_NULL_0062', 0, async (done: Function) => {
      console.info('TEST_DRIVER_FINDCOMPONENT_NULL_0062 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.type('Button').text('next again'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button == null).assertTrue();
        console.info('TEST_DRIVER_FINDCOMPONENT_NULL_0062 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_FINDCOMPONENT_NULL_0062 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_DRIVER_FINDCOMPONENT_FIRST_0063
     * @tc.name: testDriverFindComponentFirst
     * @tc.desc: find all the matched UiComponents on current UI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_FINDCOMPONENT_FIRST_0063', 0, async (done: Function) => {
      console.info('TEST_DRIVER_FINDCOMPONENT_FIRST_0063 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.type('Text'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      done();
    });
    /*
     * @tc.number: TEST_DRIVER_FINDCOMPONENTS_0064
     * @tc.name: testDriverFindComponents
     * @tc.desc: find all the matched UiComponents on current UI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_FINDCOMPONENTS_0064', 0, async (done: Function) => {
      console.info('TEST_DRIVER_FINDCOMPONENTS_0064 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let buttons = await driver.findComponents(ON.type('Button'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(buttons.length != 0).assertTrue();
        console.info('TEST_DRIVER_FINDCOMPONENTS_0064 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_FINDCOMPONENTS_0064 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_ASSERT_COMPONENT_EXIST_0065
     * @tc.name: testAssertComponentExist
     * @tc.desc:  Assert whether the matched UiComponent exists on current UI;.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_ASSERT_COMPONENT_EXIST_0065', 0, async () => {
      console.info('TEST_ASSERT_COMPONENT_EXIST_0065 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      await driver.assertComponentExist(ON.text('next page'));
      console.info('TEST_ASSERT_COMPONENT_EXIST_NULL_0065 pass');
    });
    /*
    * @tc.number: TEST_ASSERT_COMPONENT_EXIST_NULL_0066
    * @tc.name: testAssertComponentExistNull
    * @tc.desc:  Assert whether the matched UiComponent exists on current UI;.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_ASSERT_COMPONENT_EXIST_NULL_0066', 0, async (done: Function) => {
      console.info('TEST_ASSERT_COMPONENT_EXIST_NULL_0066 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      try {
        await driver.assertComponentExist(ON.text('error'));
        expect(false).assertTrue();
        done();
      }
      catch (e) {
        console.info('TEST_ASSERT_COMPONENT_EXIST_NULL_0066 pass');
        done();
      }
    });
    /*
     * @tc.number: TEST_PRESS_BACK_0067
     * @tc.name: testPressBack
     * @tc.desc: Press the BACK key.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_PRESS_BACK_0067', 0, async (done: Function) => {
      console.info('TEST_PRESS_BACK_0067 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await button.click();
      await driver.delayMs(waitUiReadyMs);
      let text2 = await driver.findComponent(ON.text('Second Page'));
      await driver.delayMs(waitUiReadyMs);
      expect(text2 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await driver.pressBack();
      await driver.delayMs(waitUiReadyMs);
      let button_ori = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(button_ori != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await button_ori.getText() == 'next page').assertTrue();
        console.info('TEST_PRESS_BACK_0067 pass');
        done();
      }
      catch (e) {
        console.info('TEST_PRESS_BACK_0067 error' + e);
        done();
      }
    });
    /*
   * @tc.number: TEST_DRIVER_CLICK_0068
   * @tc.name: testDriverClick
   * @tc.desc: click in the specified location on the screen.
   * @tc.size: MediumTest
   * @tc.type: Function
   * @tc.level:0
   */
    it('TEST_DRIVER_CLICK_0068', 0, async (done: Function) => {
      console.info('TEST_DRIVER_CLICK_0068 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let center = await Button.getBoundsCenter();
      await driver.click(center.x, center.y);
      await driver.delayMs(3000);
      let newButton = await driver.findComponent(ON.text('back to index'));
      await driver.delayMs(2000);
      expect(newButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await newButton.getText();
      await driver.delayMs(2000);
      try {
        expect(text == 'back to index').assertTrue();
        console.info('TEST_DRIVER_CLICK_0068 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_CLICK_0068 error' + e);
        done();
      }
      done();
    });
    /*
     * @tc.number: TEST_DRIVER_DOUBLE_CLICK_0069
     * @tc.name: testDriverDoubleClick
     * @tc.desc: doubleClick in the specified location on the screen.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_DRIVER_DOUBLE_CLICK_0069', 0, async (done: Function) => {
      console.info('TEST_DRIVER_DOUBLE_CLICK_0069 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('Click twice'));
      await driver.delayMs(waitUiReadyMs);
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let center = await Button.getBoundsCenter();
      await driver.doubleClick(center.x, center.y);
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('doubleClick'));
      await driver.delayMs(waitUiReadyMs);
      expect(button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'doubleClick').assertTrue();
        console.info('TEST_DRIVER_DOUBLE_CLICK_0069 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_DOUBLE_CLICK_0069 error' + e);
        done();
      }
    });
    /*
    * @tc.number: TEST_DRIVER_LONG_CLICK_0070
    * @tc.name: testDriverLongClick
    * @tc.desc: longClick in the specified location on the screen.
    * @tc.size: MediumTest
    * @tc.type: Function
    * @tc.level:2
    */
    it('TEST_DRIVER_LONG_CLICK_0070', 0, async (done: Function) => {
      console.info('TEST_DRIVER_LONG_CLICK_0070 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page'));
      await driver.delayMs(waitUiReadyMs);
      expect(Button != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let center = await Button.getBoundsCenter();
      await driver.longClick(center.x, center.y);
      await driver.delayMs(3000);
      let newButton = await driver.findComponent(ON.text('longClick'));
      await driver.delayMs(waitUiReadyMs);
      expect(newButton != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let text = await newButton.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == 'longClick').assertTrue();
        console.info('TEST_DRIVER_LONG_CLICK_0070 pass');
        done();
      }
      catch (e) {
        console.info('TEST_DRIVER_LONG_CLICK_0070 error' + e);
        done();
      }
    });
    /*
     * @tc.number: TEST_SWIPE_0071
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_SWIPE_0071', 0, async (done: Function) => {
      console.info('TEST_SWIPE_0071 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      await driver.swipe(300, 600, 300, 300);
      await driver.delayMs(3000);
      let text = await driver.findComponent(ON.text('fourth'));
      await driver.delayMs(waitUiReadyMs);
      expect(text != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar.scrollToTop();
      await driver.delayMs(3000);
      console.info('TEST_SWIPE_0071 pass');
      done();
    });
    /*
     * @tc.number: TEST_FLING_0072
     * @tc.name: testFling
     * @tc.desc: inject fling on the device display.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:2
     */
    it('TEST_FLING_0072', 0, async (done: Function) => {
      console.info('TEST_FLING_0072 start');
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      await driver.fling({
        x: 300, y: 600
      }, {
        x: 300, y: 300
      }, 20, 600);
      await driver.delayMs(3000);
      let text = await driver.findComponent(ON.text('fourth'));
      await driver.delayMs(waitUiReadyMs);
      expect(text != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.type('Scroll'));
      await driver.delayMs(waitUiReadyMs);
      expect(scrollBar != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      await scrollBar.scrollToTop();
      await driver.delayMs(3000);
      console.info('TEST_FLING_0072 pass');
      done();
    });
    /*
    * @tc.number: TEST_MATCH_PATTERN_0073
     * @tc.name: testMatchPattern
     * @tc.desc: specifies the string value match pattern.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level:0
     */
    it('TEST_MATCH_PATTERN_0073', 0, async (done: Function) => {
      await startAbility('com.example.uiacttest', 'UiTestAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button1 = await driver.findComponent(ON.text('next page', MatchPattern.EQUALS));
      await driver.delayMs(waitUiReadyMs);
      expect(Button1 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      expect(await Button1.getText() == 'next page').assertTrue();
      await driver.delayMs(waitUiReadyMs);
      console.info('TEST_MATCH_PATTERN_0073 pass');
      let Button2 = await driver.findComponent(ON.text('next', MatchPattern.STARTS_WITH));
      await driver.delayMs(waitUiReadyMs);
      expect(Button2 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      expect(await Button2.getText() == 'next page false').assertTrue();
      await driver.delayMs(waitUiReadyMs);
      console.info('TEST_MATCH_PATTERN_0073 pass2');
      let Button3 = await driver.findComponent(ON.text('next page', MatchPattern.ENDS_WITH));
      await driver.delayMs(waitUiReadyMs);
      expect(Button3 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      expect(await Button3.getText() == 'next page').assertTrue();
      await driver.delayMs(waitUiReadyMs);
      console.info('TEST_MATCH_PATTERN_0073 pass3');
      let Button4 = await driver.findComponent(ON.text('next', MatchPattern.CONTAINS));
      await driver.delayMs(waitUiReadyMs);
      expect(Button4 != null).assertTrue();
      await driver.delayMs(waitUiReadyMs);
      expect(await Button4.getText() == 'next page false').assertTrue();
      await driver.delayMs(waitUiReadyMs);
      console.info('TEST_MATCH_PATTERN_0073 pass4');
      done();
    });
  })
}







