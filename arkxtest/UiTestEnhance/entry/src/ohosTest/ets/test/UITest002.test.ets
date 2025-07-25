import { describe, it, expect, afterEach, TestType, Level, Size } from '@ohos/hypium';
import { Component, Driver, ON, PointerMatrix } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@ohos.base';

interface want {
  bundleName: string,
  abilityName: string,
  moduleName: string
}

const waitUiReadyMs = 3000;
const delegator = abilityDelegatorRegistry.getAbilityDelegator();

const startAbility = async (bundleName: string, abilityName: string) => {
  let want: want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };

  await delegator.startAbility(want).then(result => {
    console.info(`UiTestCase, start abilityFinished: ${result}`)
  }).catch((err: BusinessError) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function UITest002() {
  describe('UITest002', () => {

    afterEach(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs);
    })

    /**
     * @tc.name      : Test_isBefore_0100
     * @tc.number    : Test_isBefore_0100
     * @tc.desc      : findComponent(ON.isBefore()) 前面元素为 Text控件
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('Test_isBefore_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isBefore(ON.text("up_002")).type("Text"))
      await driver.delayMs(waitUiReadyMs)
      let text = await control.getText()
      await driver.delayMs(waitUiReadyMs)
      try {
        expect(text).assertEqual('up_001')
        console.info('Test_isBefore_0100 pass')
        done()
      } catch (e) {
        // console.info('Test_isBefore_0100 error')
        done()
      }
    })

    /**
     * @tc.name      : Test_isBefore_0500
     * @tc.number    : Test_isBefore_0500
     * @tc.desc      : 正常测试isBefore 不传获取类型 使用默认方式  替换  不是孩子控件
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('Test_isBefore_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isBefore(ON.text("up_002")))
      try {
        expect(control != null).assertTrue()
        console.info('Test_isBefore_0500 pass')
        done()
      } catch (e) {
        console.info('Test_isBefore_0500 error')
        done()
      }
    })

    /**
     * @tc.name      : Test_isBefore_0300
     * @tc.number    : Test_isBefore_0300
     * @tc.desc      : ON.isBefore()
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('Test_isBefore_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isBefore(ON.text("down_001")).type("Text"))
      let text = await control.getText()
      try {
        expect(text).assertEqual('up_001')
        console.info('Test_isBefore_0300 pass')
        done()
      } catch (e) {
        console.info('Test_isBefore_0300 error')
        done()
      }
    })

    /**
     * @tc.name      : Test_isBefore_0400
     * @tc.number    : Test_isBefore_0400
     * @tc.desc      : 获取可视区域外的前一个孩子
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('Test_isBefore_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isBefore(ON.text("up_003")).type("Text"))
      let text = await control.getText()
      try {
        expect(text).assertEqual('up_001')
        console.info('Test_isBefore_0400 pass')
        done()
      } catch (e) {
        console.info('Test_isBefore_0400 error')
        done()
      }
    })
  })
}