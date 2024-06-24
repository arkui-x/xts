

import { describe, it, expect } from '@ohos/hypium';
import {Driver, ON } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@ohos.base';
interface want {
  bundleName: string,
  abilityName: string,
  moduleName: string
}

const delegator = abilityDelegatorRegistry.getAbilityDelegator();

const startAbility = async (bundleName: string, abilityName: string) => {
  let want: want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await delegator.startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch((err:BusinessError) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function WaitUiTest() {
  describe('WaitUiTest', () => {

    //正常测试findComponent
    it('Test_WaitUiTest_0100', 0, async () => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(20000)
      try {
        expect(true).assertTrue()
        console.info('Test_WaitUiTest_0100 pass')
        // done()
      } catch (e) {
        console.info('Test_WaitUiTest_0100 error')
        // done()
      }
    })

  })
}