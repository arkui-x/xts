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
import common2D from '@ohos.graphics.common2D';
import { Driver, ON } from '@ohos.UiTest'
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import componentUtils from '@ohos.arkui.componentUtils';
import { convertxml } from '@kit.ArkTS';
import { getEnumCount } from './utils';

let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
const bundleName = abilityDelegatorRegistry.getArguments().bundleName;
function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}
export default function graphicsDrawingTest1() {
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0100
     * @tc.name      : testCanvasDrawPathNull0001
     * @tc.desc      : testCanvasDrawPathNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPathNull0001', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPathNull0001';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawPath(undefined);
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawPath(null);
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0200
     * @tc.name      : testCanvasDrawPathMultipleCalls0002
     * @tc.desc      : testCanvasDrawPathMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPathMultipleCalls0002', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPathMultipleCalls0002';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        let path = new drawing.Path();
        path.moveTo(10,10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.drawPath(path);
        }
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0300
     * @tc.name      : testCanvasDrawLineNormal0003
     * @tc.desc      : testCanvasDrawLineNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawLineNormal0003', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawLineNormal0003';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(10, 15, 10, 10);
        canvas.drawLine(10.2, 15.3, 10.4, 10.5);
        canvas.drawLine(-10, -15, 10, 10);
        canvas.drawLine(10, 15, -10, -10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0400
     * @tc.name      : testCanvasDrawLineNull0004
     * @tc.desc      : testCanvasDrawLineNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawLineNull0004', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawLineNull0004';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(undefined, 15, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(10, undefined, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(10, 15, undefined, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(10, 15, 10, undefined);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(null, 15, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(10, null, 10, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(10, 15, null, 10);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawLine(10, 15, 10, null);
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0500
     * @tc.name      : testCanvasDrawLineMultipleCalls0005
     * @tc.desc      : testCanvasDrawLineMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawLineMultipleCalls0005', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawLineMultipleCalls0005';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.drawLine(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.detachPen();
        console.info(msg + 'drawLine successed');
      } catch (e) {
        console.info(msg + `drawLine errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0600
     * @tc.name      : testCanvasDrawSingleCharacterNormal0006
     * @tc.desc      : testCanvasDrawSingleCharacterNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawSingleCharacterNormal0006', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawSingleCharacterNormal0006';
      const canvas = new drawing.Canvas(pixel);
      const font = new drawing.Font();
      try {
        canvas.drawSingleCharacter("你", font, 100, 100);
        canvas.drawSingleCharacter("A", font, 200.1, 100.1);
        canvas.drawSingleCharacter("\\", font, -200.1, 200.1);
        canvas.drawSingleCharacter("1", font, 200.1, -200.1);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0700
     * @tc.name      : testCanvasDrawSingleCharacterMultipleCalls0007
     * @tc.desc      : testCanvasDrawSingleCharacterMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawSingleCharacterMultipleCalls0007', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawSingleCharacterMultipleCalls0007';
      const canvas = new drawing.Canvas(pixel);
      const font = new drawing.Font();
      const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

      try {
        for (let i = 0; i < 20; i += 1) {
          const randomString = characters.charAt(Math.floor(Math.random()*characters.length));
          canvas.drawSingleCharacter(randomString, font, Math.random(), Math.random());
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0800
     * @tc.name      : testCanvasDrawSingleCharacterToNull0008
     * @tc.desc      : testCanvasDrawSingleCharacterToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawSingleCharacterToNull0008', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawSingleCharacterToNull0008';
      const canvas = new drawing.Canvas(pixel);
      const font = new drawing.Font();

      try {
        canvas.drawSingleCharacter(null, font, 100, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter("你", null, 100, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter("你", font, null, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter("你", font, 100, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter(undefined, font, 100, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter("你", undefined, 100, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter("你", font, undefined, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter("你", font, 100, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_0900
     * @tc.name      : testCanvasDrawSingleCharacterAbnormal0009
     * @tc.desc      : testCanvasDrawSingleCharacterAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawSingleCharacterAbnormal0009', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawSingleCharacterAbnormal0009';
      const canvas = new drawing.Canvas(pixel);
      const font = new drawing.Font();

      try {
        canvas.drawSingleCharacter("", font, 100, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawSingleCharacter("abcdd", font, 100, 100);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1000
     * @tc.name      : testCanvasDrawSingleCharacterWithFeaturesNormal0010
     * @tc.desc      : testCanvasDrawSingleCharacterWithFeaturesNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawSingleCharacterWithFeaturesNormal0010', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawSingleCharacterWithFeaturesNormal0010';
      const font = new drawing.Font();
      let canvas = new drawing.Canvas(pixel);
      font.setSize(20);
      let fontFeatures : Array<drawing.FontFeature> = [];
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 1 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("(", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 2 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("<", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 3 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("1", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 4 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      fontFeatures.push({name: 'calt', value: 0});
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 0, 0, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 5 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("（", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 6 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("<", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 7 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("1", font, 100.25, 100.25, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 8 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      font.setSize(30.55);
      fontFeatures.push({name: 'calt', value: 42});
      fontFeatures.push({name: 'ccmp', value:12});
      fontFeatures.push({name: 'frac', value:21});
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 9 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("(", font, -100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 10 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("<", font, 100, -100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 11 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("1", font, -100, -100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 12 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("a", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 13 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawSingleCharacterWithFeatures("F", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 14 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let fontFeatures1 : Array<drawing.FontFeature> = [];
      fontFeatures1.push({name: 'Azzz', value: 42});
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, 100, fontFeatures1);
        console.info(msg + `drawSingleCharacterWithFeatures 15 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      fontFeatures1.push({name: 'aaa', value: 42});
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, 100, fontFeatures1);
        console.info(msg + `drawSingleCharacterWithFeatures 16 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 16 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      fontFeatures1.push({name: 'aaa11', value: 42});
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, 100, fontFeatures1);
        console.info(msg + `drawSingleCharacterWithFeatures 17 success `);
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 17 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1100
     * @tc.name      : testCanvasDrawSingleCharacterWithFeaturesToNull0011
     * @tc.desc      : testCanvasDrawSingleCharacterWithFeaturesToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawSingleCharacterWithFeaturesToNull0011', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawSingleCharacterWithFeaturesToNull0011';
      const font = new drawing.Font();
      let canvas = new drawing.Canvas(pixel);
      font.setSize(20);
      let fontFeatures : Array<drawing.FontFeature> = [];
      fontFeatures.push({name: 'calt', value: 42});
      try {
        canvas.drawSingleCharacterWithFeatures(null, font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 1 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures(undefined, font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 2 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", null, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 3 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", undefined, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 4 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, null, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 5 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, undefined, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 6 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, null, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 7 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, undefined, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 8 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, 100, null);
        console.info(msg + `drawSingleCharacterWithFeatures 9 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("你", font, 100, 100, undefined);
        console.info(msg + `drawSingleCharacterWithFeatures 10 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1200
     * @tc.name      : testCanvasDrawSingleCharacterWithFeaturesMultipleCalls0012
     * @tc.desc      : testCanvasDrawSingleCharacterWithFeaturesMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawSingleCharacterWithFeaturesMultipleCalls0012', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawSingleCharacterWithFeaturesMultipleCalls0012';
      const font = new drawing.Font();
      let canvas = new drawing.Canvas(pixel);
      for(let i = 0; i < 20; i++) {
        font.setSize(Math.random() * 10);
        let fontFeatures : Array<drawing.FontFeature> = [];
        fontFeatures.push({name: 'calt', value: Math.random() * 100});
        try {
          canvas.drawSingleCharacterWithFeatures("你", font, Math.random() * 100, Math.random() * 100, fontFeatures);
          console.info(msg + `drawSingleCharacterWithFeatures step: ${i} success `);
        } catch (e) {
          console.info(msg + `drawSingleCharacterWithFeatures  errorCode is:  ${e.code} + errormsg is: ${e.message} step: ${i}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1300
     * @tc.name      : testCanvasDrawSingleCharacterWithFeaturesAbnormal0013
     * @tc.desc      : testCanvasDrawSingleCharacterWithFeaturesAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawSingleCharacterWithFeaturesAbnormal0013', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawSingleCharacterWithFeaturesAbnormal0013';
      const font = new drawing.Font();
      let canvas = new drawing.Canvas(pixel);
      font.setSize(50);
      let fontFeatures : Array<drawing.FontFeature> = [];
      fontFeatures.push({name: 'calt', value: 42});
      try {
        canvas.drawSingleCharacterWithFeatures("", font, 0, 0, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 1 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(25900001);
      }
      try {
        canvas.drawSingleCharacterWithFeatures("As", font, 100, 100, fontFeatures);
        console.info(msg + `drawSingleCharacterWithFeatures 2 success `);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawSingleCharacterWithFeatures 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(25900001);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1400
     * @tc.name      : testCanvasDrawTextBlobNormal0014
     * @tc.desc      : testCanvasDrawTextBlobNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawTextBlobNormal0014', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawTextBlobNormal0014';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        const textBlob = drawing.TextBlob.makeFromString("Hello, drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        canvas.attachBrush(brush);
        canvas.drawTextBlob(textBlob, 20, 20);
        canvas.drawTextBlob(textBlob, 20.5, 20.5);
        canvas.drawTextBlob(textBlob, -10, -10);
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1500
     * @tc.name      : testCanvasDrawTextBlobNull0015
     * @tc.desc      : testCanvasDrawTextBlobNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawTextBlobNull0015', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawTextBlobNull0015';
      const canvas = new drawing.Canvas(pixel);
      try {
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        canvas.attachBrush(brush);
        canvas.drawTextBlob(undefined, 20, 20);
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        const textBlob = drawing.TextBlob.makeFromString("Hello, drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        canvas.attachBrush(brush);
        canvas.drawTextBlob(textBlob, undefined, 20);
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        const textBlob = drawing.TextBlob.makeFromString("Hello, drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        canvas.attachBrush(brush);
        canvas.drawTextBlob(textBlob, 20, undefined);
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        canvas.attachBrush(brush);
        canvas.drawTextBlob(null, 20, 20);
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        const textBlob = drawing.TextBlob.makeFromString("Hello, drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        canvas.attachBrush(brush);
        canvas.drawTextBlob(textBlob, null, 20);
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        const textBlob = drawing.TextBlob.makeFromString("Hello, drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        canvas.attachBrush(brush);
        canvas.drawTextBlob(textBlob, 20, null);
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1600
     * @tc.name      : testCanvasDrawTextBlobMultipleCalls0016
     * @tc.desc      : testCanvasDrawTextBlobMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawTextBlobMultipleCalls0016', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawTextBlobMultipleCalls0016';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        const font = new drawing.Font();
        font.setSize(20);
        const textBlob = drawing.TextBlob.makeFromString("Hello, drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        canvas.attachBrush(brush);
        for (let index = 0; index < 20; index++) {
          canvas.drawTextBlob(textBlob, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.detachBrush();
        console.info(msg + 'drawTextBlob successed');
      } catch (e) {
        console.info(msg + `drawTextBlob errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1700
     * @tc.name      : testCanvasDrawPixelMapMeshNormal0017
     * @tc.desc      : testCanvasDrawPixelMapMeshNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPixelMapMeshNormal0017', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawPixelMapMeshNormal0017';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, [0xFFFFFFFF,0xFFEFFFFF,0xFFFFEFFF,0xFFFFFFEF,0xFFFFFF00,0xFFEFFFF,0xFFEFFFF,0xFFEFFFF,0xFFEFFFF], 0);
        canvas.drawPixelMapMesh(pixel, 1, 1, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1.43, [0xFFFFFFFF,0xFFEFFFFF,0xFFFFEFFF,0xFFFFFFEF], 0);
        canvas.drawPixelMapMesh(pixel, 1, 1, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1 , [0xFFFFFFFF,0xFFEFFFFF,0xFFFFEFFF,0xFFFFFFEF,0xFFFFFF00], 1.5356);
        canvas.drawPixelMapMesh(pixel, 1.55, 1, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1, [0xFFFFFFFF,0xFFEFFFFF,0xFFFFEFFF,0xFFFFFFEF], 0);
        canvas.drawPixelMapMesh(pixel, 1, 1.45, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180], 1 , [0xFFFFFFFF,0xFFEFFFFF,0xFFFFEFFF,0xFFFFFFEF,0xFFFFFF00], 1);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1800
     * @tc.name      : testCanvasDrawPixelMapMeshNull0018
     * @tc.desc      : testCanvasDrawPixelMapMeshNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPixelMapMeshNull0018', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPixelMapMeshNull0018';
      const canvas = new drawing.Canvas(pixel);
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(null, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, null, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, null, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, null, 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], null, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, null);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(undefined, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, undefined, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, undefined, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, undefined, 0, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], undefined, null, 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, undefined);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, [], 0, [0xFFFFFFFF,0xFFEFFFFF,0xFFFFEFFF,0xFFFFFFEF,0xFFFFFF00,0xFFEFFFF,0xFFEFFFF,0xFFEFFFF,0xFFEFFFF], 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, [], 0);
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_1900
     * @tc.name      : testCanvasDrawPixelMapMeshMultipleCalls0019
     * @tc.desc      : testCanvasDrawPixelMapMeshMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPixelMapMeshMultipleCalls', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPixelMapMeshMultipleCalls';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        canvas.attachBrush(brush);
        for (let index = 0; index < 20; index++) {
          canvas.drawPixelMapMesh(pixel, 2, 2, [0, 0, 50, 0, 410, 0, 0, 180, 50, 180, 410, 180, 0, 360, 50, 360, 410, 360], 0, null, 0);
        }
        canvas.detachBrush();
        console.info(msg + 'drawPixelMapMesh successed');
      } catch (e) {
        console.info(msg + `drawPixelMapMesh errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2000
     * @tc.name      : testCanvasAttachPenDetachPenNormal0020
     * @tc.desc      : testCanvasAttachPenDetachPenNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasAttachPenDetachPenNormal0020', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasAttachPenDetachPenNormal0020';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2100
     * @tc.name      : testCanvasAttachPenDetachPenNull0021
     * @tc.desc      : testCanvasAttachPenDetachPenNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachPenDetachPenNull0021', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachPenDetachPenNull0021';
      const canvas = new drawing.Canvas(pixel);
      try {
        canvas.attachPen(undefined);
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2200
     * @tc.name      : testCanvasAttachPenDetachPenMultipleCalls0022
     * @tc.desc      : testCanvasAttachPenDetachPenMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachPenDetachPenMultipleCalls0022', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachPenDetachPenMultipleCalls0022';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        for (let index = 0; index < 20; index++) {
          canvas.attachPen(pen);
        }
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        for (let index = 0; index < 20; index++) {
          canvas.detachPen();
        }
        for (let index = 0; index < 20; index++) {
          canvas.attachPen(pen);
          canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
          canvas.detachPen();
        }
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2300
     * @tc.name      : testCanvasAttachPenOly0023
     * @tc.desc      : testCanvasAttachPenOly
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachPenOly0023', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachPenOly0023';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2400
     * @tc.name      : testCanvasDttachPenOly0024
     * @tc.desc      : testCanvasDttachPenOly
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDttachPenOly0024', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDttachPenOly0024';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.detachPen();
        console.info(msg + 'attachPen successed');
      } catch (e) {
        console.info(msg + `attachPen errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2500
     * @tc.name      : testCanvasAttachBrushDetachBrushNormal0025
     * @tc.desc      : testCanvasAttachBrushDetachBrushNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasAttachBrushDetachBrushNormal', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasAttachBrushDetachBrushNormal';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachBrush(brush);
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        canvas.detachBrush();
        console.info(msg + 'attachBrush successed');
      } catch (e) {
        console.info(msg + `attachBrush errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2600
     * @tc.name      : testCanvasAttachBrushDetachBrushNull0026
     * @tc.desc      : testCanvasAttachBrushDetachBrushNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachBrushDetachBrushNull0026', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachBrushDetachBrushNull0026';
      const canvas = new drawing.Canvas(pixel);
      try {
        canvas.attachBrush(undefined);
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        canvas.detachBrush();
        console.info(msg + 'attachBrush successed');
      } catch (e) {
        console.info(msg + `attachBrush errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.attachBrush(null);
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        canvas.detachBrush();
        console.info(msg + 'attachBrush successed');
      } catch (e) {
        console.info(msg + `attachBrush errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2700
     * @tc.name      : testCanvasAttachBrushDetachBrushMultipleCalls0027
     * @tc.desc      : testCanvasAttachBrushDetachBrushMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachBrushDetachBrushMultipleCalls0027', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachBrushDetachBrushMultipleCalls0027';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        for (let index = 0; index < 20; index++) {
          canvas.attachBrush(brush);
        }
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        for (let index = 0; index < 20; index++) {
          canvas.detachBrush();
        }
        for (let index = 0; index < 20; index++) {
          canvas.attachBrush(brush);
          canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
          canvas.detachBrush();
        }
        console.info(msg + 'attachBrush successed');
      } catch (e) {
        console.info(msg + `attachBrush errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2800
     * @tc.name      : testCanvasAttachBrushOly0028
     * @tc.desc      : testCanvasAttachBrushOly
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasAttachBrushOly0028', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasAttachBrushOly0028';
      try {
        const canvas = new drawing.Canvas(pixel);
        const brush = new drawing.Brush();
        brush.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachBrush(brush);
        canvas.drawRect({ left : 0, right : 0, top : 10, bottom : 10 });
        console.info(msg + 'attachBrush successed');
      } catch (e) {
        console.info(msg + `attachBrush errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_2900
     * @tc.name      : testCanvasDttachBrushOly0029
     * @tc.desc      : testCanvasDttachBrushOly
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDttachBrushOly0029', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDttachBrushOly0029';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.detachBrush();
        console.info(msg + 'attachBrush successed');
      } catch (e) {
        console.info(msg + `attachBrush errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3000
     * @tc.name      : testCanvasSaveGetSaveCountNormal0030
     * @tc.desc      : testCanvasSaveGetSaveCountNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasSaveGetSaveCountNormal0030', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasSaveGetSaveCountNormal0030';
      try {
        const canvas = new drawing.Canvas(pixel);
        let rect: common2D.Rect = {left: 10, right: 200, top: 100, bottom: 300};
        canvas.drawRect(rect);
        let saveCount = canvas.save();
        let readCount = canvas.getSaveCount();
        canvas.restore();
        expect(saveCount + 1 == readCount).assertTrue();
        canvas.scale(2, 0.5);
        canvas.skew(0.1, 0.1);
        canvas.rotate(30, 100, 100);
        canvas.translate(10, 10);
        let saveCount2 = canvas.save();
        readCount = canvas.getSaveCount();
        canvas.restore();
        expect(saveCount + 1 == readCount).assertTrue();
        console.info(msg + 'save、getSaveCount successed');
      } catch (e) {
        console.info(msg + `save、getSaveCount errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3100
     * @tc.name      : testCanvasSaveGetSaveCountMultipleCalls0031
     * @tc.desc      : testCanvasSaveGetSaveCountMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSaveGetSaveCountMultipleCalls0031', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSaveGetSaveCountMultipleCalls0031';
      try {
        const canvas = new drawing.Canvas(pixel);
        let rect: common2D.Rect = {left: 10, right: 200, top: 100, bottom: 300};
        canvas.drawRect(rect);
        for (let index = 0; index < 20; index++) {
          canvas.save();
        }
        for (let index = 0; index < 20; index++) {
          canvas.getSaveCount();
        }
        for (let index = 0; index < 20; index++) {
          canvas.save();
          canvas.getSaveCount();
        }
        canvas.restore();
        console.info(msg + 'save、getSaveCount successed');
      } catch (e) {
        console.info(msg + `save、getSaveCount errorCode is: ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3200
     * @tc.name      : testCanvasGetSaveCountWhenNoSave0032
     * @tc.desc      : testCanvasGetSaveCountWhenNoSave
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasGetSaveCountWhenNoSave0032', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasGetSaveCountWhenNoSave0032';
      try {
        const canvas = new drawing.Canvas(pixel);
        let readCount = canvas.getSaveCount();
        expect(1 == readCount).assertTrue();
        console.info(msg + 'save、getSaveCount successed');
      } catch (e) {
        console.info(msg + `save、getSaveCount errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3300
     * @tc.name      : testCanvasSaveLayerNormal0033
     * @tc.desc      : testCanvasSaveLayerNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasSaveLayerNormal0033', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasSaveLayerNormal0033';
      try {
        const canvas = new drawing.Canvas(pixel);
        const rect: common2D.Rect = {
          left: 0, right: 100, top: 0, bottom: 100
        };
        const brush = new drawing.Brush();

        canvas.saveLayer(rect, brush)
        canvas.saveLayer(null, brush)
        canvas.saveLayer(rect, null)

        console.info(msg + 'test successed');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3400
     * @tc.name      : testCanvasSaveLayerUndefined0034
     * @tc.desc      : testCanvasSaveLayerUndefined
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSaveLayerUndefined0034', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSaveLayerUndefined0034';
      const canvas = new drawing.Canvas(pixel);
      const brush = new drawing.Brush();
      const rect: common2D.Rect = {
        left: 0, right: 100, top: 0, bottom: 100
      };

      try {
        canvas.saveLayer(undefined, brush)
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.saveLayer(rect, undefined)
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3500
     * @tc.name      : testCanvasClearNormal0035
     * @tc.desc      : testCanvasClearNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasClearNormal0035', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasClearNormal0035';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.clear({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.clear({
          alpha: 255.1, red: 255.1, green: 255.1, blue: 255.1
        });
        canvas.clear({
          alpha: 0.1, red: 0.1, green: 0.1, blue: 0.1
        });
        canvas.clear(150);

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3600
     * @tc.name      : testCanvasClearMultipleCalls0036
     * @tc.desc      : testCanvasClearMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClearMultipleCalls0036', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClearMultipleCalls0036';
      try {
        const canvas = new drawing.Canvas(pixel);
        for (let i = 0; i < 20; i += 1) {
          canvas.clear({
            alpha: Math.random() * 256, red: Math.random() * 256,
            green: Math.random() * 256, blue: Math.random() * 256
          })
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3700
     * @tc.name      : testCanvasClearToNull0037
     * @tc.desc      : testCanvasClearToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClearToNull0037', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClearToNull0037';
      const canvas = new drawing.Canvas(pixel);


      try {
        canvas.clear(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clear(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3800
     * @tc.name      : testCanvasClearAbnormal0038
     * @tc.desc      : testCanvasClearAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClearAbnormal0038', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClearAbnormal0038';
      const canvas = new drawing.Canvas(pixel);
      try {

        try {
          canvas.clear({
            alpha: 256, red: 255, green: 0, blue: 0
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        try {
          canvas.clear({
            alpha: 255, red: 256, green: 0, blue: 0
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        try {
          canvas.clear({
            alpha: 255, red: 255, green: 256, blue: 0
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        try {
          canvas.clear({
            alpha: 255, red: 255, green: 0, blue: 256
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        try {
          canvas.clear({
            alpha: -1, red: 255, green: 0, blue: 0
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        try {
          canvas.clear({
            alpha: 255, red: -1, green: 0, blue: 0
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        try {
          canvas.clear({
            alpha: 255, red: 255, green: -1, blue: 0
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        try {
          canvas.clear({
            alpha: 255, red: 255, green: 0, blue: -1
          });
          console.info(msg + `test error`);
          expect().assertFail()
        } catch (e) {
          console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
          expect(e.code).assertEqual(401);
        }

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_3900
     * @tc.name      : testCanvasRestoreNormal0039
     * @tc.desc      : testCanvasRestoreNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasRestoreNormal0039', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasRestoreNormal0039';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.save();
        canvas.restore();
        canvas.getSaveCount();
        console.info(msg + 'restore successed');
      } catch (e) {
        console.info(msg + `restore errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4000
     * @tc.name      : testCanvasRestoreMultipleCalls0040
     * @tc.desc      : testCanvasRestoreMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRestoreMultipleCalls0040', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRestoreMultipleCalls0040';
      try {
        const canvas = new drawing.Canvas(pixel);
        for (let index = 0; index < 20; index++) {
          canvas.save();
        }
        for (let index = 0; index < 20; index++) {
          canvas.restore();
        }
        canvas.getSaveCount();
        for (let index = 0; index < 20; index++) {
          canvas.save();
          canvas.restore();
          canvas.getSaveCount();
        }
        console.info(msg + 'restore successed');
      } catch (e) {
        console.info(msg + `restore errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4100
     * @tc.name      : testCanvasRestoreWhenNoSave0041
     * @tc.desc      : testCanvasRestoreWhenNoSave
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRestoreWhenNoSave0041', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRestoreWhenNoSave0041';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.restore();
        canvas.getSaveCount();
        console.info(msg + 'restore successed');
      } catch (e) {
        console.info(msg + `restore errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })
    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4200
     * @tc.name      : testCanvasRestoreToCountNormal0042
     * @tc.desc      : testCanvasRestoreToCountNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasRestoreToCountNormal0042', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasRestoreToCountNormal0042';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.drawRect({left: 10, right: 200, top: 100, bottom: 300});
        for (let index = 0; index < 20; index++) {
          canvas.save();
        }
        canvas.restoreToCount(2);
        canvas.getSaveCount();
        canvas.restoreToCount(5.22);
        canvas.getSaveCount();
        canvas.restoreToCount(1);
        canvas.getSaveCount();
        canvas.restoreToCount(0);
        canvas.getSaveCount();
        canvas.restoreToCount(15);
        canvas.getSaveCount();
        console.info(msg + 'restoreToCount successed');
      } catch (e) {
        console.info(msg + `restoreToCount errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.drawRect({left: 10, right: 200, top: 100, bottom: 300});
        for (let index = 0; index < 20; index++) {
          canvas.save();
        }
        canvas.restoreToCount(-1);
        canvas.getSaveCount();
        console.info(msg + 'restoreToCount successed');
      } catch (e) {
        console.info(msg + `restoreToCount errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4300
     * @tc.name      : testCanvasRestoreToCountNull0043
     * @tc.desc      : testCanvasRestoreToCountNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRestoreToCountNull0043', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRestoreToCountNull0043';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.restoreToCount(undefined);
        console.info(msg + 'restoreToCount successed');
      } catch (e) {
        console.info(msg + `restoreToCount errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.restoreToCount(null);
        console.info(msg + 'restoreToCount successed');
      } catch (e) {
        console.info(msg + `restoreToCount errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4400
     * @tc.name      : testCanvasRestoreToCountMultipleCalls0044
     * @tc.desc      : testCanvasRestoreToCountMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRestoreToCountMultipleCalls0044', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRestoreToCountMultipleCalls0044';
      try {
        const canvas = new drawing.Canvas(pixel);
        for (let index = 0; index < 20; index++) {
          canvas.restoreToCount(Math.random() * Number.MAX_VALUE);
        }
        console.info(msg + 'restoreToCount successed');
      } catch (e) {
        console.info(msg + `restoreToCount errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4500
     * @tc.name      : testCanvasGetWidthAndHeightNormal0045
     * @tc.desc      : testCanvasGetWidthAndHeightNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasGetWidthAndHeightNormal0045', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasGetWidthAndHeightNormal0045';
      const canvas = new drawing.Canvas(pixel);
      try {
        let width = canvas.getWidth();
        let height = canvas.getHeight();
        console.info(msg + 'test successes');
        expect(width).assertEqual(100);
        expect(height).assertEqual(100);
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4600
     * @tc.name      : testCanvasGetWidthAndHeightMultipleCalls0046
     * @tc.desc      : testCanvasGetWidthAndHeightMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasGetWidthAndHeightMultipleCalls0046', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasGetWidthAndHeightMultipleCalls0046';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          let width = canvas.getWidth();
          let height = canvas.getHeight();
          expect(width).assertEqual(100);
          expect(height).assertEqual(100);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4700
     * @tc.name      : testCanvasGetLocalClipBoundsNormal0047
     * @tc.desc      : testCanvasGetLocalClipBoundsNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasGetLocalClipBoundsNormal0047', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasGetLocalClipBoundsNormal0047';
      const canvas = new drawing.Canvas(pixel);

      try {
        let rect: common2D.Rect = canvas.getLocalClipBounds();
        expect(rect.left).assertEqual(-1)
        expect(rect.right).assertEqual(101)
        expect(rect.top).assertEqual(-1)
        expect(rect.bottom).assertEqual(101)

        canvas.clipRect({
          left: 10, right: 50, top: 30, bottom: 90
        }, drawing.ClipOp.DIFFERENCE, true);
        rect = canvas.getLocalClipBounds();

        expect(rect.left).assertEqual(-1)
        expect(rect.right).assertEqual(101)
        expect(rect.top).assertEqual(-1)
        expect(rect.bottom).assertEqual(101)
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4800
     * @tc.name      : testCanvasGetLocalClipBoundsMultipleCalls0048
     * @tc.desc      : testCanvasGetLocalClipBoundsMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasGetLocalClipBoundsMultipleCalls0048', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasGetLocalClipBoundsMultipleCalls0048';
      const canvas = new drawing.Canvas(pixel);

      try {
        for (let i = 0; i < 20; i += 1) {
          let rect: common2D.Rect = canvas.getLocalClipBounds();
          expect(rect.left).assertEqual(-1)
          expect(rect.right).assertEqual(101)
          expect(rect.top).assertEqual(-1)
          expect(rect.bottom).assertEqual(101)
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4900
     * @tc.name      : testCanvasGetTotalMatrixNormal0049
     * @tc.desc      : testCanvasGetTotalMatrixNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasGetTotalMatrixNormal0049', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasGetTotalMatrixNormal0049';
      const canvas = new drawing.Canvas(pixel);

      try {
        let matrix1 = new drawing.Matrix();
        canvas.setMatrix(matrix1)
        let matrixResult1 = canvas.getTotalMatrix();
        expect(matrixResult1.getAll()).assertDeepEquals(matrix1.getAll());

        let matrix2 = new drawing.Matrix();
        matrix2.setMatrix([1, 2, 3, 4, 5, 6, 7, 8, 9]);
        canvas.setMatrix(matrix2);
        let matrixResult2 = canvas.getTotalMatrix();
        expect(matrixResult2.getAll()).assertDeepEquals(matrix2.getAll());

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5000
     * @tc.name      : testCanvasGetTotalMatrixMultipleCalls0050
     * @tc.desc      : testCanvasGetTotalMatrixMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasGetTotalMatrixMultipleCalls0050', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasGetTotalMatrixMultipleCalls0050';
      const canvas = new drawing.Canvas(pixel);

      try {
        for (let i = 0; i < 20; i += 1) {
          let matrix = new drawing.Matrix();
          canvas.setMatrix(matrix)
          let matrixResult = canvas.getTotalMatrix();
          expect(matrixResult.getAll()).assertDeepEquals(matrix.getAll());
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5100
     * @tc.name      : testCanvasScaleNormal0051
     * @tc.desc      : testCanvasScaleNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasScaleNormal0051', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasScaleNormal0051';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.scale(2, 2);
        canvas.scale(0.5, 0.5);
        canvas.scale(-10, -10);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5200
     * @tc.name      : testCanvasScaleNull0052
     * @tc.desc      : testCanvasScaleNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasScaleNull0052', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasScaleNull0052';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.scale(undefined,2);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.scale(0.5,undefined);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.scale(null,0.5);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.scale(2,null);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'scale successed');
      } catch (e) {
        console.info(msg + `scale errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5300
     * @tc.name      : testCanvasScaleMultipleCalls0053
     * @tc.desc      : testCanvasScaleMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasScaleMultipleCalls0053', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasScaleMultipleCalls0053';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.scale(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5400
     * @tc.name      : testCanvasSkewNormal0054
     * @tc.desc      : testCanvasSkewNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasSkewNormal0054', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasSkewNormal0054';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.skew(2, 2);
        canvas.skew(0.5, 0.5);
        canvas.skew(-10, -10);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5500
     * @tc.name      : testCanvasSkewNull0055
     * @tc.desc      : testCanvasSkewNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSkewNull0055',TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSkewNull0055';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.skew(undefined,2);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.skew(0.5,undefined);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.skew(null,0.5);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.skew(2,null);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5600
     * @tc.name      : testCanvasSkewMultipleCalls0056
     * @tc.desc      : testCanvasSkewMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSkewMultipleCalls0056', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSkewMultipleCalls0056';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.skew(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'skew successed');
      } catch (e) {
        console.info(msg + `skew errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5700
     * @tc.name      : testCanvasRotateNormal0057
     * @tc.desc      : testCanvasRotateNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasRotateNormal0057', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasRotateNormal0057';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.rotate(30, 100, 100);
        canvas.rotate(30.1, 100.1, 100.1);
        canvas.rotate(0, 100, 100);
        canvas.rotate(360, 100, 100);
        canvas.rotate(-90, 100, 100);
        canvas.rotate(400, 100, 100);
        canvas.rotate(30, -100, -100);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5800
     * @tc.name      : testCanvasRotateNull0058
     * @tc.desc      : testCanvasRotateNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRotateNull0058', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRotateNull0058';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.rotate(undefined, 100, 100);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.rotate(30, undefined, 100);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.rotate(30, 100, undefined);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.rotate(null, 100, 100);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.rotate(30, null, 100);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.rotate(30, 100, null);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5900
     * @tc.name      : testCanvasRotateMultipleCalls0059
     * @tc.desc      : testCanvasRotateMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasRotateMultipleCalls0059', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasRotateMultipleCalls0059';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.rotate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'rotate successed');
      } catch (e) {
        console.info(msg + `rotate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6000
     * @tc.name      : testCanvasTranlateNormal0060
     * @tc.desc      : testCanvasTranlateNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasTranlateNormal0060', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasTranlateNormal0060';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.translate(10, 10);
        canvas.translate(10.1, 10.1);
        canvas.translate(-10, -10);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6100
     * @tc.name      : testCanvasTranlateNull0061
     * @tc.desc      : testCanvasTranlateNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasTranlateNull0061', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasTranlateNull0061';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.translate(undefined,2);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.translate(10,undefined);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.translate(null,10);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.translate(2,null);
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6200
     * @tc.name      : testCanvasTranlateMultipleCalls0062
     * @tc.desc      : testCanvasTranlateMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasTranlateMultipleCalls0062', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasTranlateMultipleCalls0062';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.translate(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.detachPen();
        console.info(msg + 'tranlate successed');
      } catch (e) {
        console.info(msg + `tranlate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6300
     * @tc.name      : testCanvasClipPathNormal0063
     * @tc.desc      : testCanvasClipPathNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasClipPathNormal0063', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasClipPathNormal0063';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, true);
        canvas.clipPath(path, drawing.ClipOp.INTERSECT, true);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, false);
        canvas.clipPath(path, drawing.ClipOp.INTERSECT, false);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE);
        canvas.clipPath(path);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6400
     * @tc.name      : testCanvasClipPathNull0064
     * @tc.desc      : testCanvasClipPathNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipPathNull0064', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipPathNull0064';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipPath(undefined, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, undefined, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, undefined);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipPath(null, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, null, true);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(10, 10, 10, 10, 15, 15);
        path.close();
        canvas.attachPen(pen);
        canvas.clipPath(path, drawing.ClipOp.DIFFERENCE, null);
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6500
     * @tc.name      : testCanvasClipPathMultipleCalls0065
     * @tc.desc      : testCanvasClipPathMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipPathMultipleCalls0065', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipPathMultipleCalls0065';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          let path = new drawing.Path();
          path.moveTo(10, 10);
          path.cubicTo(Math.random() * Number.MAX_VALUE, 10, 10, 10, 15, 15);
          path.close();
          const randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.ClipOp)));
          canvas.clipPath(path, randomEnum, Math.random() == 1 ? true : false);
        }
        canvas.detachPen();
        console.info(msg + 'clipPath successed');
      } catch (e) {
        console.info(msg + `clipPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6600
     * @tc.name      : testCanvasClipRectNormal0066
     * @tc.desc      : testCanvasClipRectNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasClipRectNormal0066', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasClipRectNormal0066';
      try {
        const canvas = new drawing.Canvas(pixel);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.DIFFERENCE, true);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.INTERSECT, true);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.DIFFERENCE, false);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.INTERSECT, false);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.DIFFERENCE);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900});
        canvas.clipRect({ left : 100.32, right : 100.5, top : 400.2, bottom : 400.3 }, drawing.ClipOp.DIFFERENCE, true);
        canvas.clipRect({ left : 0, right : 0, top : 0, bottom : 100}, drawing.ClipOp.INTERSECT, true);
        canvas.clipRect({ left : 0, right : 100, top : 100, bottom : 100}, drawing.ClipOp.DIFFERENCE, false);
        canvas.clipRect({ left : 100, right : 100, top : 100, bottom : 100}, drawing.ClipOp.INTERSECT, false);
        canvas.clipRect({ left : -100, right : 100, top : -100, bottom : 100});
        canvas.clipRect({ left : 100, right : -100, top : 100, bottom : -100}, drawing.ClipOp.DIFFERENCE, true);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6700
     * @tc.name      : testCanvasClipRectNull0067
     * @tc.desc      : testCanvasClipRectNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRectNull0067', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRectNull0067';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect(undefined, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, undefined, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.DIFFERENCE, undefined);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect(null, drawing.ClipOp.DIFFERENCE, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, null, true);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({left : 10, right : 500, top : 300, bottom : 900}, drawing.ClipOp.DIFFERENCE, null);
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({ left : null, right : 0, top : 10, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({ left : 0, right : null, top : 10, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({ left : 0, right : 100, top : null, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawRect({ left : 0, right : 100, top : 10, bottom : null });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({ left : undefined, right : 0, top : 10, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({ left : 0, right : undefined, top : 10, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({ left : 0, right : 100, top : undefined, bottom : 10 });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.clipRect({ left : 0, right : 100, top : 10, bottom : undefined });
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6800
     * @tc.name      : testCanvasClipRectMultipleCalls0068
     * @tc.desc      : testCanvasClipRectMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRectMultipleCalls0068', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRectMultipleCalls0068';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          const randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.ClipOp)));
          canvas.drawCircle(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
          canvas.clipRect({left : Math.random() * Number.MAX_VALUE, right : Math.random() * Number.MAX_VALUE, top : Math.random() * Number.MAX_VALUE, bottom : Math.random() * Number.MAX_VALUE}, randomEnum, Math.random() == 1 ? true : false);
        }
        canvas.detachPen();
        console.info(msg + 'clipRect successed');
      } catch (e) {
        console.info(msg + `clipRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6900
     * @tc.name      : testCanvasConcatMatrixNormal0069
     * @tc.desc      : testCanvasConcatMatrixNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasConcatMatrixNormal0069', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasConcatMatrixNormal0069';
      const canvas = new drawing.Canvas(pixel);
      try {
        let matrix = new drawing.Matrix();
        canvas.concatMatrix(matrix);
        matrix.setMatrix([5, 0, 0, 0, 1, 2, 0, 0, 1]);
        canvas.concatMatrix(matrix);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7000
     * @tc.name      : testCanvasConcatMatrixMultipleCalls0070
     * @tc.desc      : testCanvasConcatMatrixMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasConcatMatrixMultipleCalls0070', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasConcatMatrixMultipleCalls0070';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          let matrix = new drawing.Matrix();
          canvas.concatMatrix(matrix);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7100
     * @tc.name      : testCanvasConcatMatrixToNull0071
     * @tc.desc      : testCanvasConcatMatrixToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasConcatMatrixToNull0071', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasConcatMatrixToNull0071';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.concatMatrix(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.concatMatrix(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7200
     * @tc.name      : testCanvasClipRegionNormal0072
     * @tc.desc      : testCanvasClipRegionNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRegionNormal0072', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRegionNormal0072';
      const canvas = new drawing.Canvas(pixel);
      try {
        let region1 = new drawing.Region();
        canvas.clipRegion(region1);
        canvas.clipRegion(region1, drawing.ClipOp.DIFFERENCE);
        canvas.clipRegion(region1, drawing.ClipOp.INTERSECT);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7300
     * @tc.name      : testCanvasClipRegionMultipleCalls0073
     * @tc.desc      : testCanvasClipRegionMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRegionMultipleCalls0073', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRegionMultipleCalls0073';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; ++i) {
          let region1 = new drawing.Region();
          canvas.clipRegion(region1, drawing.ClipOp.DIFFERENCE);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7400
     * @tc.name      : testCanvasClipRegionToNull0074
     * @tc.desc      : testCanvasClipRegionToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRegionToNull0074', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRegionToNull0074';
      const canvas = new drawing.Canvas(pixel);
      let region1 = new drawing.Region();

      try {
        canvas.clipRegion(null, drawing.ClipOp.DIFFERENCE);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRegion(region1, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRegion(undefined, drawing.ClipOp.DIFFERENCE);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRegion(region1, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7500
     * @tc.name      : testCanvasClipRegionAbnormal0075
     * @tc.desc      : testCanvasClipRegionAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRegionAbnormal0075', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRegionAbnormal0075';
      const canvas = new drawing.Canvas(pixel);
      let region1 = new drawing.Region();

      try {
        canvas.clipRegion(region1, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7600
     * @tc.name      : testCanvasClipRoundRectNormal0076
     * @tc.desc      : testCanvasClipRoundRectNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasClipRoundRectNormal0076', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasClipRoundRectNormal0076';
      const canvas = new drawing.Canvas(pixel);
      try {
        let rectOne: common2D.Rect = {
          left: 10, top: 100, right: 200, bottom: 300
        };
        let roundRectOne = new drawing.RoundRect(rectOne, 10, 10);
        canvas.clipRoundRect(roundRectOne);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.INTERSECT);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, true);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, false);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.INTERSECT, true);
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.INTERSECT, false);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7700
     * @tc.name      : testCanvasClipRoundRectMultipleCalls0077
     * @tc.desc      : testCanvasClipRoundRectMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRoundRectMultipleCalls0077', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRoundRectMultipleCalls0077';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          const randomEnum = Math.floor(Math.random() * getEnumCount(drawing.ClipOp))
          let rectOne: common2D.Rect = {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          };
          let roundRectOne = new drawing.RoundRect(rectOne, Math.random(), Math.random());
          canvas.clipRoundRect(roundRectOne, randomEnum, true);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7800
     * @tc.name      : testCanvasClipRoundRectToNull0078
     * @tc.desc      : testCanvasClipRoundRectToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRoundRectToNull0078', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRoundRectToNull0078';
      const canvas = new drawing.Canvas(pixel);
      let rectOne: common2D.Rect = {
        left: 10, top: 100, right: 200, bottom: 300
      };
      let roundRectOne = new drawing.RoundRect(rectOne, 10, 10);


      try {
        canvas.clipRoundRect(null, drawing.ClipOp.DIFFERENCE, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, null, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(null, drawing.ClipOp.DIFFERENCE, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, null, false);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.clipRoundRect(roundRectOne, drawing.ClipOp.DIFFERENCE, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7900
     * @tc.name      : testCanvasClipRoundRectAbnormal0079
     * @tc.desc      : testCanvasClipRoundRectAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasClipRoundRectAbnormal0079', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasClipRoundRectAbnormal0079';
      const canvas = new drawing.Canvas(pixel);
      let rectOne: common2D.Rect = {
        left: 10, top: 100, right: 200, bottom: 300
      };
      let roundRectOne = new drawing.RoundRect(rectOne, 10, 10);

      try {
        canvas.clipRoundRect(roundRectOne, 10, true);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8000
     * @tc.name      : testCanvasIsClipEmptyNormal0080
     * @tc.desc      : testCanvasIsClipEmptyNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasIsClipEmptyNormal0080', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasIsClipEmptyNormal0080';
      const canvas = new drawing.Canvas(pixel);
      try {
        canvas.isClipEmpty();
        const path = new drawing.Path();
        canvas.clipPath(path);
        canvas.isClipEmpty();
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8100
     * @tc.name      : testCanvasIsClipEmptyMultipleCalls0081
     * @tc.desc      : testCanvasIsClipEmptyMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasIsClipEmptyMultipleCalls0081', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasIsClipEmptyMultipleCalls0081';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          canvas.isClipEmpty();
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8200
     * @tc.name      : testCanvasSetMatrixNormal0082
     * @tc.desc      : testCanvasSetMatrixNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasSetMatrixNormal0082', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasSetMatrixNormal0082';
      const canvas = new drawing.Canvas(pixel);
      try {
        let matrix = new drawing.Matrix();
        canvas.setMatrix(matrix);
        matrix.setMatrix([5.1, 1.1, 1.1, 1.1, 1.1, 1.1, 5.1, 0.3, 1.7]);
        canvas.setMatrix(matrix);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8300
     * @tc.name      : testCanvasSetMatrixMultipleCalls0083
     * @tc.desc      : testCanvasSetMatrixMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSetMatrixMultipleCalls0083', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSetMatrixMultipleCalls0083';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          const matrix = new drawing.Matrix()
          canvas.setMatrix(matrix)
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8400
     * @tc.name      : testCanvasSetMatrixToNull0084
     * @tc.desc      : testCanvasSetMatrixToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasSetMatrixToNull0084', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasSetMatrixToNull0084';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.setMatrix(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.setMatrix(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8500
     * @tc.name      : testCanvasResetMatrixNormal0085
     * @tc.desc      : testCanvasResetMatrixNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasResetMatrixNormal0085', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasResetMatrixNormal0085';
      const canvas = new drawing.Canvas(pixel);
      try {
        let matrix = new drawing.Matrix();
        matrix.preRotate(-30, 10, 20)
        canvas.setMatrix(matrix)
        canvas.drawRect(100, 100, 200, 300)
        canvas.resetMatrix();
        canvas.drawRect(200, 200, 300, 400)
        canvas.resetMatrix();

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8600
     * @tc.name      : testCanvasResetMatrixMultipleCalls0086
     * @tc.desc      : testCanvasResetMatrixMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasResetMatrixMultipleCalls0086', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasResetMatrixMultipleCalls0086';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          let matrix = new drawing.Matrix();
          canvas.setMatrix(matrix);
          canvas.resetMatrix();
        }

        for (let i = 0; i < 20; i += 1) {
          let matrix = new drawing.Matrix();
          canvas.setMatrix(matrix);
        }
        for (let i = 0; i < 20; i += 1) {
          canvas.resetMatrix();
        }

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8700
     * @tc.name      : testCanvasDrawQuickRejectPathNormal0087
     * @tc.desc      : testCanvasDrawQuickRejectPathNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('testCanvasDrawQuickRejectPathNormal0087', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      let msg = 'testCanvasDrawQuickRejectPathNormal0087';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      path.moveTo(-100,-100);
      path.lineTo(-50, -50);
      try {
        let isSuccess1 = canvas.quickRejectPath(path);
        expect(isSuccess1).assertEqual(true);
      } catch (e) {
        console.info(msg + `quickRejectPath 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.moveTo(0, 100);
      path.lineTo(-100, -100);
      try {
        let isSuccess2 = canvas.quickRejectPath(path);
        expect(isSuccess2).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.reset();
      path.moveTo(-100,-100);
      path.lineTo(0, 0);
      try {
        let isSuccess3 = canvas.quickRejectPath(path);
        expect(isSuccess3).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.reset();
      path.moveTo(-100,0);
      path.lineTo(0, 100);
      path.lineTo(-100, 200);
      try {
        let isSuccess4 = canvas.quickRejectPath(path);
        expect(isSuccess4).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let isSuccess = true;
      path.lineTo(200, 200);
      try {
        isSuccess = canvas.quickRejectPath(path);
        expect(isSuccess).assertEqual(false);
      } catch (e) {
        console.info(msg + `quickRejectPath 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      path.reset();
      isSuccess = true;
      let rect0:common2D.Rect = {
        left: 200,
        top: 200,
        right: 400,
        bottom: 400
      };
      path.addArc(rect0, 10, 50);
      path.conicTo(200, 400, 100, 200, 0);
      try {
        isSuccess = canvas.quickRejectPath(path);
        expect(isSuccess).assertEqual(true);
      } catch (e) {
        console.info(msg + `quickRejectPath 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8800
     * @tc.name      : testCanvasDrawQuickRejectPathNull0088
     * @tc.desc      : testCanvasDrawQuickRejectPathNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level4
     */
    it('testCanvasDrawQuickRejectPathNull0088', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL4, () => {
      let msg = 'testCanvasDrawQuickRejectPathNull0088';
      let canvas = new drawing.Canvas(pixel);
      try {
        canvas.quickRejectPath(null);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `quickRejectPath null errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.quickRejectPath(undefined);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `quickRejectPath undefined errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8900
     * @tc.name      : testCanvasDrawQuickRejectPathMultipleCalls0089
     * @tc.desc      : testCanvasDrawQuickRejectPathMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawQuickRejectPathMultipleCalls0089', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawQuickRejectPathMultipleCalls0089';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      for(let i = 0; i < 20; i++) {
        path.moveTo(100 + i * 0.01, 100 + i * 0.01);
        path.lineTo(150 + i * 0.01, 50 + i * 0.01);
        try {
          let isSuccess = canvas.quickRejectPath(path);
          expect(isSuccess).assertEqual(false);
        } catch (e) {
          console.info(msg + `quickRejectPath ${i} errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9000
     * @tc.name      : testCanvasDrawPointsNormal0090
     * @tc.desc      : testCanvasDrawPointsNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPointsNormal0090', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawPointsNormal0090';
      const canvas = new drawing.Canvas(pixel);
      try {
        canvas.drawPoints([{
          x: 100, y: 200
        }, {
          x: 150, y: 230
        }, {
          x: 200, y: 300
        }], drawing.PointMode.POINTS);
        canvas.drawPoints([{
          x: 100, y: 200
        }, {
          x: 150.1, y: 230.1
        }, {
          x: 200, y: 300
        }], drawing.PointMode.LINES);
        canvas.drawPoints([{
          x: 100, y: 200
        }, {
          x: 150, y: 230
        }, {
          x: 200, y: 300
        }], drawing.PointMode.POLYGON);
        canvas.drawPoints([{
          x: 100, y: 200
        }, {
          x: -150, y: 230
        }, {
          x: 200, y: -300
        }]);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9100
     * @tc.name      : testCanvasDrawPointsMultipleCalls0091
     * @tc.desc      : testCanvasDrawPointsMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointsMultipleCalls0091', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointsMultipleCalls0091';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          const randomEnum = Math.floor(getEnumCount(drawing.PointMode) * Math.random())
          canvas.drawPoints([{
            x: Math.random(), y: Math.random()
          }, {
            x: Math.random(), y: Math.random()
          }, {
            x: Math.random(), y: Math.random()
          }], randomEnum);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9200
     * @tc.name      : testCanvasDrawPointsToNull0092
     * @tc.desc      : testCanvasDrawPointsToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointsToNull0092', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointsToNull0092';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawPoints(null, drawing.PointMode.POINTS);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawPoints([{
          x: 100, y: 200
        }, {
          x: 150, y: 230
        }, {
          x: 200, y: 300
        }], null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawPoints(undefined, drawing.PointMode.POINTS);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawPoints([{
          x: 100, y: 200
        }, {
          x: 150, y: 230
        }, {
          x: 200, y: 300
        }], undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9300
     * @tc.name      : testCanvasDrawPointsAbnormal0093
     * @tc.desc      : testCanvasDrawPointsAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointsAbnormal0093', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointsAbnormal0093';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawPoints([{
          x: 100, y: 200
        }, {
          x: 150, y: 230
        }, {
          x: 200, y: 300
        }], 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawPoints([]);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TEXTBLOB_9400
     * @tc.name      : testTextBlobMakeFromRunBufferBoundsNormal0094
     * @tc.desc      : Test for testTextBlobMakeFromRunBufferBoundsNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTextBlobMakeFromRunBufferBoundsNormal0094', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testTextBlobMakeFromRunBufferBoundsNormal0094';
      let font = new drawing.Font(); // Create a new Font object

      // Make a TextBlob from a run buffer using the Font object and various bounds
      let runBuffer: drawing.TextBlobRunBuffer[] = [
        {
          glyph: 65, positionX: 0, positionY: 0
        },
        {
          glyph: 227, positionX: 14.9, positionY: 0
        }
      ];

      let boundsList: common2D.Rect[] = [
        {
          left: 0, right: 0, top: 100, bottom: 100
        },
        {
          left: 100.32, right: 100.5, top: 400.2, bottom: 400.3
        },
        {
          left: 0, right: 0, top: 0, bottom: 100
        },
        {
          left: 0, right: 100, top: 100, bottom: 100
        },
        {
          left: 100, right: 100, top: 100, bottom: 100
        },
        {
          left: -100, right: 100, top: -100, bottom: 100
        },
        {
          left: 100, right: -100, top: 100, bottom: -100
        },
        {
          left: 200, right: 100, top: 200, bottom: 100
        },
      ];

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, null);
        console.info(`${msg} makeFromRunBuffer succeeded for bounds ${JSON.stringify(null)}`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds ${JSON.stringify(null)}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      for (let bounds of boundsList) {
        try {
          const textBlob = drawing.TextBlob.makeFromRunBuffer(runBuffer, font, bounds);
          const b = textBlob.bounds();
          console.info(`${msg} bounds result is ${JSON.stringify(b)}`);
          console.info(`${msg} bounds input is ${JSON.stringify(bounds)}`);
          if (bounds.left < bounds.right && bounds.top < bounds.bottom) {
            expect(Math.round(bounds.left)).assertEqual(Math.round(b.left));
            expect(Math.round(bounds.right)).assertEqual(Math.round(b.right));
            expect(Math.round(bounds.top)).assertEqual(Math.round(b.top));
            expect(Math.round(bounds.bottom)).assertEqual(Math.round(b.bottom));
          } else {
            expect(0).assertEqual(b.left);
            expect(0).assertEqual(b.right);
            expect(0).assertEqual(b.top);
            expect(0).assertEqual(b.bottom);
          }
          console.info(`${msg} makeFromRunBuffer succeeded for bounds ${JSON.stringify(bounds)}`);
        } catch (e) {
          console.info(`${msg} makeFromRunBuffer failed for bounds ${JSON.stringify(bounds)}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, undefined);
        console.info(`${msg} makeFromRunBuffer succeeded for bounds ${JSON.stringify(undefined)}`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds ${JSON.stringify(undefined)}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        // Make a TextBlob from an empty run buffer using the Font object
        drawing.TextBlob.makeFromRunBuffer([], font);
        console.info(msg + ' makeFromRunBuffer succeeded for empty run buffer');
      } catch (e) {
        console.info(msg + ` makeFromRunBuffer failed for empty run buffer, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

    });

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TEXTBLOB_9500
     * @tc.name      : testTextBlobMakeFromRunBufferBoundsNull0095
     * @tc.desc      : Test for testTextBlobMakeFromRunBufferBoundsNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTextBlobMakeFromRunBufferBoundsNull0095', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTextBlobMakeFromRunBufferBoundsNull0095';
      let font = new drawing.Font();

      let runBuffer: drawing.TextBlobRunBuffer[] = [
        {
          glyph: 65, positionX: 0, positionY: 0
        },
        {
          glyph: 227, positionX: 14.9, positionY: 0
        }
      ];

      try {
        drawing.TextBlob.makeFromRunBuffer(undefined, font);
        console.info(`${msg} makeFromRunBuffer succeeded for bounds ${JSON.stringify(undefined)}`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds ${JSON.stringify(undefined)}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, undefined);
        console.info(`${msg} makeFromRunBuffer succeeded for bounds ${JSON.stringify(undefined)}`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds ${JSON.stringify(undefined)}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(null, font);
        console.info(`${msg} makeFromRunBuffer succeeded for bounds ${JSON.stringify(null)}`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds ${JSON.stringify(null)}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, null);
        console.info(`${msg} makeFromRunBuffer succeeded for bounds ${JSON.stringify(null)}`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds ${JSON.stringify(null)}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: null, right: 0, top: 10, bottom: 10
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with null left value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with null left value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: 0, right: null, top: 10, bottom: 10
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with null right value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with null right value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: 0, right: 100, top: null, bottom: 10
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with null top value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with null top value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: 0, right: 100, top: 10, bottom: null
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with null bottom value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with null bottom value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: undefined, right: 0, top: 10, bottom: 10
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with undefined left value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with undefined left value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: 0, right: undefined, top: 10, bottom: 10
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with undefined right value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with undefined right value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: 0, right: 100, top: undefined, bottom: 10
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with undefined top value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with undefined top value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromRunBuffer(runBuffer, font, {
          left: 0, right: 100, top: 10, bottom: undefined
        });
        console.info(`${msg} makeFromRunBuffer succeeded for bounds with undefined bottom value`);
      } catch (e) {
        console.info(`${msg} makeFromRunBuffer failed for bounds with undefined bottom value, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    });

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TEXTBLOB_9600
     * @tc.name      : testTextBlobMakeFromRunBufferBoundsMultipleCalls0096
     * @tc.desc      : Test for testTextBlobMakeFromRunBufferBoundsMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTextBlobMakeFromRunBufferBoundsMultipleCalls0096', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTextBlobMakeFromRunBufferBoundsMultipleCalls0096';
      let font = new drawing.Font(); // Create a new Font object

      for (let i = 0; i < 20; i++) {
        // Generate a random run buffer
        let randomRunBuffer: drawing.TextBlobRunBuffer[] = [
          {
            glyph: Math.floor(Math.random() * 100),
            positionX: Math.floor(Math.random() * 100),
            positionY: Math.floor(Math.random() * 100)
          },
          {
            glyph: Math.floor(Math.random() * 100),
            positionX: Math.floor(Math.random() * 100),
            positionY: Math.floor(Math.random() * 100)
          }
        ];

        // Generate random bounds
        let randomBounds: common2D.Rect = {
          left: Math.floor(Math.random() * 100),
          top: Math.floor(Math.random() * 100),
          right: Math.floor(Math.random() * 100 + 100),
          bottom: Math.floor(Math.random() * 100 + 100)
        };

        try {
          // Make a TextBlob from the random run buffer using the Font object and random bounds
          let textBlob = drawing.TextBlob.makeFromRunBuffer(randomRunBuffer, font, randomBounds);
          console.info(`${msg} makeFromRunBuffer succeeded`);

          try {
            // Call bounds method
            const result = textBlob.bounds();
            console.info(`${msg} bounds result is ` + JSON.stringify(result));
            console.info(`${msg} bounds input is ` + JSON.stringify(randomBounds));
            expect(randomBounds.left).assertEqual(result.left);
            expect(randomBounds.top).assertEqual(result.top);
            expect(randomBounds.right).assertEqual(result.right);
            expect(randomBounds.bottom).assertEqual(result.bottom);
            console.info(`${msg} bounds succeeded`);
          } catch (e) {
            console.info(`${msg} bounds failed, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
            expect().assertFail();
          }
        } catch (e) {
          console.info(`${msg} makeFromRunBuffer failed, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TEXTBLOB_9700
     * @tc.name      : testTextBlobMakeFromStringNormal0097
     * @tc.desc      : Test for testTextBlobMakeFromStringNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTextBlobMakeFromStringNormal0097', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testTextBlobMakeFromStringNormal0097';

      let font = new drawing.Font();

      try {
        drawing.TextBlob.makeFromString("drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        drawing.TextBlob.makeFromString("drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF16);
        drawing.TextBlob.makeFromString("drawing", font, drawing.TextEncoding.TEXT_ENCODING_UTF32);
        drawing.TextBlob.makeFromString("drawing", font, drawing.TextEncoding.TEXT_ENCODING_GLYPH_ID);
        console.info(msg + ' makeFromString succeeded for encoding');
      } catch (e) {
        console.info(msg + ` makeFromString failed for encoding, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        drawing.TextBlob.makeFromString("中文魑認識", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' makeFromString succeeded for Chinese string');
      } catch (e) {
        console.info(msg + ` makeFromString failed for Chinese string, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        drawing.TextBlob.makeFromString("中文魑認識", font);
        console.info(msg + ' makeFromString succeeded for Chinese string without specifying TextEncoding');
      } catch (e) {
        console.info(msg + ` makeFromString failed for Chinese string without specifying TextEncoding, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }

      try {
        drawing.TextBlob.makeFromString("", font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' makeFromString succeeded for empty string');
      } catch (e) {
        console.info(msg + ` makeFromString failed for empty string, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TEXTBLOB_9800
     * @tc.name      : testTextBlobMakeFromStringNull0098
     * @tc.desc      : Test for testTextBlobMakeFromStringNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTextBlobMakeFromStringNull0098', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTextBlobMakeFromStringNull0098';
      let font = new drawing.Font();

      try {
        drawing.TextBlob.makeFromString(undefined, font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' makeFromString succeeded for undefined string');
      } catch (e) {
        console.info(msg + ` makeFromString failed for undefined string, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromString("drawing", undefined, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' makeFromString succeeded for undefined font');
      } catch (e) {
        console.info(msg + ` makeFromString failed for undefined font, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromString("drawing", font, undefined);
        console.info(msg + ' makeFromString succeeded for undefined TextEncoding');
      } catch (e) {
        console.info(msg + ` makeFromString failed for undefined TextEncoding, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromString(null, font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' makeFromString succeeded for null string');
      } catch (e) {
        console.info(msg + ` makeFromString failed for null string, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromString("drawing", null, drawing.TextEncoding.TEXT_ENCODING_UTF8);
        console.info(msg + ' makeFromString succeeded for null font');
      } catch (e) {
        console.info(msg + ` makeFromString failed for null font, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.TextBlob.makeFromString("drawing", font, null);
        console.info(msg + ' makeFromString succeeded for null TextEncoding');
      } catch (e) {
        console.info(msg + ` makeFromString failed for null TextEncoding, errorCode is:  ${e.code}, errorMessage is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    });

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_TEXTBLOB_9900
     * @tc.name      : testTextBlobMakeFromStringMultipleCalls0099
     * @tc.desc      : Test for testTextBlobMakeFromStringMultipleCalls.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testTextBlobMakeFromStringMultipleCalls0099', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testTextBlobMakeFromStringMultipleCalls0099';
      let font = new drawing.Font();

      for (let i = 0; i < 20; i++) {
        // Generate a random string
        let randomString = Math.random().toString(36).substring(7);

        // Generate a random TextEncoding value
        let randomEncoding = Math.floor(Math.random() * getEnumCount(drawing.TextEncoding));

        try {
          drawing.TextBlob.makeFromString(randomString, font, randomEncoding);
          console.info(`${msg} makeFromString succeeded for call ${i + 1}`);
        } catch (e) {
          console.info(`${msg} makeFromString failed for call ${i + 1}, errorCode is: ${e.code}, errorMessage is: ${e.message}`);
          expect().assertFail();
        }
      }
    })
  })
}
