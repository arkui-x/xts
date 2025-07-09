/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level } from '@ohos/hypium'
import { Driver, ON } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import Want from '@ohos.app.ability.Want'
import font from '@ohos.font'
import deviceInfo from '@ohos.deviceInfo'

let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
const fontName = 'NotoSansOriya Bold'
const bundleName = abilityDelegatorRegistry.getArguments().bundleName
const osFullNameInfo: string = deviceInfo.osFullName
const platform = osFullNameInfo.split(' ')[0]

export default function abilityTest() {
  describe('ActsAbilityTest', () => {

    beforeAll(async () => {
      console.info('The bundleName is :' + JSON.stringify(bundleName))
      console.info('The DeviceInfo osFullName is :' + JSON.stringify(osFullNameInfo))
      console.info('The Device Platform is :' + JSON.stringify(platform))
      let want: Want = {
        bundleName: bundleName,
        moduleName: 'entry',
        abilityName: 'EntryAbility'
      }
      await delegator.startAbility(want)
      let driver = Driver.create()
      await driver.delayMs(3000)
    })
    beforeEach(async () => {
    })
    afterEach(async () => {
    })
    afterAll(async () => {
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0100
     * @tc.name   : SUB_font_registerFont_Func_0100
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 0
     */
    it('SUB_font_registerFont_Func_0100',Level.LEVEL0, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text01')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_01\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_01\\\"")
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0200
     * @tc.name   : SUB_font_registerFont_Func_0200
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 0
     */
    it('SUB_font_registerFont_Func_0200',Level.LEVEL0, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text02')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_02\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_02\\\"")
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0300
     * @tc.name   : SUB_font_registerFont_Func_0300
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 0
     */
    it('SUB_font_registerFont_Func_0300',Level.LEVEL0, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text03')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_03\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_03\\\"")
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0400
     * @tc.name   : SUB_font_registerFont_Func_0400
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 0
     */
    it('SUB_font_registerFont_Func_0400',Level.LEVEL0, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text04')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_04\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_04\\\"")
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0500
     * @tc.name   : SUB_font_registerFont_Func_0500
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_0500',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text11')
        console.info('strJson is ' + JSON.stringify(strJson))
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"HarmonyOS Sans\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0600
     * @tc.name   : SUB_font_registerFont_Func_0600
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_0600',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text12')
        console.info('strJson is ' + JSON.stringify(strJson))
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"HarmonyOS Sans\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0700
     * @tc.name   : SUB_font_registerFont_Func_0700
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_0700',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text13')
        console.info('strJson is ' + JSON.stringify(strJson))
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"HarmonyOS Sans\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0800
     * @tc.name   : SUB_font_registerFont_Func_0800
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_0800',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text14')
        console.info('strJson is ' + JSON.stringify(strJson))
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_0900
     * @tc.name   : SUB_font_registerFont_Func_0900
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_0900',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text15')
        console.info('strJson is ' + JSON.stringify(strJson))
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1000
     * @tc.name   : SUB_font_registerFont_Func_1000
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1000',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text16')
        console.info('strJson is ' + JSON.stringify(strJson))
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1100
     * @tc.name   : SUB_font_registerFont_Func_1100
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1100',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text21')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_21\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_21\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1200
     * @tc.name   : registerFont
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1200',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text22')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_21\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_21\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1300
     * @tc.name   : registerFont
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1300',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text23')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_21\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_21\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1400
     * @tc.name   : SUB_font_registerFont_Func_1400
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1400',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text24')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_21\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_21\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1500
     * @tc.name   : SUB_font_registerFont_Func_1500
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1500',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text25')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_21\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_21\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1600
     * @tc.name   : SUB_font_registerFont_Func_1600
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1600',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text26')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_21\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_21\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_registerFont_Func_1700
     * @tc.name   : SUB_font_registerFont_Func_1700
     * @tc.desc   : Tests the FontOptions
     * @tc.level  : Level 2
     */
    it('SUB_font_registerFont_Func_1700',Level.LEVEL2, async (done: Function) => {
      try {
        let strJson = getInspectorByKey('text27')
        console.info('strJson is ' + JSON.stringify(strJson))
        //Expected value:"fontFamily\":\"test_21\"
        expect(JSON.stringify(strJson)).assertContain("fontFamily\\\":\\\"test_21\\\"")
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_getSystemFontList_Func_0100
     * @tc.name   : SUB_font_getSystemFontList_Func_0100
     * @tc.desc   : Test the return value of getSystemFontList
     * @tc.level  : Level 0
     */
    it('SUB_font_getSystemFontList_Func_0100',Level.LEVEL0, async (done: Function) => {
      try {
        let fontList = font.getSystemFontList()
        if (platform == "Android" || platform == "IOS") {
          if (fontList && fontList.length != 0) {
            console.info('getSystemFontList is ' + JSON.stringify(fontList))
            let listLen = fontList.length
            expect(listLen).assertLarger(0)
          } else {
            expect().assertFail()
          }
        } else {
          expect(true).assertTrue()
        }
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_getFontByName_Func_0100
     * @tc.name   : SUB_font_getFontByName_Func_0100
     * @tc.desc   : Test Func getFontByName
     * @tc.level  : Level 0
     */
    it('SUB_font_getFontByName_Func_0100',Level.LEVEL0, async (done: Function) => {
      try {
        let fontInfo = font.getFontByName(fontName)
        if (platform == "Android") {
          expect(fontInfo.path).assertContain('NotoSansOriya-Bold')
          expect(fontInfo.fullName).assertEqual(fontName)
          expect(fontInfo.weight).assertLargerOrEqual(0)
          expect(fontInfo.italic).assertFalse()
        } else if (platform == "IOS") {
          expect(fontInfo.postScriptName).assertEqual(fontName)
          expect(fontInfo.fullName).assertEqual(fontName)
          expect(fontInfo.family).assertContain('Oriya')
          expect(fontInfo.italic).assertFalse()
          expect(fontInfo.monoSpace).assertFalse()
          expect(fontInfo.symbolic).assertFalse()
        } else {
          expect(fontInfo).assertUndefined()
        }
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_getFontByName_Func_0200
     * @tc.name   : SUB_font_getFontByName_Func_0200
     * @tc.desc   : Test Func getFontByName
     * @tc.level  : Level 2
     */
    it('SUB_font_getFontByName_Func_0200',Level.LEVEL2, async (done: Function) => {
      try {
        let fontInfo = font.getFontByName('123456ABAC')
        expect(fontInfo).assertUndefined()
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_font_getFontByName_Func_0300
     * @tc.name   : SUB_font_getFontByName_Func_0300
     * @tc.desc   : Test Func getFontByName
     * @tc.level  : Level 2
     */
    it('SUB_font_getFontByName_Func_0300',Level.LEVEL2, async (done: Function) => {
      try {
        let fontInfo = font.getFontByName('')
        expect(fontInfo).assertUndefined()
      } catch (err) {
        console.info('try-catch err: ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

  })
}