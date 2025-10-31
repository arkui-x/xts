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
import { describe, it, expect, afterEach, TestType, Level, Size } from '@ohos/hypium';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function ColorSpaceManagerCreateStandardTest() {
  describe('ColorSpaceManagerCreateStandardTest', () => {

    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0100
     * @tc.name  : testCreate001
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0100',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let ADOBE_RGB_1998: ColorSpaceManager.ColorSpace.ADOBE_RGB_1998 = ColorSpaceManager.ColorSpace.ADOBE_RGB_1998;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(ADOBE_RGB_1998);
        expect(value.getColorSpaceName()).assertEqual(1);
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
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0200',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let DCI_P3: ColorSpaceManager.ColorSpace.DCI_P3 = ColorSpaceManager.ColorSpace.DCI_P3;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(DCI_P3);
        expect(value.getColorSpaceName()).assertEqual(2);
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
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0300',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let DISPLAY_P3: ColorSpaceManager.ColorSpace.DISPLAY_P3 = ColorSpaceManager.ColorSpace.DISPLAY_P3;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(DISPLAY_P3);
        expect(value.getColorSpaceName()).assertEqual(3);
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0300. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0400
     * @tc.name  : testCreate004
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0400',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let SRGB: ColorSpaceManager.ColorSpace.SRGB = ColorSpaceManager.ColorSpace.SRGB;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(SRGB);
        expect(value.getColorSpaceName()).assertEqual(4);
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0400. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0500
     * @tc.name  : testCreate005
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0500',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let ADOBE_RGB_1998: ColorSpaceManager.ColorSpace.ADOBE_RGB_1998 = ColorSpaceManager.ColorSpace.ADOBE_RGB_1998;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(ADOBE_RGB_1998);
        expect(Array.isArray(value.getWhitePoint())).assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0500. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0600
     * @tc.name  : testCreate006
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0600',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let DCI_P3: ColorSpaceManager.ColorSpace.DCI_P3 = ColorSpaceManager.ColorSpace.DCI_P3;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(DCI_P3);
        expect(Array.isArray(value.getWhitePoint())).assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0600. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0700
     * @tc.name  : testCreate007
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0700',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let DISPLAY_P3: ColorSpaceManager.ColorSpace.DISPLAY_P3 = ColorSpaceManager.ColorSpace.DISPLAY_P3;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(DISPLAY_P3);
        expect(Array.isArray(value.getWhitePoint())).assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0700. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0800
     * @tc.name  : testCreate008
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0800',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let SRGB: ColorSpaceManager.ColorSpace.SRGB = ColorSpaceManager.ColorSpace.SRGB;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(SRGB);
        expect(Array.isArray(value.getWhitePoint())).assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0800. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_0900
     * @tc.name  : testCreate009
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_0900',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let ADOBE_RGB_1998: ColorSpaceManager.ColorSpace.ADOBE_RGB_1998 = ColorSpaceManager.ColorSpace.ADOBE_RGB_1998;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(ADOBE_RGB_1998);
        expect(typeof value.getGamma() === 'number').assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_0900. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_1000
     * @tc.name  : testCreate010
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_1000',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let DCI_P3: ColorSpaceManager.ColorSpace.DCI_P3 = ColorSpaceManager.ColorSpace.DCI_P3;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(DCI_P3);
        expect(typeof value.getGamma() === 'number').assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_1000. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_1100
     * @tc.name  : testCreate011
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_1100',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let DISPLAY_P3: ColorSpaceManager.ColorSpace.DISPLAY_P3 = ColorSpaceManager.ColorSpace.DISPLAY_P3;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(DISPLAY_P3);
        expect(typeof value.getGamma() === 'number').assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_Create_Func_1100. Cause: ` + JSON.stringify(err));
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_Create_Func_1200
     * @tc.name  : testCreate012
     * @tc.desc  : To test Create standard color gamut objects.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_Create_Func_1200',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let SRGB: ColorSpaceManager.ColorSpace.SRGB = ColorSpaceManager.ColorSpace.SRGB;
        let value: ColorSpaceManager.ColorSpaceManager = ColorSpaceManager.create(SRGB);
        expect(typeof value.getGamma() === 'number').assertTrue();
        done();
      } catch (err) {
        console.log(`Failed to SUB_GraphicImage_ColorSpaceManager_Create_Func_1200. Cause:${JSON.stringify(err)}`);
        expect(err.code == 18600001).assertTrue();
        done();
      }
    })
  })
}