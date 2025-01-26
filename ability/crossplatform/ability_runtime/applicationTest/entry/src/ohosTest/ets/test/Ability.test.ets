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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it } from '@ohos/hypium'
import { abilityDelegatorRegistry, Driver, ON } from '@kit.TestKit'
import { ConfigurationConstant, Want } from '@kit.AbilityKit'
import deviceInfo from '@ohos.deviceInfo'
import MyAbilityStage from '../myabilitystage/MyAbilityStage'

const FONTSIZESCALE_MIN_VALUE: number = 0
const FONTSIZESCALE_MAX_VALUE: number = 3.2
const AWAIT_SLEEP_MS_1000: number = 1000
const AWAIT_SLEEP_MS_2000: number = 2000

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
let context = abilityDelegatorRegistry.getAbilityDelegator().getAppContext().createModuleContext('entry_test')
const bundleName = abilityDelegatorRegistry.getArguments().bundleName
let platform = deviceInfo.osFullName.split(' ')[0]

export default function abilityTest() {
  describe('ActsAbilityTest', () => {
    beforeAll(async () => {
      context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
      const want: Want = {
        bundleName: bundleName,
        moduleName: 'entry',
        abilityName: 'EntryAbility'
      }
      await delegator.startAbility(want)
      await sleep(AWAIT_SLEEP_MS_2000)
    })
    beforeEach(async () => {
    })
    afterEach(async () => {
      await sleep(AWAIT_SLEEP_MS_1000)
    })
    afterAll(async () => {
      context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
    })

    /**
     * @tc.number : ACTS_ARKUIX_onConfigurationUpdate_Func_0100
     * @tc.name   : ACTS_ARKUIX_onConfigurationUpdate_Func_0100
     * @tc.desc   : Test Func onConfigurationUpdate
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_onConfigurationUpdate_Func_0100', 0, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
        let resForLanguage =
          (MyAbilityStage.configuration?.language?.includes('zh') ||
          MyAbilityStage.configuration?.language?.includes('en'))
        let resForFontSizeScale: number = MyAbilityStage.configuration?.fontSizeScale as number
        let resForScreenDensity: number = MyAbilityStage.configuration?.screenDensity as number
        expect(resForLanguage).assertTrue()
        expect(
          (resForFontSizeScale > FONTSIZESCALE_MIN_VALUE && resForFontSizeScale < FONTSIZESCALE_MAX_VALUE)).assertTrue()
        expect(resForScreenDensity > 0).assertTrue()

      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_onConfigurationUpdate_Func_0200
     * @tc.name   : ACTS_ARKUIX_onConfigurationUpdate_Func_0200
     * @tc.desc   : Test Func onConfigurationUpdate colorMode COLOR_MODE_DARK
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_onConfigurationUpdate_Func_0200', 0, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        await sleep(AWAIT_SLEEP_MS_1000)
        let res = MyAbilityStage.configuration?.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK
        expect(res).assertTrue()
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_onConfigurationUpdate_Func_0300
     * @tc.name   : ACTS_ARKUIX_onConfigurationUpdate_Func_0300
     * @tc.desc   : Test Func onConfigurationUpdate colorMode COLOR_MODE_LIGHT
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_onConfigurationUpdate_Func_0300', 0, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
        await sleep(AWAIT_SLEEP_MS_1000)
        let res = MyAbilityStage.configuration?.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
        expect(res).assertTrue()
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_onConfigurationUpdate_Func_0400
     * @tc.name   : ACTS_ARKUIX_onConfigurationUpdate_Func_0400
     * @tc.desc   : Test Func onConfigurationUpdate direction DIRECTION_HORIZONTAL
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_onConfigurationUpdate_Func_0400', 0, async (done: Function) => {
      try {
        if (platform.includes('Android')) {
          let driver = Driver.create()
          await sleep(AWAIT_SLEEP_MS_1000)
          let btPortrait = await driver.findComponent(ON.id('BT1'))
          await btPortrait.click()
          await sleep(AWAIT_SLEEP_MS_1000)
          let btLandscape = await driver.findComponent(ON.id('BT2'))
          await btLandscape.click()
          await sleep(AWAIT_SLEEP_MS_1000)
          let res = MyAbilityStage.configuration?.direction === ConfigurationConstant.Direction.DIRECTION_HORIZONTAL
          expect(res).assertTrue()
        } else {
          let res = MyAbilityStage.configuration?.direction === ConfigurationConstant.Direction.DIRECTION_VERTICAL ||
            MyAbilityStage.configuration?.direction == ConfigurationConstant.Direction.DIRECTION_HORIZONTAL
          expect(res).assertTrue()
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_onConfigurationUpdate_Func_0500
     * @tc.name   : ACTS_ARKUIX_onConfigurationUpdate_Func_0500
     * @tc.desc   : Test Func onConfigurationUpdate direction DIRECTION_VERTICAL
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_onConfigurationUpdate_Func_0500', 0, async (done: Function) => {
      try {
        if (platform.includes('Android')) {
          let driver = Driver.create()
          await sleep(AWAIT_SLEEP_MS_1000)
          let btLandscape = await driver.findComponent(ON.id('BT2'))
          await btLandscape.click()
          await sleep(AWAIT_SLEEP_MS_1000)
          let btPortrait = await driver.findComponent(ON.id('BT1'))
          await btPortrait.click()
          await sleep(AWAIT_SLEEP_MS_1000)
          let res = MyAbilityStage.configuration?.direction === ConfigurationConstant.Direction.DIRECTION_VERTICAL
          expect(res).assertTrue()
        } else {
          let res = MyAbilityStage.configuration?.direction === ConfigurationConstant.Direction.DIRECTION_VERTICAL ||
            MyAbilityStage.configuration?.direction == ConfigurationConstant.Direction.DIRECTION_HORIZONTAL
          expect(res).assertTrue()
        }
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0100
     * @tc.name   : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0100
     * @tc.desc   : Test Func setColorMode with parm COLOR_MODE_DARK
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0100', 0, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        await sleep(AWAIT_SLEEP_MS_1000)
        let res = MyAbilityStage.configuration?.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK
        expect(res).assertTrue()
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0200
     * @tc.name   : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0200
     * @tc.desc   : Test Func setColorMode with parm COLOR_MODE_LIGHT
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0200', 0, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
        await sleep(AWAIT_SLEEP_MS_1000)
        let res = MyAbilityStage.configuration?.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
        expect(res).assertTrue()
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0300
     * @tc.name   : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0300
     * @tc.desc   : Test Func setColorMode with parm null
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0300', 2, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(null)
      } catch (error) {
        expect(JSON.stringify(error).includes('401')).assertTrue()
      }
      context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0400
     * @tc.name   : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0400
     * @tc.desc   : Test Func setColorMode with parm undefined
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0400', 2, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(undefined)
      } catch (error) {
        expect(JSON.stringify(error).includes('401')).assertTrue()
      }
      context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0500
     * @tc.name   : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0500
     * @tc.desc   : Test Func setColorMode with parm -2
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0500', 2, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(-2)
        await sleep(AWAIT_SLEEP_MS_1000)
        let res = MyAbilityStage.configuration?.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
        expect(res).assertTrue()
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0600
     * @tc.name   : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0600
     * @tc.desc   : Test Func setColorMode with parm 2
     * @tc.level  : Level 2
     */
    it('ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0600', 2, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(2)
        await sleep(AWAIT_SLEEP_MS_1000)
        let res = MyAbilityStage.configuration?.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
        expect(res).assertTrue()
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
      } catch (error) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0700
     * @tc.name   : ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0700
     * @tc.desc   : Test Func setColorMode with parm COLOR_MODE_NOT_SET
     * @tc.level  : Level 0
     */
    it('ACTS_ARKUIX_ApplicationContext_setColorMode_Func_0700', 0, async (done: Function) => {
      try {
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK)
        await sleep(AWAIT_SLEEP_MS_1000)
        context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET)
        await sleep(AWAIT_SLEEP_MS_1000)
        let res = MyAbilityStage.configuration?.colorMode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT
        expect(res).assertTrue()
      } catch (error) {
        expect().assertFail()
      }
      done()
    })
  })
}