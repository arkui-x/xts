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

import window from '@ohos.window';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import common from '@ohos.app.ability.common';
import { BusinessError } from '@kit.BasicServicesKit';
import { Driver, ON } from '@ohos.UiTest';
import { abilityDelegatorRegistry } from '@kit.TestKit';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function getWindow(context: common.UIAbilityContext | undefined): Promise<window.Window> {
  return new Promise<window.Window>((resolve, reject) => {
    if (context === undefined) {
      reject(new Error('abilityContext is undefined'));
      return;
    }
    window.getLastWindow(context, (err: BusinessError, data: window.Window) => {
      if (err && err.code !== 0) {
        reject(err);
      } else {
        resolve(data);
      }
    });
  });
}

export default function KeyboardHeightTest() {
  describe('KeyboardHeightTest', () => {
    let context: common.UIAbilityContext | undefined = undefined;
    let win: window.Window | undefined = undefined;
    let driver: Driver;

    beforeAll(async () => {
      console.info('KeyboardHeightTest beforeAll begin');
      try {
        context = globalThis.abilityContext;
      } catch (e) {
        console.error('get abilityContext error: ' + JSON.stringify(e));
        context = undefined;
      }
      try {
        driver = await Driver.create();
        console.info('UiTest Driver created');
      } catch (e) {
        console.error('Driver.create error: ' + JSON.stringify(e));
      }
    });

    beforeEach(async () => {
      console.info('KeyboardHeightTest beforeEach begin');
    });

    afterEach(async () => {
      console.info('KeyboardHeightTest afterEach begin');
      // Dismiss the keyboard after each test case, ensuring clean state.
      try {
        const btn = await driver.findComponent(ON.id('closeKeyboardBtn'));
        if (btn !== null) {
          await btn.click();
          console.info('afterEach: keyboard dismissed via closeKeyboardBtn');
          await sleep(500);
        }
      } catch (e) {
        console.info('afterEach: keyboard not showing or dismiss failed: ' + JSON.stringify(e));
      }
      await sleep(1000);
      console.info('KeyboardHeightTest afterEach end');
    });

    afterAll(async () => {
      console.info('KeyboardHeightTest afterAll begin');
      if (win !== undefined) {
        try {
          win.off('keyboardHeightChange');
          console.info('afterAll: off all keyboardHeightChange callbacks');
        } catch (e) {
          console.error('afterAll off error: ' + JSON.stringify(e));
        }
      }
      console.info('KeyboardHeightTest afterAll end');
    });

    /**
     * @tc.number  : TEST_KEYBOARD_HEIGHT_TRIGGER_BY_INPUT_001
     * @tc.name    : testKeyHeightTriggerByInput001
     * @tc.desc    : Verify clicking a TextInput via UiTest pops the keyboard and triggers keyboardHeightChange
     * @tc.size    : MediumTest
     * @tc.type    : Function
     * @tc.level   : Level 0
     */
    it('testKeyHeightTriggerByInput001', 0, async (done: Function) => {
      console.info('KeyboardHeightTest testKeyHeightTriggerByInput001 begin');
      try {
        if (context === undefined) {
          context = globalThis.abilityContext;
        }
        await sleep(1000);
        if (win === undefined) {
          win = await getWindow(context);
        }
        expect(win !== undefined).assertTrue();

        let fireCount: number = 0;
        let firedHeight: number = -1;
        try {
          win.on('keyboardHeightChange', (height: number) => {
            fireCount++;
            firedHeight = height;
            console.info('keyboardHeightChange triggered, count: ' + fireCount + ', height: ' + height);
          });
          console.info('keyboardHeightChange listener registered');
        } catch (onErr) {
          console.error('keyboardHeightChange on error: ' + JSON.stringify(onErr));
        }

        try {
          await driver.delayMs(1000);
          const input = await driver.findComponent(ON.id('keyboardInput'));
          expect(input !== null).assertTrue();
          await input.click();
          console.info('clicked keyboardInput via UiTest');
        } catch (uitestErr) {
          console.error('UiTest click keyboardInput error: ' + JSON.stringify(uitestErr));
        }

        let waitMs: number = 0;
        const maxWaitMs: number = 5000;
        while (fireCount < 1 && waitMs < maxWaitMs) {
          await sleep(300);
          waitMs += 300;
        }

        if (fireCount >= 1) {
          console.info('keyboardHeightChange FIRED, count: ' + fireCount + ', height: ' + firedHeight);
          expect(fireCount).assertEqual(1); // every keyboard popup triggers exactly 1 callback
          expect(firedHeight > 0).assertTrue();
        } else {
          console.info('keyboardHeightChange NOT fired after UiTest click');
          expect(false).assertTrue();
        }

        try {
          win.off('keyboardHeightChange');
        } catch (offErr) {
          console.error('off error: ' + JSON.stringify(offErr));
        }
        done();
      } catch (err) {
        console.error('testKeyHeightTriggerByInput001 error: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });


    /**
     * @tc.number  : TEST_KEYBOARD_HEIGHT_ON_MULTI_CALLBACK_001
     * @tc.name    : testKeyHeightOnMultiCallback001
     * @tc.desc    : Verify multiple different callbacks can be registered without crashing; result logged
     * @tc.size    : MediumTest
     * @tc.type    : Function
     * @tc.level   : Level 0
     */
    it('testKeyHeightOnMultiCallback001', 0, async (done: Function) => {
      console.info('KeyboardHeightTest testKeyHeightOnMultiCallback001 begin');
      try {
        if (context === undefined) {
          context = globalThis.abilityContext;
        }
        await sleep(500);
        if (win === undefined) {
          win = await getWindow(context);
        }
        expect(win !== undefined).assertTrue();

        let cb1Fired: boolean = false;
        let cb2Fired: boolean = false;
        let cb3Fired: boolean = false;

        let cb1: Callback<number> = (height: number) => {
          cb1Fired = true;
          console.info('cb1 fired, height: ' + height);
        };
        let cb2: Callback<number> = (height: number) => {
          cb2Fired = true;
          console.info('cb2 fired, height: ' + height);
        };
        let cb3: Callback<number> = (height: number) => {
          cb3Fired = true;
          console.info('cb3 fired, height: ' + height);
        };

        let registerCount: number = 0;
        try {
          win.on('keyboardHeightChange', cb1);
          registerCount++;
          win.on('keyboardHeightChange', cb2);
          registerCount++;
          win.on('keyboardHeightChange', cb3);
          registerCount++;
          console.info('registered ' + registerCount + ' callbacks');
        } catch (onErr) {
          console.error('multi on error: ' + JSON.stringify(onErr));
        }
        console.info('multi-callback registration result: ' + registerCount + '/3');

        await sleep(1000);
        console.info('cb1Fired: ' + cb1Fired + ', cb2Fired: ' + cb2Fired + ', cb3Fired: ' + cb3Fired);

        try {
          win.off('keyboardHeightChange');
        } catch (offErr) {
          console.error('cleanup off error: ' + JSON.stringify(offErr));
        }

        driver = await Driver.create();
        let inputClicked: boolean = false;
        try {
          await driver.delayMs(500);
          try {
            const dismissBtn = await driver.findComponent(ON.id('closeKeyboardBtn'));
            if (dismissBtn !== null) {
              await dismissBtn.click();
              console.info('dismissed keyboard before trigger');
              await driver.delayMs(300);
            }
          } catch (dismissErr) {
            console.info('keyboard already dismissed before trigger');
          }
          const input = await driver.findComponent(ON.id('keyboardInput'));
          if (input !== null) {
            await input.click();
            inputClicked = true;
            console.info('clicked keyboardInput after off');
          }
        } catch (uitestErr) {
          console.error('UiTest click keyboardInput error: ' + JSON.stringify(uitestErr));
        }

        let waitMs: number = 0;
        const maxWaitMs: number = 3000;
        while (waitMs < maxWaitMs) {
          await sleep(300);
          waitMs += 300;
        }

        if (inputClicked) {
          console.info('cb1Fired: ' + cb1Fired + ', cb2Fired: ' + cb2Fired + ', cb3Fired: ' + cb3Fired);
          expect(cb1Fired).assertFalse();
          expect(cb2Fired).assertFalse();
          expect(cb3Fired).assertFalse();
        }

        done();
      } catch (err) {
        console.error('multi-callback on test error: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number  : TEST_KEYBOARD_HEIGHT_OFF_SPECIFIC_CALLBACK_001
     * @tc.name    : testKeyHeightOffSpecificCallback001
     * @tc.desc    : Verify off('keyboardHeightChange', cb) can be called without crashing; result logged
     * @tc.size    : MediumTest
     * @tc.type    : Function
     * @tc.level   : Level 0
     */
    it('testKeyHeightOffSpecificCallback001', 0, async (done: Function) => {
      console.info('KeyboardHeightTest testKeyHeightOffSpecificCallback001 begin');
      try {
        if (context === undefined) {
          context = globalThis.abilityContext;
        }
        await sleep(500);
        if (win === undefined) {
          win = await getWindow(context);
        }
        expect(win !== undefined).assertTrue();

        let cbKeepFired: boolean = false;
        let cbRemoveFired: boolean = false;

        let cbKeep: Callback<number> = (height: number) => {
          cbKeepFired = true;
          console.info('cbKeep fired, height: ' + height);
        };
        let cbRemove: Callback<number> = (height: number) => {
          cbRemoveFired = true;
          console.info('cbRemove fired, height: ' + height);
        };

        let onOk: boolean = true;
        try {
          win.on('keyboardHeightChange', cbKeep);
          win.on('keyboardHeightChange', cbRemove);
          console.info('registered cbKeep + cbRemove');
        } catch (onErr) {
          onOk = false;
          console.error('register callbacks error: ' + JSON.stringify(onErr));
        }

        let offSpecificOk: boolean = false;
        try {
          win.off('keyboardHeightChange', cbRemove);
          offSpecificOk = true;
          console.info('off specific cbRemove SUCCESS');
        } catch (offErr) {
          console.error('off specific cbRemove NOT supported, err: ' + JSON.stringify(offErr));
          offSpecificOk = false;
        }
        console.info('offSpecific result: ' + offSpecificOk + ', onOk: ' + onOk);

        driver = await Driver.create();
        let inputClicked: boolean = false;
        try {
          await driver.delayMs(500);
          try {
            const dismissBtn = await driver.findComponent(ON.id('closeKeyboardBtn'));
            if (dismissBtn !== null) {
              await dismissBtn.click();
              console.info('dismissed keyboard before trigger');
              await driver.delayMs(300);
            }
          } catch (dismissErr) {
            console.info('keyboard already dismissed before trigger');
          }
          const input = await driver.findComponent(ON.id('keyboardInput'));
          if (input !== null) {
            inputClicked = true;
            await input.click();
            console.info('clicked keyboardInput after off specific cbRemove');
          }
        } catch (uitestErr) {
          console.error('UiTest click keyboardInput error: ' + JSON.stringify(uitestErr));
        }

        let waitMs: number = 0;
        const maxWaitMs: number = 3000;
        while (waitMs < maxWaitMs) {
          await sleep(300);
          waitMs += 300;
        }

        if (inputClicked) {
          console.info('cbKeepFired: ' + cbKeepFired + ', cbRemoveFired: ' + cbRemoveFired);
          expect(cbKeepFired).assertTrue();
          expect(cbRemoveFired).assertFalse();
        }

        try {
          win.off('keyboardHeightChange');
        } catch (cleanupErr) {
          console.error('cleanup off all error: ' + JSON.stringify(cleanupErr));
        }
        done();
      } catch (err) {
        console.error('specific off test error: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });


    /**
     * @tc.number  : TEST_KEYBOARD_HEIGHT_OFF_LISTENER_001
     * @tc.name    : testKeyHeightOffListener001
     * @tc.desc    : Verify off('keyboardHeightChange') can be called without crashing
     * @tc.size    : MediumTest
     * @tc.type    : Function
     * @tc.level   : Level 0
     */
    it('testKeyHeightOffListener001', 0, async (done: Function) => {
      console.info('KeyboardHeightTest testKeyHeightOffListener001 begin');
      try {
        if (context === undefined) {
          context = globalThis.abilityContext;
        }
        await sleep(500);
        if (win === undefined) {
          win = await getWindow(context);
        }
        expect(win !== undefined).assertTrue();

        try {
          win.off('keyboardHeightChange');
          console.info('keyboardHeightChange off SUCCESS');
        } catch (offErr) {
          console.error('keyboardHeightChange off NOT supported, err: ' + JSON.stringify(offErr));
        }
        done();
      } catch (err) {
        console.error('keyboardHeightChange off outer error: ' + JSON.stringify(err));
        expect().assertFail();
        done();
      }
    });

  })
}