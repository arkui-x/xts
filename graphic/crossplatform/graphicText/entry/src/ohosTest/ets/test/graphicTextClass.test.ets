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
import drawing from "@ohos.graphics.drawing"
import common2D from "@ohos.graphics.common2D"
import image from "@ohos.multimedia.image"
import text from "@ohos.graphics.text"
import { BusinessError } from '@ohos.base';
import { buildParagraph } from './utils';
import { display } from '@kit.ArkUI';
import deviceInfo from '@ohos.deviceInfo';


let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0].split('-')[0];

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function graphicTextClass() {
  describe('graphic_text_class_test', () => {
    console.log('describe graphic_text_class_test start!!!')

    let pixel: image.PixelMap;

    beforeAll(async () => {
      const color: ArrayBuffer = new ArrayBuffer(40000); // 40000为需要创建的像素buffer大小，取值为：height * width *4
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100//100为创建的PixelMap的宽高
        }
      }
      pixel = await image.createPixelMap(color, opts);
    })

    beforeEach(async (done: Function) => {
      done();
    });

    afterEach(async () => {
      await sleep(500)
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_ParagraphBuilder_0100
     * @tc.name      : SUB_ARKUIX_GraphicText_ParagraphBuilder_0100
     * @tc.desc      : Constructs a ParagraphBuilder object and calls its methods
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_ParagraphBuilder_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testParagraphBuilder_AonstructorAndAddText"
      console.info(msg + 'begin');
      let myTextStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };

      let myTextStyleTwo: text.TextStyle = {
        color: {
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        },
        fontSize: 33,
      };
      let myParagraphStyle: text.ParagraphStyle = {
        textStyle: myTextStyle,
        align: 3,
      };
      let myPlaceholderSpan: text.PlaceholderSpan = {
        width: 22,
        height: 33,
        align: text.PlaceholderAlignment.ABOVE_BASELINE,
        baseline: text.TextBaseline.ALPHABETIC,
        baselineOffset: 66
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
      try {
        paragraphGraphBuilder.addPlaceholder(myPlaceholderSpan);
        console.info(msg + 'addPlaceholder successed');
      } catch (err) {
        console.info(msg + 'addPlaceholder error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        paragraphGraphBuilder.pushStyle(myTextStyle);
        console.info(msg + 'pushStyle successed');
      } catch (err) {
        console.info(msg + 'first pushStyle error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        paragraphGraphBuilder.addText("123666");
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'first addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        paragraphGraphBuilder.pushStyle(myTextStyleTwo);
        console.info(msg + 'pushStyle successed second');
      } catch (err) {
        console.info(msg + 'second pushStyle error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        paragraphGraphBuilder.popStyle();
        console.info(msg + 'popStyle successed');
      } catch (err) {
        console.info(msg + 'popStyle error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        paragraphGraphBuilder.addText("1235555");
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let paragraph = paragraphGraphBuilder.build();
        expect(paragraph != null).assertTrue();
        console.info(msg + 'build successed');
      } catch (err) {
        console.info(msg + 'build error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.name SUB_ARKUIX_GraphicText_ParagraphBuilder_0200
     * @tc.number SUB_ARKUIX_GraphicText_ParagraphBuilder_0200
     * @tc.desc To test interface strutStyle.
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL0
     */
    it('SUB_ARKUIX_GraphicText_ParagraphBuilder_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_ParagraphBuilder_0200===="
        console.info(msg + ' begin');
        let myTextShadow: text.TextShadow = {
          color: {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          },
          point: {
            x: 15, y: 20
          },
          blurRadius: 0.8
        };
        console.info(msg + ' myTextShadow ready go');
        let myRectStyle: text.RectStyle = {
          color: {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          },
          leftTopRadius: 15,
          rightTopRadius: 15,
          rightBottomRadius: 15,
          leftBottomRadius: 15
        }
        console.info(msg + ' myRectStyle ready go');
        let myFontFeature: text.FontFeature = {
          name: 'aabb',
          value: 15
        }
        console.info(msg + ' myFontFeature ready go');
        let myFontVariation: text.FontVariation = {
          axis: 'KeyWord',
          value: 26
        }
        console.info(msg + ' myFontVariation ready go');
        try {
          console.info(msg + ' Details are ready, carried out!');
          let myTextStyle: text.TextStyle = {
            color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            fontWeight: text.FontWeight.W100,
            fontStyle: text.FontStyle.ITALIC,
            baseline: text.TextBaseline.ALPHABETIC,
            fontFamilies: Array<string>("123"),
            fontSize: 30,
            letterSpacing: 20,
            wordSpacing: 20,
            heightScale: 20,
            halfLeading: true,
            heightOnly: true,
            ellipsis: "456",
            ellipsisMode: text.EllipsisMode.START,
            locale: "789",
            textShadows: [myTextShadow],
            backgroundRect: myRectStyle,
            baselineShift: 20,
            fontFeatures: [myFontFeature],
            fontVariations: [myFontVariation]
          };
          let myStrutStyle: text.StrutStyle = {
            fontWidth: text.FontWidth.CONDENSED,
            forceHeight: true,
            heightOverride: true,
            leading: 0.5
          }
          console.info(msg + ' myStrutStyle ready go');
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            align: 3,
            strutStyle: myStrutStyle,
          };
          try {
            let fontCollection = new text.FontCollection;
            console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' +
            JSON.stringify(fontCollection))
            console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
            try {
              let ParagraphGraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
              expect(ParagraphGraphBuilder != null).assertTrue();
              console.log(msg + ' Succeed in text.ParagraphBuilder, This case Pass !')
              done()
            } catch (err) {
              console.info(msg + ' Failed in fontCollection.ParagraphBuilder.    Cause: ' + JSON.stringify(err));
              console.info(msg + ' Failed in fontCollection.ParagraphBuilder.    Cause: ' + err);
              expect().assertFail();
              done()
            }
          } catch (err) {
            console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + JSON.stringify(err));
            console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + err);
            expect().assertFail();
            done()
          }
        } catch (err) {
          console.info(msg + 'test TextStyle error ' + JSON.stringify(err));
          console.info(msg + 'test TextStyle error ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.name SUB_ARKUIX_GraphicText_ParagraphBuilder_0300
     * @tc.number SUB_ARKUIX_GraphicText_ParagraphBuilder_0300
     * @tc.desc Perform typesetting and calculate the position of all glyphs
     * @tc.type FUNCTION
     * @tc.size MEDIUMTEST
     * @tc.level LEVEL0
     */
    it('SUB_ARKUIX_GraphicText_ParagraphBuilder_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_ParagraphBuilder_0300===="
        console.info(msg + ' begin');
        let myTextShadow: text.TextShadow = {
          color: {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          },
          point: {
            x: 15, y: 20
          },
          blurRadius: 0.8
        };
        console.info(msg + ' myTextShadow ready go');
        let myRectStyle: text.RectStyle = {
          color: {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          },
          leftTopRadius: 15,
          rightTopRadius: 15,
          rightBottomRadius: 15,
          leftBottomRadius: 15
        }
        console.info(msg + ' myRectStyle ready go');
        let myFontFeature: text.FontFeature = {
          name: 'aabb',
          value: 15
        }
        console.info(msg + ' myFontFeature ready go');
        let myStrutStyle: text.StrutStyle = {
          fontFamilies: ["Clock_01"],
          fontStyle: 0,
          fontWidth: text.FontWidth.CONDENSED,
          fontWeight: 0,
          fontSize: 16,
          height: 1,
          leading: -1,
          forceHeight: true,
          enabled: false,
          heightOverride: true,
          halfLeading: false
        }
        console.info(msg + ' myStrutStyle ready go');

        try {
          console.info(msg + ' Details are ready, carried out!');
          let myTextStyle: text.TextStyle = {
            color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            fontWeight: text.FontWeight.W100,
            fontStyle: text.FontStyle.ITALIC,
            baseline: text.TextBaseline.ALPHABETIC,
            fontFamilies: Array<string>("123"),
            fontSize: 30,
            letterSpacing: 20,
            wordSpacing: 20,
            heightScale: 20,
            halfLeading: true,
            heightOnly: true,
            ellipsis: "456",
            ellipsisMode: text.EllipsisMode.START,
            locale: "789",
            textShadows: [myTextShadow],
            backgroundRect: myRectStyle,
            baselineShift: 20,
            fontFeatures: [myFontFeature]
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            align: 3,
            strutStyle: myStrutStyle,
            textHeightBehavior: text.TextHeightBehavior.DISABLE_FIRST_ASCENT
          };
          try {
            let fontCollection = new text.FontCollection;
            console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' +
            JSON.stringify(fontCollection))
            console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
            try {
              let paragraphGraphBuilder: text.ParagraphBuilder =
                new text.ParagraphBuilder(myParagraphStyle, fontCollection);
              expect(paragraphGraphBuilder != null).assertTrue();
              paragraphGraphBuilder.addText("test");
              let paragraph: text.Paragraph = paragraphGraphBuilder.build();
              paragraph.layout(-1).then((data) => {
                console.info(`Succeeded in doing layout,  ${JSON.stringify(data)}`);
                console.log(msg + ' error in paragraph.layout(-1)')
                expect().assertFail();
                done()
              }).catch((error: BusinessError) => {
                if (error.code == 401) {
                  console.log(msg +
                    ' Parameter error. Possible causes: 1. Mandatory parameters are left unspecified;2. Incorrect parameter types. ')
                  console.log(msg + ' Case End Successfully')
                  done()
                } else {
                  console.error(`Failed to do layout, error: ${JSON.stringify(error)} message: ${error.message}`);
                  expect().assertFail();
                  done()
                }
              });
            } catch (err) {
              console.info(msg + ' Failed in fontCollection.ParagraphBuilder.    Cause: ' + JSON.stringify(err));
              console.info(msg + ' Failed in fontCollection.ParagraphBuilder.    Cause: ' + err);
              expect().assertFail();
              done()
            }
          } catch (err) {
            console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + JSON.stringify(err));
            console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + err);
            expect().assertFail();
            done()
          }
        } catch (err) {
          console.info(msg + 'test TextStyle error ' + JSON.stringify(err));
          console.info(msg + 'test TextStyle error ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0100
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_0100
     * @tc.desc      : To test Paragraph layoutSyncSync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testlayoutSync"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      expect(paragraph != null).assertTrue();
      try {
        paragraph.layoutSync(100);
      } catch (err) {
        console.info(msg + 'layoutSync error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GRAPHICTEXT_Paragraph_0200
     * @tc.name      : SUB_ARKUIX_GRAPHICTEXT_Paragraph_0200
     * @tc.desc      : To test Paragraph Paint interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GRAPHICTEXT_Paragraph_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testPaint"
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      expect(paragraph != null).assertTrue();
      try {
        paragraph.paint(canvas, 10, 10);
      } catch (err) {
        console.info(msg + 'paint error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0300
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_0300
     * @tc.desc      : To test Paragraph GetMaxWidth interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testGetMaxWidth"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let width = paragraph.getMaxWidth();
        expect(width != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getMaxWidth error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0400
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_0400
     * @tc.desc      : To test Paragraph GetHeight interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testGetHeight"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let height = paragraph.getHeight();
        expect(height != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getHeight error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0500
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_0500
     * @tc.desc      : To test Paragraph GetLongestLine interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testGetLongestLine"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let line = paragraph.getLongestLine();
        expect(line != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getLongestLine error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0600
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_0600
     * @tc.desc      : To test Paragraph GetMinIntrinsicWidth interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testGetMinIntrinsicWidth"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let width = paragraph.getMinIntrinsicWidth();
        expect(width != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getMinIntrinsicWidth error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0700
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_0700
     * @tc.desc      : To test Paragraph GetMaxIntrinsicWidth interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testGetMaxIntrinsicWidth"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let width = paragraph.getMaxIntrinsicWidth();
        expect(width != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getMaxIntrinsicWidth error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0800
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_0800
     * @tc.desc      : To test Paragraph GetAlphabeticBaseline interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testGetAlphabeticBaseline"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let baseline = paragraph.getAlphabeticBaseline();
        expect(baseline != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getAlphabeticBaseline error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_0900
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_009
     * @tc.desc      : To test Paragraph GetIdeographicBaseline interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "testGetIdeographicBaseline"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let baseline = paragraph.getIdeographicBaseline();
        expect(baseline != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getIdeographicBaseline error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1000
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1000
     * @tc.desc      : To test Paragraph GetRectsForRange interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1000"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      let range: text.Range = { start: 10, end: 50 };
      let wstyle = text.RectWidthStyle.TIGHT;
      let hstyle = text.RectHeightStyle.TIGHT;
      try {
        let rects: Array<text.TextBox> = paragraph.getRectsForRange(range, wstyle, hstyle);
        expect(rects != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getRectsForRange error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1100
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1100
     * @tc.desc      : To test Paragraph GetRectsForPlaceholders interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1100"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let rects: Array<text.TextBox> = paragraph.getRectsForPlaceholders();
        expect(rects != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getRectsForPlaceholders error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1200
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1200
     * @tc.desc      : To To test Paragraph GetGlyphPositionAtCoordinate interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1200"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let positionWithAffinity = paragraph.getGlyphPositionAtCoordinate(10, 10);
        expect(positionWithAffinity != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getGlyphPositionAtCoordinate error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let positionWithAffinity = paragraph.getGlyphPositionAtCoordinate(null, null);
        expect(positionWithAffinity).assertEqual(undefined);
      } catch (err) {
        console.info(msg + 'getGlyphPositionAtCoordinate error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let positionWithAffinity = paragraph.getGlyphPositionAtCoordinate(undefined, undefined);
        expect(positionWithAffinity).assertEqual(undefined);
      } catch (err) {
        console.info(msg + 'getGlyphPositionAtCoordinate error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1300
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1300
     * @tc.desc      : To test Paragraph GetWordBoundary interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1300"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let range: text.Range = paragraph.getWordBoundary(10);
        expect(range != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getWordBoundary error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let range: text.Range = paragraph.getWordBoundary(null);
        expect(range == undefined).assertTrue();
      } catch (err) {
        console.info(msg + 'getWordBoundary error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let range: text.Range = paragraph.getWordBoundary(undefined);
        expect(range == undefined).assertTrue();
      } catch (err) {
        console.info(msg + 'getWordBoundary error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1400
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1400
     * @tc.desc      : To test Paragraph GetLineCount interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1400"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let linecount = paragraph.getLineCount();
        expect(linecount != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getLineCount error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1500
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1500
     * @tc.desc      : To test Paragraph GetLineHeight interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1500"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let height = paragraph.getLineHeight(1);
        expect(height != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getLineHeight error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let height = paragraph.getLineHeight(null);
        expect(height).assertEqual(undefined);
      } catch (err) {
        console.info(msg + 'getLineHeight error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let height = paragraph.getLineHeight(undefined);
        expect(height).assertEqual(undefined);
      } catch (err) {
        console.info(msg + 'getLineHeight error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_16000
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_16000
     * @tc.desc      : To test Paragraph GetLineWidth interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_16000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_16000"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let width = paragraph.getLineWidth(1);
        expect(width != null).assertTrue();
      } catch (err) {
        console.info(msg + 'getLineWidth error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let width = paragraph.getLineWidth(null);
        expect(width).assertEqual(undefined);
      } catch (err) {
        console.info(msg + 'getLineWidth error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let width = paragraph.getLineWidth(undefined);
        expect(width).assertEqual(undefined);
      } catch (err) {
        console.info(msg + 'getLineWidth error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1700
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1700
     * @tc.desc      : To test Paragraph DidExceedMaxLines interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1700"
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      try {
        let did = paragraph.didExceedMaxLines();
        expect(did != null).assertTrue();
      } catch (err) {
        console.info(msg + 'didExceedMaxLines error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1800
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1800
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1800 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(100).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
      }).catch((error: BusinessError) => {
        console.log(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(false).assertTrue();
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_1900
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_1900
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_1900 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(-100).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
        expect(false).assertTrue();
      }).catch((error: BusinessError) => {
        console.log(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(error.code).assertEqual(401);
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2000
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2000
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_2000 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(null).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
        expect(false).assertTrue();
      }).catch((error: BusinessError) => {
        console.log(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(error.code).assertEqual(401);
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2100
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2100
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_2100 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(undefined).then((data) => {
        console.info(msg + `layout success !  ${JSON.stringify(data)}`);
        expect(false).assertTrue();
      }).catch((error: BusinessError) => {
        console.error(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(error.code).assertEqual(401);
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2200
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2200
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_2200 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(110.05).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
      }).catch((error: BusinessError) => {
        console.log(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(false).assertTrue();
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2300
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2300
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_2300 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(Number.MAX_VALUE).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
      }).catch((error: BusinessError) => {
        console.log(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(false).assertTrue();
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2400
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2400
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_2400 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(Number.MIN_VALUE).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
      }).catch((error: BusinessError) => {
        console.log(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(false).assertTrue();
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2500
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2500
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_2500 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(Number.MAX_SAFE_INTEGER).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
      }).catch((error: BusinessError) => {
        console.log(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(false).assertTrue();
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2600
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2600
     * @tc.desc      : To test Paragraph layout interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_2600 "
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      await paragraph.layout(Number.MIN_SAFE_INTEGER).then((data) => {
        console.log(msg + `layout success !  ${JSON.stringify(data)}`);
        expect(false).assertTrue();
      }).catch((error: BusinessError) => {
        console.error(msg + `layout failed ! error: ${JSON.stringify(error, ['code', 'message'])}`);
        expect(error.code).assertEqual(401);
      });
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2700
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2700
     * @tc.desc      : test paragraph getLineMetrics
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_2700===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          let myTextStyle: text.TextStyle = {
            color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            fontSize: 33,
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体 ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.layoutSync(600);
          let lineMetrics: text.LineMetrics | undefined = paragraph.getLineMetrics(0);
          console.info('lineMetrics:' + JSON.stringify(lineMetrics));
          expect(lineMetrics?.startIndex != null).assertTrue();
          expect(lineMetrics?.endIndex != null).assertTrue();
          expect(lineMetrics?.ascent != null).assertTrue();
          expect(lineMetrics?.descent != null).assertTrue();
          expect(lineMetrics?.height != null).assertTrue();
          expect(lineMetrics?.width != null).assertTrue();
          expect(lineMetrics?.left != null).assertTrue();
          expect(lineMetrics?.baseline != null).assertTrue();
          expect(lineMetrics?.lineNumber != null).assertTrue();
          expect(lineMetrics?.topHeight != null).assertTrue();
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2800
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2800
     * @tc.desc      : To test Paragraph getLongestLineWithIndent interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_0028===="
        console.info(msg + ' begin');
        let myTextShadow: text.TextShadow = {
          color: {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          },
          point: {
            x: 15, y: 20
          },
          blurRadius: 0.8
        };
        console.info(msg + ' myTextShadow ready go');
        let myRectStyle: text.RectStyle = {
          color: {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          },
          leftTopRadius: 15,
          rightTopRadius: 15,
          rightBottomRadius: 15,
          leftBottomRadius: 15
        }
        console.info(msg + ' myRectStyle ready go');
        let myFontFeature: text.FontFeature = {
          name: 'aabb',
          value: 15
        }
        console.info(msg + ' myFontFeature ready go');
        let myFontVariation: text.FontVariation = {
          axis: 'KeyWord',
          value: 26
        }
        console.info(msg + ' myFontVariation ready go');
        try {
          console.info(msg + ' Details are ready, carried out!');
          let myTextStyle: text.TextStyle = {
            color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            fontWeight: text.FontWeight.W100,
            fontStyle: text.FontStyle.ITALIC,
            baseline: text.TextBaseline.ALPHABETIC,
            fontFamilies: Array<string>("123"),
            fontSize: 30,
            letterSpacing: 20,
            wordSpacing: 20,
            heightScale: 20,
            halfLeading: true,
            heightOnly: true,
            ellipsis: "456",
            ellipsisMode: text.EllipsisMode.START,
            locale: "789",
            textShadows: [myTextShadow],
            backgroundRect: myRectStyle,
            baselineShift: 20,
            fontFeatures: [myFontFeature],
            fontVariations: [myFontVariation]
          };
          let myStrutStyle: text.StrutStyle = {
            fontWidth: text.FontWidth.CONDENSED,
            forceHeight: true,
            heightOverride: true,
            leading: 0.5
          }
          console.info(msg + ' myStrutStyle ready go');
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            align: 3,
            strutStyle: myStrutStyle,
          };
          try {
            let fontCollection = new text.FontCollection;
            console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' +
            JSON.stringify(fontCollection))
            console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
            try {
              let ParagraphGraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
              console.log(msg + ' Succeed in ParagraphBuilder')
              let paragraph = ParagraphGraphBuilder.build()
              console.log(msg + ' Succeed in build paragraph')
              let longestLineWithIndent = paragraph.getLongestLineWithIndent();
              console.log(msg + ' Succeed in paragraph.getLongestLineWithIndent, This case Pass !')
              expect(longestLineWithIndent != null).assertTrue();
              done()
            } catch (err) {
              console.info(msg + ' Failed in fontCollection.ParagraphBuilder.    Cause: ' + JSON.stringify(err));
              console.info(msg + ' Failed in fontCollection.ParagraphBuilder.    Cause: ' + err);
              expect().assertFail();
              done()
            }
          } catch (err) {
            console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + JSON.stringify(err));
            console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + err);
            expect().assertFail();
            done()
          }
        } catch (err) {
          console.info(msg + 'test TextStyle error ' + JSON.stringify(err));
          console.info(msg + 'test TextStyle error ' + err);
          expect().assertFail();
          done()
        }
      })


    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_2900
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_2900
     * @tc.desc      : To test interface paintOnPath of Paragraph.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====testPaintOnPath===="
        console.info(msg + ' begin');
        try {
          let myParagraphStyle: text.ParagraphStyle = {
            align: 3,
          };
          let fontCollection = new text.FontCollection();
          let ParagraphGraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let paragraph = ParagraphGraphBuilder.build();

          const color: ArrayBuffer = new ArrayBuffer(160000);
          let opts: image.InitializationOptions = { editable: true, pixelFormat: 3, size: { height: 200, width: 200 } }
          let pixelMap: image.PixelMap = image.createPixelMapSync(color, opts);
          let canvas = new drawing.Canvas(pixelMap);
          let path = new drawing.Path();
          console.log(msg + ' Succeed in every Variable!')

          path.arcTo(20, 20, 180, 180, 180, 90);
          console.log(msg + ' Succeed in arcTo!')

          paragraph.paintOnPath(canvas, path, 0, 0);
          console.log(msg + ' Succeed in paragraph.paintOnPath')
          done()
        } catch (err) {
          console.info(msg + 'test paragraph.paintOnPath error ' + JSON.stringify(err));
          console.info(msg + 'test paragraph.paintOnPath error ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_3000
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_3000
     * @tc.desc      : To test interface GetActualTextRange of Paragraph.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_3000===="
        console.info(msg + ' begin ');
        let myTextStyle: text.TextStyle = {
          color: {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          },
          fontSize: 33,
        };
        let myParagraphStyle: text.ParagraphStyle = {
          textStyle: myTextStyle,
          align: 3,
        };
        try {
          let fontCollection = new text.FontCollection();
          let ParagraphGraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let paragraph = ParagraphGraphBuilder.build();
          let rang = paragraph.getActualTextRange(0, true);
          expect(rang != null).assertTrue();
          console.log(msg + ' Succeed in getActualTextRange.')
          done()
        } catch (err) {
          console.info(msg + ' Failed in getActualTextRange.    Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in getActualTextRange.    Cause: ' + err);
          expect().assertFail();
          done()
        }
        try {
          let fontCollection = new text.FontCollection();
          let ParagraphGraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let paragraph = ParagraphGraphBuilder.build();
          let rang = paragraph.getActualTextRange(null, null);
          expect(rang).assertEqual(undefined);
        } catch (err) {
          console.info(msg + 'getActualTextRange error cause: ' + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          let fontCollection = new text.FontCollection();
          let ParagraphGraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let paragraph = ParagraphGraphBuilder.build();
          let rang = paragraph.getActualTextRange(undefined, undefined);
          expect(rang).assertEqual(undefined);
        } catch (err) {
          console.info(msg + 'getActualTextRange error cause: ' + JSON.stringify(err));
          expect().assertFail();
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_3100
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_3100
     * @tc.desc      : text updateColor updateDecoration
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_3100===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
            badgeType: text.TextBadgeType.TEXT_BADGE_NONE
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            autoSpace: true,
            trailingSpaceOptimized: true
          }

          interface Params {
            str?: string;
            str_color?: common2D.Color;
            backgroundRect?: text.RectStyle;
            Decoration_textDecoration?: text.TextDecorationType;
            Decoration_color?: common2D.Color;
            Decoration_decorationStyle?: text.TextDecorationStyle;
            Decoration_decorationThicknessScale?: number;
            textShadowsData: Array<text.TextShadow>;
          }

          let params: Params = {
            str: "",
            str_color: {
              alpha: 255,
              red: 0,
              green: 0,
              blue: 0
            },
            Decoration_textDecoration: text.TextDecorationType.NONE,
            Decoration_color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            Decoration_decorationStyle: text.TextDecorationStyle.SOLID,
            Decoration_decorationThicknessScale: 1.0,
            textShadowsData: new Array()
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体 ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          params.backgroundRect = {
            color: {
              alpha: 255,
              red: 137,
              green: 137,
              blue: 120
            },
            leftTopRadius: 1,
            rightTopRadius: 1,
            rightBottomRadius: 1,
            leftBottomRadius: 1,
          }
          paragraph.updateColor(params.Decoration_color);
          paragraph.updateDecoration({
            textDecoration: text.TextDecorationType.OVERLINE,
            color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            decorationStyle: text.TextDecorationStyle.WAVY,
            decorationThicknessScale: 2.0,
          });
          paragraph.layoutSync(600);
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_3200
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_3200
     * @tc.desc      : text updateColor updateDecoration
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_3200===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
            badgeType: text.TextBadgeType.TEXT_SUPERSCRIPT
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            autoSpace: false,
            trailingSpaceOptimized: false
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体 ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.updateColor({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          });
          paragraph.updateDecoration({
            textDecoration: text.TextDecorationType.LINE_THROUGH,
            color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            decorationStyle: text.TextDecorationStyle.DOTTED,
            decorationThicknessScale: 1.0,
          });
          paragraph.layoutSync(600);
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_3300
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_3300
     * @tc.desc      : text updateColor updateDecoration
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_3300===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
            badgeType: text.TextBadgeType.TEXT_SUBSCRIPT
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            autoSpace: true,
            trailingSpaceOptimized: false
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.updateColor({
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          });
          paragraph.updateDecoration({
            textDecoration: text.TextDecorationType.UNDERLINE,
            color: {
              alpha: 255,
              red: 255,
              green: 0,
              blue: 0
            },
            decorationStyle: text.TextDecorationStyle.DASHED,
            decorationThicknessScale: 1.5,
          });
          paragraph.layoutSync(600);
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_Paragraph_3400
     * @tc.name SUB_ARKUIX_GraphicText_Paragraph_3400
     * @tc.desc test paragraph getLineMetrics
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_0034===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.layoutSync(600);
          let range1: text.Range = { start: 0, end: 1 };
          let rects1 = paragraph.getRectsForRange(range1, text.RectWidthStyle.TIGHT, text.RectHeightStyle.TIGHT);
          console.info('www data rects 111 ', JSON.stringify(rects1.length))
          expect(rects1.length >= 0).assertTrue();
          let range2: text.Range = { start: 0, end: 0 };
          let rects2 = paragraph.getRectsForRange(range2, text.RectWidthStyle.TIGHT, text.RectHeightStyle.TIGHT);
          console.info('www data rects 222 ', JSON.stringify(rects2.length))
          expect(rects2.length == 0).assertTrue();
          let placeholderRects = paragraph.getRectsForPlaceholders();
          expect(placeholderRects.length == 0).assertTrue();
          let didExceed = paragraph.didExceedMaxLines();
          expect(didExceed == false).assertTrue();
          let lines = paragraph.getTextLines();
          expect(lines.length > 0).assertTrue();
          let arrLineMetric = paragraph.getLineMetrics();
          expect(arrLineMetric.length > 0).assertTrue();
          let lineMetrics = paragraph.getLineMetrics(0);
          expect(lineMetrics != undefined).assertTrue();
          let runs = lines[0].getGlyphRuns();
          expect(runs.length > 0).assertTrue();
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_Paragraph_3500
     * @tc.name SUB_ARKUIX_GraphicText_Paragraph_3500
     * @tc.desc test paragraph getLineMetrics
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_0035===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.layoutSync(600);
          let lines = paragraph.getTextLines();
          expect(lines.length == 0).assertTrue();
          expect(lines[0] == undefined).assertTrue();
          let arrLineMetric = paragraph.getLineMetrics();
          expect(arrLineMetric.length == 0).assertTrue();
          let lineMetrics = paragraph.getLineMetrics(0);
          expect(lineMetrics == undefined).assertTrue();
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_Paragraph_3600
     * @tc.name SUB_ARKUIX_GraphicText_Paragraph_3600
     * @tc.desc test paragraph didExceedMaxLines
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Paragraph_0036===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
            fontSize: 50,
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            maxLines: 1,
          }
          let myPlaceholderSpan: text.PlaceholderSpan = {
            width: 100,
            height: 100,
            align: text.PlaceholderAlignment.FOLLOW_PARAGRAPH,
            baseline: text.TextBaseline.ALPHABETIC,
            baselineOffset: 100
          };
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          paragraphBuilder.addPlaceholder(myPlaceholderSpan);
          let textData = "测试 loadFontSync 加载字体ComingSoon.ttf_测试 loadFontSync 加载字体ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.layoutSync(600);
          let placeholderRects = paragraph.getRectsForPlaceholders();
          expect(placeholderRects.length > 0).assertTrue();
          let didExceed = paragraph.didExceedMaxLines();
          expect(didExceed == true).assertTrue();
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_3700
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_3700
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_3700 "
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(600);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_3800
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_3800
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_3800 "

      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(-100);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_3900
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_3900
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_3900 "
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(null);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_4000
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_4000
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_4000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_4000 "
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(undefined);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_4100
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_4100
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_4100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_4100 "
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(110.05);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_4200
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_4200
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_4200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_4200 "
      console.info(msg + 'begin');
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(Number.MAX_VALUE);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_4300
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_4300
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_4300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_4300 "
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(Number.MIN_VALUE);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_4400
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_4400
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_4400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_4400 "
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(Number.MAX_SAFE_INTEGER);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Paragraph_4500
     * @tc.name      : SUB_ARKUIX_GraphicText_Paragraph_4500
     * @tc.desc      : To test Paragraph layoutAsync interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('SUB_ARKUIX_GraphicText_Paragraph_4500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let msg = "SUB_ARKUIX_GraphicText_Paragraph_4500 "
      try {
        let paragraph: text.Paragraph = buildParagraph();
        paragraph.layoutSync(Number.MIN_SAFE_INTEGER);
      } catch (err) {
        console.log(msg + `layout failed ! error: ${JSON.stringify(err, ['code', 'message'])}`);
        expect(err.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0100
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0100
     * @tc.desc      : test TextLine GlyphCount
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_TextLines_0100"
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let textTitle = "123";
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      paragraph.paint(canvas, 0, 0);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        try {
          expect(textLine.getGlyphCount()).assertEqual(textTitle.length);
          console.info(msg + 'getGlyphCount successed second');
        } catch (err) {
          console.info(msg + 'getGlyphCount error cause: ' + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0200
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0200
     * @tc.desc      : test TextLine GetTextRange
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_TextLines_0200"
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      paragraph.paint(canvas, 0, 0);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        try {
          expect(0).assertEqual(textLine.getTextRange().start);
          console.info(msg + 'getTextRange successed second');
        } catch (err) {
          console.info(msg + 'getGlyphCount error cause: ' + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0300
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0300
     * @tc.desc      : test TextLine Paint
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_TextLines_0300"
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      paragraph.paint(canvas, 0, 0);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        try {
          textLine.paint(canvas, textLine.getTextRange().start, textLine.getTextRange().end);
          console.info(msg + 'paint successed second');
        } catch (err) {
          console.info(msg + 'paint error cause: ' + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0400
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0400
     * @tc.desc      : To test Line CreateTruncatedLine interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_0400';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        let truncatedTextLine = textLine.createTruncatedLine(100, text.EllipsisMode.START, "...");
        try {
          truncatedTextLine.paint(canvas, 0, 100);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(50, text.EllipsisMode.END, "...");
        try {
          truncatedTextLine.paint(canvas, 0, 100);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(50, text.EllipsisMode.MIDDLE, "...");
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(-50, text.EllipsisMode.END, "...");
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(null, text.EllipsisMode.START, "...");
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(100, null, "...");
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(100, text.EllipsisMode.START, null);
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(undefined, text.EllipsisMode.END, "...");
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(100, undefined, "...");
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        truncatedTextLine = textLine.createTruncatedLine(100, text.EllipsisMode.START, undefined);
        try {
          expect(truncatedTextLine).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0500
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0500
     * @tc.desc      : To test Line GetTypographicBounds interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_0500';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        let bounds = textLine.getTypographicBounds();
        try {
          expect(bounds.ascent < 0).assertTrue();
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          expect(bounds.descent).assertLargerOrEqual(0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          expect(bounds.leading).assertLargerOrEqual(0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          expect(bounds.width).assertLarger(0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0600
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0600
     * @tc.desc      : To test Line GetImageBounds interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_0600';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        let bounds = textLine.getImageBounds();
        try {
          expect(bounds.left).assertLargerOrEqual(0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          expect(bounds.top).assertLargerOrEqual(0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          expect(bounds.right).assertLarger(bounds.left);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          expect(bounds.bottom).assertLarger(bounds.top);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0700
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0700
     * @tc.desc      : To test Line GetTrailingSpaceWidth interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1 
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_0700';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        let width = textLine.getTrailingSpaceWidth();
        try {
          expect(width).assertEqual(0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0800
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0800
     * @tc.desc      : To test Line GetStringIndexForPosition interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_0800';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        let point: common2D.Point = { x: 0.0, y: 2.0 };
        let index = textLine.getStringIndexForPosition(point);
        try {
          expect(index).assertEqual(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        point.x = 20.0;
        index = textLine.getStringIndexForPosition(point);
        try {
          expect(index).assertEqual(2);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        point.x = -2.0;
        index = textLine.getStringIndexForPosition(point);
        try {
          expect(index).assertEqual(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        index = textLine.getStringIndexForPosition(null);
        try {
          expect(index).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        index = textLine.getStringIndexForPosition(undefined);
        try {
          expect(index).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_0900
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_0900
     * @tc.desc      : To test Line GetOffsetForStringIndex interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_0900';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        let offset = textLine.getOffsetForStringIndex(0);
        try {
          expect(offset).assertEqual(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getOffsetForStringIndex(1);
        try {
          expect(offset).assertEqual(12);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getOffsetForStringIndex(-2);
        try {
          expect(offset).assertEqual(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getOffsetForStringIndex(null);
        try {
          expect(offset).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getOffsetForStringIndex(undefined);
        try {
          expect(offset).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_1000
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_1000
     * @tc.desc      : To test Line EnumerateCaretOffsets interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_1000';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        textLine.enumerateCaretOffsets((offset: number, index: number, leadingEdge: boolean): boolean => {
          try {
            expect(index).assertLessOrEqual(1);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            if (index == 0 && leadingEdge == true) {
              expect(offset).assertEqual(0.0);
            }

            if (offset == 12 && index == 0) {
              expect(leadingEdge).assertEqual(false);
            }
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          return index > 0;
        });
        try {
          textLine.enumerateCaretOffsets(null);
        } catch (err) {
          try {
            expect(err.message).assertEqual("Invalid params.");
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
        try {
          textLine.enumerateCaretOffsets(undefined);
        } catch (err) {
          try {
            expect(err.message).assertEqual("Invalid params.");
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_TextLines_1100
     * @tc.name      : SUB_ARKUIX_GraphicText_TextLines_1100
     * @tc.desc      : To test Line GetAlignmentOffset interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_TextLines_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_TextLines_1100';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];

        let offset = textLine.getAlignmentOffset(0.0, 300);
        try {
          expect(offset).assertEqual(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getAlignmentOffset(0.5, 300);
        try {
          expect(offset).assertLarger(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getAlignmentOffset(2, 10);
        try {
          expect(offset).assertEqual(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getAlignmentOffset(-2, 300);
        try {
          expect(offset).assertEqual(0.0);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getAlignmentOffset(null, 20);
        try {
          expect(offset).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getAlignmentOffset(2.0, null);
        try {
          expect(offset).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getAlignmentOffset(2.0, undefined);
        try {
          expect(offset).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
        offset = textLine.getAlignmentOffset(null, 20);
        try {
          expect(offset).assertEqual(undefined);
        } catch (err) {
          console.info(msg + JSON.stringify(err));
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0100
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0100
     * @tc.desc      : To test Run GetGlyphCount interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0100';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        textLine.paint(canvas, 0, (i + 1) * 20);
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            expect(run.getGlyphCount()).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0200
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0200
     * @tc.desc      : To test Run GetGlyphs interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0200';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel);
      let paragraph: text.Paragraph = buildParagraph();
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        textLine.paint(canvas, 0, (i + 1) * 20);
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            expect(run.getGlyphs()).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0300
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0300
     * @tc.desc      : To test Run GetPositions interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0300';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        textLine.paint(canvas, 0, (i + 1) * 20);
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            expect(run.getPositions().length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0400
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0400
     * @tc.desc      : To test Run GetOffsets interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0400';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        textLine.paint(canvas, 0, (i + 1) * 20);
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            expect(run.getOffsets().length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0500
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0500
     * @tc.desc      : To test Run GetFont interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0500';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        textLine.paint(canvas, 0, (i + 1) * 20);
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            run.getFont();
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0600
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0600
     * @tc.desc      : To test Run Paint interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0600';
      console.info(msg + 'begin');
      let canvas = new drawing.Canvas(pixel)
      let paragraph: text.Paragraph = buildParagraph();
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            run.paint(canvas, 0, j * 20);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0700
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0700
     * @tc.desc      : To test Run GetGlyphs interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0700';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            expect(run.getGlyphs({ start: -1, end: 1 })).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getGlyphs({ start: -1, end: -20 })).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getGlyphs({ start: 0, end: 1 }).length).assertEqual(1);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getGlyphs(null)).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getGlyphs(undefined)).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getGlyphs({ start: 0, end: 0 }).length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0800
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0800
     * @tc.desc      : To test Run GetPositions interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0800';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            expect(run.getPositions({ start: 0, end: 3 }).length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getPositions({ start: 0, end: 30 }).length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getPositions({ start: 0, end: 0 }).length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getPositions({ start: -1, end: -2 })).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getPositions(null)).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getPositions(undefined)).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_0900
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_0900
     * @tc.desc      : To test Run getStringIndices interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_0900';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            expect(run.getStringIndices().length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getStringIndices({ start: 0, end: 1 }).length).assertEqual(1);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getStringIndices({ start: 0, end: 0 }).length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getStringIndices({ start: 0, end: 30 }).length).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getStringIndices({ start: -1, end: -1 })).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getStringIndices(null)).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(run.getStringIndices(undefined)).assertEqual(undefined);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_1000
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_1000
     * @tc.desc      : To test Run getStringRange interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_1000';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          try {
            let stringRange: text.Range = run.getStringRange();
            expect(stringRange.start).assertEqual(0);
            expect(stringRange.end).assertEqual(3);
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_1100
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_1100
     * @tc.desc      : To test Run getImageBounds interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_1100';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          let bounds: common2D.Rect = run.getImageBounds();
          try {
            expect(bounds.right > bounds.left).assertTrue();
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(bounds.bottom > bounds.top).assertTrue();
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_1200
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_1200
     * @tc.desc      : To test Run getTypographicBounds interface.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = 'SUB_ARKUIX_GraphicText_Runs_1200';
      console.info(msg + 'begin');
      let paragraph: text.Paragraph = buildParagraph();
      paragraph.layoutSync(200);
      let textLines: Array<text.TextLine> = paragraph.getTextLines();
      let length = textLines.length;
      for (let i = 0; i < length; i++) {
        let textLine: text.TextLine = textLines[i];
        let runs: Array<text.Run> = textLine.getGlyphRuns();
        let runslength = runs.length;
        for (let j = 0; j < runslength; j++) {
          let run: text.Run = runs[j];
          let bounds: text.TypographicBounds = run.getTypographicBounds();
          try {
            expect(bounds.ascent < 0).assertTrue();
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(bounds.descent > 0).assertTrue();
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(bounds.leading >= 0).assertTrue();
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
          try {
            expect(bounds.width > 0).assertTrue();
          } catch (err) {
            console.info(msg + JSON.stringify(err));
            expect().assertFail();
          }
        }
      }
    })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_Runs_1300
     * @tc.name SUB_ARKUIX_GraphicText_Runs_1300
     * @tc.desc test getGlyphs
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level 1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Runs_1300====";
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
            fontSize: 50,
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            maxLines: 1,
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体HarmonyClock_01.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.layoutSync(600);
          let lines = paragraph.getTextLines();
          let runs = lines[0].getGlyphRuns();
          console.info('www data runs ' + JSON.stringify(runs));
          expect(runs.length > 0).assertTrue();
          let glphy1 = runs[0].getGlyphs();
          console.info('www data glphy1 ' + JSON.stringify(glphy1));
          expect(glphy1.length > 0).assertTrue();
          let glphy2 = runs[0].getGlyphs({ start: 0, end: 1 });
          console.info('www data glphy2 ' + JSON.stringify(glphy2));
          expect(glphy2.length > 0).assertTrue();
          let glphy3 = runs[0].getGlyphs({ start: 0, end: 0 });
          console.info('www data glphy3 ' + JSON.stringify(glphy3));
          expect(glphy3.length > 0).assertTrue();
          let glphy4 = runs[0].getGlyphs({ start: 0, end: -1 });
          console.info('www data glphy4 ' + JSON.stringify(glphy4));
          expect(glphy4 == undefined).assertTrue();
          let glphy5 = runs[0].getGlyphs(null);
          console.info('www data glphy5 ' + JSON.stringify(glphy5));
          expect(glphy5 == undefined).assertTrue();
          let glphy6 = runs[0].getGlyphs(undefined);
          console.info('www data glphy6 ' + JSON.stringify(glphy6));
          expect(glphy6 == undefined).assertTrue();
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_Runs_1400
     * @tc.name SUB_ARKUIX_GraphicText_Runs_1400
     * @tc.desc test getPositions
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Runs_1400====";
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
            fontSize: 50,
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            maxLines: 1,
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.layoutSync(600);
          let lines = paragraph.getTextLines();
          let runs = lines[0].getGlyphRuns();
          console.info('www data runs ' + JSON.stringify(runs));
          expect(runs.length > 0).assertTrue();
          let position1 = runs[0].getPositions();
          console.info('www data position1 ' + JSON.stringify(position1));
          expect(position1.length > 0).assertTrue();
          let position2 = runs[0].getPositions({ start: 0, end: 1 });
          console.info('www data position2 ' + JSON.stringify(position2));
          expect(position2.length > 0).assertTrue();
          let position3 = runs[0].getPositions({ start: 0, end: 0 });
          console.info('www data position3 ' + JSON.stringify(position3));
          expect(position3.length > 0).assertTrue();
          let position4 = runs[0].getPositions({ start: 0, end: -1 });
          console.info('www data position4 ' + JSON.stringify(position4));
          expect(position4 == undefined).assertTrue();
          let position5 = runs[0].getPositions(null);
          console.info('www data position5 ' + JSON.stringify(position5));
          expect(position5 == undefined).assertTrue();
          let position6 = runs[0].getPositions(undefined);
          console.info('www data position6 ' + JSON.stringify(position6));
          expect(position6 == undefined).assertTrue();
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_Runs_1500
     * @tc.name SUB_ARKUIX_GraphicText_Runs_1500
     * @tc.desc test getStringIndices
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Runs_1500====";
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
            fontSize: 50,
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            maxLines: 1,
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          paragraph.layoutSync(600);
          let lines = paragraph.getTextLines();
          let runs = lines[0].getGlyphRuns();
          console.info('www data runs ' + JSON.stringify(runs));
          expect(runs.length > 0).assertTrue();
          let offset = runs[0].getOffsets();
          console.info('www data offset ' + JSON.stringify(offset));
          expect(offset.length > 0).assertTrue();
          let indices = runs[0].getStringIndices(); // 获取渲染块全部字符索引
          console.info('www data indices ' + JSON.stringify(indices));
          expect(indices.length > 0).assertTrue();
          let indicesRange1 = runs[0].getStringIndices({ start: 1, end: 2 }); // 获取渲染块从起始位置1开始, 长度为2范围内的字符索引
          console.info('www data indicesRange1 ' + JSON.stringify(indicesRange1));
          expect(indicesRange1.length > 0).assertTrue();
          let indicesRange2 = runs[0].getStringIndices({ start: -1, end: 2 }); // -1是非法参数，将返回undefined
          console.info('www data indicesRange2 ' + JSON.stringify(indicesRange2));
          expect(indicesRange2 == undefined).assertTrue();
          let indicesRange3 = runs[0].getStringIndices({ start: 0, end: -10 }); // -10是非法参数，将返回undefined
          console.info('www data indicesRange3 ' + JSON.stringify(indicesRange3));
          expect(indicesRange3 == undefined).assertTrue();
          let indicesNull = runs[0].getStringIndices(null); // null是非法参数，将返回undefined
          console.info('www data indicesNull ' + JSON.stringify(indicesNull));
          expect(indicesNull == undefined).assertTrue();
          let indicesUndefined = runs[0].getStringIndices(undefined); // undefined是非法参数，将返回undefined
          console.info('www data indicesUndefined ' + JSON.stringify(indicesUndefined));
          expect(indicesUndefined == undefined).assertTrue();
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_1600
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_1600
     * @tc.desc      : test run getTextDirection getAdvances
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Runs_0016===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            verticalAlign: text.TextVerticalAlign.CENTER,
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          try {
            text.setTextUndefinedGlyphDisplay(text.TextUndefinedGlyphDisplay.USE_TOFU);
          } catch (err) {
            console.info('www data test error ' + msg + err);
            expect().assertFail();
          }
          paragraph.layoutSync(600);
          let lines: Array<text.TextLine> = paragraph.getTextLines();
          let length = lines.length;
          for (let i = 0; i < length; i++) {
            let runs: Array<text.Run> = lines[i].getGlyphRuns();
            let x: number = 0;
            let y: number = 0;
            for (let j = 0; j < runs.length; j++) {
              let glyphs = runs[j].getGlyphs();
              let font = runs[j].getFont();
              try {
                let textDirection = runs[0].getTextDirection();
                expect(textDirection).assertEqual(text.TextDirection.LTR);
              } catch (err) {
                console.info(msg + JSON.stringify(err));
                expect().assertFail();
              }
              try {
                let advancesRange1 = runs[0].getAdvances({ start: 0, end: 10 });
                expect(advancesRange1.length > 0).assertTrue();
                let advancesRange2 = runs[0].getAdvances({ start: 10, end: 10 });
                expect(advancesRange2.length == 0).assertTrue();
                let advancesRange3 = runs[0].getAdvances({ start: 0, end: -10 });
                expect(advancesRange3).assertEqual(undefined);
              } catch (err) {
                console.info(msg + JSON.stringify(err));
                expect().assertFail();
              }
              try {
                let advancesRange = runs[0].getAdvances({ start: -1, end: 2 });
                expect(advancesRange).assertEqual(undefined);
              } catch (err) {
                console.info(msg + JSON.stringify(err));
                expect().assertFail();
              }

            }
          }
          try {
            fontCollection.unloadFontSync('custom');
          } catch (err) {
            console.info('www data test error ' + msg + err);
            expect().assertFail();
          }
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_Runs_1700
     * @tc.name      : SUB_ARKUIX_GraphicText_Runs_1700
     * @tc.desc      : test run getTextDirection getAdvances
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_Runs_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_Runs_0017===="
        let fontCollection: text.FontCollection = new text.FontCollection();
        try {
          fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
          let fontFamilies: Array<string> = ["ComingSoon"]
          let myTextStyle: text.TextStyle = {
            fontFamilies: fontFamilies,
          };
          let myParagraphStyle: text.ParagraphStyle = {
            textStyle: myTextStyle,
            verticalAlign: text.TextVerticalAlign.BOTTOM,
            textDirection: text.TextDirection.RTL
          }
          let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
          let textData = "سىناق تېكىستى";
          paragraphBuilder.addText(textData);
          let paragraph: text.Paragraph = paragraphBuilder.build();
          try {
            text.setTextUndefinedGlyphDisplay(text.TextUndefinedGlyphDisplay.USE_DEFAULT);
          } catch (err) {
            console.info('www data test error ' + msg + err);
            expect().assertFail();
          }
          paragraph.layoutSync(600);
          let lines: Array<text.TextLine> = paragraph.getTextLines();
          let length = lines.length;
          for (let i = 0; i < length; i++) {
            let runs: Array<text.Run> = lines[i].getGlyphRuns();
            let x: number = 0;
            let y: number = 0;
            for (let j = 0; j < runs.length; j++) {
              let glyphs = runs[j].getGlyphs();
              let font = runs[j].getFont();
              try {
                let textDirection = runs[0].getTextDirection();
                expect(textDirection).assertEqual(text.TextDirection.RTL);
              } catch (err) {
                console.info(msg + JSON.stringify(err));
                expect().assertFail();
              }
              try {
                let advancesRange = runs[0].getAdvances({ start: 0, end: -10 });
                expect(advancesRange).assertEqual(undefined);
              } catch (err) {
                console.info(msg + JSON.stringify(err));
                expect().assertFail();
              }
              try {
                let advancesNull = runs[0].getAdvances(null);
                expect(advancesNull).assertEqual(undefined);
              } catch (err) {
                console.info(msg + JSON.stringify(err));
                expect().assertFail();
              }

            }
          }
          try {
            fontCollection.unloadFont('custom');
          } catch (err) {
            console.info('www data test error ' + msg + err);
            expect().assertFail();
          }
          done();
        } catch (err) {
          console.info(msg + 'test error' + err);
          expect().assertFail();
          done();
        }
      })
    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0100
     * @tc.name      : SUB_ARKUIX_GraphicText_LineTypeset_0100
     * @tc.desc      : Constructs a LineTypeset object test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level  1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_0100"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      try {
        let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
        console.info(msg + 'build LineTypeset successed');
        try {
          let count = lineTypeset.getLineBreak(0, 800);
          if (count != str.length) {
            console.info(msg + 'getLineBreak return error value');
            expect().assertFail();
          }
        } catch (err) {
          console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
          expect().assertFail();
        }
        try {
          lineTypeset.createLine(0, str.length);
        } catch (err) {
          console.info(msg + 'build LineTypeset error cause: ' + JSON.stringify(err));
          expect().assertFail();
        }
      } catch (err) {
        console.info(msg + 'build LineTypeset error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0200
     * @tc.name      : run SUB_ARKUIX_GraphicText_LineTypeset_0200
     * @tc.desc      : getLineBreak interface abnormal parameter test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_0200"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
      console.info(msg + 'build LineTypeset successed');
      try {
        let count = lineTypeset.getLineBreak(null, 800);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let count = lineTypeset.getLineBreak(undefined, 800);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0300
     * @tc.name      : SUB_ARKUIX_GraphicText_LineTypeset_0300
     * @tc.desc      : getLineBreak interface parameter test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_0300"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
      expect(lineTypeset != null).assertTrue();
      console.info(msg + 'build LineTypeset successed');
      try {
        let count = lineTypeset.getLineBreak(-10, 800);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let count = lineTypeset.getLineBreak(0, -10);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let count = lineTypeset.getLineBreak(Number.MIN_VALUE, Number.MAX_VALUE);
        expect(count).assertEqual(str.length);
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }

      try {
        let count = lineTypeset.getLineBreak(Number.MAX_VALUE, Number.MIN_VALUE);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let count = lineTypeset.getLineBreak(1.23, Number.MAX_VALUE);
        expect(count).assertEqual(str.length - 1);
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0400
     * @tc.name      : SUB_ARKUIX_GraphicText_LineTypeset_0400
     * @tc.desc      : getLineBreak interface parameter test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_0400"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
      expect(lineTypeset != null).assertTrue();
      console.info(msg + 'build LineTypeset successed');
      try {
        let count = lineTypeset.getLineBreak(0, display.getDefaultDisplaySync().width);
        expect(count).assertEqual(str.length);
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }

      try {
        let count = lineTypeset.getLineBreak(3, display.getDefaultDisplaySync().width);
        expect(count).assertEqual(str.length - 3);
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0500
     * @tc.name      : SUB_ARKUIX_GraphicText_LineTypeset_0500
     * @tc.desc      : getLineBreak interface parameter test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_0500"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
      expect(lineTypeset != null).assertTrue();
      console.info(msg + 'build LineTypeset successed');
      try {
        let count = lineTypeset.getLineBreak(0, null);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let count = lineTypeset.getLineBreak(0, undefined);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0600
     * @tc.name      : SUB_ARKUIX_GraphicText_LineTypeset_0600
     * @tc.desc      : Constructs a LineTypeset object test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_006"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
      expect(lineTypeset != null).assertTrue();
      console.info(msg + 'build LineTypeset successed');
      try {
        let line = lineTypeset.createLine(0, str.length);
        expect(6).assertEqual(line.getGlyphCount());
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }

      try {
        let line = lineTypeset.createLine(1, 5);
        expect(5).assertEqual(line.getGlyphCount());
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0700
     * @tc.name      : SUB_ARKUIX_GraphicText_LineTypeset_0700
     * @tc.desc      : createLine interface parameter test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_0700"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
      console.info(msg + 'build LineTypeset successed');
      try {
        lineTypeset.createLine(-10, str.length);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        lineTypeset.createLine(0, -10);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let line = lineTypeset.createLine(Number.MIN_VALUE, Number.MAX_VALUE);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let line = lineTypeset.createLine(Number.MAX_VALUE, Number.MIN_VALUE);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        let line = lineTypeset.createLine(1.23, str.length);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_LineTypeset_0800
     * @tc.name      : SUB_ARKUIX_GraphicText_LineTypeset_0800
     * @tc.desc      : createLine interface parameter test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('SUB_ARKUIX_GraphicText_LineTypeset_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let msg = "SUB_ARKUIX_GraphicText_LineTypeset_0800"
      console.info(msg + 'begin');
      let textStyle: text.TextStyle = {
        color: {
          alpha: 255,
          red: 0,
          green: 0,
          blue: 255
        },
        fontSize: 66,
      };
      let paragraphStyle: text.ParagraphStyle = {
        textStyle: textStyle,
        align: 3,
      };
      let fontCollection = new text.FontCollection();
      let paragraphGraphBuilder = new text.ParagraphBuilder(paragraphStyle, fontCollection);
      let str: string = "123456";
      try {
        paragraphGraphBuilder.addText(str);
        console.info(msg + 'addText successed first');
      } catch (err) {
        console.info(msg + 'second addText error cause: ' + JSON.stringify(err));
        expect().assertFail();
      }
      let lineTypeset = paragraphGraphBuilder.buildLineTypeset();
      expect(lineTypeset != null).assertTrue();
      console.info(msg + 'build LineTypeset successed');
      try {
        lineTypeset.createLine(null, str.length);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        lineTypeset.createLine(undefined, str.length);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        lineTypeset.createLine(0, null);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }

      try {
        lineTypeset.createLine(0, undefined);
        expect().assertFail();
      } catch (err) {
        console.info(msg + 'getLineBreak error cause: ' + JSON.stringify(err));
        expect().not().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_0100
     * @tc.name      : SUB_ARKUIX_GraphicText_0100
     * @tc.desc      : test text setTextHighContrast
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = "====SUB_ARKUIX_GraphicText_0100===="
      let fontCollection: text.FontCollection = new text.FontCollection();
      try {
        fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
        let fontFamilies: Array<string> = ["ComingSoon"]
        let myTextStyle: text.TextStyle = {
          fontFamilies: fontFamilies,
        };
        let myParagraphStyle: text.ParagraphStyle = {
          textStyle: myTextStyle,
        }
        let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
        let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
        paragraphBuilder.addText(textData);
        let paragraph: text.Paragraph = paragraphBuilder.build();
        try {
          text.setTextHighContrast(text.TextHighContrast.TEXT_APP_DISABLE_HIGH_CONTRAST);
        } catch (err) {
          console.info('www data test error ' + msg + err);
          expect().assertFail();
        }
        paragraph.layoutSync(600);
        done();
      } catch (err) {
        console.info(msg + 'test error' + err);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_0200
     * @tc.name      : SUB_ARKUIX_GraphicText_0200
     * @tc.desc      : test text setTextHighContrast
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = "====SUB_ARKUIX_GraphicText_0200===="
      let fontCollection: text.FontCollection = new text.FontCollection();
      try {
        fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
        let fontFamilies: Array<string> = ["ComingSoon"]
        let myTextStyle: text.TextStyle = {
          fontFamilies: fontFamilies,
        };
        let myParagraphStyle: text.ParagraphStyle = {
          textStyle: myTextStyle,
          verticalAlign: text.TextVerticalAlign.TOP,
        }
        let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
        let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
        paragraphBuilder.addText(textData);
        let paragraph: text.Paragraph = paragraphBuilder.build();
        try {
          text.setTextHighContrast(text.TextHighContrast.TEXT_APP_ENABLE_HIGH_CONTRAST);
        } catch (err) {
          console.info('www data test error ' + msg + err);
          expect().assertFail();
        }
        paragraph.layoutSync(600);
        done();
      } catch (err) {
        console.info(msg + 'test error' + err);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number    : SUB_ARKUIX_GraphicText_0300
     * @tc.name      : SUB_ARKUIX_GraphicText_0300
     * @tc.desc      : test text setTextUndefinedGlyphDisplay
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('SUB_ARKUIX_GraphicText_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = "====SUB_ARKUIX_GraphicText_0300===="
      let fontCollection: text.FontCollection = new text.FontCollection();
      try {
        fontCollection.loadFontSync('ComingSoon', $rawfile("ComingSoon.ttf"));
        let fontFamilies: Array<string> = ["ComingSoon"]
        let myTextStyle: text.TextStyle = {
          fontFamilies: fontFamilies,
        };
        let myParagraphStyle: text.ParagraphStyle = {
          textStyle: myTextStyle,
          verticalAlign: text.TextVerticalAlign.BASELINE,
        }
        let myPlaceholderSpan: text.PlaceholderSpan = {
          width: 22,
          height: 33,
          align: text.PlaceholderAlignment.FOLLOW_PARAGRAPH,
          baseline: text.TextBaseline.ALPHABETIC,
          baselineOffset: 66
        };
        let paragraphBuilder: text.ParagraphBuilder = new text.ParagraphBuilder(myParagraphStyle, fontCollection);
        let textData = "测试 loadFontSync 加载字体ComingSoon.ttf";
        paragraphBuilder.addText(textData);
        paragraphBuilder.addPlaceholder(myPlaceholderSpan);
        let paragraph: text.Paragraph = paragraphBuilder.build();
        try {
          text.setTextUndefinedGlyphDisplay(text.TextUndefinedGlyphDisplay.USE_DEFAULT);
        } catch (err) {
          console.info('www data test error ' + msg + err);
          expect().assertFail();
        }
        paragraph.layoutSync(600);
        done();
      } catch (err) {
        console.info(msg + 'test error' + err);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_0400
     * @tc.name SUB_ARKUIX_GraphicText_0400
     * @tc.desc test text matchFontDescriptors getSystemFontFullNamesByType
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = "====SUB_ARKUIX_GraphicText_0400====";
      let fontType: text.SystemFontType = text.SystemFontType.ALL;
      let fontTypeNums = await text.getSystemFontFullNamesByType(fontType);
      console.info("ALL" + msg + fontTypeNums);
      console.info('ALL' + fontTypeNums.length);
      expect(fontTypeNums.length >= 0).assertTrue();

      let fontType2: text.SystemFontType = text.SystemFontType.GENERIC;
      let fontTypeNums2 = await text.getSystemFontFullNamesByType(fontType2);
      console.info("GENERIC" + msg + fontTypeNums2);
      console.info("GENERIC" + msg + fontTypeNums2.length);
      expect(fontTypeNums2.length >= 0).assertTrue();

      let fontCollection = text.FontCollection.getGlobalInstance();
      fontCollection.loadFontSync('HarmonyOS_Sans_SC',
        $rawfile("HarmonyOS Sans/HarmonyOS_Sans_SC/HarmonyOS_Sans_SC_Bold.ttf"));
      let fontTypeNums1 = await text.getSystemFontFullNamesByType(text.SystemFontType.CUSTOMIZED);
      expect(fontTypeNums1.length >= 0).assertTrue();

      let fontDescriptor1 = await text.matchFontDescriptors({
        weight: text.FontWeight.W400,
      })
      console.info("matchFontDescriptors1" + msg + fontDescriptor1.length);
      expect(fontDescriptor1.length >= 0).assertTrue();

      let fontDescriptor2 = await text.matchFontDescriptors({})
      console.info('matchFontDescriptors2' + msg + JSON.stringify(fontDescriptor2));
      expect(fontDescriptor2.length >= 0).assertTrue();
      done();
    })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_0500
     * @tc.name SUB_ARKUIX_GraphicText_0500
     * @tc.desc test text getFontDescriptorByFullName set SystemFontType is GENERIC
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_005===="
        console.info(msg + ' begin ');
        if (platform == "Android" || platform == "OpenHarmony") {
          try {
            let fontType: text.SystemFontType = text.SystemFontType.GENERIC
            let promise = text.getFontDescriptorByFullName("Noto Sans Pau Cin Hau Regular", fontType)
            promise.then((fontdecriptor) => {
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
              console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)
              expect(fontdecriptor != null).assertTrue();
            }).catch((error: BusinessError) => {
              console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
              expect().assertFail();
            });
            done()
          } catch (err) {
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
            expect().assertFail();
            done()
          }
        } else if (platform == "iOS") {
          try {
            let fontType: text.SystemFontType = text.SystemFontType.GENERIC
            let promise = text.getFontDescriptorByFullName("American Typewriter", fontType)
            promise.then((fontdecriptor) => {
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
              console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)
              expect(fontdecriptor != null).assertTrue();
              done()
            }).catch((error: BusinessError) => {
              console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
              expect().assertFail();
              done()
            });
          } catch (err) {
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
            expect().assertFail();
            done()
          }
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_0600
     * @tc.name SUB_ARKUIX_GraphicText_0600
     * @tc.desc test text getFontDescriptorByFullName set SystemFontType is ALL
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_006===="
        console.info(msg + ' begin ');
        if (platform == "Android" || platform == "OpenHarmony") {
          try {
            let fontType: text.SystemFontType = text.SystemFontType.ALL
            let promise = text.getFontDescriptorByFullName("Noto Sans Marchen Regular", fontType)
            promise.then((fontdecriptor) => {
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
              console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)
              expect(fontdecriptor != null).assertTrue();
              done()
            }).catch((error: BusinessError) => {
              console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
              expect().assertFail();
              done()
            });
          } catch (err) {
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
            expect().assertFail();
            done()
          }
        } else if (platform == "iOS") {
          try {
            let fontType: text.SystemFontType = text.SystemFontType.ALL
            let promise = text.getFontDescriptorByFullName("American Typewriter", fontType)
            promise.then((fontdecriptor) => {
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
              console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
              console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)
              expect(fontdecriptor != null).assertTrue();
              done()
            }).catch((error: BusinessError) => {
              console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
              expect().assertFail();
              done()
            });

          } catch (err) {
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
            console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
            expect().assertFail();
            done()
          }
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_0700
     * @tc.name SUB_ARKUIX_GraphicText_0700
     * @tc.desc test text getFontDescriptorByFullName set SystemFontType is CUSTOMIZED
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_007===="
        console.info(msg + ' begin ');
        try {
          let fontCollection1 = text.FontCollection.getGlobalInstance();
          fontCollection1.loadFontSync('HarmonyOS_Sans_SC',
            $rawfile("HarmonyOS Sans/HarmonyOS_Sans_SC/HarmonyOS_Sans_SC_Bold.ttf"));
          let fontType: text.SystemFontType = text.SystemFontType.ALL
          let promise = text.getFontDescriptorByFullName("HarmonyOS_Sans_SC", fontType)
          promise.then((fontdecriptor) => {
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
            expect(fontdecriptor != null).assertTrue();
            done()
          }).catch((error: BusinessError) => {
            console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
            expect().assertFail();
            done()
          });
        } catch (err) {
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_0800
     * @tc.name SUB_ARKUIX_GraphicText_0800
     * @tc.desc test text getFontDescriptorByFullName set fullName is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_0800===="
        console.info(msg + ' begin ');
        try {
          let fontType: text.SystemFontType = text.SystemFontType.ALL
          let promise = text.getFontDescriptorByFullName(null, fontType)
          promise.then((fontdecriptor) => {
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
            console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)

          }).catch((error: BusinessError) => {
            console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
            done()
          });
        } catch (err) {
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_0900
     * @tc.name SUB_ARKUIX_GraphicText_0900
     * @tc.desc test text getFontDescriptorByFullName set fullName is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_0900===="
        console.info(msg + ' begin ');
        try {
          let fontType: text.SystemFontType = text.SystemFontType.ALL
          let promise = text.getFontDescriptorByFullName(undefined, fontType)
          promise.then((fontdecriptor) => {
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
            console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)

          }).catch((error: BusinessError) => {
            console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
            done()
          });
        } catch (err) {
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_1000
     * @tc.name SUB_ARKUIX_GraphicText_1000
     * @tc.desc test text getSystemFontFullNamesByType set fontType is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_1000===="
        console.info(msg + ' begin ');
        try {
          let promise = text.getSystemFontFullNamesByType(undefined)
          promise.then((fontdecriptor) => {
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
            console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)

          }).catch((error: BusinessError) => {
            console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
            done()
          });
        } catch (err) {
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_1100
     * @tc.name SUB_ARKUIX_GraphicText_1100
     * @tc.desc test text getSystemFontFullNamesByType set fontType is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_1100===="
        console.info(msg + ' begin ');
        try {
          let promise = text.getSystemFontFullNamesByType(null)
          promise.then((fontdecriptor) => {
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + JSON.stringify(fontdecriptor))
            console.log(msg + ' Succeed in text.getFontDescriptorByFullName  ' + fontdecriptor)
            console.info(msg + ` desc: ${JSON.stringify(fontdecriptor)}`)

          }).catch((error: BusinessError) => {
            console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
            done()
          });
        } catch (err) {
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_1200
     * @tc.name SUB_ARKUIX_GraphicText_1200
     * @tc.desc test text matchFontDescriptors Type is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_1200===="
        console.info(msg + ' begin ');
        try {
          let promise = text.matchFontDescriptors(undefined)
          promise.then((data) => {
            data.forEach((item, index) => {
              console.info(` Font descriptor result: ${JSON.stringify(item)}` + '\n')
            })
          }).catch((error: BusinessError) => {
            console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
            done()
          });
        } catch (err) {
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_1300
     * @tc.name SUB_ARKUIX_GraphicText_1300
     * @tc.desc test text matchFontDescriptors Type is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_1300===="
        console.info(msg + ' begin ');
        try {
          let promise = text.matchFontDescriptors(null)
          promise.then((data) => {
            data.forEach((item, index) => {
              console.info(` Font descriptor result: ${JSON.stringify(item)}` + '\n')
            })
          }).catch((error: BusinessError) => {
            console.error(msg + ` Failed to get fontDescriptor by fullName, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
            done()
          });
        } catch (err) {
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in text.getFontDescriptorByFullName.  Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_FontCollection_0100
     * @tc.name SUB_ARKUIX_GraphicText_FontCollection_0100
     * @tc.desc test FontCollection loadFontSync
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_FontCollection_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_FontCollection_0100===="
        console.info(msg + ' begin ');
        try {
          let fontCollection = text.FontCollection.getGlobalInstance();
          expect(fontCollection != undefined).assertTrue();
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' +
          JSON.stringify(fontCollection))
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
          fontCollection.loadFontSync('HarmonyOS_Sans_SC_Bold',
            $rawfile("HarmonyOS Sans/HarmonyOS_Sans_SC/HarmonyOS_Sans_SC_Bold.ttf"));
          console.log(msg + ' Succeed in fontCollection.loadFontSync.')
          try {
            fontCollection.unloadFont('HarmonyOS_Sans_SC_Bold');
          } catch (err) {
            console.info('www data test error ' + msg + err);
            expect().assertFail();
          }
          done()
        } catch (err) {
          console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_FontCollection_0200
     * @tc.name SUB_ARKUIX_GraphicText_FontCollection_0200
     * @tc.desc test FontCollection loadFont Promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_FontCollection_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_FontCollection_0200===="
        console.info(msg + ' begin ');
        try {
          let fontCollection = text.FontCollection.getGlobalInstance();
          expect(fontCollection != undefined).assertTrue();
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' +
          JSON.stringify(fontCollection))
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
          fontCollection.loadFont("HarmonyOS_Sans_SC_Bold",
            $rawfile("HarmonyOS Sans/HarmonyOS_Sans_SC/HarmonyOS_Sans_SC_Bold.ttf"))
            .then(() => {
              console.log(msg + ' Succeed in fontCollection.loadFontSync.')
            })
          fontCollection.unloadFont("HarmonyOS_Sans_SC_Bold").then((data) => {
          }).catch((error: Error) => {
            console.error(`wangbohan Failed to do unloadFont, error: ${JSON.stringify(error)} message: ${error.message}`);
          });
          done()

        } catch (err) {
          console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in fontCollection.loadFontSync.    Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_FontCollection_0300
     * @tc.name SUB_ARKUIX_GraphicText_FontCollection_0300
     * @tc.desc test FontCollection clearCaches Promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_FontCollection_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_FontCollection_0300===="
        console.info(msg + ' begin ');
        try {
          let fontCollection = text.FontCollection.getGlobalInstance();
          expect(fontCollection != undefined).assertTrue();
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
          fontCollection.clearCaches();
          console.log(msg + ' Succeed in fontCollection.clearCaches.')
          done()

        } catch (err) {
          console.info(msg + ' Failed in fontCollection.getGlobalInstance.    Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in fontCollection.getGlobalInstance.    Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_FontCollection_0400
     * @tc.name SUB_ARKUIX_GraphicText_FontCollection_0400
     * @tc.desc test FontCollection loadFont Promise set null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_FontCollection_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_FontCollection_0400===="
        console.info(msg + ' begin ');
        try {
          let fontCollection = text.FontCollection.getGlobalInstance();
          expect(fontCollection != undefined).assertTrue();
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' +
          JSON.stringify(fontCollection))
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
          fontCollection.loadFont(null, null)
            .then(() => {
              console.log(msg + ' Succeed in fontCollection.loadFont.')
            }).catch((error: BusinessError) => {
            console.error(`Failed in fontCollection.loadFont, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
          });
          done()
        } catch (err) {
          console.info(msg + ' Failed in fontCollection.loadFont  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in fontCollection.loadFont   Cause: ' + err);
          expect().assertFail();
          done()
        }
      })

    /**
     * @tc.number SUB_ARKUIX_GraphicText_FontCollection_0500
     * @tc.name SUB_ARKUIX_GraphicText_FontCollection_0500
     * @tc.desc test FontCollection loadFont Promise set undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level Level1
     */
    it('SUB_ARKUIX_GraphicText_FontCollection_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "====SUB_ARKUIX_GraphicText_FontCollection_0500===="
        console.info(msg + ' begin ');
        try {
          let fontCollection = text.FontCollection.getGlobalInstance();
          expect(fontCollection != undefined).assertTrue();
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' +
          JSON.stringify(fontCollection))
          console.log(msg + ' text.FontCollection.getGlobalInstance OK, fontCollection is  ' + fontCollection)
          fontCollection.loadFont(undefined, undefined)
            .then(() => {
              console.log(msg + ' Succeed in fontCollection.loadFont.')
            }).catch((error: BusinessError) => {
            console.error(`Failed in fontCollection.loadFont, error: ${JSON.stringify(error)}`);
            expect(error.code).assertEqual(401);
          });
          done()
        } catch (err) {
          console.info(msg + ' Failed in fontCollection.loadFont  Cause: ' + JSON.stringify(err));
          console.info(msg + ' Failed in fontCollection.loadFont  Cause: ' + err);
          expect().assertFail()
          done()
        }
      })

  })
}

