/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { describe, afterAll, beforeAll, afterEach, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { ON, Driver } from '@ohos.UiTest';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import hilog from '@ohos.hilog';

const DOMAIN: number = 0x0000;
const TAG: string = 'InteractionEffect';

const BUTTON_CLICK_TIMEOUT = 500;
const PAGE_LOAD_TIMEOUT = 1500;
const ABILITY_SWITCH_TIMEOUT = 2000;

const delegator = abilityDelegatorRegistry.getAbilityDelegator();
const driver = Driver.create();

async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: bundleName,
    abilityName: abilityName,
    moduleName: 'entry'
  };

  await delegator.startAbility(want).then(result => {
    hilog.info(DOMAIN, TAG, `UiTestCase, start abilityFinished: ${result}`);
  }).catch((err: object) => {
    hilog.error(DOMAIN, TAG, `UiTestCase, start abilityFailed: ${err}`);
  });
  await driver.delayMs(ABILITY_SWITCH_TIMEOUT);
}

async function clickButton(buttonId: string) {
  let button = await driver.findComponent(ON.id(buttonId));
  if (button !== undefined) {
    await button.click();
  }
  await driver.delayMs(BUTTON_CLICK_TIMEOUT);
}

async function openTestPage(pageId: string) {
  let goPage = await driver.findComponent(ON.id(pageId));
  if (goPage !== undefined) {
    await goPage.click();
  }
  await driver.delayMs(PAGE_LOAD_TIMEOUT);
  if (await driver.findComponent(ON.id("backButton")) === undefined) {
    await driver.delayMs(PAGE_LOAD_TIMEOUT);
  }
}

async function terminateTopAbility() {
  let topAbility = await delegator.getCurrentTopAbility();
  await topAbility.context.terminateSelf();
  await driver.delayMs(ABILITY_SWITCH_TIMEOUT);
}

export default function InteractionEffect() {
  describe('InteractionEffect', () => {
    beforeAll(async () => {
      await startAbility('com.example.interactioneffecttest', 'EntryAbility');
    })
    afterEach(async () => {
      let backPage = await driver.findComponent(ON.id("backButton"));
      if (backPage !== undefined) {
        await backPage.click();
      }
      await driver.delayMs(PAGE_LOAD_TIMEOUT);
    })
    afterAll(async () => {
      await terminateTopAbility();
    })

    /**
     * @tc.number ArkUIX_Web_initialScale_0100
     * @tc.name ArkUIX_Web_initialScale_0100
     * @tc.desc Test the Web component's initialScale property, set initialScale to 50%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 50%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('50');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0100 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0200
     * @tc.name ArkUIX_Web_initialScale_0200
     * @tc.desc Test the Web component's initialScale property, set initialScale to 100%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 100%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('100');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0200 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0300
     * @tc.name ArkUIX_Web_initialScale_0300
     * @tc.desc Test the Web component's initialScale property, set initialScale to 150%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 150%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('150');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0300 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0400
     * @tc.name ArkUIX_Web_initialScale_0400
     * @tc.desc Test the Web component's initialScale property, set initialScale to 200%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 200%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('200');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0400 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0500
     * @tc.name ArkUIX_Web_initialScale_0500
     * @tc.desc Test the Web component's initialScale property, set initialScale to 500%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 500%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('500');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0500 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0600
     * @tc.name ArkUIX_Web_initialScale_0600
     * @tc.desc Test the Web component's initialScale property, set initialScale to 800%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 800%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('800');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0600 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0700
     * @tc.name ArkUIX_Web_initialScale_0700
     * @tc.desc Test the Web component's initialScale property, set initialScale to 1000%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 1000%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('1000');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0700 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0800
     * @tc.name ArkUIX_Web_initialScale_0800
     * @tc.desc Test the Web component's initialScale property, set initialScale to 2000%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 2000%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('1000');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0800 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_0900
     * @tc.name ArkUIX_Web_initialScale_0900
     * @tc.desc Test the Web component's initialScale property, set initialScale to -1%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale -1%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('37');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_0900 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_1000
     * @tc.name ArkUIX_Web_initialScale_1000
     * @tc.desc Test the Web component's initialScale property, set initialScale to 0%.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 100%');
        await clickButton('adjustInitialScale 0%');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('100');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_1000 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_1100
     * @tc.name ArkUIX_Web_initialScale_1100
     * @tc.desc Test the Web component's initialScale property, set initialScale to null.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 100%');
        await clickButton('adjustInitialScale null');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('100');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_1100 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_initialScale_1200
     * @tc.name ArkUIX_Web_initialScale_1200
     * @tc.desc Test the Web component's initialScale property, set initialScale to undefined.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_initialScale_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustInitialScale 100%');
        await clickButton('adjustInitialScale undefined');
        await clickButton('getScale');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('100');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_initialScale_1200 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_overScrollMode_0100
     * @tc.name ArkUIX_Web_overScrollMode_0100
     * @tc.desc Test the Web component's overScrollMode property, set overScrollMode to ALWAYS.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     * @tc.require
     */
    it('ArkUIX_Web_overScrollMode_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustOverScrollMode ALWAYS');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('网页加载成功');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_overScrollMode_0100 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_overScrollMode_0200
     * @tc.name ArkUIX_Web_overScrollMode_0200
     * @tc.desc Test the Web component's overScrollMode property, set overScrollMode to NEVER.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_overScrollMode_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustOverScrollMode NEVER');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('网页加载成功');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_overScrollMode_0200 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_overScrollMode_0300
     * @tc.name ArkUIX_Web_overScrollMode_0300
     * @tc.desc Test the Web component's overScrollMode property, set overScrollMode to null.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_overScrollMode_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustOverScrollMode null');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('网页加载成功');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_overScrollMode_0300 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_overScrollMode_0400
     * @tc.name ArkUIX_Web_overScrollMode_0400
     * @tc.desc Test the Web component's overScrollMode property, set overScrollMode to undefined.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_overScrollMode_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustOverScrollMode undefined');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('网页加载成功');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_overScrollMode_0400 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_overScrollMode_0500
     * @tc.name ArkUIX_Web_overScrollMode_0500
     * @tc.desc Test the Web component's overScrollMode property, set overScrollMode to -10.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 4
     * @tc.require
     */
    it('ArkUIX_Web_overScrollMode_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, async () => {
      try {
        await openTestPage('goWebScaleAndOverScrollTest');
        await clickButton('adjustOverScrollMode -10');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('网页加载成功');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_overScrollMode_0500 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_nonExplicitCall_0100
     * @tc.name ArkUIX_Web_nonExplicitCall_0100
     * @tc.desc Test the Web component's initialScale and overScrollMode property, without explicitly setting.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_nonExplicitCall_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goNonExplicitTest');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('网页加载成功');
        await clickButton('getScale');
        result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('37');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_nonExplicitCall_0100 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_overScrollModeEnum_0100
     * @tc.name ArkUIX_Web_overScrollModeEnum_0100
     * @tc.desc Test the Web component's overScrollMode enum value NEVER.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_overScrollModeEnum_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goOverScrollModeTest');
        await clickButton('overScrollModeNever');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('0');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_overScrollModeEnum_0100 failed: ${error}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number ArkUIX_Web_overScrollModeEnum_0200
     * @tc.name ArkUIX_Web_overScrollModeEnum_0200
     * @tc.desc Test the Web component's overScrollMode enum value ALWAYS.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('ArkUIX_Web_overScrollModeEnum_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, async () => {
      try {
        await openTestPage('goOverScrollModeTest');
        await clickButton('overScrollModeAlways');
        let result = await driver.findComponent(ON.id('result'));
        expect(await result.getText()).assertEqual('1');
      } catch (error) {
        hilog.error(DOMAIN, TAG, `ArkUIX_Web_overScrollModeEnum_0200 failed: ${error}`);
        expect().assertFail();
      }
    });
  })
}
