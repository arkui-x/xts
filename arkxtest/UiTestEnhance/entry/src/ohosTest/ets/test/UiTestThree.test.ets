import { describe, it, expect, afterEach, TestType, Level, Size } from '@ohos/hypium';
import { Component, Driver, ON, PointerMatrix } from '@ohos.UiTest'
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
  }).catch((err: BusinessError) => {
    console.error(`UiTestCase, start abilityFailed: ${err}`)
  })
}

export default function uiTestThreeTest() {
  describe('UiTestThree', () => {
    afterEach(async () => {
      let topAbility = await delegator.getCurrentTopAbility();
      await topAbility.context.terminateSelf();
      let driver = Driver.create()
      await driver.delayMs(waitUiReadyMs);
    });

    /*
     * @tc.number    : testTriggerCombineKeys_001
     * @tc.name      : testTriggerCombineKeys_001
     * @tc.desc      : 使用组合键复制并粘贴文本
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTriggerCombineKeys_001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let textInputA: Component = await driver.findComponent(ON.id('inputA'))
      let textInputB: Component = await driver.findComponent(ON.id('inputB'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputA != null).assertTrue()

      await textInputA.click()
      await driver.delayMs(waitUiReadyMs)
      await textInputA.inputText('123abcABC')
      await driver.delayMs(waitUiReadyMs)
      let textA: string = await textInputA.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(textA).assertEqual('123abcABC')
      await textInputA.click()
      await driver.delayMs(waitUiReadyMs)
      await driver.triggerCombineKeys(2072, 2017)
      await driver.delayMs(waitUiReadyMs)
      await driver.triggerCombineKeys(2072, 2019)
      await driver.delayMs(waitUiReadyMs)
      await textInputB.click()
      await driver.delayMs(waitUiReadyMs)
      await driver.triggerCombineKeys(2072, 2038)
      await driver.delayMs(waitUiReadyMs)
      let textInputBB = await driver.findComponent(ON.id('inputB'))
      await driver.delayMs(waitUiReadyMs)
      let textB: string = await textInputBB.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(textB).assertEqual('123abcABC')
      done();
    });

    /*
     * @tc.number    : testTriggerCombineKeysSpecialCharacters_002
     * @tc.name      : testTriggerCombineKeysSpecialCharacters_002
     * @tc.desc      : 使用组合键复制并粘贴特殊字符文本
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTriggerCombineKeysSpecialCharacters_002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)

        let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
        await textInputButton.click()
        await driver.delayMs(waitUiReadyMs)
        let textInputA: Component = await driver.findComponent(ON.id('inputA'))
        let textInputB: Component = await driver.findComponent(ON.id('inputB'))
        await driver.delayMs(waitUiReadyMs)
        expect(textInputA != null).assertTrue()

        await textInputA.click()
        await driver.delayMs(waitUiReadyMs)
        await textInputA.inputText('你好!@#$%&')
        await driver.delayMs(waitUiReadyMs)
        let textA: string = await textInputA.getText()
        await driver.delayMs(waitUiReadyMs)
        expect(textA == '你好!@#$%&').assertTrue()
        await textInputA.click()
        await driver.delayMs(waitUiReadyMs)
        await driver.triggerCombineKeys(2072, 2017)
        await driver.delayMs(waitUiReadyMs)
        await driver.triggerCombineKeys(2072, 2019)
        await driver.delayMs(waitUiReadyMs)
        await textInputB.click()
        await driver.delayMs(waitUiReadyMs)
        await driver.triggerCombineKeys(2072, 2038)
        await driver.delayMs(waitUiReadyMs)
        let textInputBB: Component = await driver.findComponent(ON.id('inputB'))
        await driver.delayMs(waitUiReadyMs)
        let textB: string = await textInputBB.getText()
        await driver.delayMs(waitUiReadyMs)
        expect(textB == '你好!@#$%&').assertTrue()
        done()
      });

    /*
     * @tc.number    : testTriggerCombineKeysError_003
     * @tc.name      : testTriggerCombineKeysError_003
     * @tc.desc      : 使用组合键并传入错误参数
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTriggerCombineKeysError_003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
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
        let textA: string = await textInputA.getText()
        await driver.delayMs(waitUiReadyMs)
        expect(textA == '123').assertTrue()
        await textInputA.click()
        await driver.delayMs(waitUiReadyMs)
        expect((await driver.triggerCombineKeys(0, 0)) == null).assertTrue()
        done()
      });

    /*
     * @tc.number    : testGetBounds_004
     * @tc.name      : testGetBounds_004
     * @tc.desc      : 获取控件边框
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetBounds_004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputButton != null).assertTrue()

      let buttonRect = await textInputButton.getBounds()
      await driver.delayMs(waitUiReadyMs)
      expect(buttonRect.left < buttonRect.right).assertTrue()
      expect(buttonRect.top < buttonRect.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testGetBoundsSmall_005
     * @tc.name      : testGetBoundsSmall_005
     * @tc.desc      : 获取极小
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetBoundsSmall_005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await driver.delayMs(waitUiReadyMs)
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)
      let smallText: Component = await driver.findComponent(ON.id('smallText'))
      await driver.delayMs(waitUiReadyMs)
      expect(smallText != null).assertTrue()

      await driver.delayMs(waitUiReadyMs)
      let textRect = await smallText.getBounds()
      await driver.delayMs(waitUiReadyMs)
      expect(textRect.left < textRect.right).assertTrue()
      expect(textRect.top < textRect.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testGetBoundsHalfImage_006
     * @tc.name      : testGetBoundsHalfImage_006
     * @tc.desc      : 获取显示不全
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetBoundsHalfImage_006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let getBoundsHalfPage: Component = await driver.findComponent(ON.text('GetBoundsHalfPage'))
      await driver.delayMs(waitUiReadyMs)
      await getBoundsHalfPage.click()
      await driver.delayMs(waitUiReadyMs)
      let clockImage: Component = await driver.findComponent(ON.id('clockImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(clockImage != null).assertTrue()

      await driver.delayMs(waitUiReadyMs)
      let imageRect = await clockImage.getBounds()
      await driver.delayMs(waitUiReadyMs)
      expect(imageRect.left < imageRect.right).assertTrue()
      expect(imageRect.top < imageRect.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testGetBoundsLarge_007
     * @tc.name      : testGetBoundsLarge_007
     * @tc.desc      : 获取超大
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetBoundsLarge_007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let getBoundsFullPage: Component = await driver.findComponent(ON.text('GetBoundsFullPage'))
      await driver.delayMs(waitUiReadyMs)
      await getBoundsFullPage.click()
      await driver.delayMs(waitUiReadyMs)
      let cameraImage: Component = await driver.findComponent(ON.id('cameraImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(cameraImage != null).assertTrue()

      await driver.delayMs(waitUiReadyMs)
      let imageRect = await cameraImage.getBounds()
      await driver.delayMs(waitUiReadyMs)
      expect(imageRect.left < imageRect.right).assertTrue()
      await driver.delayMs(waitUiReadyMs)
      expect(imageRect.top < imageRect.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPointerMatrixCreate_008
     * @tc.name      : testPointerMatrixCreate_008
     * @tc.desc      : 创建PointerMatr
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPointerMatrixCreate_008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)
      let navigationPage: Component = await driver.findComponent(ON.text('NavigationPage'))
      await driver.delayMs(waitUiReadyMs)
      expect(navigationPage != null).assertTrue()

      let pointerMatrix: PointerMatrix = PointerMatrix.create(2, 3);
      await driver.delayMs(waitUiReadyMs)
      expect(pointerMatrix != null).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPointerMatrixCreateError_009
     * @tc.name      : testPointerMatrixCreateError_009
     * @tc.desc      : 创建PointerMatrix对象时传入
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPointerMatrixCreateError_009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)
        let navigationPage: Component = await driver.findComponent(ON.text('NavigationPage'))
        await driver.delayMs(waitUiReadyMs)
        expect(navigationPage != null).assertTrue()

        try {
          let pointerMatrix: PointerMatrix = PointerMatrix.create(-999, -999);
          await driver.delayMs(waitUiReadyMs)
          expect(pointerMatrix).assertNull()
        } catch (exception) {
          hilog.info(0x0000, 'testPointerMatrixCreateError_009', '%{public}s', 'pointerMatrix create parameter error');
        }
        done()
      });

    /*
     * @tc.number    : testSetPoint_010
     * @tc.name      : testSetPoint_010
     * @tc.desc      : 设置并注入
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPoint_010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      let pointers: PointerMatrix = PointerMatrix.create(2, 2);
      pointers.setPoint(0, 0, { x: 100, y: 1100 })
      pointers.setPoint(0, 1, { x: 300, y: 800 })
      pointers.setPoint(1, 0, { x: 600, y: 300 })
      pointers.setPoint(1, 1, { x: 400, y: 600 })
      await driver.delayMs(waitUiReadyMs)
      await driver.injectMultiPointerAction(pointers)

      await driver.delayMs(waitUiReadyMs)
      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left < imageRectB.left).assertTrue()
      expect(imageRectA.top < imageRectB.top).assertTrue()
      expect(imageRectA.right > imageRectB.right).assertTrue()
      expect(imageRectA.bottom > imageRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testSetPointUnorderedSteps_011
     * @tc.name      : testSetPointUnorderedSteps_011
     * @tc.desc      : 不按照顺序设置并注入
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPointUnorderedSteps_011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      let pointers: PointerMatrix = PointerMatrix.create(2, 2);
      pointers.setPoint(0, 1, { x: 300, y: 800 })
      pointers.setPoint(0, 0, { x: 100, y: 1100 })
      pointers.setPoint(1, 1, { x: 400, y: 600 })
      pointers.setPoint(1, 0, { x: 600, y: 300 })
      await driver.delayMs(waitUiReadyMs)
      await driver.injectMultiPointerAction(pointers)

      await driver.delayMs(waitUiReadyMs)
      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left < imageRectB.left).assertTrue()
      await driver.delayMs(waitUiReadyMs)
      expect(imageRectA.top < imageRectB.top).assertTrue()
      await driver.delayMs(waitUiReadyMs)
      expect(imageRectA.right > imageRectB.right).assertTrue()
      await driver.delayMs(waitUiReadyMs)
      expect(imageRectA.bottom > imageRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testSetPointExceptionParameter_012
     * @tc.name      : testSetPointExceptionParameter_012
     * @tc.desc      : setPoint传入
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPointExceptionParameter_012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)

        let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
        await multiFingerOperationButton.click()
        await driver.delayMs(waitUiReadyMs)
        let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
        await driver.delayMs(waitUiReadyMs)
        expect(scaleImage != null).assertTrue()

        let pointers: PointerMatrix = PointerMatrix.create(2, 2);
        try {
          pointers.setPoint(-1, -1, { x: 300, y: 800 })
          pointers.setPoint(-1, -2, { x: 100, y: 1100 })
          pointers.setPoint(-2, -1, { x: 400, y: 600 })
          pointers.setPoint(-2, -2, { x: 600, y: 300 })
          await driver.delayMs(waitUiReadyMs)
        } catch (exception) {
          hilog.info(0x0000, 'testSetPointExceptionParameter_012', '%{public}s',
            'pointerMatrix setPoint parameter error');
        }
        done()
      });

    /*
     * @tc.number    : testSetPointCoincide_013
     * @tc.name      : testSetPointCoincide_013
     * @tc.desc      : 多指操作
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPointCoincide_013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerSlidingButton: Component = await driver.findComponent(ON.text('MultiFingerSlidingPage'))
      await multiFingerSlidingButton.click()
      await driver.delayMs(waitUiReadyMs)
      let column: Component = await driver.findComponent(ON.id('multiFingerSlidingColumn'))
      await driver.delayMs(waitUiReadyMs)
      expect(column != null).assertTrue()

      let pointers: PointerMatrix = PointerMatrix.create(2, 2);
      pointers.setPoint(0, 0, { x: 300, y: 1100 })
      pointers.setPoint(0, 1, { x: 300, y: 300 })
      pointers.setPoint(1, 0, { x: 300, y: 1100 })
      pointers.setPoint(1, 1, { x: 300, y: 300 })
      await driver.delayMs(waitUiReadyMs)
      await driver.injectMultiPointerAction(pointers)
      await driver.delayMs(waitUiReadyMs)

      let textComponent: Component = await driver.findComponent(ON.text('7'))
      let text: string = await textComponent.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(text).assertEqual('7')
      done()
    });

    /*
     * @tc.number    : testSetPointOut_014
     * @tc.name      : testSetPointOut_014
     * @tc.desc      : 设置从屏幕内滑动到屏幕外并注入
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPointOut_014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      let pointers: PointerMatrix = PointerMatrix.create(2, 2);
      pointers.setPoint(0, 0, { x: 100, y: 1100 })
      pointers.setPoint(0, 1, { x: 300, y: 800 })
      pointers.setPoint(1, 0, { x: 600, y: 300 })
      pointers.setPoint(1, 1, { x: 400, y: 600 })
      await driver.delayMs(waitUiReadyMs)
      await driver.injectMultiPointerAction(pointers)

      await driver.delayMs(waitUiReadyMs)
      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left < imageRectB.left).assertTrue()
      expect(imageRectA.top < imageRectB.top).assertTrue()
      expect(imageRectA.right > imageRectB.right).assertTrue()
      expect(imageRectA.bottom > imageRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchOut_015
     * @tc.name      : testPinchOut_015
     * @tc.desc      : test PinchOut
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchOut_015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchOut(1.3)
      await driver.delayMs(waitUiReadyMs)

      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left > imageRectB.left).assertTrue()
      expect(imageRectA.top > imageRectB.top).assertTrue()
      expect(imageRectA.right < imageRectB.right).assertTrue()
      expect(imageRectA.bottom < imageRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchOutExceptionParameter_016
     * @tc.name      : testPinchOutExceptionParameter_016
     * @tc.desc      : 放大接口异常传参
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchOutExceptionParameter_016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)

        let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
        await multiFingerOperationButton.click()
        await driver.delayMs(waitUiReadyMs)
        let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
        await driver.delayMs(waitUiReadyMs)
        expect(scaleImage != null).assertTrue()

        try {
          await scaleImage.pinchOut(-2)
          await driver.delayMs(waitUiReadyMs)
        } catch (exception) {
          hilog.info(0x0000, 'testPinchOutExceptionParameter_016', '%{public}s', 'pinchOut interface parameter error');
        }
        done()
      });;

    /*
     * @tc.number    : testPinchOutLessThanOne_017
     * @tc.name      : testPinchOutLessThanOne_017
     * @tc.desc      : 放大接口传入小于1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchOutLessThanOne_017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchOut(1.3)
      await driver.delayMs(waitUiReadyMs)

      await driver.delayMs(waitUiReadyMs)
      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left > imageRectB.left).assertTrue()
      expect(imageRectA.top > imageRectB.top).assertTrue()
      expect(imageRectA.right < imageRectB.right).assertTrue()
      expect(imageRectA.bottom < imageRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchOutManyTimes_018
     * @tc.name      : testPinchOutManyTimes_018
     * @tc.desc      : 放大接口多次调用
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchOutManyTimes_018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchOut(1.3)
      await driver.delayMs(waitUiReadyMs)

      await driver.delayMs(waitUiReadyMs)
      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchOut(1.3)
      await driver.delayMs(waitUiReadyMs)

      await driver.delayMs(waitUiReadyMs)
      let scaleImageC: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectC = await scaleImageC.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left > imageRectB.left && imageRectB.left > imageRectC.left).assertTrue()
      expect(imageRectA.top > imageRectB.top && imageRectB.top > imageRectC.top).assertTrue()
      expect(imageRectA.right < imageRectB.right && imageRectB.right < imageRectC.right).assertTrue()
      expect(imageRectA.bottom < imageRectB.bottom && imageRectB.bottom < imageRectC.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchOutInvalid_019
     * @tc.name      : testPinchOutInvalid_019
     * @tc.desc      : test PinchOut Invalid
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchOutInvalid_019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('NavigationPage'))
      await driver.delayMs(waitUiReadyMs)

      let buttonRectA = await multiFingerOperationButton.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await multiFingerOperationButton.pinchOut(1.3)
      await driver.delayMs(waitUiReadyMs)

      await driver.delayMs(waitUiReadyMs)
      let multiFingerOperationButtonB: Component = await driver.findComponent(ON.text('NavigationPage'))
      await driver.delayMs(waitUiReadyMs)
      let buttonRectB = await multiFingerOperationButtonB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(buttonRectA.left == buttonRectB.left).assertTrue()
      expect(buttonRectA.top == buttonRectB.top).assertTrue()
      expect(buttonRectA.right == buttonRectB.right).assertTrue()
      expect(buttonRectA.bottom == buttonRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchIn_020
     * @tc.name      : testPinchIn_020
     * @tc.desc      : test PinchIn
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchIn_020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchIn(0.6)
      await driver.delayMs(waitUiReadyMs)

      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left < imageRectB.left).assertTrue()
      expect(imageRectA.top < imageRectB.top).assertTrue()
      expect(imageRectA.right > imageRectB.right).assertTrue()
      expect(imageRectA.bottom > imageRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchInExceptionParameter_021
     * @tc.name      : testPinchInExceptionParameter_021
     * @tc.desc      : 缩小接口异常传参
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchInExceptionParameter_021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)

        let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
        await multiFingerOperationButton.click()
        await driver.delayMs(waitUiReadyMs)
        let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
        await driver.delayMs(waitUiReadyMs)
        expect(scaleImage != null).assertTrue()

        try {
          await scaleImage.pinchIn(-2)
          await driver.delayMs(waitUiReadyMs)
        } catch (exception) {
          hilog.info(0x0000, 'testPinchInExceptionParameter_021', '%{public}s', 'pinchIn interface parameter error');
        }
        done()
      });

    /*
     * @tc.number    : testPinchInGreaterThanOne_022
     * @tc.name      : testPinchInGreaterThanOne_022
     * @tc.desc      : 缩小接口传入大于1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchInGreaterThanOne_022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchIn(0.6)
      await driver.delayMs(waitUiReadyMs)

      await driver.delayMs(waitUiReadyMs)
      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left < imageRectB.left).assertTrue()
      expect(imageRectA.top < imageRectB.top).assertTrue()
      expect(imageRectA.right > imageRectB.right).assertTrue()
      expect(imageRectA.bottom > imageRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchInManyTimes_023
     * @tc.name      : testPinchInManyTimes_023
     * @tc.desc      : test PinchIn Many Times
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchInManyTimes_023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
      await multiFingerOperationButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      expect(scaleImage != null).assertTrue()

      let imageRectA = await scaleImage.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchIn(0.6)
      await driver.delayMs(waitUiReadyMs)

      let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectB = await scaleImageB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await scaleImage.pinchIn(0.6)
      await driver.delayMs(waitUiReadyMs)

      let scaleImageC: Component = await driver.findComponent(ON.id('scaleImage'))
      await driver.delayMs(waitUiReadyMs)
      let imageRectC = await scaleImageC.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(imageRectA.left < imageRectB.left && imageRectB.left < imageRectC.left).assertTrue()
      expect(imageRectA.top < imageRectB.top && imageRectB.top < imageRectC.top).assertTrue()
      expect(imageRectA.right > imageRectB.right && imageRectB.right > imageRectC.right).assertTrue()
      expect(imageRectA.bottom > imageRectB.bottom && imageRectB.bottom > imageRectC.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testPinchInInvalid_024
     * @tc.name      : testPinchInInvalid_024
     * @tc.desc      : test PinchIn Invalid
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPinchInInvalid_024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerOperationButton: Component = await driver.findComponent(ON.text('NavigationPage'))
      await driver.delayMs(waitUiReadyMs)

      let buttonRectA = await multiFingerOperationButton.getBounds()
      await driver.delayMs(waitUiReadyMs)

      await multiFingerOperationButton.pinchIn(0.1)
      await driver.delayMs(waitUiReadyMs)

      await driver.delayMs(waitUiReadyMs)
      let multiFingerOperationButtonB: Component = await driver.findComponent(ON.text('NavigationPage'))
      await driver.delayMs(waitUiReadyMs)
      let buttonRectB = await multiFingerOperationButtonB.getBounds()
      await driver.delayMs(waitUiReadyMs)

      expect(buttonRectA.left == buttonRectB.left).assertTrue()
      expect(buttonRectA.top == buttonRectB.top).assertTrue()
      expect(buttonRectA.right == buttonRectB.right).assertTrue()
      expect(buttonRectA.bottom == buttonRectB.bottom).assertTrue()
      done()
    });

    /*
     * @tc.number    : testFindcomponents_025
     * @tc.name      : testFindcomponents_025
     * @tc.desc      : 查找
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFindcomponents_025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let navigationText: Component = await driver.findComponent(ON.text('NavigationPage'))
      await driver.delayMs(waitUiReadyMs)
      expect(await navigationText.getText()).assertEqual('NavigationPage')

      let buttons = await driver.findComponents(ON.type('Button'))
      let buttonNumber: number = buttons.length
      await driver.delayMs(waitUiReadyMs)
      expect(buttonNumber > 0).assertTrue()
      done()
    });

    /*
     * @tc.number    : testFindcomponentsZero_026
     * @tc.name      : testFindcomponentsZero_026
     * @tc.desc      : 查找不存
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFindcomponentsZero_026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let navigationText: Component = await driver.findComponent(ON.text('NavigationPage'))
      await driver.delayMs(waitUiReadyMs)
      expect(await navigationText.getText()).assertEqual('NavigationPage')

      let scroll = await driver.findComponents(ON.type('Scroll'))
      await driver.delayMs(waitUiReadyMs)
      expect(scroll == null).assertTrue()
      done()
    });

    /*
     * @tc.number    : testScrollSearch_027
     * @tc.name      : testScrollSearch_027
     * @tc.desc      : scrollComponent.scrollSearch
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testScrollSearch_027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerSlidingButton: Component = await driver.findComponent(ON.text('MultiFingerSlidingPage'))
      await multiFingerSlidingButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scrollComponent: Component = await driver.findComponent(ON.type('Scroll'))
      await driver.delayMs(waitUiReadyMs)
      expect(scrollComponent != null).assertTrue()

      let numText: Component = await scrollComponent.scrollSearch(ON.text('7'))
      await driver.delayMs(waitUiReadyMs)
      expect(await numText.getText()).assertEqual('7')
      done()
    });

    /*
     * @tc.number    : testScrollSearchAbsent_028
     * @tc.name      : testScrollSearchAbsent_028
     * @tc.desc      : 滑动搜索不存
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testScrollSearchAbsent_028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let multiFingerSlidingButton: Component = await driver.findComponent(ON.text('MultiFingerSlidingPage'))
      await multiFingerSlidingButton.click()
      await driver.delayMs(waitUiReadyMs)
      let scrollComponent: Component = await driver.findComponent(ON.type('Scroll'))
      await driver.delayMs(waitUiReadyMs)
      expect(scrollComponent != null).assertTrue()

      let numText: Component = await scrollComponent.scrollSearch(ON.text('100'))
      await driver.delayMs(waitUiReadyMs)
      expect(numText == null).assertTrue()
      done()
    });

    /*
     * @tc.number    : testInjectMultiPointerAction_029
     * @tc.name      : testInjectMultiPointerAction_029
     * @tc.desc      : 注入
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testInjectMultiPointerAction_029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)

        let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
        await multiFingerOperationButton.click()
        await driver.delayMs(waitUiReadyMs)
        let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
        await driver.delayMs(waitUiReadyMs)
        expect(scaleImage != null).assertTrue()

        let imageRectA = await scaleImage.getBounds()
        await driver.delayMs(waitUiReadyMs)

        let pointers: PointerMatrix = PointerMatrix.create(2, 2);
        pointers.setPoint(0, 0, { x: 100, y: 1100 })
        pointers.setPoint(0, 1, { x: 300, y: 800 })
        pointers.setPoint(1, 0, { x: 600, y: 300 })
        pointers.setPoint(1, 1, { x: 400, y: 600 })
        await driver.delayMs(waitUiReadyMs)
        await driver.injectMultiPointerAction(pointers)

        await driver.delayMs(waitUiReadyMs)
        let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
        await driver.delayMs(waitUiReadyMs)
        let imageRectB = await scaleImageB.getBounds()
        await driver.delayMs(waitUiReadyMs)

        expect(imageRectA.left < imageRectB.left).assertTrue()
        expect(imageRectA.top < imageRectB.top).assertTrue()
        expect(imageRectA.right > imageRectB.right).assertTrue()
        expect(imageRectA.bottom > imageRectB.bottom).assertTrue()
        done()
      });

    /*
     * @tc.number    : testInjectMultiPointerActionNoOperation_030
     * @tc.name      : testInjectMultiPointerActionNoOperation_030
     * @tc.desc      : 注入多指操
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testInjectMultiPointerActionNoOperation_030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)

        let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
        await driver.delayMs(waitUiReadyMs)
        await multiFingerOperationButton.click()
        await driver.delayMs(waitUiReadyMs)
        let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
        await driver.delayMs(waitUiReadyMs)
        expect(scaleImage != null).assertTrue()

        await driver.delayMs(waitUiReadyMs)
        let pointers: PointerMatrix = PointerMatrix.create(2, 2);
        await driver.delayMs(waitUiReadyMs)

        try {
          await driver.injectMultiPointerAction(pointers)
        } catch (exception) {
          hilog.info(0x0000, 'testInjectMultiPointerActionNoOperation_030', '%{public}s',
            'pointers finger steps not set');
        }
        done()
      });

    /*
     * @tc.number    : testInjectMultiPointerActionExceptionParameter_031
     * @tc.name      : testInjectMultiPointerActionExceptionParameter_031
     * @tc.desc      : 注入多指操作
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testInjectMultiPointerActionExceptionParameter_031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        await startAbility('com.example.uitest', 'EntryAbility')
        let driver: Driver = Driver.create()
        await driver.delayMs(waitUiReadyMs)

        let multiFingerOperationButton: Component = await driver.findComponent(ON.text('MultiFingerOperationPage'))
        await driver.delayMs(waitUiReadyMs)
        await multiFingerOperationButton.click()
        await driver.delayMs(waitUiReadyMs)
        let scaleImage: Component = await driver.findComponent(ON.id('scaleImage'))
        await driver.delayMs(waitUiReadyMs)
        expect(scaleImage != null).assertTrue()

        await driver.delayMs(waitUiReadyMs)
        let imageRectA = await scaleImage.getBounds()
        await driver.delayMs(waitUiReadyMs)

        try {
          await driver.injectMultiPointerAction(null)

          await driver.delayMs(waitUiReadyMs)
          let scaleImageB: Component = await driver.findComponent(ON.id('scaleImage'))
          await driver.delayMs(waitUiReadyMs)
          let imageRectB = await scaleImageB.getBounds()
          await driver.delayMs(waitUiReadyMs)

          expect(imageRectA.left == imageRectB.left).assertTrue()
          expect(imageRectA.top == imageRectB.top).assertTrue()
          expect(imageRectA.right == imageRectB.right).assertTrue()
          expect(imageRectA.bottom == imageRectB.bottom).assertTrue()
        } catch (exception) {
          hilog.info(0x0000, 'testInjectMultiPointerActionExceptionParameter_031', '%{public}s',
            'injectMultiPointerAction parameter error');
        }
        done()
      });

    /*
     * @tc.number    : testMultiFingerRotation_032
     * @tc.name      : testMultiFingerRotation_032
     * @tc.desc      : 测试 RotatePage
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultiFingerRotation_032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let rotateButton: Component = await driver.findComponent(ON.text('RotatePage'))
      await rotateButton.click()
      await driver.delayMs(waitUiReadyMs)
      let rotateText: Component = await driver.findComponent(ON.id('rotateText'))
      let rotateTextBefore = await rotateText.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(rotateTextBefore).assertEqual('0')

      let pointers: PointerMatrix = PointerMatrix.create(2, 2);
      pointers.setPoint(0, 0, { x: 600, y: 1100 })
      pointers.setPoint(0, 1, { x: 100, y: 1100 })
      pointers.setPoint(1, 0, { x: 100, y: 200 })
      pointers.setPoint(1, 1, { x: 600, y: 200 })
      await driver.delayMs(waitUiReadyMs)
      await driver.injectMultiPointerAction(pointers)

      let rotateTextAfter: Component = await driver.findComponent(ON.id('rotateText'))
      let text = await rotateTextAfter.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(text != '0').assertTrue()
      done()
    });

    /*
     * @tc.number    : testTriggerKey_033
     * @tc.name      : testTriggerKey_033
     * @tc.desc      : 测试模拟点击按键
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTriggerKey_033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await startAbility('com.example.uitest', 'EntryAbility')
      let driver: Driver = Driver.create()
      await driver.delayMs(waitUiReadyMs)

      let textInputButton: Component = await driver.findComponent(ON.text('TextInputPage'))
      await textInputButton.click()
      await driver.delayMs(waitUiReadyMs)

      let textInputA: Component = await driver.findComponent(ON.id('inputA'))
      await driver.delayMs(waitUiReadyMs)
      expect(textInputA != null).assertTrue()

      await driver.delayMs(waitUiReadyMs)
      await textInputA.click()
      await driver.delayMs(waitUiReadyMs)
      await driver.triggerKey(2000)
      await driver.delayMs(waitUiReadyMs)

      let textInputAfter: Component = await driver.findComponent(ON.id('inputA'))
      await driver.delayMs(waitUiReadyMs)
      let inputText = await textInputAfter.getText()
      await driver.delayMs(waitUiReadyMs)
      expect(inputText).assertEqual('0')
      await driver.delayMs(waitUiReadyMs)
      done();
    });
  })
}