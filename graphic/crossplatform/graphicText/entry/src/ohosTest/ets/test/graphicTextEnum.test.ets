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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from "@ohos/hypium"
import image from "@ohos.multimedia.image"
import text from "@ohos.graphics.text"


function sleep(time: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, time);
  });
}

export default function graphicTextEnum() {
  describe('graphic_text_enum_test', ()=> {
    console.log('describe graphic_text_enum_test start!!!')

    let pixel:image.PixelMap;
    beforeAll(async ()=> {
      const color: ArrayBuffer = new ArrayBuffer(40000); // 40000为需要创建的像素buffer大小，取值为：height * width *4
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100//100为创建的PixelMap的宽高
        }
      }
      pixel = await image.createPixelMap(color, opts);
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_RectWidthStyle_Enum_0100
     * @tc.name      : SUB_ARKUIX_GraphicText_RectWidthStyle_Enum_0100
     * @tc.desc      : To test the enum value of RectWidthStyle.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_ARKUIX_GraphicText_RectWidthStyle_Enum_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_RectWidthStyle_Enum_0100"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.RectWidthStyle.TIGHT);
        expect(1).assertEqual(text.RectWidthStyle.MAX);
      } catch (err) {
        console.info(msg + 'test enum value of RectWidthStyle error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_RectHeightStyle_Enum_0200
     * @tc.name      : SUB_ARKUIX_GraphicText_RectHeightStyle_Enum_0200
     * @tc.desc      : To test the enum value of RectHeightStyle.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_ARKUIX_GraphicText_RectHeightStyle_Enum_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_RectHeightStyle_Enum_0200"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.RectHeightStyle.TIGHT);
        expect(1).assertEqual(text.RectHeightStyle.MAX);
        expect(2).assertEqual(text.RectHeightStyle.INCLUDE_LINE_SPACE_MIDDLE);
        expect(3).assertEqual(text.RectHeightStyle.INCLUDE_LINE_SPACE_TOP);
        expect(4).assertEqual(text.RectHeightStyle.INCLUDE_LINE_SPACE_BOTTOM);
        expect(5).assertEqual(text.RectHeightStyle.STRUT);
      } catch (err) {
        console.info(msg + 'test enum value of RectHeightStyle error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Affinity_Enum_0300
     * @tc.name      : SUB_ARKUIX_GraphicText_Affinity_Enum_0300
     * @tc.desc      : To test the enum value of Affinity.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_Affinity_Enum_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_Affinity_Enum_0300"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.Affinity.UPSTREAM);
        expect(1).assertEqual(text.Affinity.DOWNSTREAM);
      } catch (err) {
        console.info(msg + 'test enum value of Affinity error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextAlign_Enum_0400
     * @tc.name      : SUB_ARKUIX_GraphicText_TextAlign_Enum_0400
     * @tc.desc      : To test the enum value of TextAlign.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('SUB_ARKUIX_GraphicText_TextAlign_Enum_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextAlign_Enum_0400"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.TextAlign.LEFT);
        expect(1).assertEqual(text.TextAlign.RIGHT);
        expect(2).assertEqual(text.TextAlign.CENTER);
        expect(3).assertEqual(text.TextAlign.JUSTIFY);
        expect(4).assertEqual(text.TextAlign.START);
        expect(5).assertEqual(text.TextAlign.END);
      } catch (err) {
        console.info(msg + 'test enum value of TextAlign error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextDirection_Enum_0500
     * @tc.name      : SUB_ARKUIX_GraphicText_TextDirection_Enum_0500
     * @tc.desc      : To test the enum value of TextDirection.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_TextDirection_Enum_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextDirection_Enum_0500"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.TextDirection.RTL);
        expect(1).assertEqual(text.TextDirection.LTR);
      } catch (err) {
        console.info(msg + 'test enum value of TextDirection error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_BreakStrategy_Enum_0600
     * @tc.name      : SUB_ARKUIX_GraphicText_BreakStrategy_Enum_0600
     * @tc.desc      : To test the enum value of BreakStrategy.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_BreakStrategy_Enum_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_BreakStrategy_Enum_0600"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.BreakStrategy.GREEDY);
        expect(1).assertEqual(text.BreakStrategy.HIGH_QUALITY);
        expect(2).assertEqual(text.BreakStrategy.BALANCED);
      } catch (err) {
        console.info(msg + 'test enum value of BreakStrategy error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_WordBreak_Enum_0700
     * @tc.name      : SUB_ARKUIX_GraphicText_WordBreak_Enum_0700
     * @tc.desc      : To test the enum value of WordBreak.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_WordBreak_Enum_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_WordBreak_Enum_0700"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.WordBreak.NORMAL);
        expect(1).assertEqual(text.WordBreak.BREAK_ALL);
        expect(2).assertEqual(text.WordBreak.BREAK_WORD);
      } catch (err) {
        console.info(msg + 'test enum value of WordBreak error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0800
     * @tc.name      : SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0800
     * @tc.desc      : To test the enum value of TextDecorationType.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0800"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.TextDecorationType.NONE);
        expect(1).assertEqual(text.TextDecorationType.UNDERLINE);
        expect(2).assertEqual(text.TextDecorationType.OVERLINE);
        expect(4).assertEqual(text.TextDecorationType.LINE_THROUGH);
      } catch (err) {
        console.info(msg + 'test enum value of TextDecorationType error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0900
     * @tc.name      : SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0900
     * @tc.desc      : To test the enum value of TextDecorationStyle.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextDecorationType_Enum_0900"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.TextDecorationStyle.SOLID);
        expect(1).assertEqual(text.TextDecorationStyle.DOUBLE);
        expect(2).assertEqual(text.TextDecorationStyle.DOTTED);
        expect(3).assertEqual(text.TextDecorationStyle.DASHED);
        expect(4).assertEqual(text.TextDecorationStyle.WAVY);
      } catch (err) {
        console.info(msg + 'test enum value of TextDecorationStyle error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_FontWeight_Enum_1000
     * @tc.name      : SUB_ARKUIX_GraphicText_FontWeight_Enum_1000
     * @tc.desc      : To test the enum value of FontWeight.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_FontWeight_Enum_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_FontWeight_Enum_1000"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.FontWeight.W100);
        expect(1).assertEqual(text.FontWeight.W200);
        expect(2).assertEqual(text.FontWeight.W300);
        expect(3).assertEqual(text.FontWeight.W400);
        expect(4).assertEqual(text.FontWeight.W500);
        expect(5).assertEqual(text.FontWeight.W600);
        expect(6).assertEqual(text.FontWeight.W700);
        expect(7).assertEqual(text.FontWeight.W800);
        expect(8).assertEqual(text.FontWeight.W900);
      } catch (err) {
        console.info(msg + 'test enum value of FontWeight error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_FontStyle_Enum_1100
     * @tc.name      : SUB_ARKUIX_GraphicText_FontStyle_Enum_1100
     * @tc.desc      : To test the enum value of FontStyle.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Leve0
     */
    it('SUB_ARKUIX_GraphicText_FontStyle_Enum_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_FontStyle_Enum_1100"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.FontStyle.NORMAL);
        expect(1).assertEqual(text.FontStyle.ITALIC);
        expect(2).assertEqual(text.FontStyle.OBLIQUE);
      } catch (err) {
        console.info(msg + 'test enum value of FontStyle error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextBaseline_Enum_1200
     * @tc.name      : SUB_ARKUIX_GraphicText_TextBaseline_Enum_1200
     * @tc.desc      : To test the enum value of TextBaseline.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_TextBaseline_Enum_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextBaseline_Enum_1200"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.TextBaseline.ALPHABETIC);
        expect(1).assertEqual(text.TextBaseline.IDEOGRAPHIC);
      } catch (err) {
        console.info(msg + 'test enum value of TextBaseline error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextBaseline_Enum_1300
     * @tc.name      : SUB_ARKUIX_GraphicText_TextBaseline_Enum_1300
     * @tc.desc      : To test the enum value of EllipsisMode.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_TextBaseline_Enum_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextBaseline_Enum_1300"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.EllipsisMode.START);
        expect(1).assertEqual(text.EllipsisMode.MIDDLE);
        expect(2).assertEqual(text.EllipsisMode.END);
      } catch (err) {
        console.info(msg + 'test enum value of EllipsisMode error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_PlaceholderAlignment_Enum_1400
     * @tc.name      : SUB_ARKUIX_GraphicText_PlaceholderAlignment_Enum_1400
     * @tc.desc      : To test the enum value of PlaceholderAlignment.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_PlaceholderAlignment_Enum_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_PlaceholderAlignment_Enum_1400"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.PlaceholderAlignment.OFFSET_AT_BASELINE);
        expect(1).assertEqual(text.PlaceholderAlignment.ABOVE_BASELINE);
        expect(2).assertEqual(text.PlaceholderAlignment.BELOW_BASELINE);
        expect(3).assertEqual(text.PlaceholderAlignment.TOP_OF_ROW_BOX);
        expect(4).assertEqual(text.PlaceholderAlignment.BOTTOM_OF_ROW_BOX);
        expect(5).assertEqual(text.PlaceholderAlignment.CENTER_OF_ROW_BOX);
        expect(6).assertEqual(text.PlaceholderAlignment.FOLLOW_PARAGRAPH);
      } catch (err) {
        console.info(msg + 'test enum value of PlaceholderAlignment error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1500
     * @tc.name      : SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1500
     * @tc.desc      : To test the enum value of TextVerticalAlign.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1500"
      console.info(msg + 'begin');
      try {
        expect(0).assertEqual(text.TextVerticalAlign.BASELINE);
        expect(1).assertEqual(text.TextVerticalAlign.BOTTOM);
        expect(2).assertEqual(text.TextVerticalAlign.CENTER);
        expect(3).assertEqual(text.TextVerticalAlign.TOP);
      } catch (err) {
        console.info(msg + 'test enum value of testTextVerticalAlign error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1600
     * @tc.name      SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1600
     * @tc.desc      To test the enum value of TextFontWidth.
     * @tc.size      MediumTest
     * @tc.type      Function
     * @tc.level     Level0
     */
    it('SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async ()=> {
      let msg = "SUB_ARKUIX_GraphicText_TextFontWidth_Enum_1600"
      console.info(msg + 'begin');
      try {
        expect(1).assertEqual(text.FontWidth.ULTRA_CONDENSED);
        expect(2).assertEqual(text.FontWidth.EXTRA_CONDENSED);
        expect(3).assertEqual(text.FontWidth.CONDENSED);
        expect(4).assertEqual(text.FontWidth.SEMI_CONDENSED);
        expect(5).assertEqual(text.FontWidth.NORMAL);
        expect(6).assertEqual(text.FontWidth.SEMI_EXPANDED);
        expect(7).assertEqual(text.FontWidth.EXPANDED);
        expect(8).assertEqual(text.FontWidth.EXTRA_EXPANDED);
        expect(9).assertEqual(text.FontWidth.ULTRA_EXPANDED);
      } catch (err) {
        console.info(msg + 'test enum value of testTextFontWidth error ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.name   SUB_ARKUIX_GraphicText_TextHeightBehavior_Enum_1700
     * @tc.number SUB_ARKUIX_GraphicText_TextHeightBehavior_Enum_1700
     * @tc.desc   To test interface loadFontSync of FontCollection.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('SUB_ARKUIX_GraphicText_TextHeightBehavior_Enum_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done:Function)=> {
      let msg = "====SUB_ARKUIX_GraphicText_TextHeightBehavior_Enum_1700===="
      try{
        expect(text.TextHeightBehavior.ALL).assertEqual(0)
        expect(text.TextHeightBehavior.DISABLE_FIRST_ASCENT).assertEqual(1)
        expect(text.TextHeightBehavior.DISABLE_LAST_ASCENT).assertEqual(2)
        expect(text.TextHeightBehavior.DISABLE_ALL).assertEqual(3)
        console.log(msg + ' Succeed in Enum ')
        done()
      }catch(err){
        console.log(msg + ' Failed in Enum ' + err)
        console.log(msg + ' Failed in Enum ' + JSON.stringify(err))
        expect().assertFail()
        done()
      }
    })

  })
}