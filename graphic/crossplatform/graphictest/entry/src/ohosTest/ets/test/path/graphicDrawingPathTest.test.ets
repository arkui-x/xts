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

import { describe, beforeAll, it, expect, TestType, Level, Size } from "@ohos/hypium"
import { BusinessError } from '@ohos.base';
import { common2D, drawing } from '@kit.ArkGraphics2D';
import image from '@ohos.multimedia.image';

export default function graphicDrawingPathTest() {
  describe('graphicDrawingPathTest', ()=> {
    console.log('describe graphicDrawingPathTest start!!!')

    beforeAll(async ()=> {
    })
    
    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0100
     * @tc.name      : testPathIteratorVerb0001
     * @tc.desc      : The property of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testPathIteratorVerb0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function)=> {
      let msg = " ====testPathIteratorVerb0001==== "
      try {
        console.info(msg + ' Succeeded in PathIteratorVerb.');
        expect(drawing.PathIteratorVerb.MOVE == 0).assertTrue()
        expect(drawing.PathIteratorVerb.LINE == 1).assertTrue()
        expect(drawing.PathIteratorVerb.QUAD == 2).assertTrue()
        expect(drawing.PathIteratorVerb.CONIC == 3).assertTrue()
        expect(drawing.PathIteratorVerb.CUBIC == 4).assertTrue()
        expect(drawing.PathIteratorVerb.CLOSE == 5).assertTrue()
        expect(drawing.PathIteratorVerb.DONE == drawing.PathIteratorVerb.CLOSE + 1	).assertTrue()
        console.info(msg + ' drawing.PathIteratorVerb.MOVE: ' + drawing.PathIteratorVerb.MOVE);
        console.info(msg + ' drawing.PathIteratorVerb.LINE: ' + drawing.PathIteratorVerb.LINE);
        console.info(msg + ' drawing.PathIteratorVerb.QUAD: ' + drawing.PathIteratorVerb.QUAD);
        console.info(msg + ' drawing.PathIteratorVerb.CONIC: ' + drawing.PathIteratorVerb.CONIC);
        console.info(msg + ' drawing.PathIteratorVerb.CUBIC: ' + drawing.PathIteratorVerb.CUBIC);
        console.info(msg + ' drawing.PathIteratorVerb.CLOSE: ' + drawing.PathIteratorVerb.CLOSE);
        console.info(msg + ' drawing.PathIteratorVerb.DONE: ' + drawing.PathIteratorVerb.DONE);
        done()
      } catch (err) {
        console.log(msg + " Faild in drawing.PathIteratorVerb " + JSON.stringify(err))
        console.log(msg + " Faild in drawing.PathIteratorVerb " + err)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0200
     * @tc.name      : testPathIteratorNext0002
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testPathIteratorNext0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function)=> {
      let msg = " ====testPathIteratorNext0002==== "
      try {
        let path: drawing.Path = new drawing.Path();
        path.moveTo(10, 20);
        let iter: drawing.PathIterator = new drawing.PathIterator(path);
        let verbStr: Array<string> = ["MOVE", "LINE", "QUAD", "CONIC", "CUBIC", "CLOSE", "DONE"];
        let pointCount: Array<number> = [1,2,3,4,4,0,0]; //1,2,3,3.5,4,0,0
        let points: Array<common2D.Point> = [{x: 0, y: 0}, {x: 0, y: 0}, {x: 0, y: 0}, {x: 0, y: 0}];
        let offset = 0;
        let verb = iter.next(points, offset);
        console.info(msg + ' iter.next(points, offset): ' + verb);
        done()
      } catch (err) {
        console.log(msg + " Faild in PathIterator.next " + JSON.stringify(err))
        console.log(msg + " Faild in PathIterator.next " + err)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0300
     * @tc.name      : testPathIteratorPeek0003
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testPathIteratorPeek0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function)=> {
      let msg = " ====testPathIteratorPeek0003==== "
      try {
        let path: drawing.Path = new drawing.Path();
        let iter: drawing.PathIterator = new drawing.PathIterator(path);
        let res = iter.peek();
        console.info(msg + ' iter.peek(): ' + res);
        done()
      } catch (err) {
        console.log(msg + " Faild in PathIterator.peek " + JSON.stringify(err))
        console.log(msg + " Faild in PathIterator.peek " + err)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0400
     * @tc.name      : testPathIteratorHasNext0004
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testPathIteratorHasNext0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function)=> {
      let msg = " ====testPathIteratorHasNext0004==== "
      try {
        let path: drawing.Path = new drawing.Path();
        let iter: drawing.PathIterator = new drawing.PathIterator(path);
        let res = iter.hasNext();
        console.info(msg + ' iter.hasNext(): ' + res);
        done()
      } catch (err) {
        console.log(msg + " Faild in PathIterator.hasNext " + JSON.stringify(err))
        console.log(msg + " Faild in PathIterator.hasNext " + err)
        expect().assertFail()
        done()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_WMS_SPCIAL_XTS_GRAPHICDRAWINGFONT_JS_API_0500
     * @tc.name      : testPathEffectCreatePathDashEffect0005
     * @tc.desc      : The Interface of drawing
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testPathEffectCreatePathDashEffect0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done:Function)=> {
      let msg = " ====testPathEffectCreatePathDashEffect0005==== "
        let color = new ArrayBuffer(96);
      let opts : image.InitializationOptions = {
        editable: true,
        pixelFormat: 3,
        size: {
          height: 4,
          width: 6
        }
      }
      image.createPixelMap(color, opts).then((pixelMap) => {
        let canvas = new drawing.Canvas(pixelMap);
        let pen = new drawing.Pen();
        let penColor: common2D.Color = { alpha: 255, red: 255, green: 0, blue: 0 }
        pen.setColor(penColor);
        pen.setStrokeWidth(10);
        canvas.attachPen(pen);
        pen.setAntiAlias(true);

        let path = new drawing.Path();
        path.moveTo(100, 100);
        path.lineTo(150, 50);
        path.lineTo(200, 100);

        let path1 = new drawing.Path();
        path1.moveTo(0, 0);
        path1.lineTo(10, 0);
        path1.lineTo(20, 10);
        path1.lineTo(0,10);

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
  })
}