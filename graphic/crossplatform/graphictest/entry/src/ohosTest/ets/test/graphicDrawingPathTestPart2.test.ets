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
import { describe, beforeAll,  it, expect, TestType, Level, Size } from "@ohos/hypium"
import { BusinessError } from '@ohos.base';
import { common2D, drawing } from '@kit.ArkGraphics2D';
import image from '@ohos.multimedia.image';

async function sleep(time: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve();
    }, time);
  });
}

export default function graphicDrawingPathTestPart2() {
  describe('graphicDrawingPathTest', () => {
    console.log('describe graphicDrawingPathTest start!!!')
    beforeAll(async () => {
    })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0100
     * @tc.name      : testPathDashStyle0001
     * @tc.desc      : The property of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('testPathDashStyle0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = "testPathDashStyle0001"
      try {
        console.info(msg + ' Succeeded in PathDashStyle.');
        expect(drawing.PathDashStyle.TRANSLATE == 0).assertTrue()
        expect(drawing.PathDashStyle.ROTATE == 1).assertTrue()
        expect(drawing.PathDashStyle.MORPH == 2).assertTrue()
        console.info(msg + ' drawing.PathDashStyle.TRANSLATE: ' + drawing.PathDashStyle.TRANSLATE);
        console.info(msg + ' drawing.PathDashStyle.ROTATE: ' + drawing.PathDashStyle.ROTATE);
        console.info(msg + ' drawing.PathDashStyle.MORPH: ' + drawing.PathDashStyle.MORPH);
        done()
      } catch (err) {
        console.log(msg + " Faild in drawing.PathDashStyle " + JSON.stringify(err))
        console.log(msg + " Faild in drawing.PathDashStyle " + err)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0200
     * @tc.name      : testPathEffectCreatePathDashEffect0002
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('testPathEffectCreatePathDashEffect0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "testPathEffectCreatePathDashEffect0002"
        const color = new ArrayBuffer(96);
        let opts: image.InitializationOptions = {
          editable: true,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        }
        image.createPixelMap(color, opts).then((pixelMap) => {
          const canvas = new drawing.Canvas(pixelMap);
          let pen = new drawing.Pen();
          const penColor: common2D.Color = {
            alpha: 255,
            red: 255,
            green: 0,
            blue: 0
          }
          pen.setColor(penColor);
          pen.setStrokeWidth(10);
          canvas.attachPen(pen);
          pen.setAntiAlias(true);

          const path = new drawing.Path();
          path.moveTo(100, 100);
          path.lineTo(150, 50);
          path.lineTo(200, 100);

          const path1 = new drawing.Path();
          path1.moveTo(0, 0);
          path1.lineTo(10, 0);
          path1.lineTo(20, 10);
          path1.lineTo(0, 10);

          let pathEffect1: drawing.PathEffect = drawing.PathEffect.createPathDashEffect(path1, 50, -30,
            drawing.PathDashStyle.MORPH);
          pen.setPathEffect(pathEffect1);

          canvas.attachPen(pen);
          canvas.drawPath(path);
          canvas.detachPen();
          console.info(msg + ' drawing.PathEffect.createPathDashEffect: ' + pathEffect1);
          console.info(msg + ' drawing.PathEffect.createPathDashEffect: ' + JSON.stringify(pathEffect1));
          done()
        }).catch((err: BusinessError) => {
          console.log(msg + " Faild in drawing.PathEffect.createPathDashEffect " + JSON.stringify(err))
          console.log(msg + " Faild in drawing.PathEffect.createPathDashEffect " + err)
          expect().assertFail()
          done()
        })
      })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0300
     * @tc.name      : testPathEffectCreateSumPathEffect0003
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('testPathEffectCreateSumPathEffect0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "testPathEffectCreateSumPathEffect0003"
        const color = new ArrayBuffer(96);
        let opts: image.InitializationOptions = {
          editable: true,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        }
        image.createPixelMap(color, opts).then((pixelMap) => {
          const canvas = new drawing.Canvas(pixelMap);
          let intervals = [10, 5];
          let pathEffectOne = drawing.PathEffect.createDashPathEffect(intervals, 5);
          let pathEffectTwo = drawing.PathEffect.createDashPathEffect(intervals, 10);
          let effect = drawing.PathEffect.createSumPathEffect(pathEffectOne, pathEffectTwo);
          console.info(msg + ' drawing.PathEffect.createSumPathEffect: ' + effect);
          console.info(msg + ' drawing.PathEffect.createSumPathEffect: ' + JSON.stringify(effect));
          done()
        }).catch((err: BusinessError) => {
          console.log(msg + " Faild in drawing.PathEffect.createSumPathEffect " + JSON.stringify(err))
          console.log(msg + " Faild in drawing.PathEffect.createSumPathEffect " + err)
          expect().assertFail()
          done()
        })
      })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0400
     * @tc.name      : testPathEffectCreateDiscretePathEffect0004
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('testPathEffectCreateDiscretePathEffect0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "testPathEffectCreateDiscretePathEffect0004"
        const color = new ArrayBuffer(96);
        let opts: image.InitializationOptions = {
          editable: true,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        }
        image.createPixelMap(color, opts).then((pixelMap) => {
          const canvas = new drawing.Canvas(pixelMap);
          let effect = drawing.PathEffect.createDiscretePathEffect(100, -50, 0);
          console.info(msg + ' drawing.PathEffect.createDiscretePathEffect: ' + effect);
          console.info(msg + ' drawing.PathEffect.createDiscretePathEffect: ' + JSON.stringify(effect));
          done()
        }).catch((err: BusinessError) => {
          console.log(msg + " Faild in drawing.PathEffect.createDiscretePathEffect " + JSON.stringify(err))
          console.log(msg + " Faild in drawing.PathEffect.createDiscretePathEffect " + err)
          expect().assertFail()
          done()
        })
      })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0500
     * @tc.name      : testPathEffectCreateComposePathEffect0005
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('testPathEffectCreateComposePathEffect0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let msg = "testPathEffectCreateComposePathEffect0005"
        const color = new ArrayBuffer(96);
        let opts: image.InitializationOptions = {
          editable: true,
          pixelFormat: 3,
          size: {
            height: 4,
            width: 6
          }
        }
        image.createPixelMap(color, opts).then((pixelMap) => {
          const canvas = new drawing.Canvas(pixelMap);
          let pathEffect1 = drawing.PathEffect.createCornerPathEffect(100);
          let pathEffect2 = drawing.PathEffect.createCornerPathEffect(10);
          let effect = drawing.PathEffect.createComposePathEffect(pathEffect1, pathEffect2);
          console.info(msg + ' drawing.PathEffect.createComposePathEffect: ' + effect);
          console.info(msg + ' drawing.PathEffect.createComposePathEffect: ' + JSON.stringify(effect));
          done()
        }).catch((err: BusinessError) => {
          console.log(msg + " Faild in drawing.PathEffect.createComposePathEffect " + JSON.stringify(err))
          console.log(msg + " Faild in drawing.PathEffect.createComposePathEffect " + err)
          expect().assertFail()
          done()
        })
      })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0600
     * @tc.name      : testPenGetHexColor0006
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('testPenGetHexColor0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let msg = "testPenGetHexColor0006"
      try {
        let color: common2D.Color = {
          alpha: 255,
          red: 255,
          green: 0,
          blue: 0
        };
        let pen = new drawing.Pen();
        pen.setColor(color);
        let hex_color: number = pen.getHexColor();
        console.info(msg + ' getHexColor:  ', hex_color.toString(16));
        console.info(msg + ' pen.getHexColor: ' + JSON.stringify(hex_color));
        done()
      } catch (err) {
        console.log(msg + " Faild in pen.getHexColor " + JSON.stringify(err))
        console.log(msg + " Faild in pen.getHexColor " + err)
        expect().assertFail()
        done()
      }
    })
  })
}