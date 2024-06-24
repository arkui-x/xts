/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import { Driver, ON } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import componentUtils from '@ohos.arkui.componentUtils';

let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
const bundleName = abilityDelegatorRegistry.getArguments().bundleName;
export default function ComponentUtilsTest() {
  describe('ActsComponentUtilsTest', () => {
    beforeAll(async () => {
      const want: Want = {
        bundleName:bundleName,
        moduleName: 'entry',
        abilityName: 'EntryAbility'
      }
      await delegator.startAbility(want);
    })
    afterAll(async () => {
    })
    beforeEach(async () => {
    })
    afterEach(async () => {

    })

    /**
     * @tc.number : SUB_ComponentUtils_getRectangleById_Func_0010
     * @tc.name   : getRectangleById
     * @tc.desc   : Test getRectangleById with Image Component ID
     * @tc.level  : Level 0
     */
    it('SUB_ComponentUtils_getRectangleById_Func_0010', 0, async (done: Function) => {
      let driver = Driver.create();
      await driver.delayMs(2000);
      let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById('Test0010');
      console.info("SUB_ComponentUtils_getRectangleById_Func_0010 modePosition data is : " + JSON.stringify(modePosition));

      expect(JSON.stringify(modePosition.size)).assertEqual('{"width":200,"height":190}');
      expect(JSON.stringify(modePosition.translate)).assertEqual('{"x":10,"y":5,"z":20}');
      expect(JSON.stringify(modePosition.scale)).assertEqual('{"x":0.5,"y":1.5,"z":1,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePosition.rotate))
        .assertEqual('{"x":1,"y":1,"z":1,"angle":250,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePosition.transform)).assertEqual('[1,0,0,0,0,1,0,0,0,0,1,0,100,10,100,1]');

      await driver.delayMs(2000);
      done();
    })

    /**
     * @tc.number : SUB_ComponentUtils_getRectangleById_Func_0020
     * @tc.name   : getRectangleById
     * @tc.desc   : Test getRectangleById with Row Component ID
     * @tc.level  : Level 0
     */
    it('SUB_ComponentUtils_getRectangleById_Func_0020', 0, async (done: Function) => {
      let driver = Driver.create();
      await driver.delayMs(2000);
      let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById('Test0020');
      console.info("SUB_ComponentUtils_getRectangleById_Func_0020 modePosition data is : " + JSON.stringify(modePosition));

      expect(JSON.stringify(modePosition.size)).assertEqual('{"width":210,"height":200}');
      expect(JSON.stringify(modePosition.translate)).assertEqual('{"x":10,"y":5,"z":20}');
      expect(JSON.stringify(modePosition.scale)).assertEqual('{"x":0.5,"y":1.5,"z":1,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePosition.rotate))
        .assertEqual('{"x":1,"y":1,"z":1,"angle":250,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePosition.transform)).assertEqual('[1,0,0,0,0,1,0,0,0,0,1,0,120,15,105,1]');

      await driver.delayMs(2000);
      done();
    })

    /**
     * @tc.number : SUB_ComponentUtils_getRectangleById_Func_0030
     * @tc.name   : getRectangleById
     * @tc.desc   : Test getRectangleById with Rect Component ID
     * @tc.level  : Level 0
     */
    it('SUB_ComponentUtils_getRectangleById_Func_0030', 0, async (done: Function) => {
      let driver = Driver.create();
      await driver.delayMs(2000);
      let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById('Test0030');
      console.info("SUB_ComponentUtils_getRectangleById_Func_0030 modePosition data is : " + JSON.stringify(modePosition));

      expect(JSON.stringify(modePosition.size)).assertEqual('{"width":40,"height":50}');
      expect(JSON.stringify(modePosition.translate)).assertEqual('{"x":10,"y":5,"z":20}');
      expect(JSON.stringify(modePosition.scale)).assertEqual('{"x":0.5,"y":1.5,"z":1,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePosition.rotate))
        .assertEqual('{"x":1,"y":1,"z":1,"angle":250,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePosition.transform)).assertEqual('[1,0,0,0,0,1,0,0,0,0,1,0,130,20,110,1]');

      await driver.delayMs(2000);
      done();
    })

    /**
     * @tc.number : SUB_ComponentUtils_getRectangleById_Func_0040
     * @tc.name   : getRectangleById
     * @tc.desc   : Test getRectangleById with False Component ID
     * @tc.level  : Level 2
     */
    it('SUB_ComponentUtils_getRectangleById_Func_0040', 0, async (done: Function) => {
      let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById('123456');
      console.info("SUB_ComponentUtils_getRectangleById_Func_0040 modePosition data is : " + JSON.stringify(modePosition));

      expect(JSON.stringify(modePosition.size)).assertEqual('{"width":0,"height":0}');
      expect(JSON.stringify(modePosition.translate)).assertEqual('{"x":0,"y":0,"z":0}');
      expect(JSON.stringify(modePosition.scale)).assertEqual('{"x":0,"y":0,"z":0,"centerX":0,"centerY":0}');
      expect(JSON.stringify(modePosition.rotate))
        .assertEqual('{"x":0,"y":0,"z":0,"angle":0,"centerX":0,"centerY":0}');
      expect(JSON.stringify(modePosition.transform)).assertEqual('[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1]');

      done();
    })

    /**
     * @tc.number : SUB_ComponentUtils_getRectangleById_Func_0050
     * @tc.name   : getRectangleById
     * @tc.desc   : Test getRectangleById with null
     * @tc.level  : Level 2
     */
    it('SUB_ComponentUtils_getRectangleById_Func_0050', 0, async (done: Function) => {
      try {
        let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById(null);
        console.info("SUB_ComponentUtils_getRectangleById_Func_0050 modePosition data is : " + JSON.stringify(modePosition));
        done();
      } catch (err) {
        console.info("SUB_ComponentUtils_getRectangleById_Func_0050 modePosition err is: " + JSON.stringify(err));
        expect(JSON.stringify(err)).assertEqual('{}');
        done();
      }
    })

    /**
     * @tc.number : SUB_ComponentUtils_getRectangleById_Func_0060
     * @tc.name   : getRectangleById
     * @tc.desc   : Test getRectangleById with undefined
     * @tc.level  : Level 2
     */
    it('SUB_ComponentUtils_getRectangleById_Func_0060', 0, async (done: Function) => {
      try {
        let modePosition: componentUtils.ComponentInfo = componentUtils.getRectangleById(undefined);
        console.info("SUB_ComponentUtils_getRectangleById_Func_0060 modePosition data is : " + JSON.stringify(modePosition));
        done();
      } catch (err) {
        console.info("SUB_ComponentUtils_getRectangleById_Func_0060 modePosition err is: " + JSON.stringify(err));
        expect(JSON.stringify(err)).assertEqual('{}');
        done();
      }
    })

    /**
     * @tc.number : SUB_ComponentUtils_getRectangleById_Func_0070
     * @tc.name   : getRectangleById
     * @tc.desc   : Test getRectangleById with dynamic data scenarios
     * @tc.level  : Level 1
     */
    it('SUB_ComponentUtils_getRectangleById_Func_0070', 0, async (done: Function) => {
      let driver = Driver.create();
      await driver.delayMs(2000);
      let modePositionBefore: componentUtils.ComponentInfo = componentUtils.getRectangleById('Test0040');
      console.info("SUB_ComponentUtils_getRectangleById_Func_0070 modePosition data is : " + JSON.stringify(modePositionBefore));

      expect(JSON.stringify(modePositionBefore.size)).assertEqual('{"width":250,"height":240}');
      expect(JSON.stringify(modePositionBefore.translate)).assertEqual('{"x":10,"y":5,"z":20}');
      expect(JSON.stringify(modePositionBefore.scale)).assertEqual('{"x":1,"y":1,"z":1,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePositionBefore.rotate))
        .assertEqual('{"x":1,"y":1,"z":1,"angle":250,"centerX":50,"centerY":60}');
      expect(JSON.stringify(modePositionBefore.transform)).assertEqual('[1,0,0,0,0,1,0,0,0,0,1,0,120,10,100,1]');

      await driver.delayMs(2000);
      let button = await driver.findComponent(ON.id('BT1'));
      await button.click();
      await driver.delayMs(1000);
      let modePositionAfter: componentUtils.ComponentInfo = componentUtils.getRectangleById('Test0040');
      console.info("SUB_ComponentUtils_getRectangleById_Func_0070 modePosition data is : " + JSON.stringify(modePositionAfter));

      expect(JSON.stringify(modePositionAfter.size)).assertEqual('{"width":50,"height":50}');
      expect(JSON.stringify(modePositionAfter.translate)).assertEqual('{"x":15,"y":10,"z":25}');
      expect(JSON.stringify(modePositionAfter.scale)).assertEqual('{"x":1.5,"y":1.5,"z":1,"centerX":55,"centerY":55}');
      expect(JSON.stringify(modePositionAfter.rotate))
        .assertEqual('{"x":1.5,"y":1.5,"z":1.5,"angle":255,"centerX":55,"centerY":55}');
      expect(JSON.stringify(modePositionAfter.transform)).assertEqual('[1,0,0,0,0,1,0,0,0,0,1,0,125,15,105,1]');

      await button.click();
      await driver.delayMs(2000);
      done();
    })
  })
}