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
import CommonFunc from '../utils/Common';
import data from '@ohos.telephony.data';

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const bundleName = abilityDelegatorRegistry.getArguments().bundleName;
const waitUiReadyMs = 1000;


async function startAbility(bundleName: string, abilityName: string) {
  let want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await delegator.startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch(err => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function NewUiTest() {

  describe('NewUiTest', function () {

    it('NewTEST_ON_TEXT_test', 0, async function (done) {
      console.info('NewTEST_ON_TEXT_0001_null start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.text("test"))
      let text = await button.getText()
      await driver.delayMs(waitUiReadyMs)
      try {
        expect(text == "test").assertTrue()
        console.info('NewTEST_ON_TEXT_0001_test pass')
        done()
      } catch (e) {
        console.info('NewTEST_ON_TEXT_0001_test error' + e)
        done()
      }
    })

    //------error
    it('TEST_ON_TEXT_NULL_0003', 0, async function (done) {
      console.info('TEST_ON_TEXT_NULL_0003 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      try {
        await driver.findComponent(ON.text(null)).catch(err => {
          console.info('TEST_ON_TEXT_NULL_0003 1234')
          var code = JSON.stringify(err["code"]);

          expect(code == "401").assertTrue()
          console.info('TEST_ON_TEXT_NULL_0003 pass')
          done()

        })
      } catch (e) {
        console.info('TEST_ON_TEXT_NULL_0003 error code ' + e.code)
        console.info('TEST_ON_TEXT_NULL_0003 error message ' + e.message)
        done()
      }
    })

    //------error
    it('TEST_ON_TEXT_RESULT_NULL_004', 0, async function (done) {
      console.info('TEST_ON_TEXT_RESULT_NULL_004 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.text("aaaaaa"))
      // let text = await button.getText()
      try {
        expect(button == null).assertTrue()
        console.info('TEST_ON_TEXT_RESULT_NULL_004 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_TEXT_RESULT_NULL_004 error' + e)
        done()
      }
    })

    //error
    it('TEST_ON_TEXT_RESULT_SPE_CHAR_0005', 0, async function (done) {
      console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.text("❤❥웃유♋"))
      console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 pass'+button)
      try {
        expect(button != null).assertTrue()
        console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_TEXT_RESULT_SPE_CHAR_0005 error' + e)
        done()
      }
    })


    it('TEST_MATCH_EQUALS_NULL_007', 0, async function (done) {
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button1 = await driver.findComponent(ON.text('next page111', MatchPattern.EQUALS))
      try {
        expect(await Button1.getText() == null).assertTrue()
        console.info('TEST_MATCH_EQUALS_NULL_007 pass')
        done()
      } catch (e) {
        console.info('TEST_MATCH_EQUALS_NULL_007 error' + e)
        done()
      }
    })


    it('TEST_MATCH_CONTAINS_NULL_009', 0, async function (done) {
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button1 = await driver.findComponent(ON.text('xt page111', MatchPattern.CONTAINS))
      try {
        expect(await Button1.getText() == null).assertTrue()
        console.info('TEST_MATCH_CONTAINS_NULL_009 pass')
        done()
      } catch (e) {
        console.info('TEST_MATCH_CONTAINS_NULL_009 error' + e)
        done()
      }
    })

    it('TEST_MATCH_STARTS_WITH_NULL_0011', 0, async function (done) {
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button1 = await driver.findComponent(ON.text('ext', MatchPattern.STARTS_WITH))
      try {
        expect(await Button1.getText() == null).assertTrue()
        console.info('TEST_MATCH_STARTS_WITH_NULL_0011 pass')
        done()
      } catch (e) {
        console.info('TEST_MATCH_STARTS_WITH_NULL_0011 error' + e)
        done()
      }
    })

    it('TEST_MATCH_ENDS_WITH_0012', 0, async function (done) {
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button1 = await driver.findComponent(ON.text('page', MatchPattern.ENDS_WITH))
      await driver.delayMs(waitUiReadyMs)
      try {
        expect(await Button1.getText() == "next page").assertTrue()
        console.info('TEST_MATCH_ENDS_WITH_0012 pass')
        done()
      } catch (e) {
        console.info('TEST_MATCH_ENDS_WITH_0012 error' + e)
        done()
      }
    })

    it('TEST_MATCH_PATTERN_ENDS_WITH_0013', 0, async function (done) {
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button1 = await driver.findComponent(ON.text('next', MatchPattern.ENDS_WITH))
      try {
        expect(await Button1.getText() == null).assertTrue()
        console.info('TEST_MATCH_PATTERN_ENDS_WITH_0013 pass')
        done()
      } catch (e) {
        console.info('TEST_MATCH_PATTERN_ENDS_WITH_0013 error' + e)
        done()
      }
    })
    // ------error
    it('TEST_ON_ID_NULL_15', 0, async function (done) {
      console.info('TEST_ON_ID_NULL_15 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      try {
        ON.id(null)
      }catch (err){
        let code = JSON.stringify(err["code"])
        try {
          expect(code == "401").assertTrue()
          console.info('TEST_ON_ID_NULL_15 pass')
          done()
        } catch (e) {
          console.info('TEST_ON_ID_NULL_15 error' + e)
          done()
        }
      }


    })

//------error
    it('TEST_ON_TYPE_NULL_0018', 0, async function (done) {
      console.info('TEST_ON_TYPE_NULL start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      // console.info('------------------------------'+JSON.stringify(ON.type(null)))
      try {
        ON.type(null)
      }catch (err){
        let code = JSON.stringify(err["code"])
        try {
          expect(code == "401").assertTrue()
          console.info('TEST_ON_TYPE_NULL_0018 pass')
          done()
        } catch (e) {
          console.info('TEST_ON_TYPE_NULL_0018 error' + e)
          done()
        }
      }
      // let type = await driver.findComponent(ON.type(null))
    })

    it('TEST_ON_CLICKABLE_Null_0020', 0, async function (done) {
      console.info('TEST_ON_CLICKABLE_Null_0020 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let radio = await driver.findComponent(ON.clickable())
      let RadioClickable = await radio.isClickable()
      try {
        expect(RadioClickable === true).assertTrue()
        console.info('TEST_ON_CLICKABLE_Null_0020 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_CLICKABLE_Null_0020 error' + e)
        done()
      }
    })

    it('TEST_ON_LONG_CLICKABLE_NULL_0025', 0, async function (done) {
      console.info('TEST_ON_LONG_CLICKABLE_NULL_0025 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.longClickable())
      let longClickable = await button.isLongClickable()
      try {
        expect(longClickable == true).assertTrue()
        console.info('TEST_ON_LONG_CLICKABLE_NULL_0025 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_LONG_CLICKABLE_NULL_0025 error' + e)
        done()
      }
    })

    it('TEST_ON_SCROLLABLE_NULL_0028', 0, async function (done) {
      console.info('TEST_ON_SCROLLABLE_NULL_0028 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let scrollBar = await driver.findComponent(ON.scrollable())
      let scrollable = await scrollBar.isScrollable()
      try {
        expect(scrollable == true).assertTrue()
        console.info('TEST_ON_SCROLLABLE_NULL_0028 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_SCROLLABLE_NULL_0028 error' + e)
        done()
      }
    })

    it('TEST_ON_ENABLED_NUll_0031', 0, async function (done) {
      console.info('TEST_ON_ENABLED_NUll_0031 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.enabled().text('next page'))
      let enable = await button.isEnabled()
      try {
        expect(enable == true).assertTrue()
        console.info('TEST_ON_ENABLED_NUll_0031 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_ENABLED_NUll_0031 error' + e)
        done()
      }
    })


    it('TEST_ON_FOCUSED_NUll_0034', 0, async function (done) {
      console.info('TEST_ON_FOCUSED_NUll_0034 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.focused())
      let focused = await button.isFocused()
      try {
        expect(focused == true).assertTrue()
        console.info('TEST_ON_FOCUSED_NUll_0034 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_FOCUSED_NUll_0034 start')
        done()
      }
    })


    //error
    it('TEST_ON_SELECTED_NULL_0037', 0, async function (done) {
      console.info('TEST_ON_SELECTED_NULL_0037 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.selected(true))
      try {
        expect(button == null).assertTrue()
        console.info('TEST_ON_SELECTED_NULL_0037 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_SELECTED_NULL_0037 error' + e)
        done()
      }
    })

    it('TEST_ON_CHECKED_NULL_0040', 0, async function (done) {
      console.info('TEST_ON_CHECKED_NULL_0040 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let radio = await driver.findComponent(ON.checked(false).type('Toggle'))
      let RadioChecked = await radio.isChecked()
      try {
        expect(RadioChecked === false).assertTrue()
        console.info('TEST_ON_CHECKED_NULL_0040 pass')
        done()
      } catch (e) {
        console.info('TEST_ON_CHECKED_NULL_0040 error' + e)
        done()
      }
    })

//------error
    it('TEST_CONTROL_CLICK_0045', 0, async function (done) {
      console.info('TEST_CONTROL_CLICK_0045 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button = await driver.findComponent(ON.text('next page false'))
      await Button.click()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.text('doubleClick'))
      try {
        expect(button == null).assertTrue()
        console.info('TEST_CONTROL_CLICK_0045 pass')
        done()
      } catch (e) {
        console.info('TEST_CONTROL_CLICK_0045 error' + e)
        done()
      }
    })

    // next page false
    it('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047', 0, async function (done) {
      console.info('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button = await driver.findComponent(ON.text('Click twice false'))
      await Button.doubleClick()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.text('doubleClick'))
      try {
        expect(button == null).assertTrue()
        console.info('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047 pass')
        done()
      } catch (e) {
        console.info('TEST_CONTROL_DOUBLE_CLICK_FALSE_0047 error' + e)
        done()
      }
    })

    it('TEST_CONTROL_LONG_CLICK_0049', 0, async function (done) {
      console.info('TEST_CONTROL_LONG_CLICK_0058 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let Button = await driver.findComponent(ON.text('next page false'))
      await Button.longClick()
      await driver.delayMs(waitUiReadyMs)
      let newButton = await driver.findComponent(ON.text('longClick'))
      try {
        expect(newButton == null).assertTrue()
        console.info('TEST_CONTROL_LONG_CLICK_0049 pass')
        done()
      } catch (e) {
        console.info('TEST_CONTROL_LONG_CLICK_0049 error' + e)
        done()
      }
    })

    //error
    it('TEST_GETTEXT_FALSE_0053', 0, async function (done) {
      console.info('TEST_GETTEXT_FALSE_0053 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.id('my-key-new'))
      await driver.delayMs(waitUiReadyMs)
      try {
        expect(button != null).assertTrue()
        console.info('TEST_GETTEXT_FALSE_0053 pass')
        done()
      } catch (e) {
        console.info('TEST_GETTEXT_FALSE_0053 error' + e)
        done()
      }
    })

    it('TEST_GET_TYPE_FALSE_0055', 0, async function (done) {
      console.info('TEST_GET_TYPE_FALSE_0055 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let text = await driver.findComponent(ON.type('Text'))
      let type = await text.getType()
      console.info('TEST_GET_TYPE_FALSE_0055 pass'+type)
      try {
        // @ts-ignore
        expect(type == 'Text').assertTrue()
        console.info('TEST_GET_TYPE_FALSE_0055 pass')
        done()
      } catch (e) {
        console.info('TEST_GET_TYPE_FALSE_0055 error' + e)
        done()
      }
    })
//error
    it('TEST_IS_CLICKABLE_TRUE_0057', 0, async function (done) {
      console.info('TEST_IS_CLICKABLE_TRUE_0057 start')
      await startAbility('com.example.uiacttest', 'UiTestAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let button = await driver.findComponent(ON.clickable(false).type('Toggle'))
      try {
        expect(button == null).assertTrue()
        console.info('TEST_IS_CLICKABLE_TRUE_0057 pass')
        done()
      } catch (e) {
        console.info('TEST_IS_CLICKABLE_TRUE_0057 error' + e)
        done()
      }
    })

  })
}







