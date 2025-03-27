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
import Display from '@ohos.display';
import { describe, it, expect,afterEach } from '@ohos/hypium';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function DisplayTest() {
  describe('DisplayTest', () => {
    afterEach(async () => {
      await sleep(1000)
    });

    let displayClass: Display.Display;
    try {
      displayClass = Display.getDefaultDisplaySync();
    } catch (exception) {
      console.error('Failed to obtain the default display object. Code: ' + JSON.stringify(exception));
    }

    /**
     * @tc.number: SUB_GraphicImage_display_densityDPI_Func_0100
     * @tc.name  : testDensityDPI
     * @tc.desc  : To test The screen density of the display device.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_display_densityDPI_Func_0100', 0, async (done: Function) => {
      try {
        let value: number = displayClass.densityDPI;
        console.log(`displayClass.densityDPI:${JSON.stringify(value)}`)
        expect(typeof value === 'number').assertTrue();
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_display_densityDPI_Func_0100 catch error msg:${JSON.stringify(e.message)} error code:${JSON.stringify(e.code)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_display_densityPixels_Func_0200
     * @tc.name  : testDensityPixels
     * @tc.desc  : To test Displays the logical density of the device.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_display_densityPixels_Func_0200', 0, async (done: Function) => {
      try {
        let value: number = displayClass.densityPixels;
        console.log(`displayClass.densityPixels:${JSON.stringify(value)}`);
        expect(typeof value === 'number').assertTrue();
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_display_densityPixels_Func_0200 catch error msg:${JSON.stringify(e.message)} error code:${JSON.stringify(e.code)}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_display_scaledDensity_Func_0300
     * @tc.name  : testScaledDensity
     * @tc.desc  : To test Displays the logical density of the device.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_display_scaledDensity_Func_0300', 0, async (done: Function) => {
      try {
        let value: number = displayClass.scaledDensity;
        console.log(`displayClass.scaledDensity:${JSON.stringify(value)}`);
        expect(typeof value === 'number').assertTrue();
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_display_scaledDensity_Func_0300 catch error msg:${JSON.stringify(e.message)} error code:${JSON.stringify(e.code)}`);
        expect().assertFail();
        done();
      }
    })
  })
}