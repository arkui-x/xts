import hilog from '@ohos.hilog';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import colorSpaceManager from '@ohos.graphics.colorSpaceManager';

export default function abilityTest() {
  describe('ActsAbilityTest',() => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.

    it('assertContain',0, () => {
      // // Defines a test case. This API supports three parameters: test case name, filter parameter, and test case function.
      // hilog.info(0x0000, 'testTag', '%{public}s', 'it begin');
      // let a = 'abc'
      // let b = 'b'
      // Defines a variety of assertion methods, which are used to declare expected boolean conditions.
      expect(colorSpaceManager.ColorSpace.UNKNOWN).assertEqual(0)
      expect(colorSpaceManager.ColorSpace.ADOBE_RGB_1998).assertEqual(1)
      // expect(a).assertEqual(a)
    })
    it('assertContain2',0, () => {
      // // Defines a test case. This API supports three parameters: test case name, filter parameter, and test case function.
      // hilog.info(0x0000, 'testTag', '%{public}s', 'it begin');
      // let a = 'abc'
      // let b = 'b'
      // Defines a variety of assertion methods, which are used to declare expected boolean conditions.
      expect(colorSpaceManager.ColorSpace.UNKNOWN).assertEqual(0)
      expect(colorSpaceManager.ColorSpace.ADOBE_RGB_1998).assertEqual(1)
      // expect(a).assertEqual(a)
    })
  })
}