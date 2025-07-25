/**
 * Copyright (c) 2023-2025 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import { Driver, MatchPattern, ON } from '@ohos.UiTest'
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

export default function NewUiTest() {
  describe('NewUiTest', () => {
    afterEach(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(1800);
    })

    /**
     * @tc.name      : NewTEST_ON_TEXT_test
     * @tc.number    : NewTEST_ON_TEXT_test
     * @tc.desc      : ON text, button.getText()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('NewTEST_ON_TEXT_test', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('NewTEST_ON_TEXT_0001_null start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text("test"));
      let text = await button.getText();
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(text == "test").assertTrue();
        console.info('NewTEST_ON_TEXT_0001_test pass');
        done();
      } catch (e) {
        console.info('NewTEST_ON_TEXT_0001_test error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_TEXT_NULL_0003
     * @tc.number    : TEST_ON_TEXT_NULL_0003
     * @tc.desc      : findComponent(ON.text(null))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_TEXT_NULL_0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_TEXT_NULL_0003 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      try {
        await driver.findComponent(ON.text(null)).catch((err: object) => {
          console.info('TEST_ON_TEXT_NULL_0003 1234');
          let code = JSON.stringify(err["code"]);
          expect(code == "401").assertTrue();
          console.info('TEST_ON_TEXT_NULL_0003 pass');
          done();
        });
      } catch (e) {
        console.info('TEST_ON_TEXT_NULL_0003 error code ' + e.code);
        console.info('TEST_ON_TEXT_NULL_0003 error message ' + e.message);
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_TEXT_RESULT_NULL_004
     * @tc.number    : TEST_ON_TEXT_RESULT_NULL_004
     * @tc.desc      : test ON text result is null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_TEXT_RESULT_NULL_004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_TEXT_RESULT_NULL_004 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text("aaaaaa"));
      // let text = await button.getText()
      try {
        expect(button == null).assertTrue();
        console.info('TEST_ON_TEXT_RESULT_NULL_004 pass');
        done();
      } catch (e) {
        console.info('TEST_ON_TEXT_RESULT_NULL_004 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_TEXT_RESULT_SPE_CHAR_0005
     * @tc.number    : TEST_ON_TEXT_RESULT_SPE_CHAR_0005
     * @tc.desc      : driver.findComponent(ON.text("❤❥웃유♋"))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_TEXT_RESULT_SPE_CHAR_0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 start');
        await startAbility('com.example.uiacttest', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let button = await driver.findComponent(ON.text("❤❥웃유♋"));
        console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 pass' + button);
        try {
          expect(button != null).assertTrue();
          console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 pass');
          done();
        } catch (e) {
          console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 error' + e);
          done();
        }
      });

    /**
     * @tc.name      : TEST_MATCH_EQUALS_NULL_007
     * @tc.number    : TEST_MATCH_EQUALS_NULL_007
     * @tc.desc      : driver.findComponent(ON.text('next page111', MatchPattern.EQUALS))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_MATCH_EQUALS_NULL_007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button1 = await driver.findComponent(ON.text('next page111', MatchPattern.EQUALS));
      try {
        expect(await Button1.getText() == null).assertTrue();
        console.info('TEST_MATCH_EQUALS_NULL_007 pass');
        done();
      } catch (e) {
        console.info('TEST_MATCH_EQUALS_NULL_007 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_MATCH_CONTAINS_008
     * @tc.number    : TEST_MATCH_CONTAINS_008
     * @tc.desc      : driver.findComponent(ON.text('xt pa', MatchPattern.CONTAINS))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_MATCH_CONTAINS_008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button1 = await driver.findComponent(ON.text('xt pa', MatchPattern.CONTAINS));
      try {
        expect(await Button1.getText() == 'next page false').assertTrue();
        console.info('TEST_MATCH_CONTAINS_008 pass');
        done();
      } catch (e) {
        console.info('TEST_MATCH_CONTAINS_008 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_MATCH_CONTAINS_NULL_009
     * @tc.number    : TEST_MATCH_CONTAINS_NULL_009
     * @tc.desc      : driver.findComponent(ON.text('xt page111', MatchPattern.CONTAINS))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('TEST_MATCH_CONTAINS_NULL_009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button1 = await driver.findComponent(ON.text('xt page111', MatchPattern.CONTAINS));
      try {
        expect(await Button1.getText() == null).assertTrue();
        console.info('TEST_MATCH_CONTAINS_NULL_009 pass');
        done();
      } catch (e) {
        console.info('TEST_MATCH_CONTAINS_NULL_009 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_MATCH_STARTS_WITH_NULL_0011
     * @tc.number    : TEST_MATCH_STARTS_WITH_NULL_0011
     * @tc.desc      : driver.findComponent(ON.text('dddd', MatchPattern.STARTS_WITH))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('TEST_MATCH_STARTS_WITH_NULL_0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        await startAbility('com.example.uiacttest', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let Button1 = await driver.findComponent(ON.text('dddd', MatchPattern.STARTS_WITH));
        try {
          expect(await Button1.getText()).assertEqual(null);
          console.info('TEST_MATCH_STARTS_WITH_NULL_0011 pass');
          done();
        } catch (e) {
          console.info('TEST_MATCH_STARTS_WITH_NULL_0011 error' + e);
          done();
        }
      });

    /**
     * @tc.name      : TEST_MATCH_ENDS_WITH_0012
     * @tc.number    : TEST_MATCH_ENDS_WITH_0012
     * @tc.desc      : driver.findComponent(ON.text('page', MatchPattern.ENDS_WITH))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_MATCH_ENDS_WITH_0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button1 = await driver.findComponent(ON.text('page', MatchPattern.ENDS_WITH));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(await Button1.getText() == "next page").assertTrue();
        console.info('TEST_MATCH_ENDS_WITH_0012 pass');
        done();
      } catch (e) {
        console.info('TEST_MATCH_ENDS_WITH_0012 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_MATCH_PATTERN_ENDS_WITH_0013
     * @tc.number    : TEST_MATCH_PATTERN_ENDS_WITH_0013
     * @tc.desc      : driver.findComponent(ON.text('next', MatchPattern.ENDS_WITH))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_MATCH_PATTERN_ENDS_WITH_0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uiacttest', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let Button1 = await driver.findComponent(ON.text('next', MatchPattern.ENDS_WITH));
        try {
          expect(await Button1.getText() == null).assertTrue();
          console.info('TEST_MATCH_PATTERN_ENDS_WITH_0013 pass');
          done();
        } catch (e) {
          console.info('TEST_MATCH_PATTERN_ENDS_WITH_0013 error' + e);
          done();
        }
      });

    /**
     * @tc.name      : TEST_ON_ID_NULL_15
     * @tc.number    : TEST_ON_ID_NULL_15
     * @tc.desc      : ON.id(null);
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('TEST_ON_ID_NULL_15', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('TEST_ON_ID_NULL_15 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      try {
        ON.id(null);
      } catch (err) {
        let code = JSON.stringify(err["code"]);
        try {
          expect(code == "401").assertTrue();
          console.info('TEST_ON_ID_NULL_15 pass');
          done();
        } catch (e) {
          console.info('TEST_ON_ID_NULL_15 error' + e);
          done();
        }
      }
    });

    /**
     * @tc.name      : TEST_ON_TYPE_NULL_0018
     * @tc.number    : TEST_ON_TYPE_NULL_0018
     * @tc.desc      : ON.type(null);
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('TEST_ON_TYPE_NULL_0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.info('TEST_ON_TYPE_NULL_0018 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      try {
        ON.type(null);
      } catch (err) {
        let code = JSON.stringify(err["code"]);
        try {
          expect(code == "401").assertTrue();
          console.info('TEST_ON_TYPE_NULL_0018 pass');
          done();
        } catch (e) {
          console.info('TEST_ON_TYPE_NULL_0018 error' + e);
          done();
        }
      }
      // let type = await driver.findComponent(ON.type(null))
    });

    /**
     * @tc.name      : TEST_ON_CLICKABLE_Null_0020
     * @tc.number    : TEST_ON_CLICKABLE_Null_0020
     * @tc.desc      : radio.isClickable()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_CLICKABLE_Null_0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_CLICKABLE_Null_0020 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let radio = await driver.findComponent(ON.clickable());
      let RadioClickable = await radio.isClickable();
      try {
        expect(RadioClickable === true).assertTrue();
        console.info('TEST_ON_CLICKABLE_Null_0020 pass');
        done();
      } catch (e) {
        console.info('TEST_ON_CLICKABLE_Null_0020 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_LONG_CLICKABLE_NULL_0025
     * @tc.number    : TEST_ON_LONG_CLICKABLE_NULL_0025
     * @tc.desc      : button.isLongClickable()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_LONG_CLICKABLE_NULL_0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.info('TEST_ON_LONG_CLICKABLE_NULL_0025 start');
        await startAbility('com.example.uiacttest', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let button = await driver.findComponent(ON.longClickable());
        let longClickable = await button.isLongClickable();
        try {
          expect(longClickable == true).assertTrue();
          console.info('TEST_ON_LONG_CLICKABLE_NULL_0025 pass');
          done();
        } catch (e) {
          console.info('TEST_ON_LONG_CLICKABLE_NULL_0025 error' + e);
          done();
        }
      });

    /**
     * @tc.name      : TEST_ON_SCROLLABLE_NULL_0028
     * @tc.number    : TEST_ON_SCROLLABLE_NULL_0028
     * @tc.desc      : scrollBar.isScrollable()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_SCROLLABLE_NULL_0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_SCROLLABLE_NULL_0028 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let scrollBar = await driver.findComponent(ON.scrollable());
      let scrollable = await scrollBar.isScrollable();
      try {
        expect(scrollable == true).assertTrue();
        console.info('TEST_ON_SCROLLABLE_NULL_0028 pass');
        done();
      } catch (e) {
        console.info('TEST_ON_SCROLLABLE_NULL_0028 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_ENABLED_NUll_0031
     * @tc.number    : TEST_ON_ENABLED_NUll_0031
     * @tc.desc      : driver.findComponent(ON.enabled())
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_ENABLED_NUll_0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_ENABLED_NUll_0031 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.enabled().text('next page'));
      let enable = await button.isEnabled();
      try {
        expect(enable == true).assertTrue();
        console.info('TEST_ON_ENABLED_NUll_0031 pass');
        done();
      } catch (e) {
        console.info('TEST_ON_ENABLED_NUll_0031 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_FOCUSED_NUll_0034
     * @tc.number    : TEST_ON_FOCUSED_NUll_0034
     * @tc.desc      : input.click() & button.isFocused()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_FOCUSED_NUll_0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_FOCUSED_NUll_0034 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let input = await driver.findComponent(ON.id('TextInput'));
      await driver.delayMs(waitUiReadyMs);
      await input.click();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.focused());
      let focused = await button.isFocused();
      try {
        expect(focused).assertTrue();
        console.info('TEST_ON_FOCUSED_NUll_0034 pass');
        done();
      } catch (e) {
        console.info('TEST_ON_FOCUSED_NUll_0034 start');
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_SELECTED_NULL_0037
     * @tc.number    : TEST_ON_SELECTED_NULL_0037
     * @tc.desc      : driver.findComponent(ON.selected(true))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_SELECTED_NULL_0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_SELECTED_NULL_0037 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.selected(true));
      try {
        expect(button == null).assertTrue();
        console.info('TEST_ON_SELECTED_NULL_0037 pass');
        done();
      } catch (e) {
        console.info('TEST_ON_SELECTED_NULL_0037 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_ON_CHECKED_NULL_0040
     * @tc.number    : TEST_ON_CHECKED_NULL_0040
     * @tc.desc      : radio.isChecked()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_ON_CHECKED_NULL_0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_ON_CHECKED_NULL_0040 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let radio = await driver.findComponent(ON.checked(false).type('Toggle'));
      let RadioChecked = await radio.isChecked();
      try {
        expect(RadioChecked === false).assertTrue();
        console.info('TEST_ON_CHECKED_NULL_0040 pass');
        done();
      } catch (e) {
        console.info('TEST_ON_CHECKED_NULL_0040 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_CONTROL_CLICK_0045
     * @tc.number    : TEST_CONTROL_CLICK_0045
     * @tc.desc      : Button.click()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_CONTROL_CLICK_0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_CONTROL_CLICK_0045 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page false'));
      await Button.click();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.text('doubleClick'));
      try {
        expect(button == null).assertTrue();
        console.info('TEST_CONTROL_CLICK_0045 pass');
        done();
      } catch (e) {
        console.info('TEST_CONTROL_CLICK_0045 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_CONTROL_DOUBLE_CLICK_FALSE_0047
     * @tc.number    : TEST_CONTROL_DOUBLE_CLICK_FALSE_0047
     * @tc.desc      : Button.doubleClick()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        console.info('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047 start');
        await startAbility('com.example.uiacttest', 'EntryAbility');
        let driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let Button = await driver.findComponent(ON.text('Click twice false'));
        await Button.doubleClick();
        await driver.delayMs(waitUiReadyMs);
        let button = await driver.findComponent(ON.text('doubleClick'));
        try {
          expect(button == null).assertTrue();
          console.info('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047 pass');
          done();
        } catch (e) {
          console.info('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047 error' + e);
          done();
        }
      });

    /**
     * @tc.name      : TEST_CONTROL_LONG_CLICK_0049
     * @tc.number    : TEST_CONTROL_LONG_CLICK_0049
     * @tc.desc      : driver.findComponent(ON.text())
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_CONTROL_LONG_CLICK_0049', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_CONTROL_LONG_CLICK_0058 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let Button = await driver.findComponent(ON.text('next page false'));
      await Button.longClick();
      await driver.delayMs(waitUiReadyMs);
      let newButton = await driver.findComponent(ON.text('longClick'));
      try {
        expect(newButton == null).assertTrue();
        console.info('TEST_CONTROL_LONG_CLICK_0049 pass');
        done();
      } catch (e) {
        console.info('TEST_CONTROL_LONG_CLICK_0049 error' + e);
        done();
      }
    });


    /**
     * @tc.name      : TEST_GETTEXT_FALSE_0053
     * @tc.number    : TEST_GETTEXT_FALSE_0053
     * @tc.desc      : driver.findComponent(ON.id())
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_GETTEXT_FALSE_0053', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_GETTEXT_FALSE_0053 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.id('my-key-new'));
      await driver.delayMs(waitUiReadyMs);
      try {
        expect(button != null).assertTrue();
        console.info('TEST_GETTEXT_FALSE_0053 pass');
        done();
      } catch (e) {
        console.info('TEST_GETTEXT_FALSE_0053 error' + e);
        done();
      }
    });

    /**
     * @tc.name      : TEST_GET_TYPE_FALSE_0055
     * @tc.number    : TEST_GET_TYPE_FALSE_0055
     * @tc.desc      : getType()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_GET_TYPE_FALSE_0055', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_GET_TYPE_FALSE_0055 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let text = await driver.findComponent(ON.type('Text'));
      let type = await text.getType();
      console.info('TEST_GET_TYPE_FALSE_0055 pass' + type);
      try {
        expect(type == 'Text').assertTrue();
        console.info('TEST_GET_TYPE_FALSE_0055 pass');
        done();
      } catch (e) {
        console.info('TEST_GET_TYPE_FALSE_0055 error' + e);
        done();
      }
    });


    /**
     * @tc.name      : TEST_IS_CLICKABLE_TRUE_0057
     * @tc.number    : TEST_IS_CLICKABLE_TRUE_0057
     * @tc.desc      : driver.findComponent(ON.clickable(false).type('Toggle'))
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TEST_IS_CLICKABLE_TRUE_0057', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('TEST_IS_CLICKABLE_TRUE_0057 start');
      await startAbility('com.example.uiacttest', 'EntryAbility');
      let driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      let button = await driver.findComponent(ON.clickable(false).type('Toggle'));
      try {
        expect(button == null).assertTrue();
        console.info('TEST_IS_CLICKABLE_TRUE_0057 pass');
        done();
      } catch (e) {
        console.info('TEST_IS_CLICKABLE_TRUE_0057 error' + e);
        done();
      }
    });
  })
}







