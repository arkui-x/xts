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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType, Size, Level } from '@ohos/hypium';
import drawing from '@ohos.graphics.drawing';
import colorSpaceManager from '@ohos.graphics.colorSpaceManager';
import common2D from '@ohos.graphics.common2D';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function penPart2Test() {
  describe('DrawingTsPenPart2Test', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(async() => {

    })
    beforeEach(async () => {
      await sleep(100)
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(async () => {
      await sleep(1000)
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(async () => {
      await sleep(500)
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0100
     * @tc.name      : testPenSetAndGetColor4fNormal0001
     * @tc.desc      : Test for testPenSetAndGetColor4fNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPenSetAndGetColor4fNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testPenSetAndGetColor4fNormal0001';
      let pen = new drawing.Pen();
      let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG);
      let color4f:common2D.Color4f = {alpha:0.8, red:0.5, green:0.4, blue:0.7};
      try {
        pen.setColor4f(color4f, colorSpace);
        console.info(msg + ' setColor4f successed');
        let color = pen.getColor4f();
        console.info(msg + ' getColor4f successed color is: ' + JSON.stringify(color));
        let dif_alpha = Math.abs(color.alpha-color4f.alpha);
        expect( dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color.red-color4f.red);
        expect( dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color.green-color4f.green);
        expect( dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color.blue-color4f.blue);
        expect( dif_blue < 0.0001).assertEqual(true);
      } catch( e ) {
        console.info(msg + ` 1 errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
      try {
        color4f = {alpha:1, red:1, green:1, blue:1};
        pen.setColor4f(color4f, colorSpace);
        let color2 = pen.getColor4f();
        console.info(msg + ' setColor4f 2 successed');
        let color = pen.getColor4f();
        console.info(msg + ' getColor4f 2 successed color2 is: ' + JSON.stringify(color2));
        let dif_alpha = Math.abs(color2.alpha-color4f.alpha);
        expect( dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color2.red-color4f.red);
        expect( dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color2.green-color4f.green);
        expect( dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color2.blue-color4f.blue);
        expect( dif_blue < 0.0001).assertEqual(true);
      } catch( e ) {
        console.info(msg + ` 2 errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
      try {
        color4f = {alpha:0, red:0, green:0, blue:0};
        pen.setColor4f(color4f, colorSpace);
        console.info(msg + ' setColor4f 3 successed');
        let color3 = pen.getColor4f();
        console.info(msg + ' getColor4f 3 successed color3 is: ' + JSON.stringify(color3));
        let dif_alpha = Math.abs(color3.alpha-color4f.alpha);
        expect( dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color3.red-color4f.red);
        expect( dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color3.green-color4f.green);
        expect( dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color3.blue-color4f.blue);
        expect( dif_blue < 0.0001).assertEqual(true);
      } catch( e ) {
        console.info(msg + ` 3 errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
      try {
        pen.setColor4f(color4f, null);
        console.info(msg + ' setColor4f 4 successed');
        let color4 = pen.getColor4f();
        console.info(msg + ' getColor4f 4 successed color4 is: ' + JSON.stringify(color4));
        let dif_alpha = Math.abs(color4.alpha-color4f.alpha);
        expect( dif_alpha < 0.0001).assertEqual(true);
        let dif_red = Math.abs(color4.red-color4f.red);
        expect( dif_red < 0.0001).assertEqual(true);
        let dif_green = Math.abs(color4.green-color4f.green);
        expect( dif_green < 0.0001).assertEqual(true);
        let dif_blue = Math.abs(color4.blue-color4f.blue);
        expect( dif_blue < 0.0001).assertEqual(true);
      } catch( e ) {
        console.info(msg + ` 4 errorCode is:  ${ e.code } + errormsg is: ${ e.message }`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PEN_0200
     * @tc.name      : testPenSetAndGetColor4fMultipleCalls0002
     * @tc.desc      : testPenSetAndGetColor4fMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPenSetAndGetColor4fMultipleCalls0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testPenSetAndGetColor4fMultipleCalls0002';
      try {
        for (let i = 0; i < 20; i += 1) {
          let pen = new drawing.Pen();
          let colorSpace = colorSpaceManager.create(colorSpaceManager.ColorSpace.BT2020_HLG);
          let color4f:common2D.Color4f = {alpha:Math.random() *1, red:Math.random() *1, green:Math.random() *1, blue:Math.random() *1};
          console.info(msg + 'setColor4f  color4f is ' + JSON.stringify(color4f) +' step: ' +i);
          pen.setColor4f(color4f, colorSpace);
          console.info(msg + 'setColor4f success step is ' + i);
          let color = pen.getColor4f();
          console.info(msg + 'getColor4f success color is ' + JSON.stringify(color) +' step: ' +i);
          let dif_alpha = Math.abs(color.alpha-color4f.alpha);
          expect( dif_alpha < 0.0001).assertEqual(true);
          let dif_red = Math.abs(color.red-color4f.red);
          expect( dif_red < 0.0001).assertEqual(true);
          let dif_green = Math.abs(color.green-color4f.green);
          expect( dif_green < 0.0001).assertEqual(true);
          let dif_blue = Math.abs(color.blue-color4f.blue);
          expect( dif_blue < 0.0001).assertEqual(true);
        }
      } catch (e) {
        console.info(msg + `isInterpolate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })
  })
}