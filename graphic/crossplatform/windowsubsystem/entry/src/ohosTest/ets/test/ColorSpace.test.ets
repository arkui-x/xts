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
import { describe, it, expect } from '@ohos/hypium';


export default function ColorSpaceTest() {
  describe('ColorSpaceTest', () => {
    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0100
     * @tc.name  : testColorSpace001
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0100', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.UNKNOWN = ColorSpaceManager.ColorSpace.UNKNOWN;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0100 :${value}`);
        expect(value).assertEqual(0);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0100 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0200
     * @tc.name  : testColorSpace002
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0200', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.ADOBE_RGB_1998 = ColorSpaceManager.ColorSpace.ADOBE_RGB_1998;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0200 :${value}`);
        expect(value).assertEqual(1);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0200 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0300
     * @tc.name  : testColorSpace003
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0300', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.DCI_P3 = ColorSpaceManager.ColorSpace.DCI_P3;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0300 :${value}`);
        expect(value).assertEqual(2);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0300 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0400
     * @tc.name  : testColorSpace004
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0400', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.DISPLAY_P3 = ColorSpaceManager.ColorSpace.DISPLAY_P3;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0400 :${value}`);
        expect(value).assertEqual(3);
        done();
      } catch (e) {
        console.log('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0400 catch error msg:${e.message} error code:${e.code}');
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0500
     * @tc.name  : testColorSpace005
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0500', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.SRGB = ColorSpaceManager.ColorSpace.SRGB;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0500 :${value}`);
        expect(value).assertEqual(4);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0500 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0600
     * @tc.name  : testColorSpace006
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0600', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.CUSTOM = ColorSpaceManager.ColorSpace.CUSTOM;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0600 :${value}`);
        expect(value).assertEqual(5);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0600 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0700
     * @tc.name  : testColorSpace007
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0700', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT709 = ColorSpaceManager.ColorSpace.BT709;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0700 :${value}`);
        expect(value).assertEqual(6);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0700 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0800
     * @tc.name  : testColorSpace008
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0800', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT601_EBU = ColorSpaceManager.ColorSpace.BT601_EBU;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0800 :${value}`);
        expect(value).assertEqual(7);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0800 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0900
     * @tc.name  : testColorSpace009
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0900', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT601_SMPTE_C = ColorSpaceManager.ColorSpace.BT601_SMPTE_C;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0900 :${value}`);
        expect(value).assertEqual(8);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_0900 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1000
     * @tc.name  : testColorSpace010
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1000', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT2020_HLG = ColorSpaceManager.ColorSpace.BT2020_HLG;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1000 :${value}`);
        expect(value).assertEqual(9);
        done();
      } catch (e) {
        console.log('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1000 catch error msg:${e.message} error code:${e.code}');
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1100
     * @tc.name  : testColorSpace011
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1100', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT2020_PQ = ColorSpaceManager.ColorSpace.BT2020_PQ;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1100 :${value}`);
        expect(value).assertEqual(10);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1100 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1200
     * @tc.name  : testColorSpace012
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1200', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.P3_HLG = ColorSpaceManager.ColorSpace.P3_HLG;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1200 :${value}`);
        expect(value).assertEqual(11);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1200 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1300
     * @tc.name  : testColorSpace013
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1300', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.P3_PQ = ColorSpaceManager.ColorSpace.P3_PQ;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1300 :${value}`);
        expect(value).assertEqual(12);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1300 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1400
     * @tc.name  : testColorSpace014
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1400', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.ADOBE_RGB_1998_LIMIT = ColorSpaceManager.ColorSpace.ADOBE_RGB_1998_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1400 :${value}`);
        expect(value).assertEqual(13);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1400 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1500
     * @tc.name  : testColorSpace015
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1500', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.DISPLAY_P3_LIMIT = ColorSpaceManager.ColorSpace.DISPLAY_P3_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1500 :${value}`);
        expect(value).assertEqual(14);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1500 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1600
     * @tc.name  : testColorSpace016
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1600', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.SRGB_LIMIT = ColorSpaceManager.ColorSpace.SRGB_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1600 :${value}`);
        expect(value).assertEqual(15);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1600 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1700
     * @tc.name  : testColorSpace017
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1700', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT709_LIMIT = ColorSpaceManager.ColorSpace.BT709_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1700 :${value}`);
        expect(value).assertEqual(16);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1700 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1800
     * @tc.name  : testColorSpace018
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1800', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT601_EBU_LIMIT = ColorSpaceManager.ColorSpace.BT601_EBU_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1800 :${value}`);
        expect(value).assertEqual(17);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1800 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1900
     * @tc.name  : testColorSpace009
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1900', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT601_SMPTE_C_LIMIT = ColorSpaceManager.ColorSpace.BT601_SMPTE_C_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1900 :${value}`);
        expect(value).assertEqual(18);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_1900 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2000
     * @tc.name  : testColorSpace020
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2000', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT2020_HLG_LIMIT = ColorSpaceManager.ColorSpace.BT2020_HLG_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2000 :${value}`);
        expect(value).assertEqual(19);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2000 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2100
     * @tc.name  : testColorSpace021
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2100', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.BT2020_PQ_LIMIT = ColorSpaceManager.ColorSpace.BT2020_PQ_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2100 :${value}`);
        expect(value).assertEqual(20);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2100 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2200
     * @tc.name  : testColorSpace022
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2200', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.P3_HLG_LIMIT = ColorSpaceManager.ColorSpace.P3_HLG_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2200 :${value}`);
        expect(value).assertEqual(21);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2200 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2300
     * @tc.name  : testColorSpace023
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2300', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.P3_PQ_LIMIT = ColorSpaceManager.ColorSpace.P3_PQ_LIMIT;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2300 :${value}`);
        expect(value).assertEqual(22);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2300 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2400
     * @tc.name  : testColorSpace024
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2400', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.LINEAR_P3 = ColorSpaceManager.ColorSpace.LINEAR_P3;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2400 :${value}`);
        expect(value).assertEqual(23);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2400 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2500
     * @tc.name  : testColorSpace025
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2500', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.LINEAR_BT709 = ColorSpaceManager.ColorSpace.LINEAR_BT709;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2500:${value}`);
        expect(value).assertEqual(24);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2500 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2600
     * @tc.name  : testColorSpace026
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2600', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.LINEAR_BT2020 = ColorSpaceManager.ColorSpace.LINEAR_BT2020;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2600 :${value}`);
        expect(value).assertEqual(25);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2600 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2700
     * @tc.name  : testColorSpace027
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2700', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.DISPLAY_SRGB = ColorSpaceManager.ColorSpace.DISPLAY_SRGB;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2700 :${value}`);
        expect(value).assertEqual(4);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2700 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2800
     * @tc.name  : testColorSpace028
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2800', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.DISPLAY_P3_SRGB = ColorSpaceManager.ColorSpace.DISPLAY_P3_SRGB;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2800 :${value}`);
        expect(value).assertEqual(3);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2800 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2900
     * @tc.name  : testColorSpace029
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2900', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.DISPLAY_P3_HLG = ColorSpaceManager.ColorSpace.DISPLAY_P3_HLG;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2900 :${value}`);
        expect(value).assertEqual(11);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_2900 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3000
     * @tc.name  : testColorSpace030
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3000', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.DISPLAY_P3_PQ = ColorSpaceManager.ColorSpace.DISPLAY_P3_PQ;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3000 :${value}`);
        expect(value).assertEqual(12);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3000 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })

    /**
     * @tc.number: SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3100
     * @tc.name  : testColorSpace031
     * @tc.desc  : To test Enumeration of color gamut types.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 2
     */
    it('SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3100', 0, async (done: Function) => {
      try {
        let value: ColorSpaceManager.ColorSpace.CUSTOM = ColorSpaceManager.ColorSpace.CUSTOM;
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3100 :${value}`);
        expect(value).assertEqual(5);
        done();
      } catch (e) {
        console.log(`SUB_GraphicImage_ColorSpaceManager_ColorSpace_Func_3100 catch error msg:${e.message} error code:${e.code}`);
        expect(e.code == 18600001).assertTrue();
        done();
      }
    })
  })
}