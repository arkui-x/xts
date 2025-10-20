/*
 * Copyright (c) 2025 Shenzhen Kaihong Digital Industry Development Co., Ltd.
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

import {
  afterAll,
  afterEach,
  beforeAll,
  beforeEach,
  describe,
  expect,
  it,
  TestType,
  Size,
  Level
} from '@ohos/hypium';
import drawing from '@ohos.graphics.drawing';
import { getEnumCount } from './utils';
import buffer from '@ohos.buffer';

export default function fontPart2Test() {
  describe('DrawingTsFontPart2Test', () => {
    const DEFAULT = 0;
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async () => {
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0100
     * @tc.name      : testFontCountTextTextNormal0001
     * @tc.desc      : Test for testFontCountTextTextNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontCountTextTextNormal0001' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontCountTextTextNormal0001';
      let font = new drawing.Font();

      try {
        let resultNumber: number = font.countText('ABCDE');
        expect(resultNumber == 5).assertTrue();
        console.info(msg + ' countTextText successed,resultNumber correct');
      } catch( e ) {
        console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        let resultNumber: number = font.countText('你好');
        expect(resultNumber == 2).assertTrue();
        console.info(msg + ' countTextText successed,resultNumber correct');
      } catch( e ) {
        console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        let resultNumber: number = font.countText('！@#￥2223@##');
        expect(resultNumber == 11).assertTrue();
        console.info(msg + ' countTextText successed,resultNumber correct');
      } catch( e ) {
        console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        let resultNumber: number = font.countText('魑魅魍魉');
        expect(resultNumber == 4).assertTrue();
        console.info(msg + ' countTextText successed,resultNumber correct');
      } catch( e ) {
        console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        let resultNumber: number = font.countText('');
        expect(resultNumber == 0).assertTrue();
        console.info(msg + ' countTextText successed,resultNumber correct');
      } catch( e ) {
        console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0200
     * @tc.name      : testFontCountTextTextNull0002
     * @tc.desc      : Test for testFontCountTextTextNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontCountTextTextNull0002' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontCountTextTextNull0002';
      let font = new drawing.Font();

      try {
        font.countText(null);
        console.info(msg + ' countTextText succeeded');
      } catch( e ) {
        console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.countText(undefined);
        console.info(msg + ' countTextText succeeded');
      } catch( e ) {
        console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0300
     * @tc.name      : testFontCountTextTextMultipleCalls0003
     * @tc.desc      : Test for testFontCountTextTextMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontCountTextTextMultipleCalls0003' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontCountTextTextMultipleCalls0003';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let resultNumber: number = font.countText('ABCDE');
          expect(resultNumber == 5).assertTrue();
          console.info(msg + ' countTextText successed,resultNumber correct');
        } catch( e ) {
          console.info(msg + ` countTextText errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0400
     * @tc.name      : testFontSetAndGetEdgingNormal0004
     * @tc.desc      : Test for testFontSetAndGetEdgingNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndGetEdgingNormal0004' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontSetAndGetEdgingNormal0004';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0500
     * @tc.name      : testFontSetAndGetEdgingNull0005
     * @tc.desc      : Test for testFontSetAndGetEdgingNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetEdgingNull0005' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetEdgingNull0005';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0600
     * @tc.name      : testFontSetAndGetEdgingMultipleCalls0006
     * @tc.desc      : Test for testFontSetAndGetEdgingMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetEdgingMultipleCalls0006' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetEdgingMultipleCalls0006';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0700
     * @tc.name      : testFontSetAndGetEdgingAbnormal0007
     * @tc.desc      : Test for testFontSetAndGetEdgingAbnormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetEdgingAbnormal0007' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetEdgingAbnormal0007';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0800
     * @tc.name      : testFontSetAndGetHintingNormal0008
     * @tc.desc      : Test for testFontSetAndGetHintingNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndGetHintingNormal0008' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontSetAndGetHintingNormal0008';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_0900
     * @tc.name      : testFontSetAndGetHintingNull0009
     * @tc.desc      : Test for testFontSetAndGetHintingNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetHintingNull0009' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetHintingNull0009';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1000
     * @tc.name      : testFontSetAndGetHintingMultipleCalls0010
     * @tc.desc      : Test for testFontSetAndGetHintingMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetHintingMultipleCalls0010' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetHintingMultipleCalls0010';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1100
     * @tc.name      : testFontSetAndGetHintingAbnormal0011
     * @tc.desc      : Test for testFontSetAndGetHintingAbnormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetHintingAbnormal0011' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetHintingAbnormal0011';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1200
     * @tc.name      : testFontSetAndGetScaleXNormal0012
     * @tc.desc      : Test for testFontSetAndGetScaleXNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndGetScaleXNormal0012' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontSetAndGetScaleXNormal0012';
      let font = new drawing.Font();

      try {
        font.setScaleX(2);
        let scaleX: number = font.getScaleX();
        expect(scaleX == 2).assertTrue();
        console.info(msg + ' setAndGetScaleX successed,getScaleX:' + scaleX);
      } catch( e ) {
        console.info(msg + ` setAndGetScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setScaleX(0.5);
        let scaleX: number = font.getScaleX();
        expect(scaleX == 0.5).assertTrue();
        console.info(msg + ' setAndGetScaleX successed,getScaleX:' + scaleX);
      } catch( e ) {
        console.info(msg + ` setAndGetScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setScaleX(0);
        let scaleX: number = font.getScaleX();
        expect(scaleX == 0).assertTrue();
        console.info(msg + ' setAndGetScaleX successed,getScaleX:' + scaleX);
      } catch( e ) {
        console.info(msg + ` setAndGetScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setScaleX(-1);
        let scaleX: number = font.getScaleX();
        expect(scaleX == -1).assertTrue();
        console.info(msg + ' setAndGetScaleX successed,getScaleX:' + scaleX);
      } catch( e ) {
        console.info(msg + ` setAndGetScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1300
     * @tc.name      : testFontSetAndGetScaleXNull0013
     * @tc.desc      : Test for testFontSetAndGetScaleXNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetScaleXNull0013' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetScaleXNull0013';
      let font = new drawing.Font();

      try {
        font.setScaleX(null);
        console.info(msg + ' setAndGetScaleX succeeded');
      } catch( e ) {
        console.info(msg + ` setAndGetScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setScaleX(undefined);
        console.info(msg + ' setAndGetScaleX succeeded');
      } catch( e ) {
        console.info(msg + ` setAndGetScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1400
     * @tc.name      : testFontSetAndGetScaleXMultipleCalls0014
     * @tc.desc      : Test for testFontSetAndGetScaleXMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetScaleXMultipleCalls0014' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetScaleXMultipleCalls0014';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          font.setScaleX(Math.random() * Number.MAX_VALUE);
          let scaleX: number = font.getScaleX();
          console.info(msg + ' setAndGetScaleX successed,getScaleX:' + scaleX);
        } catch( e ) {
          console.info(msg + ` setAndGetScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          font.setScaleX(Math.random() * Number.MAX_VALUE);
          console.info(msg + ' setScaleX successed');
        } catch( e ) {
          console.info(msg + ` setScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let scaleX: number = font.getScaleX();
          console.info(msg + ' getScaleX successed,getScaleX:' + scaleX);
        } catch( e ) {
          console.info(msg + ` getScaleX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1500
     * @tc.name      : testFontSetAndGetSkewXNormal0015
     * @tc.desc      : Test for testFontSetAndGetSkewXNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndGetSkewXNormal0015' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontSetAndGetSkewXNormal0015';
      let font = new drawing.Font();

      try {
        font.setSkewX(2);
        let skewX: number = font.getSkewX();
        expect(skewX == 2).assertTrue();
        console.info(msg + ' setAndGetSkewX successed,getSkewX:' + skewX);
      } catch( e ) {
        console.info(msg + ` setAndGetSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setSkewX(0.5);
        let skewX: number = font.getSkewX();
        expect(skewX == 0.5).assertTrue();
        console.info(msg + ' setAndGetSkewX successed,getSkewX:' + skewX);
      } catch( e ) {
        console.info(msg + ` setAndGetSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setSkewX(0);
        let skewX: number = font.getSkewX();
        expect(skewX == 0).assertTrue();
        console.info(msg + ' setAndGetSkewX successed,getSkewX:' + skewX);
      } catch( e ) {
        console.info(msg + ` setAndGetSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setSkewX(- 1);
        let skewX: number = font.getSkewX();
        expect(skewX == -1).assertTrue();
        console.info(msg + ' setAndGetSkewX successed,getSkewX:' + skewX);
      } catch( e ) {
        console.info(msg + ` setAndGetSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1600
     * @tc.name      : testFontSetAndGetSkewXNull0016
     * @tc.desc      : Test for testFontSetAndGetSkewXNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetSkewXNull0016' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetSkewXNull0016';
      let font = new drawing.Font();

      try {
        font.setSkewX(null);
        console.info(msg + ' setAndGetSkewX succeeded');
      } catch( e ) {
        console.info(msg + ` setAndGetSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setSkewX(undefined);
        console.info(msg + ' setAndGetSkewX succeeded');
      } catch( e ) {
        console.info(msg + ` setAndGetSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1700
     * @tc.name      : testFontSetAndGetSkewXMultipleCalls0017
     * @tc.desc      : Test for testFontSetAndGetSkewXMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndGetSkewXMultipleCalls0017' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndGetSkewXMultipleCalls0017';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          font.setSkewX(Math.random() * Number.MAX_VALUE);
          let skewX: number = font.getSkewX();
          console.info(msg + ' setAndGetSkewX successed,getSkewX:' + skewX);
        } catch( e ) {
          console.info(msg + ` setAndGetSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          font.setSkewX(Math.random() * Number.MAX_VALUE);
          console.info(msg + ' setSkewX successed');
        } catch( e ) {
          console.info(msg + ` setSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let skewX: number = font.getSkewX();
          console.info(msg + ' getSkewX successed,getSkewX:' + skewX);
        } catch( e ) {
          console.info(msg + ` getSkewX errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1800
     * @tc.name      : testFontIsSubpixelNormal0018
     * @tc.desc      : Test for testFontIsSubpixelNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontIsSubpixelNormal0018' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontIsSubpixelNormal0018';
      let font = new drawing.Font();

      try {
        font.enableSubpixel(true);
        let subpixel: boolean = font.isSubpixel();
        expect(subpixel == true).assertTrue();
        console.info(msg + ' enableSubpixel successed,isSubpixel:' + subpixel);
      } catch( e ) {
        console.info(msg + ` enableSubpixel errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.enableSubpixel(false);
        let subpixel: boolean = font.isSubpixel();
        expect(subpixel == false).assertTrue();
        console.info(msg + ' enableSubpixel successed,isSubpixel:' + subpixel);
      } catch( e ) {
        console.info(msg + ` enableSubpixel errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_1900
     * @tc.name      : testFontIsSubpixelMultipleCalls0019
     * @tc.desc      : Test for testFontIsSubpixelMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontIsSubpixelMultipleCalls0019' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontIsSubpixelMultipleCalls0019';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let subpixel: boolean = font.isSubpixel();
          expect(subpixel == false).assertTrue();
          console.info(msg + ' isSubpixel successed,isSubpixel:' + subpixel);
        } catch( e ) {
          console.info(msg + ` isSubpixel errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2000
     * @tc.name      : testFontIsLinearMetricsNormal0020
     * @tc.desc      : Test for testFontIsLinearMetricsNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontIsLinearMetricsNormal0020' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontIsLinearMetricsNormal0020';
      let font = new drawing.Font();

      try {
        font.enableLinearMetrics(true);
        let linearMetrics: boolean = font.isLinearMetrics();
        expect(linearMetrics == true).assertTrue();
        console.info(msg + ' enableLinearMetrics successed,isSubpixel:' + linearMetrics);
      } catch( e ) {
        console.info(msg + ` enableLinearMetrics errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.enableLinearMetrics(false);
        let linearMetrics: boolean = font.isLinearMetrics();
        expect(linearMetrics == false).assertTrue();
        console.info(msg + ' enableLinearMetrics successed,isSubpixel:' + linearMetrics);
      } catch( e ) {
        console.info(msg + ` enableLinearMetrics errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2100
     * @tc.name      : testFontIsLinearMetricsMultipleCalls0021
     * @tc.desc      : Test for testFontIsLinearMetricsMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontIsLinearMetricsMultipleCalls0021' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontIsLinearMetricsMultipleCalls0021';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let linearMetrics: boolean = font.isLinearMetrics();
          expect(linearMetrics == false).assertTrue();
          console.info(msg + ' isLinearMetrics successed,linearMetrics:' + linearMetrics);
        } catch( e ) {
          console.info(msg + ` isLinearMetrics errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2200
     * @tc.name      : testFontIsEmboldenNormal0022
     * @tc.desc      : Test for testFontIsEmboldenNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontIsEmboldenNormal0022' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontIsEmboldenNormal0022';
      let font = new drawing.Font();

      try {
        font.enableEmbolden(true);
        let embolden: boolean = font.isEmbolden();
        expect(embolden == true).assertTrue();
        console.info(msg + ' enableEmbolden successed,embolden:' + embolden);
      } catch( e ) {
        console.info(msg + ` enableEmbolden errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.enableEmbolden(false);
        let embolden: boolean = font.isEmbolden();
        expect(embolden == false).assertTrue();
        console.info(msg + ' enableEmbolden successed,embolden:' + embolden);
      } catch( e ) {
        console.info(msg + ` enableEmbolden errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2300
     * @tc.name      : testFontIsEmboldenMultipleCalls0023
     * @tc.desc      : Test for testFontIsEmboldenMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontIsEmboldenMultipleCalls0023' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontIsEmboldenMultipleCalls0023';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let embolden: boolean = font.isEmbolden();
          expect(embolden == false).assertTrue();
          console.info(msg + ' isEmbolden successed,embolden:' + embolden);
        } catch( e ) {
          console.info(msg + ` isEmbolden errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2400
     * @tc.name      : testFontGetTextPath0024
     * @tc.desc      : Test for testFontGetTextPathParameterError4
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0024' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath0024';
      let font = new drawing.Font();
      let myString: string = "Hello, TypeScript!";
      try {
        font.getTextPath(myString, buffer.from(myString).length, 0, null);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }

      try {
        font.getTextPath(myString, buffer.from(myString).length, 0, undefined);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2500
     * @tc.name      : testFontMeasureSingleCharacterNull0025
     * @tc.desc      : Test for testFontMeasureSingleCharacterNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontMeasureSingleCharacterNull0025' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontMeasureSingleCharacterNull0025';
      let font = new drawing.Font();

      try {
        font.measureSingleCharacter(null);
        console.info(msg + ' measureSingleCharacter succeeded');
      } catch( e ) {
        console.info(msg + ` measureSingleCharacter errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.measureSingleCharacter(undefined);
        console.info(msg + ' measureSingleCharacter succeeded');
      } catch( e ) {
        console.info(msg + ` measureSingleCharacter errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2600
     * @tc.name      : testFontMeasureSingleCharacterMultipleCalls0026
     * @tc.desc      : Test for testFontMeasureSingleCharacterMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontMeasureSingleCharacterMultipleCalls0026' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontMeasureSingleCharacterMultipleCalls0026';
      let font = new drawing.Font();
      const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

      for ( let i = 0 ; i < 20 ; i ++ ) {
        const randomString = characters.charAt(Math.floor(Math.random()*characters.length));
        try {
          let width: number = font.measureSingleCharacter(randomString)
          console.info(msg + ' measureSingleCharacter successed,width:' + width);
        } catch( e ) {
          console.info(msg + ` measureSingleCharacter errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2700
     * @tc.name      : testFontMeasureSingleCharacterAbnormal0027
     * @tc.desc      : Test for testFontMeasureSingleCharacterAbnormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontMeasureSingleCharacterAbnormal0027' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontMeasureSingleCharacterAbnormal0027';
      let font = new drawing.Font();

      try {
        let width = font.measureSingleCharacter("");
        console.info(msg + ' measureSingleCharacter successed,width:' + width);
      } catch( e ) {
        console.info(msg + ` measureSingleCharacter errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        let width = font.measureSingleCharacter("abdcdefg");
        console.info(msg + ' measureSingleCharacter successed,width:' + width);
      } catch( e ) {
        console.info(msg + ` measureSingleCharacter errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2800
     * @tc.name      : testFontSetAndIsBaselineSnapNormal0028
     * @tc.desc      : Test for testFontSetAndIsBaselineSnapNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndIsBaselineSnapNormal0028' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontSetAndIsBaselineSnapNormal0028';
      let font = new drawing.Font();

      try {
        let baselineSnap: boolean = font.isBaselineSnap();
        expect(baselineSnap == true).assertTrue();
        console.info(msg + ' setAndIsBaselineSnap successed,baselineSnap:' + baselineSnap);
      } catch( e ) {
        console.info(msg + ` setAndIsBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setBaselineSnap(true);
        let baselineSnap: boolean = font.isBaselineSnap();
        expect(baselineSnap == true).assertTrue();
        console.info(msg + ' setAndIsBaselineSnap successed,baselineSnap:' + baselineSnap);
      } catch( e ) {
        console.info(msg + ` setAndIsBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setBaselineSnap(false);
        let baselineSnap: boolean = font.isBaselineSnap();
        expect(baselineSnap == false).assertTrue();
        console.info(msg + ' setAndIsBaselineSnap successed,baselineSnap:' + baselineSnap);
      } catch( e ) {
        console.info(msg + ` setAndIsBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_2900
     * @tc.name      : testFontSetAndIsBaselineSnapNull0029
     * @tc.desc      : Test for testFontSetAndIsBaselineSnapNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsBaselineSnapNull0029' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndIsBaselineSnapNull0029';
      let font = new drawing.Font();

      try {
        font.setBaselineSnap(null);
        console.info(msg + ' setAndIsBaselineSnap successed');
      } catch( e ) {
        console.info(msg + ` setAndIsBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setBaselineSnap(undefined);
        console.info(msg + ' setAndIsBaselineSnap succeeded');
      } catch( e ) {
        console.info(msg + ` setAndIsBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3000
     * @tc.name      : testFontSetAndIsBaselineSnapMultipleCalls0030
     * @tc.desc      : Test for testFontSetAndIsBaselineSnapMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsBaselineSnapMultipleCalls0030' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndIsBaselineSnapMultipleCalls0030';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          const randomBoolean = Math.random() < 0.5;
          font.setBaselineSnap(randomBoolean);
          let baselineSnap: boolean = font.isBaselineSnap();
          console.info(msg + ' setAndIsBaselineSnap successed,baselineSnap:' + baselineSnap);
        } catch( e ) {
          console.info(msg + ` setAndIsBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          const randomBoolean = Math.random() < 0.5;
          font.setBaselineSnap(randomBoolean);
          console.info(msg + ' setBaselineSnap successed');
        } catch( e ) {
          console.info(msg + ` setBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let baselineSnap: boolean = font.isBaselineSnap();
          console.info(msg + ' isBaselineSnap successed,baselineSnap:' + baselineSnap);
        } catch( e ) {
          console.info(msg + ` isBaselineSnap errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3100
     * @tc.name      : testFontSetAndIsForceAutoHintingNormal0031
     * @tc.desc      : Test for testFontSetAndIsForceAutoHintingNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndIsForceAutoHintingNormal0031' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontSetAndIsForceAutoHintingNormal0031';
      let font = new drawing.Font();

      try {
        let forceAutoHinting: boolean = font.isForceAutoHinting();
        expect(forceAutoHinting == false).assertTrue();
        console.info(msg + ' SetAndIsForceAutoHinting successed,isForceAutoHinting:' + forceAutoHinting);
      } catch( e ) {
        console.info(msg + ` SetAndIsForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setForceAutoHinting(true);
        let forceAutoHinting: boolean = font.isForceAutoHinting();
        expect(forceAutoHinting == true).assertTrue();
        console.info(msg + ' SetAndIsForceAutoHinting successed,isForceAutoHinting:' + forceAutoHinting);
      } catch( e ) {
        console.info(msg + ` SetAndIsForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setForceAutoHinting(false);
        let forceAutoHinting: boolean = font.isForceAutoHinting();
        expect(forceAutoHinting == false).assertTrue();
        console.info(msg + ' SetAndIsForceAutoHinting successed,isForceAutoHinting:' + forceAutoHinting);
      } catch( e ) {
        console.info(msg + ` SetAndIsForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3200
     * @tc.name      : testFontSetAndIsForceAutoHintingNull0032
     * @tc.desc      : Test for testFontSetAndIsForceAutoHintingNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsForceAutoHintingNull0032' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndIsForceAutoHintingNull0032';
      let font = new drawing.Font();

      try {
        font.setForceAutoHinting(null);
        console.info(msg + ' setForceAutoHinting successed');
      } catch( e ) {
        console.info(msg + ` setForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setForceAutoHinting(undefined);
        console.info(msg + ' setForceAutoHinting succeeded');
      } catch( e ) {
        console.info(msg + ` setForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3300
     * @tc.name      : testFontSetAndIsForceAutoHintingMultipleCalls0033
     * @tc.desc      : Test for testFontSetAndIsForceAutoHintingMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsForceAutoHintingMultipleCalls0033' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndIsForceAutoHintingMultipleCalls0033';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          const randomBoolean = Math.random() < 0.5;
          font.setForceAutoHinting(randomBoolean);
          let forceAutoHinting: boolean = font.isForceAutoHinting();
          console.info(msg + ' setAndIsForceAutoHinting successed,forceAutoHinting:' + forceAutoHinting);
        } catch( e ) {
          console.info(msg + ` setAndIsForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          const randomBoolean = Math.random() < 0.5;
          font.setForceAutoHinting(randomBoolean);
          console.info(msg + ' setForceAutoHinting successed');
        } catch( e ) {
          console.info(msg + ` setForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let forceAutoHinting: boolean = font.isForceAutoHinting();
          console.info(msg + ' isForceAutoHinting successed,forceAutoHinting:' + forceAutoHinting);
        } catch( e ) {
          console.info(msg + ` isForceAutoHinting errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3400
     * @tc.name      : testFontSetAndIsEmbeddedBitmapsNormal0034
     * @tc.desc      : Test for testFontSetAndIsEmbeddedBitmapsNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontSetAndIsEmbeddedBitmapsNormal0034' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontSetAndIsEmbeddedBitmapsNormal0034';
      let font = new drawing.Font();

      try {
        let embeddedBitmaps: boolean = font.isEmbeddedBitmaps();
        expect(embeddedBitmaps == false).assertTrue();
        console.info(msg + ' isEmbeddedBitmaps successed');
      } catch( e ) {
        console.info(msg + ` isEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setEmbeddedBitmaps(true);
        let embeddedBitmaps: boolean = font.isEmbeddedBitmaps();
        expect(embeddedBitmaps == true).assertTrue();
        console.info(msg + ' setAndIsEmbeddedBitmaps successed,embeddedBitmaps:' + embeddedBitmaps);
      } catch( e ) {
        console.info(msg + ` setAndIsEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }

      try {
        font.setEmbeddedBitmaps(false);
        let embeddedBitmaps: boolean = font.isEmbeddedBitmaps();
        expect(embeddedBitmaps == false).assertTrue();
        console.info(msg + ' setAndIsEmbeddedBitmaps successed,embeddedBitmaps:' + embeddedBitmaps);
      } catch( e ) {
        console.info(msg + ` setAndIsEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3500
     * @tc.name      : testFontSetAndIsEmbeddedBitmapsNull0035
     * @tc.desc      : Test for testFontSetAndIsEmbeddedBitmapsNull.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsEmbeddedBitmapsNull0035' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndIsEmbeddedBitmapsNull0035';
      let font = new drawing.Font();

      try {
        font.setEmbeddedBitmaps(null);
        console.info(msg + ' setEmbeddedBitmaps successed');
      } catch( e ) {
        console.info(msg + ` setEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }

      try {
        font.setEmbeddedBitmaps(undefined);
        console.info(msg + ' setEmbeddedBitmaps succeeded');
      } catch( e ) {
        console.info(msg + ` setEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3600
     * @tc.name      : testFontSetAndIsEmbeddedBitmapsMultipleCalls0036
     * @tc.desc      : Test for testFontSetAndIsEmbeddedBitmapsMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testFontSetAndIsEmbeddedBitmapsMultipleCalls0036' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3 , () => {
      let msg = 'testFontSetAndIsEmbeddedBitmapsMultipleCalls0036';
      let font = new drawing.Font();

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          const randomBoolean = Math.random() < 0.5;
          font.setEmbeddedBitmaps(randomBoolean);
          let embeddedBitmaps: boolean = font.isEmbeddedBitmaps();
          console.info(msg + ' setAndIsEmbeddedBitmaps successed,embeddedBitmaps:' + embeddedBitmaps);
        } catch( e ) {
          console.info(msg + ` setAndIsEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          const randomBoolean = Math.random() < 0.5;
          font.setEmbeddedBitmaps(randomBoolean);
          console.info(msg + ' setEmbeddedBitmaps successed');
        } catch( e ) {
          console.info(msg + ` setEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }

      for ( let i = 0 ; i < 20 ; i ++ ) {
        try {
          let embeddedBitmaps: boolean = font.isEmbeddedBitmaps();
          console.info(msg + ' isEmbeddedBitmaps successed,embeddedBitmaps:' + embeddedBitmaps);
        } catch( e ) {
          console.info(msg + ` isEmbeddedBitmaps errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3700
     * @tc.name      : testFontGetTextPath0037
     * @tc.desc      : Test for testFontGetTextPathForCharacterNormal1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0037' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath0037';
      let font = new drawing.Font();
      let myString: string = "Hello, TypeScript!";
      let path: drawing.Path | null = null;
      try {
        path = font.getTextPath(myString, buffer.from(myString).length, 0, 200);
        expect(path).not().assertNull();
        expect(path.getLength(false)).assertLarger(0);
        console.info(msg + ' getTextPath successed');
      } catch(e) {
        console.info(msg + ' getTextPath failed');
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3800
     * @tc.name      : testFontGetTextPath0038
     * @tc.desc      : Test for testFontGetTextPathForCharacterNormal2
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0038' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath0038';
      let font = new drawing.Font();
      try {
        let myString: string = " ";
        let path = font.getTextPath(myString, buffer.from(myString).length, 0, 200);
        expect(path).not().assertNull();
        expect(path.getLength(false) == 0).assertTrue();
        console.info(msg + ' GetTextPath successed,path length:' + path.getLength(false));
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_3900
     * @tc.name      : testFontGetTextPath0039
     * @tc.desc      : Test for testFontGetTextPathForCharacterNormal3
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0039' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath3900';
      let font = new drawing.Font();
      try {
        let myString: string = "Hello, TypeScript!";
        let path = font.getTextPath(myString, buffer.from(myString).length, -1, -1);
        expect(path).not().assertNull();
        console.info(msg + ' GetTextPath successed');
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_4000
     * @tc.name      : testFontGetTextPath0040
     * @tc.desc      : Test for testFontGetTextPathForCharacterNormal4
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0040' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath0040';
      let font = new drawing.Font();
      let flag = false
      try {
        let myString: string = "Hello, TypeScript!";
        let path = font.getTextPath(myString, buffer.from(myString).length, 0, 200);
        if(path.getLength(false) >= 0){
          flag = true
        }
        expect(path).not().assertNull();
        expect(flag).assertEqual(true);
        console.info(msg + ' GetTextPath successed');
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_4100
     * @tc.name      : testFontGetTextPath0041
     * @tc.desc      : Test for testFontGetTextPathParameterError1
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0041' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath0041';
      let font = new drawing.Font();
      let myString: string = "Hello, TypeScript!";
      try {
        font.getTextPath(null, buffer.from(myString).length, -1, -1);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }

      try {
        font.getTextPath(undefined, buffer.from(myString).length, -1, -1);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_4200
     * @tc.name      : testFontGetTextPath0042
     * @tc.desc      : Test for testFontGetTextPathParameterError2
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0042' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath0042';
      let font = new drawing.Font();
      let myString: string = "Hello, TypeScript!";
      try {
        font.getTextPath(myString, null, -1, -1);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }

      try {
        font.getTextPath(myString, undefined, -1, -1);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_FONT_4300
     * @tc.name      : testFontGetTextPath0043
     * @tc.desc      : Test for testFontGetTextPathParameterError3
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFontGetTextPath0043' , TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0 , () => {
      let msg = 'testFontGetTextPath0043';
      let font = new drawing.Font();
      let myString: string = "Hello, TypeScript!";
      try {
        font.getTextPath(myString, buffer.from(myString).length, null, -1);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }

      try {
        font.getTextPath(myString, buffer.from(myString).length, undefined, -1);
        expect().assertFail();
      } catch( e ) {
        console.info(msg + ` GetTextPath errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().not().assertFail();
      }
    })
  })
}