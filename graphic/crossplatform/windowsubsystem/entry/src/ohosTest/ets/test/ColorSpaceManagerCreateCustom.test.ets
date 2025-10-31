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
import ColorSpaceManager from '@ohos.graphics.colorSpaceManager';
import { describe, it, expect, afterEach, Level, TestType, Size } from '@ohos/hypium';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function ColorSpaceManagerCreateCustomTest() {
  describe('ColorSpaceManagerCreateCustomTest', () => {
    afterEach(async () => {
      await sleep(500);
    });

    let primaries: ColorSpaceManager.ColorSpacePrimaries = {
      redX: 0.1,
      redY: 0.1,
      greenX: 0.2,
      greenY: 0.2,
      blueX: 0.3,
      blueY: 0.3,
      whitePointX: 0.4,
      whitePointY: 0.4
    };
    let gamma: number = 2.2;

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0100
     * @tc.name  : testCreate001
     * @tc.desc  : To test Create a user-defined color gamut object
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(primaries, gamma);
        expect(value.getColorSpaceName()).assertEqual(5);
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0100. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0200
     * @tc.name  : testCreate002
     * @tc.desc  : To test Create a user-defined color gamut object.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(primaries, gamma);
        expect(Array.isArray(value.getWhitePoint())).assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0200. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0300
     * @tc.name  : testCreate003
     * @tc.desc  : To test Create a user-defined color gamut object.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(primaries, gamma);
        expect(typeof value.getGamma() === 'number').assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0300. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })
  })
}