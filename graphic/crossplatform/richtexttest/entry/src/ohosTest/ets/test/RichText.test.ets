import { describe, it, expect, beforeAll, beforeEach, afterEach, afterAll } from '@ohos/hypium'
import { Driver, MatchPattern, ON, Component } from '@ohos.UiTest'
import { startAbility, waitUiReadyMs } from '../utils/index'

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function RichTextTest() {
  describe('RichTextTest', () => {
    /**
     * beforeAll: PreRichTextTest at the test suite level, which are executed before the test suite is executed.
     */
    beforeAll(async () => {
      console.log('SUB_BaseComponent_RichText_RichText Test start');
      await startAbility('com.example.richtexttest', 'EntryAbility');
      let driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
    });

    /**
     * beforeEach: PreRichTextbeTest at the test case level, which are executed before each test case is executed.
     */
    beforeEach(() => {
      console.info("beforeEach: Test case-level clearance conditions is executed.");
    });

    /**
     * afterEach: Test case-level clearance conditions, which are executed after each test case is executed.
     */
    afterEach(async () => {
      console.info("afterEach: Test case-level clearance conditions is executed.");
      await sleep(1000)
    });

    /**
     * afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed.
     */
    afterAll(async () => {
      await sleep(1000)
      console.log('SUB_BaseComponent_RichText_RichText Test end');
    });

    /**
     * @tc.number: SUB_BaseComponent_RichText_RichText_Component_0100
     * @tc.name  : testRichText
     * @tc.desc  : To test the Rich text component.
     * @tc.size  : MediumTest
     * @tc.type  : Component
     * @tc.level : Level 2
     */
    it('SUB_BaseComponent_RichText_RichText_Component_0100', 0, async () => {
      let driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const RICHTEXT: Component = await driver.findComponent(ON.text('下划线', MatchPattern.CONTAINS));
      const text: string = await RICHTEXT.getText();
      console.log(`SUB_BaseComponent_RichText_RichText_Component_0100 text:${text}`);
      let data: string = '<h1 style="text-align: center;">h1标题</h1>' +
        '<h1 style="text-align: center;"><i>h1斜体</i></h1>' +
        '<h1 style="text-align: center;"><u>h1下划线</u></h1>' +
        '<h2 style="text-align: center;">h2标题</h2>' +
        '<h3 style="text-align: center;">h3标题</h3>' +
        '<p style="text-align: center;">p常规</p><hr/>' +
        '<div style="width: 500px;height: 500px;border: 1px solid;margin: 0auto;">' +
        '<p style="font-size: 35px;text-align: center;font-weight: bold; color: rgb(24,78,228)">字体大小35px,行高45px</p>' +
        '<p style="background-color: rgb(229, 229, 229);line-height: 45px;font-size: 35px;text-indent: 2em;">' +
        '<p>这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字这是一段文字</p>';
      expect(text).assertEqual(data);
    })

    /**
     * @tc.number: SUB_BaseComponent_RichText_OnStart_Func_0200
     * @tc.name  : testOnStart
     * @tc.desc  : To test the Rich text OnStart event.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_BaseComponent_RichText_OnStart_Func_0200', 0, async () => {
      let driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const OnStart: Component = await driver.findComponent(ON.text('OnStart', MatchPattern.CONTAINS));
      const text: string = await OnStart.getText();
      console.log(`SUB_BaseComponent_RichText_OnStart_Func_0200 text:${text}`);
      expect(text).assertEqual('<h1 style="text-align: center;">OnStart Be triggered</h1>');
    })

    /**
     * @tc.number: SUB_BaseComponent_RichText_OnComplete_Func_0300
     * @tc.name  : testOnComplete
     * @tc.desc  : To test the Rich text OnComplete event.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_BaseComponent_RichText_OnComplete_Func_0300', 0, async () => {
      let driver: Driver = Driver.create();
      await driver.delayMs(waitUiReadyMs);
      const OnComplete: Component = await driver.findComponent(ON.text('OnComplete', MatchPattern.CONTAINS));
      const text: string = await OnComplete.getText();
      console.log(`SUB_BaseComponent_RichText_OnComplete_Func_0300 text:${text}`);
      expect(text).assertEqual('<h1 style="text-align: center;">OnComplete Be triggered</h1>');
    })
  })
}
