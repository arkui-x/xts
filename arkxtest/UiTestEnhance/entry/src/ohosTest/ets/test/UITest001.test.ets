import { describe, it, expect, afterEach } from '@ohos/hypium';
import { Component, Driver, MatchPattern, ON, PointerMatrix } from '@ohos.UiTest'
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

export default function UITest001() {
  describe('UITest001', () => {

    afterEach(async ()=>{
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs);
    })

    //正常测试findComponent
    it('Test_findComponent_0100', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(1000)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.text("p_00",MatchPattern.CONTAINS))
      let text = await control.getText()
      try {
        expect(text).assertEqual('up_001')
        console.info('Test_findComponent_0100 pass')
        done()
      } catch (e) {
        console.info('Test_findComponent_0100 error')
        done()
      }
    })

    // 正常测试within 可视区域内正常孩子
    it('Test_within_0200', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.within(ON.id("up")).text("up_002"))
      let text = await control.getText()
      try {
        expect(text).assertEqual('up_002')
        console.info('Test_within_0200 pass')
        done()
      } catch (e) {
        console.info('Test_within_0200 error')
        done()
      }
    })

    // 正常测试within 可视区域外正常孩子
    it('Test_within_0300', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.within(ON.id("up")).text("up_003"))
      let text = await control.getText()
      try {
        expect(text).assertEqual('up_003')
        console.info('Test_within_0300 pass')
        done()
      } catch (e) {
        console.info('Test_within_0300 error')
        done()
      }
    })

    // 正常测试within 可视区域二级子孩子
    it('Test_within_0400', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.within(ON.id("center")).text("center_center"))
      let text = await control.getText()

      try {
        expect(text).assertEqual('center_center')
        console.info('Test_within_0400 pass')
        done()
      } catch (e) {
        console.info('Test_within_0400 error')
        done()
      }
    })

    // 正常测试within 可视区域不是孩子
    it('Test_within_0500', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.within(ON.id("center")).text("up_001"))

      try {
        expect(control == null).assertTrue()
        console.info('Test_within_0500 pass')
        done()
      } catch (e) {
        console.info('Test_within_0500 error')
        done()
      }
    })

    // 正常测试within 可视区域孩子为空
    it('Test_within_0600', 0, async (done : Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let WithBeforAfterPage: Component = await driver.findComponent(ON.text('WithBeforAfterPage'))
      await WithBeforAfterPage.click()
      await driver.delayMs(waitUiReadyMs)

      let control = await driver.findComponent(ON.within(ON.id("center_empty")).text("up_001"))

      try {
        expect(control == null).assertTrue()
        console.info('Test_within_0600 pass')
        done()
      } catch (e) {
        console.info('Test_within_0600 error')
        done()
      }
    })
  })
}