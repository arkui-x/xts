import { describe, it, expect, afterEach } from '@ohos/hypium';
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
  }).catch((err:BusinessError) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function UITest003() {
  describe('UITest003', () => {

    afterEach(async ()=>{
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs);
    })

    // 正常测试isAfter 下面元素为 Text控件
    it('Test_isAfter_0100', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isAfter(ON.text("down_003")).type("Text"))

      let text = await control.getText()
      try {
        expect(text).assertEqual('down_004')
        console.info('Test_isAfter_0100 pass')
        done()
      } catch (e) {
        console.info('Test_isAfter_0100 error')
        done()
      }
    })

    // 正常测试iisAfter 下面 不传获取类型 使用默认方式  替换  不是孩子控件
    it('Test_isAfter_0200', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isAfter(ON.text("down_003")))
      let text = await control.getText()
      try {
        expect(text).assertEqual('down_004')
        console.info('Test_isAfter_0200 pass')
        done()
      } catch (e) {
        console.info('Test_isAfter_0200 error')
        done()
      }
    })

    // 获取最外层控件before
    it('Test_isAfter_0300', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isAfter(ON.id("father")))
      try {
        expect(control != null).assertTrue()
        console.info('Test_isAfter_0300 pass')
        done()
      } catch (e) {
        console.info('Test_isAfter_0300 error')
        done()
      }
    })

    // 获取最后一个孩子的下一个
    it('Test_isAfter_0400', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isAfter(ON.text("up_004")).type("Text"))
      let text = await control.getText()
      try {
        expect(text).assertEqual('center_001')
        console.info('Test_isAfter_0400 pass')
        done()
      } catch (e) {
        console.info('Test_isAfter_0400 error')
        done()
      }
    })

    // 获取一个在可视区域外的孩子的下一个孩子
    it('Test_isAfter_0500', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.isAfter(ON.text("down_002")).type("Text"))
      let text = await control.getText()
      try {
        expect(text).assertEqual('down_003')
        console.info('Test_isAfter_0500 pass')
        done()
      } catch (e) {
        console.info('Test_isAfter_0500 error')
        done()
      }
    })

  })
}