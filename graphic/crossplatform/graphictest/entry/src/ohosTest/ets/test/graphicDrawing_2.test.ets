/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType, Size, Level } from '@ohos/hypium';
import image from '@ohos.multimedia.image';
import drawing from '@ohos.graphics.drawing';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import { getEnumCount } from './utils';

let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
const bundleName = abilityDelegatorRegistry.getArguments().bundleName;
function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}
export default function graphicsDrawingTest2() {
  describe('ActsComponentUtilsTest', () => {
    let pixel: image.PixelMap;
    let pixelMap: image.PixelMap;
    const DEFAULT = 0;
    const FONT_PATH = "/system/fonts/Harmon" + "yOS_Sans_Italic.ttf";
    beforeAll(async () => {
      const want: Want = {
        bundleName:bundleName,
        moduleName: 'entry',
        abilityName: 'EntryAbility'
      }
      await delegator.startAbility(want);

      const color: ArrayBuffer = new ArrayBuffer(40000); // 96为需要创建的像素buffer大小，取值为：height * width *4
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100
        }
      }
      pixel = await image.createPixelMap(color, opts);
      pixelMap = await image.createPixelMap(color, opts);
    })
    afterAll(async () => {
      await sleep(500)
    })
    beforeEach(async () => {
      await sleep(100)
    })
    afterEach(async () => {
      await sleep(1000)
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_0100
     * @tc.name      : testTypefaceArgumentsAddVariationNormal0001
     * @tc.desc      : Test for testTypefaceArgumentsAddVariationNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testTypefaceArgumentsAddVariationNormal0001', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testTypefaceArgumentsAddVariationNormal0001';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        typeFaceArgument.addVariation('wght', 100);
        console.info(msg + ' TypefaceArguments typeFaceArgument successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments typeFaceArgument errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let str = "/system/fonts/HarmonyOS_Sans_SC.ttf";
        let font = new drawing.Font();
        typeFaceArgument.addVariation('wght', 100);
        let myTypeFace = drawing.Typeface.makeFromFileWithArguments(str, typeFaceArgument);
        console.info(msg + ' makeFromFileWithArguments myTypeFace successed');
      } catch (e) {
        console.info(msg + ` makeFromFileWithArguments myTypeFace errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 1);
        console.info(msg + ' TypefaceArguments 1 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', -1);
        console.info(msg + ' TypefaceArguments -1 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments -1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 900);
        console.info(msg + ' TypefaceArguments 900 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 900 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 901);
        console.info(msg + ' TypefaceArguments 901 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 901 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 1.5);
        console.info(msg + ' TypefaceArguments 1.5 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 1.5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', -1.5);
        console.info(msg + ' TypefaceArguments -1.5 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments -1.5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('9999', 100);
        console.info(msg + ' TypefaceArguments 9999 100 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 9999 100 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('a123', 100);
        console.info(msg + ' TypefaceArguments a123 100 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments a123 100 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wdth', 100);
        console.info(msg + ' TypefaceArguments wdth 100 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments wdth 100 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wdth', 0);
        console.info(msg + ' TypefaceArguments wdth 0 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments wdth 0 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_0200
     * @tc.name      : testTypefaceArgumentsAddVariationCalls0002
     * @tc.desc      : Test for testTypefaceArgumentsAddVariationCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypefaceArgumentsAddVariationCalls0002', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypefaceArgumentsAddVariationCalls0002';

      let font = new drawing.Font();
      let typeface = font.getTypeface();
      for (let i = 0; i < 20; i++) {
        try {
          let typeFaceArgument = new drawing.TypefaceArguments();
          typeFaceArgument.addVariation('wght', Math.random() * 200)
          console.info(msg + ' addVariation successed step: ' + i);
        } catch (e) {
          console.info(msg + ` addVariation errorCode is:  ${e.code} + errormsg is: ${e.message} step: ${i}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_0300
     * @tc.name      : testTypefaceArgumentsAddVariationAbnormal0003
     * @tc.desc      : testTypefaceArgumentsAddVariationAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypefaceArgumentsAddVariationAbnormal0003', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypefaceArgumentsAddVariationAbnormal0003';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        typeFaceArgument.addVariation('wghta', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation wghta errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('wgh', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation wgh errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('√123', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation √123 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('※×√×', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation ※×√× errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('11w×', 100)
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation 11w× errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_0400
     * @tc.name      : testTypefaceArgumentsAddVariationNull0004
     * @tc.desc      : testTypefaceArgumentsAddVariationNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testTypefaceArgumentsAddVariationNull0004', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL4, () => {
      let msg = 'testTypefaceArgumentsAddVariationNull0004';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        typeFaceArgument.addVariation(null, 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation null errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        typeFaceArgument.addVariation(undefined, 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation undefined errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        typeFaceArgument.addVariation('wght', null);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation null2 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        typeFaceArgument.addVariation('wght', undefined)
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation undefined2 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_0500
     * @tc.name      : testTypeFaceGetFamilyNameNormal0005
     * @tc.desc      : Test for testTypeFaceGetFamilyNameNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTypeFaceGetFamilyNameNormal0005', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testTypeFaceGetFamilyNameNormal0005';
      try {
        let font = new drawing.Font();
        let typeface = font.getTypeface();
        typeface.getFamilyName();
        console.info(msg + ' getFamilyName successed');
      } catch (e) {
        console.info(msg + ` getFamilyName errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_0600
     * @tc.name      : testTypeFaceGetFamilyNameMultipleCalls0006
     * @tc.desc      : Test for testTypeFaceGetFamilyNameMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceGetFamilyNameMultipleCalls0006', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceGetFamilyNameMultipleCalls0006';

      let font = new drawing.Font();
      let typeface = font.getTypeface();
      for (let i = 0; i < 20; i++) {
        try {
          typeface.getFamilyName();
          console.info(msg + ' getFamilyName successed');
        } catch (e) {
          console.info(msg + ` getFamilyName errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_0700
     * @tc.name      : testTypefaceArgumentsAddVariationNull0007
     * @tc.desc      : testTypefaceArgumentsAddVariationNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testTypefaceArgumentsAddVariationNull0007', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL4, () => {
      let msg = 'testTypefaceArgumentsAddVariationNull0007';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        typeFaceArgument.addVariation(null, 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation null errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        typeFaceArgument.addVariation(undefined, 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation undefined errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        typeFaceArgument.addVariation('wght', null);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation null2 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        typeFaceArgument.addVariation('wght', undefined)
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation undefined2 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_0800
     * @tc.name      : testTypeFaceMakeFromFileMultipleCalls0008
     * @tc.desc      : testTypeFaceMakeFromFileMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromFileMultipleCalls0008', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromFileMultipleCalls0008';
      let font = new drawing.Font();

      try {
        for (let i = 0; i < 20; i += 1) {
          let str = FONT_PATH;
          const mytypeface = drawing.Typeface.makeFromFile(str);
        }

        console.info(msg + ' test succeeded.');
      } catch (e) {
        console.info(msg + ` test failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_0900
     * @tc.name      : testTypeFaceMakeFromFileAbnormal0009
     * @tc.desc      : testTypeFaceMakeFromFileAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromFileAbnormal0009', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromFileAbnormal0009';

      try {
        const mytypeface = drawing.Typeface.makeFromFile("hello_world");
        console.info(msg + ' test failed.');
      } catch (e) {
        console.info(msg + ` test succeeded, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        const mytypeface = drawing.Typeface.makeFromFile("/system/fonts/FakePath.ttf");
        console.info(msg + ' test failed.');
      } catch (e) {
        console.info(msg + ` test succeeded, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1000
     * @tc.name      : testTypeFaceMakeFromRawFileAbnormal0010
     * @tc.desc      : testTypeFaceMakeFromRawFileAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromRawFileAbnormal0010', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromRawFileAbnormal0010';
      try {
        const mytypeface:drawing.Typeface = drawing.Typeface.makeFromRawFile($rawfile('image.png'));
        console.info(msg + ' makeFromRawFile image.png success' + JSON.stringify(mytypeface));
        expect(mytypeface == null).assertTrue();
      } catch (e) {
        console.info(msg + ` makeFromRawFile image.png errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1100
     * @tc.name      : testTypeFaceMakeFromRawFileMultipleCalls0011
     * @tc.desc      : testTypeFaceMakeFromRawFileMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromRawFileMultipleCalls0011', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromRawFileMultipleCalls0011';
      try {
        for (let i = 0; i < 20; i += 1) {
          let mytypeface:drawing.Typeface = drawing.Typeface.makeFromRawFile($rawfile('HarmonyOS_Sans_Condensed.ttf'));
          console.info(msg + ' makeFromRawFile HarmonyOS_Sans_Condensed.ttf success' + JSON.stringify(mytypeface));
          expect(!!mytypeface).assertTrue();
        }
      } catch (e) {
        console.info(msg + ` makeFromRawFile HarmonyOS_Sans_Condensed.ttf errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1200
     * @tc.name      : testTypeFaceMakeFromRawFileNormal0012
     * @tc.desc      : testTypeFaceMakeFromRawFileNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromRawFileNormal0012', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromRawFileNormal0012';
      try {
        let mytypeface:drawing.Typeface = drawing.Typeface.makeFromRawFile($rawfile('HarmonyOS_Sans_Condensed.ttf'));
        console.info(msg + ' makeFromRawFile HarmonyOS_Sans_Condensed.ttf success' + JSON.stringify(mytypeface));
        expect(!!mytypeface).assertTrue();
      } catch (e) {
        console.info(msg + ` makeFromRawFile HarmonyOS_Sans_Condensed.ttf errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let mytypeface2:drawing.Typeface = drawing.Typeface.makeFromRawFile($rawfile('ttf/HarmonyOS_Sans_Condensed.ttf'));
        console.info(msg + ' makeFromRawFile ttf/HarmonyOS_Sans_Condensed.ttf success' + JSON.stringify(mytypeface2));
        expect(!!mytypeface2).assertTrue();
      } catch (e) {
        console.info(msg + ` makeFromRawFile ttf/HarmonyOS_Sans_Condensed.ttf errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1300
     * @tc.name      : testTypeFaceMakeFromRawFileNull0013
     * @tc.desc      : testTypeFaceMakeFromRawFileNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromRawFileNull0013', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromRawFileNull0013';
      try {
        drawing.Typeface.makeFromRawFile(null);
        console.info(msg + ' makeFromRawFile null success');
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` makeFromRawFile null errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        drawing.Typeface.makeFromRawFile(undefined);
        console.info(msg + ' makeFromRawFile undefined success');
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` makeFromRawFile undefined errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1400
     * @tc.name      : testTypeFaceMakeFromRawFileWithArgumentsNormal0014
     * @tc.desc      : testTypeFaceMakeFromRawFileWithArgumentsNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testTypeFaceMakeFromRawFileWithArgumentsNormal0014', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testTypeFaceMakeFromRawFileWithArgumentsNormal0014';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        let myTypeFace = drawing.Typeface.makeFromRawFileWithArguments($rawfile('HarmonyOS_Sans_Condensed.ttf'), typeFaceArgument);
        console.info(msg + ' makeFromRawFileWithArguments myTypeFace successed');
        expect(myTypeFace != null || myTypeFace != undefined).assertTrue()
      } catch (e) {
        console.info(msg + ` makeFromFileWithArguments myTypeFace errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let myTypeFace2 = drawing.Typeface.makeFromRawFileWithArguments($rawfile('ttf/HarmonyOS_Sans_Condensed.ttf'), typeFaceArgument);
        console.info(msg + ' makeFromRawFileWithArguments myTypeFace2 successed');
        expect(myTypeFace2 != null || myTypeFace2 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + ` makeFromFileWithArguments myTypeFace2 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1500
     * @tc.name      : testTypeFaceMakeFromRawFileWithArgumentsMultipleCalls0015
     * @tc.desc      : testTypeFaceMakeFromRawFileWithArgumentsMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromRawFileWithArgumentsMultipleCalls0015', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromRawFileWithArgumentsMultipleCalls0015';
      for (let i = 0; i < 20; i++) {
        try {
          let typeFaceArgument = new drawing.TypefaceArguments();
          let myTypeFace = drawing.Typeface.makeFromRawFileWithArguments($rawfile('HarmonyOS_Sans_Condensed.ttf'), typeFaceArgument)
          console.info(msg + ' makeFromRawFileWithArguments successed step: ' + i );
          expect(myTypeFace != null || myTypeFace != undefined).assertTrue()
        } catch (e) {
          console.info(msg + ` makeFromRawFileWithArguments errorCode is:  ${e.code}, errorMessage is: ${e.message} step: ${i}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1600
     * @tc.name      : testTypeFaceMakeFromRawFileWithArgumentsNull0016
     * @tc.desc      : testTypeFaceMakeFromRawFileWithArgumentsNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromRawFileWithArgumentsNull0016', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromRawFileWithArgumentsNull0016';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        let myTypeFace = drawing.Typeface.makeFromRawFileWithArguments(null, typeFaceArgument);
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace success`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        let myTypeFace2 = drawing.Typeface.makeFromRawFileWithArguments(undefined, typeFaceArgument);
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace2 success`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace2 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        let myTypeFace3 = drawing.Typeface.makeFromRawFileWithArguments($rawfile('HarmonyOS_Sans_Condensed.ttf'), null);
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace3 success`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace3 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
      try {
        let myTypeFace4 = drawing.Typeface.makeFromRawFileWithArguments($rawfile('HarmonyOS_Sans_Condensed.ttf'), undefined);
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace4 success`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` makeFromRawFileWithArguments myTypeFace4 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACE_1700
     * @tc.name      : testTypeFaceMakeFromRawFileWithArgumentsAbnormal0017
     * @tc.desc      : testTypeFaceMakeFromRawFileWithArgumentsAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypeFaceMakeFromRawFileWithArgumentsAbnormal0017', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypeFaceMakeFromRawFileWithArgumentsAbnormal0017';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        let myTypeFace = drawing.Typeface.makeFromRawFileWithArguments($rawfile('image.png'), typeFaceArgument);
        console.info(msg + ` makeFromFileWithArguments myTypeFace success`);
        expect(myTypeFace).assertEqual(undefined)
      } catch (e) {
        console.info(msg + ` makeFromFileWithArguments myTypeFace errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let myTypeFace2 = drawing.Typeface.makeFromRawFileWithArguments($r('app.boolean.apptest1'), typeFaceArgument);
        console.info(msg + ` makeFromFileWithArguments myTypeFace2 success`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` makeFromFileWithArguments mytypeface2 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401)
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1800
     * @tc.name      : testFontSetAndGetEdgingNormal0018
     * @tc.desc      : Test for testFontSetAndGetEdgingNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndGetEdgingNormal0018' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0 , () => {
      let msg = 'testFontSetAndGetEdgingNormal0018';
      let font = new drawing.Font();

      try {
        font.setEdging(drawing.FontEdging.ALIAS);
        let edging: drawing.FontEdging = font.getEdging();
        expect(edging == drawing.FontEdging.ALIAS).assertTrue();
        console.info(msg + ' setAndGetEdging successed,GetEdging:' + edging);
      } catch( e ) {
        console.info(msg + ` setAndGetEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setEdging(drawing.FontEdging.ANTI_ALIAS);
        let edging: drawing.FontEdging = font.getEdging();
        expect(edging == drawing.FontEdging.ANTI_ALIAS).assertTrue();
        console.info(msg + ' setAndGetEdging successed,GetEdging:' + edging);
      } catch( e ) {
        console.info(msg + ` setAndGetEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setEdging(drawing.FontEdging.SUBPIXEL_ANTI_ALIAS);
        let edging: drawing.FontEdging = font.getEdging();
        expect(edging == drawing.FontEdging.SUBPIXEL_ANTI_ALIAS).assertTrue();
        console.info(msg + ' setAndGetEdging successed,GetEdging:' + edging);
      } catch( e ) {
        console.info(msg + ` setAndGetEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1900
     * @tc.name      : testFontSetAndGetEdgingNull0019
     * @tc.desc      : Test for testFontSetAndGetEdgingNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetEdgingNull0019' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetEdgingNull0019';
      let font = new drawing.Font();

      try {
        font.setEdging(null);
        console.info(msg + ' setEdging succeeded');
      } catch( e ) {
        console.info(msg + ` setEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setEdging(undefined);
        console.info(msg + ' setEdging succeeded');
      } catch( e ) {
        console.info(msg + ` setEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2000
     * @tc.name      : testFontSetAndGetEdgingMultipleCalls0020
     * @tc.desc      : Test for testFontSetAndGetEdgingMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetEdgingMultipleCalls0020' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetEdgingMultipleCalls0020';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        const randomEnum = Math.floor(Math.random() * getEnumCount(drawing.FontEdging));
        try {
          font.setEdging(randomEnum);
          let edging: drawing.FontEdging = font.getEdging();
          console.info(msg + ' setAndGetEdging successed,GetEdging:' + edging);
        } catch( e ) {
          console.info(msg + ` setAndGetEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        const randomEnum = Math.floor(Math.random() * getEnumCount(drawing.FontEdging));
        try {
          font.setEdging(randomEnum);
          console.info(msg + ' setEdging successed');
        } catch( e ) {
          console.info(msg + ` setEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let edging: drawing.FontEdging = font.getEdging();
          console.info(msg + ' getEdging successed,GetEdging:' + edging);
        } catch( e ) {
          console.info(msg + ` getEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2100
     * @tc.name      : testFontSetAndGetEdgingAbnormal0021
     * @tc.desc      : Test for testFontSetAndGetEdgingAbnormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetEdgingAbnormal0021' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetEdgingAbnormal0021';
      let font = new drawing.Font();

      try {
        font.setEdging(10);
        console.info(msg + ' setEdging succeeded');
      } catch( e ) {
        console.info(msg + ` setEdging errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2200
     * @tc.name      : testFontSetAndGetHintingNormal0022
     * @tc.desc      : Test for testFontSetAndGetHintingNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndGetHintingNormal0022' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0 , () => {
      let msg = 'testFontSetAndGetHintingNormal0022';
      let font = new drawing.Font();

      try {
        font.setHinting(drawing.FontHinting.NONE);
        let hinting: drawing.FontHinting = font.getHinting();
        expect(hinting == drawing.FontHinting.NONE).assertTrue();
        console.info(msg + ' setAndGetHinting successed,getHinting:' + hinting);
      } catch( e ) {
        console.info(msg + ` setAndGetHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setHinting(drawing.FontHinting.SLIGHT);
        let hinting: drawing.FontHinting = font.getHinting();
        expect(hinting == drawing.FontHinting.SLIGHT).assertTrue();
        console.info(msg + ' setAndGetHinting successed,getHinting:' + hinting);
      } catch( e ) {
        console.info(msg + ` setAndGetHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setHinting(drawing.FontHinting.NORMAL);
        let hinting: drawing.FontHinting = font.getHinting();
        expect(hinting == drawing.FontHinting.NORMAL).assertTrue();
        console.info(msg + ' setAndGetHinting successed,getHinting:' + hinting);
      } catch( e ) {
        console.info(msg + ` setAndGetHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setHinting(drawing.FontHinting.FULL);
        let hinting: drawing.FontHinting = font.getHinting();
        expect(hinting == drawing.FontHinting.FULL).assertTrue();
        console.info(msg + ' setAndGetHinting successed,getHinting:' + hinting);
      } catch( e ) {
        console.info(msg + ` setAndGetHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2300
     * @tc.name      : testFontSetAndGetHintingNull0023
     * @tc.desc      : Test for testFontSetAndGetHintingNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetHintingNull0023' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetHintingNull0023';
      let font = new drawing.Font();

      try {
        font.setHinting(null);
        console.info(msg + ' setHinting succeeded');
      } catch( e ) {
        console.info(msg + ` setHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setHinting(undefined);
        console.info(msg + ' setHinting succeeded');
      } catch( e ) {
        console.info(msg + ` setHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2400
     * @tc.name      : testFontSetAndGetHintingMultipleCalls0024
     * @tc.desc      : Test for testFontSetAndGetHintingMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetHintingMultipleCalls0024' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetHintingMultipleCalls0024';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        const randomEnum = Math.floor(Math.random() * getEnumCount(drawing.FontHinting));
        try {
          font.setHinting(randomEnum);
          let hinting: drawing.FontHinting = font.getHinting()
          console.info(msg + ' setAndGetHinting successed,getHinting:' + hinting);
        } catch( e ) {
          console.info(msg + ` setAndGetHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        const randomEnum = Math.floor(Math.random() * getEnumCount(drawing.FontHinting));
        try {
          font.setHinting(randomEnum);
          console.info(msg + ' setHinting successed');
        } catch( e ) {
          console.info(msg + ` setHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let hinting: drawing.FontHinting = font.getHinting();
          console.info(msg + ' getHinting successed,getHinting:' + hinting);
        } catch( e ) {
          console.info(msg + ` getHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2500
     * @tc.name      : testFontSetAndGetHintingAbnormal0025
     * @tc.desc      : Test for testFontSetAndGetHintingAbnormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetHintingAbnormal0025' , TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetHintingAbnormal0025';
      let font = new drawing.Font();

      try {
        font.setHinting(10);
        console.info(msg + ' setAndGetHinting succeeded');
      } catch( e ) {
        console.info(msg + ` setAndGetHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2600
     * @tc.name      : testFontEnableSubpixelNormal0026
     * @tc.desc      : Test for testFontEnableSubpixelNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontEnableSubpixelNormal0026', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testFontEnableSubpixelNormal0026';
      let font = new drawing.Font();

      try {
        font.enableSubpixel(true);
        console.info(msg + ' enableSubpixel succeeded');
      } catch (e) {
        console.info(msg + ` enableSubpixel failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        font.enableSubpixel(false);
        console.info(msg + ' enableSubpixel succeeded');
      } catch (e) {
        console.info(msg + ` enableSubpixel failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2700
     * @tc.name      : testFontEnableSubpixelNull0027
     * @tc.desc      : Test for testFontEnableSubpixelNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontEnableSubpixelNull0027', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontEnableSubpixelNull0027';
      let font = new drawing.Font(); // Create a new Font object

      try {
        // Attempt to call enableSubpixel method with undefined
        font.enableSubpixel(undefined);
        console.info(msg + ' enableSubpixel succeeded');
      } catch (e) {
        console.info(msg + ` enableSubpixel failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        // Attempt to call enableSubpixel method with null
        font.enableSubpixel(null);
        console.info(msg + ' enableSubpixel succeeded');
      } catch (e) {
        console.info(msg + ` enableSubpixel failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2800
     * @tc.name      : testFontEnableSubpixelMultipleCalls0028
     * @tc.desc      : Test for testFontEnableSubpixelMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontEnableSubpixelMultipleCalls0028', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontEnableSubpixelMultipleCalls0028';
      let font = new drawing.Font(); // Create a new Font object

      for (let i = 0; i < 20; i++) {
        // Generate a random boolean value
        let randomBool = Math.random() < 0.5;

        try {
          // Attempt to call enableSubpixel method with a random boolean value
          font.enableSubpixel(randomBool);
          console.info(`${msg} enableSubpixel succeeded for call ${i + 1}`);
        } catch (e) {
          console.info(`${msg} enableSubpixel failed for call ${i + 1}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2900
     * @tc.name      : testFontEnableLinearMetricsNormal0029
     * @tc.desc      : Test for testFontEnableLinearMetricsNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontEnableLinearMetricsNormal0029', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testFontEnableLinearMetricsNormal0029';
      let font = new drawing.Font(); // Step 1: Create a new Font object

      try {
        // Step 2: Attempt to call enableLinearMetrics method with true
        font.enableLinearMetrics(true);
        console.info(msg + ' enableLinearMetrics succeeded');
      } catch (e) {
        console.info(msg + ` enableLinearMetrics failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        // Step 3: Attempt to call enableLinearMetrics method with false
        font.enableLinearMetrics(false);
        console.info(msg + ' enableLinearMetrics succeeded');
      } catch (e) {
        console.info(msg + ` enableLinearMetrics failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3000
     * @tc.name      : testFontEnableLinearMetricsNull0030
     * @tc.desc      : Test for testFontEnableLinearMetricsNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontEnableLinearMetricsNull0030', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontEnableLinearMetricsNull0030';
      let font = new drawing.Font(); // Create a new Font object

      try {
        // Attempt to call enableLinearMetrics method with undefined
        font.enableLinearMetrics(undefined);
        console.info(msg + ' enableLinearMetrics succeeded');
      } catch (e) {
        console.info(msg + ` enableLinearMetrics failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        // Attempt to call enableLinearMetrics method with null
        font.enableLinearMetrics(null);
        console.info(msg + ' enableLinearMetrics succeeded');
      } catch (e) {
        console.info(msg + ` enableLinearMetrics failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3100
     * @tc.name      : testFontEnableLinearMetricsMultipleCalls0031
     * @tc.desc      : Test for testFontEnableLinearMetricsMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontEnableLinearMetricsMultipleCalls0031', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontEnableLinearMetricsMultipleCalls0031';
      let font = new drawing.Font(); // Create a new Font object

      for (let i = 0; i < 20; i++) {
        // Generate a random boolean value
        let randomBool = Math.random() < 0.5;

        try {
          // Attempt to call enableLinearMetrics method with a random boolean value
          font.enableLinearMetrics(randomBool);
          console.info(`${msg} enableLinearMetrics succeeded for call ${i + 1}`);
        } catch (e) {
          console.info(`${msg} enableLinearMetrics failed for call ${i + 1}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3200
     * @tc.name      : testFontSetGetSizeNormal0032
     * @tc.desc      : Test for testFontSetGetSizeNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetGetSizeNormal0032', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testFontSetGetSizeNormal0032';
      let font = new drawing.Font(); // Create a new Font object

      try {
        // Attempt to call setSize method with 5
        font.setSize(5);
        console.info(msg + ' setSize succeeded');
      } catch (e) {
        console.info(msg + ` setSize failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        // Attempt to call getSize method
        const size = font.getSize();
        expect(size).assertEqual(5);
        console.info(msg + ' getSize succeeded');
      } catch (e) {
        console.info(msg + ` getSize failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        // Attempt to call setSize method with 0
        font.setSize(0);
        console.info(msg + ' setSize succeeded');
      } catch (e) {
        console.info(msg + ` setSize failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        // Corresponding call to getSize method
        const size = font.getSize();
        expect(size).assertEqual(0);
        console.info(msg + ' getSize succeeded');
      } catch (e) {
        console.info(msg + ` getSize failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3300
     * @tc.name      : testFontSetGetSizeNull0033
     * @tc.desc      : Test for testFontSetGetSizeNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetGetSizeNull0033', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontSetGetSizeNull0033';
      let font = new drawing.Font(); // Step 1: Create a new Font object

      try {
        // Step 2: Attempt to call setSize method with undefined
        font.setSize(undefined);
        console.info(msg + ' setSize succeeded');
      } catch (e) {
        console.info(msg + ` setSize failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        // Step 3: Attempt to call setSize method with null
        font.setSize(null);
        console.info(msg + ' setSize succeeded');
      } catch (e) {
        console.info(msg + ` setSize failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3400
     * @tc.name      : testFontSetGetSizeMultipleCalls0034
     * @tc.desc      : Test for testFontSetGetSizeMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetGetSizeMultipleCalls0034', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontSetGetSizeMultipleCalls0034';
      let font = new drawing.Font(); // Step 1: Create a new Font object

      for (let i = 0; i < 20; i++) {
        // Generate a random size value
        let randomSize = Math.floor(Math.random() * 100);

        try {
          // Step 2: Attempt to call setSize method with a random size value
          font.setSize(randomSize);
          console.info(`${msg} setSize succeeded for call ${i + 1}`);
        } catch (e) {
          console.info(`${msg} setSize failed for call ${i + 1}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }

        try {
          // Step 3: Corresponding call to getSize method
          let size = font.getSize();
          console.info(`${msg} getSize succeeded for call ${i + 1}`);
          expect(size).assertEqual(randomSize);
        } catch (e) {
          console.info(`${msg} getSize failed for call ${i + 1}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3500
     * @tc.name      : testFontSetGetSizeWhenNoSet0035
     * @tc.desc      : Test for testFontSetGetSizeWhenNoSet.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testFontSetGetSizeWhenNoSet0035', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      let msg = 'testFontSetGetSizeWhenNoSet0035';
      let font = new drawing.Font();
      try {
        font.getSize();
        console.info(msg + ' getSize successed');
      } catch (e) {
        console.info(msg + ` getSize errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3600
     * @tc.name      : testFontSetGetTypeFaceNormal0036
     * @tc.desc      : Test for testFontSetGetTypeFaceNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetGetTypeFaceNormal0036', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testFontSetGetTypeFaceNormal0036';
      let font = new drawing.Font();

      try {
        font.setTypeface(new drawing.Typeface());
        console.info(msg + ' setTypeface succeeded');
      } catch (e) {
        console.info(msg + ` setTypeface failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        font.getTypeface();
        console.info(msg + ' getTypeface succeeded');
      } catch (e) {
        console.info(msg + ` getTypeface failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      // todo: how to create a customTypeface?
      let customTypeface = new drawing.Typeface();

      try {
        font.setTypeface(customTypeface);
        console.info(msg + ' setTypeface succeeded');
      } catch (e) {
        console.info(msg + ` setTypeface failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        font.getTypeface();
        console.info(msg + ' getTypeface succeeded');
      } catch (e) {
        console.info(msg + ` getTypeface failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3700
     * @tc.name      : testFontSetGetTypeFaceNull0037
     * @tc.desc      : Test for testFontSetGetTypeFaceNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetGetTypeFaceNull0037', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontSetGetTypeFaceNull0037';
      let font = new drawing.Font();

      try {
        font.setTypeface(undefined);
        console.info(msg + ' setTypeface succeeded');
      } catch (e) {
        console.info(msg + ` setTypeface failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setTypeface(null);
        console.info(msg + ' setTypeface succeeded');
      } catch (e) {
        console.info(msg + ` setTypeface failed, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3800
     * @tc.name      : testFontSetGetTypeFaceMultipleCalls0038
     * @tc.desc      : Test for testFontSetGetTypeFaceMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetGetTypeFaceMultipleCalls0038', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontSetGetTypeFaceMultipleCalls0038';
      let font = new drawing.Font();
      for (let i = 0; i < 20; i++) {
        try {
          font.setTypeface(new drawing.Typeface());
          font.getTypeface();
          console.info(`${msg} getTypeface succeeded`);
        } catch (e) {
          console.info(`${msg} setTypeface or getTypeface failed, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3900
     * @tc.name      : testFontSetGetTypeFaceWhenNoSet0039
     * @tc.desc      : Test for testFontSetGetTypeFaceWhenNoSet.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testFontSetGetTypeFaceWhenNoSet0039', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      let msg = 'testFontSetGetTypeFaceWhenNoSet0039';
      try {
        const font = new drawing.Font();
        font.getTypeface();
        console.info(msg + ' getTypeface successed');
      } catch (e) {
        console.info(msg + ` getTypeface errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_4000
     * @tc.name      : testFontGetMetricsNormal0040
     * @tc.desc      : Test for testFontGetMetricsNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetMetricsNormal0040', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testFontGetMetricsNormal0040';
      try {
        const font = new drawing.Font();
        let metrics = font.getMetrics();
        console.info(msg + ' getMetrics successed' + JSON.stringify(metrics));
        expect(metrics.flags !== null).assertTrue();
        expect(metrics.top !== null).assertTrue();
        expect(metrics.ascent !== null).assertTrue();
        expect(metrics.descent !== null).assertTrue();
        expect(metrics.bottom !== null).assertTrue();
        expect(metrics.leading !== null).assertTrue();
        expect(metrics.avgCharWidth !== null).assertTrue();
        expect(metrics.avgCharWidth !== null).assertTrue();
        expect(metrics.xMin !== null).assertTrue();
        expect(metrics.xMax !== null).assertTrue();
        expect(metrics.xHeight !== null).assertTrue();
        expect(metrics.capHeight !== null).assertTrue();
        expect(metrics.underlineThickness !== null).assertTrue();
        expect(metrics.underlinePosition !== null).assertTrue();
        expect(metrics.strikethroughThickness !== null).assertTrue();
        expect(metrics.strikethroughPosition !== null).assertTrue();
      } catch (e) {
        console.info(msg + ` getMetrics errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_4100
     * @tc.name      : testFontGetMetricsMultipleCalls0041
     * @tc.desc      : Test for testFontGetMetricsMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontGetMetricsMultipleCalls0041', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testFontGetMetricsMultipleCalls0041';

      for (let i = 0; i < 20; i++) {
        try {
          const font = new drawing.Font();
          font.setSize(10 + i);
          const result = font.getMetrics();
          expect(!!result).assertTrue();
          console.info(`${msg} getMetrics succeeded for font ${i}`);
        } catch (e) {
          console.info(`${msg} getMetrics failed for font ${i}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_4200
     * @tc.name      : testPathResetNormal0042
     * @tc.desc      : testPathResetNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathResetNormal0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathResetNormal0042';
      try {
        let path = new drawing.Path();
        path.reset();
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_4300
     * @tc.name      : testPathResetMultipleCalls0043
     * @tc.desc      : testPathResetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathResetMultipleCalls0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathResetMultipleCalls0043';
      let path = new drawing.Path();
      try {
        for (let index = 0; index < 20; index++) {
          path.cubicTo(10, 10, 10, 10, 15, 15);
          path.reset();
        }
        path.close()
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        path.cubicTo(10, 10, 10, 10, 15, 15);
        for (let index = 0; index < 20; index++) {
          path.reset();
        }
        path.close()
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_4400
     * @tc.name      : testTypefaceArgumentsAddVariationNormal0044
     * @tc.desc      : Test for testTypefaceArgumentsAddVariationNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testTypefaceArgumentsAddVariationNormal0044', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testTypefaceArgumentsAddVariationNormal0044';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        typeFaceArgument.addVariation('wght', 100);
        console.info(msg + ' TypefaceArguments typeFaceArgument successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments typeFaceArgument errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let str = "/system/fonts/HarmonyOS_Sans_SC.ttf";
        let font = new drawing.Font();
        typeFaceArgument.addVariation('wght', 100);
        let myTypeFace = drawing.Typeface.makeFromFileWithArguments(str, typeFaceArgument);
        console.info(msg + ' makeFromFileWithArguments myTypeFace successed');
      } catch (e) {
        console.info(msg + ` makeFromFileWithArguments myTypeFace errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 1);
        console.info(msg + ' TypefaceArguments 1 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', -1);
        console.info(msg + ' TypefaceArguments -1 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments -1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 900);
        console.info(msg + ' TypefaceArguments 900 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 900 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 901);
        console.info(msg + ' TypefaceArguments 901 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 901 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', 1.5);
        console.info(msg + ' TypefaceArguments 1.5 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 1.5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wght', -1.5);
        console.info(msg + ' TypefaceArguments -1.5 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments -1.5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('9999', 100);
        console.info(msg + ' TypefaceArguments 9999 100 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments 9999 100 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('a123', 100);
        console.info(msg + ' TypefaceArguments a123 100 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments a123 100 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wdth', 100);
        console.info(msg + ' TypefaceArguments wdth 100 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments wdth 100 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        typeFaceArgument.addVariation('wdth', 0);
        console.info(msg + ' TypefaceArguments wdth 0 successed');
      } catch (e) {
        console.info(msg + ` TypefaceArguments wdth 0 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_4500
     * @tc.name      : testTypefaceArgumentsAddVariationCalls0045
     * @tc.desc      : Test for testTypefaceArgumentsAddVariationCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypefaceArgumentsAddVariationCalls0045', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypefaceArgumentsAddVariationCalls0045';

      let font = new drawing.Font();
      let typeface = font.getTypeface();
      for (let i = 0; i < 20; i++) {
        try {
          let typeFaceArgument = new drawing.TypefaceArguments();
          typeFaceArgument.addVariation('wght', Math.random() * 200)
          console.info(msg + ' addVariation successed step: ' + i);
        } catch (e) {
          console.info(msg + ` addVariation errorCode is:  ${e.code} + errormsg is: ${e.message} step: ${i}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TYPEFACEARGUMENTS_4600
     * @tc.name      : testTypefaceArgumentsAddVariationAbnormal0046
     * @tc.desc      : testTypefaceArgumentsAddVariationAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTypefaceArgumentsAddVariationAbnormal0046', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTypefaceArgumentsAddVariationAbnormal0046';
      let typeFaceArgument = new drawing.TypefaceArguments();
      try {
        typeFaceArgument.addVariation('wghta', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation wghta errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('wgh', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation wgh errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('√123', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation √123 errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('※×√×', 100);
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation ※×√× errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
      try {
        typeFaceArgument.addVariation('11w×', 100)
        expect().assertFail();
      } catch (e) {
        console.info(msg + ` addVariation 11w× errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(25900001)
      }
    })
  })
}
