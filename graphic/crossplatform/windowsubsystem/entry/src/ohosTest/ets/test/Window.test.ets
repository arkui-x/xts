/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
import { BusinessError } from '@ohos.base';
import { describe, it, expect, afterEach, Level, Size, TestType } from '@ohos/hypium';
import { Driver, ON, Component } from '@ohos.UiTest';
import { startAbility, waitUiReadyMs, sleep } from '../utils/index';

export default function WindowTest() {
  describe('WindowTest', () => {
    afterEach(async () => {
      await sleep(500);
    });
    
    /**
     * @tc.number: SUB_GraphicImage_Window_WindowEventType_Func_0100
     * @tc.name  : testWindowEventType
     * @tc.desc  : To test Window life cycle.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_WindowEventType_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {

        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs * 3);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        if (windowClass === undefined) {
          console.info('SUB_GraphicImage_Window_WindowEventType_Func_0100. windowClass undefined');
        }

        let isToEntryAbility: boolean = false;

        windowClass.on('windowEvent', (data: number) => {
          console.info(`SUB_GraphicImage_Window_WindowEventType_Func_0100. data:${JSON.stringify(data)}`);

          if (isToEntryAbility) {
            expect(data === 1 || data === 2).assertTrue();
          } else {
            expect(data === 3 || data === 4).assertTrue();
          }

        })

        const toMainAbility: Component = await driver.findComponent(ON.id('toMainAbility'));
        isToEntryAbility = false;
        await toMainAbility.click();
        await driver.delayMs(waitUiReadyMs);
        const toEntryAbility: Component = await driver.findComponent(ON.id('toEntryAbility'));
        isToEntryAbility = true;
        await toEntryAbility.click();
        await driver.delayMs(waitUiReadyMs);
        windowClass.off('windowEvent');
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_WindowEventType_Func_0100. Cause:${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_WindowEventType_On_Func_0200
     * @tc.name  : testOn
     * @tc.desc  : To test Enable the monitoring of window life cycle changes.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_On_Func_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {

        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        if (windowClass === undefined) {
          console.info('SUB_GraphicImage_Window_On_Func_0200. windowClass undefined');
        }

        let isToEntryAbility: boolean = false;

        windowClass.on('windowEvent', (data: number) => {
          console.info(`SUB_GraphicImage_Window_On_Func_0200. data:${JSON.stringify(data)}`);

          if (isToEntryAbility) {
            expect(data === 1 || data === 2).assertTrue();
          } else {
            expect(data === 3 || data === 4).assertTrue();
          }

        })

        const toMainAbility: Component = await driver.findComponent(ON.id('toMainAbility'));
        isToEntryAbility = false;
        await toMainAbility.click();
        await driver.delayMs(waitUiReadyMs);
        const toEntryAbility: Component = await driver.findComponent(ON.id('toEntryAbility'));
        isToEntryAbility = true;
        await toEntryAbility.click();
        await driver.delayMs(waitUiReadyMs);
        windowClass.off('windowEvent');
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_On_Func_0200. Cause:${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_Off_Func_0300
     * @tc.name  : testOff
     * @tc.desc  : To test Disable the monitoring of window life cycle changes.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_Off_Func_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        let flag: Boolean = false;
        let cl1: (data: number) => void = (data: number) => {
          console.info(`SUB_GraphicImage_Window_Off_Func_0300. cl1data:${JSON.stringify(data)}`);
          flag = true;
        }
        let cl2: (data: number) => void = (data: number) => {
          console.info(`SUB_GraphicImage_Window_Off_Func_0300. cl2data:${JSON.stringify(data)}`);
          console.info(`SUB_GraphicImage_Window_Off_Func_0300. flag:${JSON.stringify(flag)}`);
          expect(flag).assertFalse();
        }
        windowClass.on('windowEvent', cl1);
        windowClass.on('windowEvent', cl2);
        windowClass.off('windowEvent', cl1);
        const toMainAbility: Component = await driver.findComponent(ON.id('toMainAbility'));
        await toMainAbility.click();
        await driver.delayMs(waitUiReadyMs);
        windowClass.off('windowEvent', cl2);
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_Off_Func_0300. Cause:${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_getWindowColorSpace_Func_0400
     * @tc.name  : testGetWindowColorSpace001
     * @tc.desc  : To test Get the current window color gamut mode.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_getWindowColorSpace_Func_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        let value: window.ColorSpace = windowClass.getWindowColorSpace();
        console.log(`getWindowColorSpace:${JSON.stringify(value)}`);
        expect(value === 0 || value === 1).assertTrue();
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_getWindowColorSpace_Func_0400. Cause:${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_0500
     * @tc.name  : testSetWindowColorSpace001
     * @tc.desc  : To test Set the current window to default color gamut mode and use callback asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        windowClass.setWindowColorSpace(window.ColorSpace.DEFAULT, (err: BusinessError) => {
          const errCode: number = err.code;
          if (errCode) {
            console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
            return;
          }
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = (windowClass as window.Window).getWindowColorSpace();
          console.log(`setWindowColorSpace:${JSON.stringify(value)}`);
          expect(value === 0).assertTrue();
        });
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_setWindowColorSpace_Func_0500. Cause:${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_0600
     * @tc.name  : testSetWindowColorSpace002
     * @tc.desc  : To test Set the current window to wide color gamut mode and use callback asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        windowClass.setWindowColorSpace(window.ColorSpace.WIDE_GAMUT, (err: BusinessError) => {
          const errCode: number = err.code;
          if (errCode) {
            console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
            return;
          }
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = (windowClass as window.Window).getWindowColorSpace();
          console.log(`setWindowColorSpace:${JSON.stringify(value)}`);
          expect(value === 1).assertTrue();
        });
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_setWindowColorSpace_Func_0600. Cause:${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_0700
     * @tc.name  : testSetWindowColorSpace003
     * @tc.desc  : To test Set the current window to default color gamut mode and use Promise asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        let promise: Promise<void> = windowClass.setWindowColorSpace(window.ColorSpace.DEFAULT);
        promise.then(() => {
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = (windowClass as window.Window).getWindowColorSpace();
          console.log(`setWindowColorSpace:${JSON.stringify(value)}`);
          expect(value === 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
        });
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_setWindowColorSpace_Func_0700. Cause:${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_0800
     * @tc.name  : testSetWindowColorSpace004
     * @tc.desc  : To test Set the current window to wide gamut mode and use Promise asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await startAbility('com.example.windowsubsystem', 'EntryAbility');
        let driver: Driver = Driver.create();
        await driver.delayMs(waitUiReadyMs);
        let windowClass: window.Window | undefined = AppStorage.get('windowEntryAbility') as window.Window;
        let promise: Promise<void> = windowClass.setWindowColorSpace(window.ColorSpace.WIDE_GAMUT);
        promise.then(() => {
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = (windowClass as window.Window).getWindowColorSpace();
          console.log(`setWindowColorSpace:${JSON.stringify(value)}`);
          expect(value === 1).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
        });
        done();
      } catch (exception) {
        console.error(`Failed to SUB_GraphicImage_Window_setWindowColorSpace_Func_0800. Cause::${JSON.stringify(exception)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_getWindowColorSpace_Func_0900
     * @tc.name  : testGetWindowColorSpace002
     * @tc.desc  : To test Get the current window color gamut mode.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_getWindowColorSpace_Func_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let windowClass: window.Window = window.findWindow("uncreatedWindow");
        let value: window.ColorSpace = windowClass.getWindowColorSpace();
        console.log(`getWindowColorSpace:${JSON.stringify(value)}`);
        expect(value === 0 || value === 1).assertTrue();
        done();
      } catch (err) {
        expect(err.code === 1300002).assertTrue();
        console.error(`Failed to SUB_GraphicImage_Window_getWindowColorSpace_Func_0900. Cause:${JSON.stringify(err)}`);
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_1000
     * @tc.name  : testSetWindowColorSpace005
     * @tc.desc  : To test Set the current window to default color gamut mode and use callback asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let windowClass: window.Window = window.findWindow("uncreatedWindow");
        windowClass.setWindowColorSpace(window.ColorSpace.DEFAULT, (err: BusinessError) => {
          const errCode: number = err.code;
          if (errCode) {
            console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
            return;
          }
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = windowClass.getWindowColorSpace();
          console.log(`setWindowColorSpace:${JSON.stringify(value)}`);
          expect(value === 0).assertTrue();
        });
        done();
      } catch (err) {
        expect(err.code === 1300002).assertTrue();
        console.error(`Failed to SUB_GraphicImage_Window_setWindowColorSpace_Func_1000. Cause:${JSON.stringify(err)}`);
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_1100
     * @tc.name  : testSetWindowColorSpace006
     * @tc.desc  : To test Set the current window to wide color gamut mode and use callback asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let windowClass: window.Window = window.findWindow("uncreatedWindow");
        windowClass.setWindowColorSpace(window.ColorSpace.WIDE_GAMUT, (err: BusinessError) => {
          const errCode: number = err.code;
          if (errCode) {
            console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
            return;
          }
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = windowClass.getWindowColorSpace();
          console.log(`setWindowColorSpace:${JSON.stringify(value)}`);
          expect(value === 1).assertTrue();
        });
        done();
      } catch (err) {
        expect(err.code === 1300002).assertTrue();
        console.error(`Failed to  SUB_GraphicImage_Window_setWindowColorSpace_Func_1100. Cause:${JSON.stringify(err)}`);
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_1200
     * @tc.name  : testSetWindowColorSpace007
     * @tc.desc  : To test Set the current window to default color gamut mode and use Promise asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let windowClass: window.Window = window.findWindow("uncreatedWindow");
        let promise: Promise<void> = windowClass.setWindowColorSpace(window.ColorSpace.DEFAULT);
        promise.then(() => {
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = windowClass.getWindowColorSpace();
          console.log(`setWindowColorSpace:${JSON.stringify(value)}`);
          expect(value === 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
        });
        done();
      } catch (err) {
        expect(err.code === 1300002).assertTrue();
        console.error(`Failed to SUB_GraphicImage_Window_setWindowColorSpace_Func_1200. Cause:${JSON.stringify(err)}`);
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_Window_setWindowColorSpace_Func_1300
     * @tc.name  : testSetWindowColorSpace008
     * @tc.desc  : To test Set the current window to wide gamut mode and use Promise asynchronous callback.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_Window_setWindowColorSpace_Func_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let windowClass: window.Window = window.findWindow("uncreatedWindow");
        let promise: Promise<void> = windowClass.setWindowColorSpace(window.ColorSpace.WIDE_GAMUT);
        promise.then(() => {
          console.info('Succeeded in setting window colorspace.');
          let value: window.ColorSpace = windowClass.getWindowColorSpace();
          console.log(`setWindowColorSpace:${value}`);
          expect(value === 1).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`Failed to set window colorspace. Cause:${JSON.stringify(err)}`);
        });
        done();
      } catch (err) {
        expect(err.code === 1300002).assertTrue();
        console.error(`Failed to SUB_GraphicImage_Window_setWindowColorSpace_Func_1300. Cause:${JSON.stringify(err)}`);
        done();
      }
    })
  })
}