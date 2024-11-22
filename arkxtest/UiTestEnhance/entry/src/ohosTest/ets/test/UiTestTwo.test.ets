import { describe, it, expect } from '@ohos/hypium';
import { Component, Driver, ON, PointerMatrix, UiDirection } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { BusinessError } from '@ohos.base';
import hilog from '@ohos.hilog';

interface want {
  bundleName: string,
  abilityName: string,
  moduleName: string
}

const waitUiReadyMs = 1500;
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

export default function uiTestTwoTest() {
  describe('UiTestTwo', () => {

    /*
     * @tc.number: 001
     * @tc.name: testFlingFromTopToBottom_001
     * @tc.desc: 模拟从上向下滑动
     */
    it('testFlingFromTopToBottom_001', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let slidingPageButton: Component = await driver.findComponent(ON.text('MultiFingerSlidingPage'))
      await slidingPageButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textOne: Component = await driver.findComponent(ON.text('1'))
      await driver.delayMs(waitUiReadyMs)
      expect(textOne != null).assertTrue()

      await driver.fling(UiDirection.DOWN, 3000)
      await driver.delayMs(waitUiReadyMs)
      let textEightAfter = await driver.findComponent(ON.text('8'))
      await driver.delayMs(waitUiReadyMs)
      expect(textEightAfter != null).assertTrue()

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 002
     * @tc.name: testFlingFromDownUp_002
     * @tc.desc: 模拟从下向上滑动
     */
    it('testFlingFromDownUp_002', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let slidingPageButton: Component = await driver.findComponent(ON.text('MultiFingerSlidingPage'))
      await slidingPageButton.click()
      await driver.delayMs(waitUiReadyMs)
      let slidingScroll: Component = await driver.findComponent(ON.id('multiFingerSlidingScroll'))
      await driver.delayMs(waitUiReadyMs)
      expect(slidingScroll != null).assertTrue()
      await slidingScroll.scrollToBottom()
      await driver.delayMs(waitUiReadyMs)

      await driver.fling(UiDirection.UP, 3000)
      await driver.delayMs(waitUiReadyMs)
      let textTwoAfter = await driver.findComponent(ON.text('2'))
      await driver.delayMs(waitUiReadyMs)
      expect(textTwoAfter != null).assertTrue()

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 003
     * @tc.name: testFlingFromLeftToRight_003
     * @tc.desc: 模拟从左向右滑动
     */
    it('testFlingFromLeftToRight_003', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let slidingPageButton: Component = await driver.findComponent(ON.text('HorizontallySlidePage'))
      await slidingPageButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scroll: Component = await driver.findComponent(ON.id('horizontallySlideScroll'))
      await driver.delayMs(waitUiReadyMs)
      expect(scroll != null).assertTrue()

      await driver.fling(UiDirection.RIGHT, 6000)
      await driver.delayMs(waitUiReadyMs)
      let textEightAfter = await driver.findComponent(ON.text('8'))
      await driver.delayMs(waitUiReadyMs)
      expect(textEightAfter != null).assertTrue()

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 004
     * @tc.name: testFlingFromRightToLeft_004
     * @tc.desc: 模拟从右向左滑动
     */
    it('testFlingFromRightToLeft_004', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let slidingPageButton: Component = await driver.findComponent(ON.text('HorizontallySlidePage'))
      await slidingPageButton.click()
      await driver.delayMs(waitUiReadyMs)
      let slidingScroll: Component = await driver.findComponent(ON.id('horizontallySlideScroll'))
      await driver.delayMs(waitUiReadyMs)
      expect(slidingScroll != null).assertTrue()
      await driver.fling(UiDirection.RIGHT, 6000)
      await driver.delayMs(waitUiReadyMs)

      await driver.fling(UiDirection.LEFT, 6000)
      await driver.delayMs(waitUiReadyMs)
      let textTwoAfter = await driver.findComponent(ON.text('2'))
      await driver.delayMs(waitUiReadyMs)
      expect(textTwoAfter != null).assertTrue()

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 005
     * @tc.name: testFlingFromTopToBottomExceptionParameter_005
     * @tc.desc: 模拟从上向下滑动传入错误参数
     */
    it('testFlingFromTopToBottomExceptionParameter_005', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let slidingPageButton: Component = await driver.findComponent(ON.text('MultiFingerSlidingPage'))
      await slidingPageButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textOne: Component = await driver.findComponent(ON.text('1'))
      await driver.delayMs(waitUiReadyMs)
      expect(textOne != null).assertTrue()

      await driver.fling(UiDirection.DOWN, -3000)
      await driver.delayMs(waitUiReadyMs)
      let textFourAfter = await driver.findComponent(ON.text('4'))
      await driver.delayMs(waitUiReadyMs)
      expect(textFourAfter != null).assertTrue()

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 006
     * @tc.name: testInputText_006
     * @tc.desc: 模拟输入文本
     */
    it('testInputText_006', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textInputA: Component = await driver.findComponent(ON.id('inputA'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputA != null).assertTrue()

      await textInputA.click()
      await driver.delayMs(waitUiReadyMs)
      await textInputA.inputText('123')
      await driver.delayMs(waitUiReadyMs)
      let inputAText = await textInputA.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(inputAText).assertEqual('123')

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 007
     * @tc.name: testInputTextChinese_007
     * @tc.desc: 模拟输入汉字文本
     */
    it('testInputTextChinese_007', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textInputA: Component = await driver.findComponent(ON.id('inputA'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputA != null).assertTrue()

      await textInputA.click()
      await driver.delayMs(waitUiReadyMs)
      await textInputA.inputText('你好')
      await driver.delayMs(waitUiReadyMs)
      let inputAText = await textInputA.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(inputAText).assertEqual('你好')

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 008
     * @tc.name: testInputTextSpecialCharacters_008
     * @tc.desc: 模拟输入特殊字符文本
     */
    it('testInputTextSpecialCharacters_008', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textInputA: Component = await driver.findComponent(ON.id('inputA'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputA != null).assertTrue()

      await textInputA.click()
      await driver.delayMs(waitUiReadyMs)
      await textInputA.inputText('**&&')
      await driver.delayMs(waitUiReadyMs)
      let inputAText = await textInputA.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(inputAText).assertEqual('**&&')

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 009
     * @tc.name: testInputTextCapitalization_009
     * @tc.desc: 模拟输入大写文本
     */
    it('testInputTextCapitalization_009', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textInputA: Component = await driver.findComponent(ON.id('inputA'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputA != null).assertTrue()

      await textInputA.click()
      await driver.delayMs(waitUiReadyMs)
      await textInputA.inputText('ABC')
      await driver.delayMs(waitUiReadyMs)
      let inputAText = await textInputA.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(inputAText).assertEqual('ABC')

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 010
     * @tc.name: testInputTextHalfInputBox_010
     * @tc.desc: 模拟在显示一半的输入框中输入文本
     */
    it('testInputTextHalfInputBox_010', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textInputC: Component = await driver.findComponent(ON.id('inputC'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputC != null).assertTrue()

      await textInputC.click()
      await driver.delayMs(waitUiReadyMs)
      await textInputC.inputText('1212')
      await driver.delayMs(waitUiReadyMs)
      let inputCText = await textInputC.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(inputCText).assertEqual('1212')

      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

    /*
     * @tc.number: 012
     * @tc.name: testTriggerKeyExceptionParameter_012
     * @tc.desc: 模拟点击按键传入异常参数
     */
    it('testTriggerKeyExceptionParameter_012', 0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textInputA: Component = await driver.findComponent(ON.id('inputA'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputA != null).assertTrue()

      await driver.triggerKey(-999)
      await driver.delayMs(waitUiReadyMs)
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      await driver.delayMs(waitUiReadyMs);
      done()
    })

  })
}