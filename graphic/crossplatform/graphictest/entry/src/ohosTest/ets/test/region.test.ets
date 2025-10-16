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
import drawing from '@ohos.graphics.drawing';
import image from '@ohos.multimedia.image';
import { getEnumCount, getRandomNumber } from './utils';
import common2D from '@ohos.graphics.common2D';

export default function drawingTsRegionTestPart2() {
  describe('DrawingTsRegionTest', () => {
    let pixel: image.PixelMap;
    beforeAll(async () => {
      const color: ArrayBuffer = new ArrayBuffer(40000);
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100
        }
      }
      pixel = await image.createPixelMap(color, opts);
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number    : SUB_GRAPHIC_REGION_ISCOMPLEX_0100
     * @tc.name      : testIsComplex0001
     * @tc.desc      : testRegionIsComplexNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testIsComplex0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionIsComplexNormal';
      let region = new drawing.Region();
      try {
        let flag: boolean = region.isComplex();
        console.info(msg + `Region isComplex flag success`);
        expect(flag).assertEqual(false);
      } catch (e) {
        console.info(msg + `Region isComplex flag error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region = new drawing.Region(100, 100, 200, 200);
      try {
        let flag2: boolean = region.isComplex();
        console.info(msg + `Region isComplex flag2 success`);
        expect(flag2).assertEqual(false);
      } catch (e) {
        console.info(msg + `Region isComplex flag2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.op(new drawing.Region(120, 120, 180, 180), drawing.RegionOp.UNION);
      try {
        let flag3: boolean = region.isComplex();
        console.info(msg + `Region isComplex flag3 success`);
        expect(flag3).assertEqual(false);
      } catch (e) {
        console.info(msg + `Region isComplex flag3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.op(new drawing.Region(220, 220, 280, 280), drawing.RegionOp.UNION);
      try {
        let flag4: boolean = region.isComplex();
        console.info(msg + `Region isComplex flag4 success`);
        expect(flag4).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isComplex flag4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let path = new drawing.Path()
      region.setRect(100, 100, 400, 400);
      path.arcTo(50, 50, 300, 300, 0, 359);
      region.setPath(path, region);
      try {
        let flag5: boolean = region.isComplex();
        console.info(msg + `Region isComplex flag5 success`);
        expect(flag5).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isComplex flag5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_REGION_ISCOMPLEX_0200
     * @tc.name      : testIsComplex0002
     * @tc.desc      : testRegionIsComplexMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsComplex0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionIsComplexMultipleCalls';
      let region = new drawing.Region();
      for (let i = 0; i < 20; i += 1) {
        try {
          let flag: boolean = region.isComplex();
          console.info(msg + `region isComplex success step: ` + i);
          expect(flag).assertEqual(false);
        } catch (e) {
          console.info(msg +
            `drawing region isComplex error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_REGION_ISEMPTY_0300
     * @tc.name      : testIsEmpty0003
     * @tc.desc      : testRegionIsEmptyNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testIsEmpty0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionIsEmptyNormal';
      let region = new drawing.Region();
      try {
        let flag: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag success`);
        expect(flag).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        let flag2: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag2 success`);
        expect(flag2).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region = new drawing.Region(0, 0, 0, 0);
      try {
        let flag3: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag3 success`);
        expect(flag3).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 20, 20, 20);
      try {
        let flag4: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag4 success`);
        expect(flag4).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 10, 10, 20);
      try {
        let flag5: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag5 success`);
        expect(flag5).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(20, 20, 20, 20);
      try {
        let flag6: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag6 success`);
        expect(flag6).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag6 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0, 0, 100, 100);
      try {
        let flag7: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag7 success`);
        expect(flag7).assertEqual(false);
      } catch (e) {
        console.info(msg + `Region isEmpty flag7 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0, 10.2632, 100.25474, 100.2884);
      try {
        let flag8: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag8 success`);
        expect(flag8).assertEqual(false);
      } catch (e) {
        console.info(msg + `Region isEmpty flag8 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(-100, -100.98788, -50, -50);
      try {
        let flag9: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag9 success`);
        expect(flag9).assertEqual(false);
      } catch (e) {
        console.info(msg + `Region isEmpty flag9 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(100, 100.25, -100, -100.255);
      try {
        let flag10: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag10 success`);
        expect(flag10).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag10 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_REGION_ISEMPTY_0400
     * @tc.name      : testIsEmpty0004
     * @tc.desc      : testRegionIsEmptyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsEmpty0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionIsEmptyMultipleCalls';
      let region = new drawing.Region();
      for (let i = 0; i < 20; i += 1) {
        try {
          let flag: boolean = region.isEmpty();
          console.info(msg + `region isEmpty success step: ` + i);
          expect(flag).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `drawing region isEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_REGION_GETBOUNDS_0500
     * @tc.name      : testGetBounds0005
     * @tc.desc      : testRegionGetBoundsNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testGetBounds0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionGetBoundsNormal';
      let region = new drawing.Region();
      try {
        let rect: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect success`);
        console.info(msg + `rect11: ${JSON.stringify(rect)}`);
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let region1 = new drawing.Region(region);
      try {
        let rect2: common2D.Rect = region1.getBounds();
        console.info(msg + `Region getBounds rect2 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect2)}`);
        expect(rect2.left == 0 && rect2.top == 0 && rect2.right == 0 && rect2.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region = new drawing.Region(0, 0, 0, 0);
      try {
        let rect3: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect3 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect3)}`);
        expect(rect3.left == 0 && rect3.top == 0 && rect3.right == 0 && rect3.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 20, 20, 20);
      try {
        let rect4: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect4 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect4)}`);
        expect(rect4.left == 0 && rect4.top == 0 && rect4.right == 0 && rect4.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 10, 10, 20);
      try {
        let rect5: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect5 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect5)}`);
        expect(rect5.left == 0 && rect5.top == 0 && rect5.right == 0 && rect5.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(20, 20, 20, 20);
      try {
        let rect6: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect6 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect6)}`);
        expect(rect6.left == 0 && rect6.top == 0 && rect6.right == 0 && rect6.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect6 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0, 0, 100, 100);
      try {
        let rect7: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect7 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect7)}`);
        expect(rect7.left == 0 && rect7.top == 0 && rect7.right == 100 && rect7.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect7 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0, 10.2632, 100.25474, 100.2884);
      try {
        let rect8: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect8 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect8)}`);
        expect(rect8.left == 0 && rect8.top == 10 && rect8.right == 100 && rect8.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect8 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(-100, -100.98788, -50, -50);
      try {
        let rect9: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect9 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect9)}`);
        expect(rect9.left == -100 && rect9.top == -100 && rect9.right == -50 && rect9.bottom == -50).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect9 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(100, 100.25, -100, -100.255);
      try {
        let rect10: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect10 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect10)}`);
        expect(rect10.left == 0 && rect10.top == 0 && rect10.right == 0 && rect10.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect10 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let path = new drawing.Path()
      region.setRect(100, 100, 400, 400);
      path.arcTo(50, 50, 300, 300, 0, 359);
      region.setPath(path, region);
      try {
        let rect11: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect11 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect11)}`);
        expect(rect11.left == 100 && rect11.top == 100 && rect11.right == 300 && rect11.bottom == 300)
          .assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect11 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_REGION_GETBOUNDS_0600
     * @tc.name      : testGetBounds0006
     * @tc.desc      : testRegionGetBoundsMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testGetBounds0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionGetBoundsMultipleCalls';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect = region.getBounds();
          console.info(msg + `region getBounds success step: ` + i);
          console.info(msg + `rect: ${JSON.stringify(rect)}`);
          expect(rect.left == 100 && rect.top == 100 && rect.right == 400 && rect.bottom == 400).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `drawing region getBounds error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_GETBOUNDARYPATH_0700
     * @tc.name      : testGetBoundaryPath0007
     * @tc.desc      : testRegionGetBoundaryPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testGetBoundaryPath0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionGetBoundaryPathNormal';
      let region = new drawing.Region();
      try {
        let getpath = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath success`);
        expect(getpath != null || getpath != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let region1 = new drawing.Region(region);
      try {
        let getpath2 = region1.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath2 success`);
        expect(getpath2 != null || getpath2 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region = new drawing.Region(0, 0, 0, 0);
      try {
        let getpath3 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath3 success`);
        expect(getpath3 != null || getpath3 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 20, 20, 20);
      try {
        let getpath4 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath4 success`);
        expect(getpath4 != null || getpath4 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 10, 10, 20);
      try {
        let getpath5 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath5 success`);
        expect(getpath5 != null || getpath5 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(20, 20, 20, 20);
      try {
        let getpath6 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath6 success`);
        expect(getpath6 != null || getpath6 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath6 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(50, 50, 300, 300);
      try {
        let getpath7 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath7 success`);
        expect(getpath7 != null || getpath7 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath7 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0, 100.2632, 600.25474, 500.2884);
      try {
        let getpath8 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath8 success`);
        expect(getpath8 != null || getpath8 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath8 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(-100, -100.98788, 450, 450);
      try {
        let getpath9 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath9 success`);
        expect(getpath9 != null || getpath9 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath9 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(100, 100.25, -100, -100.255);
      try {
        let getpath10 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath10 success`);
        expect(getpath10 != null || getpath10 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath10 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let path = new drawing.Path()
      region.setRect(100, 100, 400, 400);
      path.arcTo(50, 50, 300, 300, 0, 359);
      region.setPath(path, region);
      try {
        let getpath11 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath11 success`);
        expect(getpath11 != null || getpath11 != undefined).assertTrue()
      } catch (e) {
        console.info(msg +
          `Region getBoundaryPath getpath11 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_GETBOUNDARYPATH_0800
     * @tc.name      : testGetBoundaryPath0008
     * @tc.desc      : testRegionGetBoundaryPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testGetBoundaryPath0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionGetBoundaryPathMultipleCalls';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      for (let i = 0; i < 20; i += 1) {
        try {
          let getpath = region.getBoundaryPath();
          console.info(msg + `region getBoundaryPath success step: ` + i);
          expect(getpath != null || getpath != undefined).assertTrue()
        } catch (e) {
          console.info(msg +
            `drawing region getBoundaryPath error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISPOINTCONTAINED_0900
     * @tc.name      : testIsPointContained0009
     * @tc.desc      : testRegionIsPointContainedNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testIsPointContained0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionIsPointContainedNormal';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        let flag: boolean = region.isPointContained(200, 200);
        expect(flag).assertTrue();
        flag = region.isPointContained(100, 100);
        expect(flag).assertTrue();
        flag = region.isPointContained(50, 100);
        expect(flag).assertFalse();
        flag = region.isPointContained(100.1, 200.25);
        expect(flag).assertTrue();
        flag = region.isPointContained(401.2, 401.6);
        expect(flag).assertFalse();
        flag = region.isPointContained(-50, -50);
        expect(flag).assertFalse();
        canvas.drawPoint(200, 200);
        canvas.drawRegion(region);
        console.info(msg + `isPointContained successed`);
      } catch (e) {
        console.info(msg + `isPointContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISPOINTCONTAINED_1000
     * @tc.name      : testIsPointContained0010
     * @tc.desc      : testRegionIsPointContainedNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testIsPointContained0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionIsPointContainedNull';
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        region.isPointContained(undefined, 100);
        console.info(msg + `isPointContained successed`);
      } catch (e) {
        console.info(msg + `isPointContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        region.isPointContained(null, 100);
        console.info(msg + `isPointContained successed`);
      } catch (e) {
        console.info(msg + `isPointContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        region.isPointContained(100, undefined);
        console.info(msg + `isPointContained successed`);
      } catch (e) {
        console.info(msg + `isPointContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        region.isPointContained(100, null);
        console.info(msg + `isPointContained successed`);
      } catch (e) {
        console.info(msg + `isPointContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISPOINTCONTAINED_1100
     * @tc.name      : testIsPointContained0011
     * @tc.desc      : testRegionIsPointContainedMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testIsPointContained0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionIsPointContainedMultipleCalls';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        let flag: boolean = false;
        for (let index = 0; index < 20; index++) {
          let num1 = getRandomNumber(101, 399);
          let num2 = getRandomNumber(101, 399);
          flag = region.isPointContained(num1, num2);
          console.info(msg + `isPointContained flag: ${flag}, random num1: ${num1}, num2: ${num2}`);
          expect(flag).assertTrue();
        }
        canvas.drawPoint(200, 200);
        canvas.drawRegion(region);
        console.info(msg + `isPointContained successed`);
      } catch (e) {
        console.info(msg + `isPointContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISREGIONCONTAINED_1200
     * @tc.name      : testIsRegionContained0012
     * @tc.desc      : testRegionIsRegionContainedNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testIsRegionContained0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionIsRegionContainedNormal';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        let other = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        other.setRect(150, 150, 250, 250);
        let flag: boolean = region.isRegionContained(other);
        expect(flag).assertTrue();
        other.setRect(100.1, 100.1, 400.1, 400.1);
        flag = region.isRegionContained(other);
        expect(flag).assertTrue();
        other.setRect(50, 50, 500, 500);
        flag = region.isRegionContained(other);
        expect(flag).assertFalse();
        other.setRect(50, 50, 150, 150);
        flag = region.isRegionContained(other);
        expect(flag).assertFalse();
        other.setRect(50, 50, 80, 80);
        flag = region.isRegionContained(other);
        expect(flag).assertFalse();
        canvas.drawRegion(region);
        canvas.drawRegion(other);
        console.info(msg + `isRegionContained successed`);
      } catch (e) {
        console.info(msg + `isRegionContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISREGIONCONTAINED_1300
     * @tc.name      : testIsRegionContained0013
     * @tc.desc      : testRegionIsRegionContainedNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testIsRegionContained0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionIsRegionContainedNull';
      try {
        let region = new drawing.Region();
        region.isRegionContained(undefined);
        console.info(msg + `isRegionContained successed`);
      } catch (e) {
        console.info(msg + `isRegionContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.isRegionContained(null);
        console.info(msg + `isRegionContained successed`);
      } catch (e) {
        console.info(msg + `isRegionContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISREGIONCONTAINED_1400
     * @tc.name      : testIsRegionContained0014
     * @tc.desc      : testRegionIsRegionContainedMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testIsRegionContained0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionIsRegionContainedMultipleCalls';
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        let flag: boolean = false;
        for (let index = 0; index < 20; index++) {
          flag = region.isRegionContained(region);
          expect(flag).assertTrue();
        }
        console.info(msg + `isRegionContained successed`);
      } catch (e) {
        console.info(msg + `isRegionContained failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_QUICKREJECT_1500
     * @tc.name      : testQuickReject0015
     * @tc.desc      : testRegionQuickRejectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testQuickReject0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionQuickRejectNormal';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        let other = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        other.setRect(150, 150, 250, 250);
        let flag: boolean = region.quickReject(50, 50, 70, 70);
        expect(flag).assertTrue();
        flag = region.quickReject(100.1, 100.1, 400.1, 400.1);
        expect(flag).assertFalse();
        flag = region.quickReject(50, 50, 200, 200);
        expect(flag).assertFalse();
        flag = region.quickReject(401.1, 401.1, 500, 500);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        canvas.drawRegion(other);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_QUICKREJECT_1600
     * @tc.name      : testQuickReject0016
     * @tc.desc      : testRegionQuickRejectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testQuickReject0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionQuickRejectNull';
      try {
        let region = new drawing.Region();
        region.quickReject(undefined, 50, 70, 70);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.quickReject(50, undefined, 70, 70);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.quickReject(50, 50, undefined, 70);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.quickReject(50, 50, 70, undefined);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.quickReject(null, 50, 70, 70);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.quickReject(50, null, 70, 70);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.quickReject(50, 50, null, 70);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.quickReject(50, 50, 70, null);
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_QUICKREJECT_1700
     * @tc.name      : testQuickReject0017
     * @tc.desc      : testRegionQuickRejectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testQuickReject0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionQuickRejectMultipleCalls';
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        let flag: boolean = false;
        for (let index = 0; index < 20; index++) {
          flag = region.quickReject(50, 50, 70, 70);
          expect(flag).assertTrue();
        }
        console.info(msg + `quickReject successed`);
      } catch (e) {
        console.info(msg + `quickReject failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETPATH_1800
     * @tc.name      : testSetPath0018
     * @tc.desc      : testRegionSetPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPath0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionSetPathNormal';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setRect(100, 100, 400, 400);
        path.arcTo(50, 50, 300, 300, 0, 359);
        region.setPath(path, region);
        canvas.drawRegion(region);
        console.info(msg + `setPath successed`);
      } catch (e) {
        console.info(msg + `setPath failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETPATH_1900
     * @tc.name      : testSetPath0019
     * @tc.desc      : testRegionSetPathNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetPath0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionSetPathNull';
      let canvas = new drawing.Canvas(pixel);
      try {
        let region = new drawing.Region();
        region.setPath(undefined, region);
        canvas.drawRegion(region);
        console.info(msg + `setPath successed`);
      } catch (e) {
        console.info(msg + `setPath failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setPath(path, undefined);
        canvas.drawRegion(region);
        console.info(msg + `setPath successed`);
      } catch (e) {
        console.info(msg + `setPath failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setPath(null, region);
        canvas.drawRegion(region);
        console.info(msg + `setPath successed`);
      } catch (e) {
        console.info(msg + `setPath failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setPath(path, null);
        canvas.drawRegion(region);
        console.info(msg + `setPath successed`);
      } catch (e) {
        console.info(msg + `setPath failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETPATH_2000
     * @tc.name      : testSetPath0020
     * @tc.desc      : testRegionSetPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetPath0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionSetPathMultipleCalls';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setRect(100, 100, 400, 400);
        path.arcTo(50, 50, 300, 300, 0, 359);
        let flag: boolean = false;
        for (let index = 0; index < 20; index++) {
          flag = region.setPath(path, region);
          expect(flag).assertTrue();
        }
        canvas.drawRegion(region);
        console.info(msg + `setPath successed`);
      } catch (e) {
        console.info(msg + `setPath failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETRECT_2100
     * @tc.name      : testSetRect0021
     * @tc.desc      : testRegionSetRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetRect0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionSetRectNormal';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        region.setRect(100.1, 100.1, 400.1, 400.1);
        region.setRect(-100.1, -100.1, 400.1, 400.1);
        region.setRect(100, 100, 100, 400);
        region.setRect(100, 400, 400, 400);
        region.setRect(Number.MIN_VALUE, Number.MIN_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETRECT_2200
     * @tc.name      : testSetRect0022
     * @tc.desc      : testRegionSetRectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetRect0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionSetRectNull';
      let canvas = new drawing.Canvas(pixel);
      try {
        let region = new drawing.Region();
        region.setRect(undefined, 50, 70, 70);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(50, undefined, 70, 70);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(50, 50, undefined, 70);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(50, 50, 70, undefined);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(null, 50, 70, 70);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(50, null, 70, 70);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(50, 50, null, 70);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let region = new drawing.Region();
        region.setRect(50, 50, 70, null);
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETRECT_2300
     * @tc.name      : testSetRect0023
     * @tc.desc      : testRegionSetRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetRect0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionSetRectMultipleCalls';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        for (let index = 0; index < 20; index++) {
          region.setRect(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE,
            Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.drawRegion(region);
        console.info(msg + `setRect successed`);
      } catch (e) {
        console.info(msg + `setRect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_OP_2400
     * @tc.name      : testOp0024
     * @tc.desc      : testRegionOpNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testOp0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionOpNormal';
      let canvas = new drawing.Canvas(pixel);
      try {
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, drawing.RegionOp.DIFFERENCE);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, drawing.RegionOp.INTERSECT);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, drawing.RegionOp.UNION);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, drawing.RegionOp.XOR);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, drawing.RegionOp.REVERSE_DIFFERENCE);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
      try {
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, drawing.RegionOp.REPLACE);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_OP_2500
     * @tc.name      : testOp0025
     * @tc.desc      : testRegionOpNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testOp0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionOpNull';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(undefined, drawing.RegionOp.REPLACE);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, undefined);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(null, drawing.RegionOp.REPLACE);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = region.op(othregion, null);
        expect(flag).assertTrue();
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_OP_2600
     * @tc.name      : testOp0026
     * @tc.desc      : testRegionOpMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testOp0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionOpMultipleCalls';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        for (let index = 0; index < 20; index++) {
          let randomEnum = Math.floor(Math.random() * getEnumCount(drawing.RegionOp));
          let flag: boolean = region.op(othregion, randomEnum);
          expect(flag).assertTrue();
        }
        canvas.drawRegion(region);
        console.info(msg + `op successed`);
      } catch (e) {
        console.info(msg + `op failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_OFFSET_2700
     * @tc.name      : testOffset0027
     * @tc.desc      : testRegionOffsetNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testOffset0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionOffsetNormal';
      let region = new drawing.Region();
      try {
        region.offset(10, 20);
        console.info(msg + `Region offset 1 success`);
      } catch (e) {
        console.info(msg + `Region offset 1 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(50, 50, 300, 300);
      try {
        region.offset(-50, -50);
        console.info(msg + `Region offset 2 success`);
      } catch (e) {
        console.info(msg + `Region offset 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        region.offset(100.25, 150.852);
        region.offset(100.25, 0);
        console.info(msg + `Region offset 3 success`);
      } catch (e) {
        console.info(msg + `Region offset 3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        region.offset(-100.25, 300.25);
        console.info(msg + `Region offset 4 success`);
      } catch (e) {
        console.info(msg + `Region offset 4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let path = new drawing.Path()
      region.setRect(100, 100, 400, 400);
      path.arcTo(50, 50, 300, 300, 0, 359);
      region.setPath(path, region);
      try {
        region.offset(-100.25, 500.25);
        console.info(msg + `Region offset 5 success`);
      } catch (e) {
        console.info(msg + `Region offset 5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        region.offset(Number.MAX_VALUE, Number.MAX_VALUE);
        console.info(msg + `Region offset 6 success`);
      } catch (e) {
        console.info(msg + `Region offset 6 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_OFFSET_2800
     * @tc.name      : testOffset0028
     * @tc.desc      : testRegionOffsetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testOffset0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionOffsetMultipleCalls';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      for (let i = 0; i < 20; i += 1) {
        try {
          region.offset(100, 100);
          console.info(msg + `region offset success step: ` + i);
        } catch (e) {
          console.info(msg +
            `drawing region offset error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_OFFSET_2900
     * @tc.name      : testOffset0029
     * @tc.desc      : testRegionOffsetNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testOffset0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionOffsetNull';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      try {
        region.offset(null, 100);
        console.info(msg + `region offset 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `region offset 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        region.offset(undefined, 100);
        console.info(msg + `region offset 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `region offset 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        region.offset(100, null);
        console.info(msg + `region offset 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `region offset 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        region.offset(100, undefined);
        console.info(msg + `region offset 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `region offset 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_QUICKREJECTREGION_3000
     * @tc.name      : testQuickRejectRegion0030
     * @tc.desc      : testRegionQuickRejectRegionNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testQuickRejectRegion0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionQuickRejectRegionNormal';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      let other = new drawing.Region(50.1, 50.1, 150.1, 150.1);
      try {
        let flag1 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag1 success`);
        expect(flag1).assertEqual(false);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag1 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(0, 0, 100, 100);
      try {
        let flag2 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag2 success`);
        expect(flag2).assertEqual(true);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(-100, -100, 500, 500);
      try {
        let flag3 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag3 success`);
        expect(flag3).assertEqual(false);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(100, 100, 400, 400);
      try {
        let flag4 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag4 success`);
        expect(flag4).assertEqual(false);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(500, 500, 600, 600);
      try {
        let flag5 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag5 success`);
        expect(flag5).assertEqual(true);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(200.254, 200.255, 300.255, 300.952);
      try {
        let flag6 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag6 success`);
        expect(flag6).assertEqual(false);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag6 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(400, 400, 500, 500);
      try {
        let flag7 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag7 success`);
        expect(flag7).assertEqual(true);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag7 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(0, 0, 200, 100);
      try {
        let flag8 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag8 success`);
        expect(flag8).assertEqual(true);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag8 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(0, 100, 100, 400);
      try {
        let flag9 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag9 success`);
        expect(flag9).assertEqual(true);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag9 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(200, 400, 300, 500);
      try {
        let flag10 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag10 success`);
        expect(flag10).assertEqual(true);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag10 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      other.setRect(400, 300, 500, 500);
      try {
        let flag11 = region.quickRejectRegion(other);
        console.info(msg + `Region quickRejectRegion flag11 success`);
        expect(flag11).assertEqual(true);
      } catch (e) {
        console.info(msg +
          `Region quickRejectRegion flag11 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_QUICKREJECTREGION_3100
     * @tc.name      : testQuickRejectRegion0031
     * @tc.desc      : testRegionQuickRejectRegionMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testQuickRejectRegion0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionQuickRejectRegionMultipleCalls';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      let other = new drawing.Region(50.1, 50.1, 150.1, 150.1);
      for (let i = 0; i < 20; i += 1) {
        try {
          let flag1 = region.quickRejectRegion(other);
          console.info(msg + `region quickRejectRegion success step: ` + i);
          expect(flag1).assertEqual(false);
        } catch (e) {
          console.info(msg +
            `drawing region quickRejectRegion error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_QUICKREJECTREGION_3200
     * @tc.name      : testQuickRejectRegion0032
     * @tc.desc      : testRegionQuickRejectRegionNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testQuickRejectRegion0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionQuickRejectRegionNull';
      let region = new drawing.Region();
      try {
        region.quickRejectRegion(null);
        console.info(msg + `region quickRejectRegion null successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `region quickRejectRegion null failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        region.quickRejectRegion(undefined);
        console.info(msg + `region quickRejectRegion undefined successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `region quickRejectRegion undefined failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETEMPTY_3300
     * @tc.name      : testSetEmpty0033
     * @tc.desc      : testRegionSetEmptyNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetEmpty0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionSetEmptyNormal';
      let region = new drawing.Region();
      region.setEmpty();
      try {
        let flag: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag success`);
        expect(flag).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag1 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
      region.setRect(0, 0, 100, 100)
      region.setEmpty();
      try {
        let flag2: boolean = region.isEmpty();
        console.info(msg + `Region isEmpty flag2 success`);
        expect(flag2).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region isEmpty flag2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETEMPTY_3400
     * @tc.name      : testSetEmpty0034
     * @tc.desc      : testRegionSetEmptyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetEmpty0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionSetEmptyMultipleCalls';
      let region = new drawing.Region();
      for (let i = 0; i < 20; i += 1) {
        try {
          region.setEmpty()
          let flag: boolean = region.isEmpty();
          console.info(msg + `region isEmpty success step: ` + i);
          expect(flag).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `drawing region isEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETREGION_3500
     * @tc.name      : testSetRegion0035
     * @tc.desc      : testRegionSetRegionNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testSetRegion0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRegionSetRegionNormal';
      let region = new drawing.Region();
      let region2 = new drawing.Region();
      try {
        region2.setRegion(region);
        let setRegion = region2.isEmpty();
        console.info(msg + `Region setRegion 1 success`);
        expect(setRegion).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region setRegion 1 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 20, 20, 20)
      region2.setRegion(region);
      try {
        let rect = region2.getBounds();
        console.info(msg + `Region getBounds 2 success`);
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 10, 10, 20)
      region2.setRegion(region);
      try {
        let rect2 = region2.getBounds();
        console.info(msg + `Region getBounds rect2 success`);
        expect(rect2.left == 0 && rect2.top == 0 && rect2.right == 0 && rect2.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(20, 20, 20, 20)
      region2.setRegion(region);
      try {
        let rect3 = region2.getBounds();
        console.info(msg + `Region getBounds rect3 success`);
        expect(rect3.left == 0 && rect3.top == 0 && rect3.right == 0 && rect3.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0, 0, 100, 100)
      region2.setRegion(region);
      try {
        let rect4 = region2.getBounds();
        console.info(msg + `Region getBounds rect4 success`);
        expect(rect4.left == 0 && rect4.top == 0 && rect4.right == 100 && rect4.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0, 10.2632, 100.25474, 100.2884);
      try {
        region2.setRegion(region);
        console.info(msg + `Region region2 setRegion 2 success`);
      } catch (e) {
        console.info(msg + `Region region2 setRegion 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(-100, -100.98788, -50, -50);
      try {
        region2.setRegion(region);
        console.info(msg + `Region region2 setRegion 3 success`);
      } catch (e) {
        console.info(msg + `Region region2 setRegion 3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(100, 100.25, -100, -100.255)
      region2.setRegion(region);
      try {
        let rect7 = region2.getBounds();
        console.info(msg + `Region getBounds rect7 success`);
        console.info(msg + `Region getBounds rect7: ` + JSON.stringify(rect7));
        expect(rect7.left == 0 && rect7.top == 0 && rect7.right == 0 && rect7.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect7 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let path = new drawing.Path()
      region.setRect(100, 100, 400, 400);
      path.arcTo(50, 50, 300, 300, 0, 359);
      region.setPath(path, region);
      try {
        region2.setRegion(region);
        console.info(msg + `Region region2 setRegion 4 success`);
      } catch (e) {
        console.info(msg + `Region region2 setRegion 4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETREGION_3600
     * @tc.name      : testSetRegion0036
     * @tc.desc      : testRegionSetRegionMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetRegion0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionSetRegionMultipleCalls';
      let region = new drawing.Region();
      let region2 = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      for (let i = 0; i < 20; i += 1) {
        try {
          region2.setRegion(region);
          console.info(msg + `region2 setRegion success step: ` + i);
        } catch (e) {
          console.info(msg +
            `drawing region2 setRegion error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETREGION_3700
     * @tc.name      : testSetRegion0037
     * @tc.desc      : testRegionSetRegionNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testSetRegion0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRegionSetRegionNull';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      try {
        region.setRegion(null);
        console.info(msg + `region setRegion null successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `region setRegion null failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        region.setRegion(undefined);
        console.info(msg + `region setRegion undefined successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `region setRegion undefined failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISPOINTCONTAINED_3800
     * @tc.name      : testIsPointContained0038
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testIsPointContained0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        let flag: boolean = false;
        flag = region.isPointContained(null, 200);
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of RegionIsPointContained Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of RegionIsPointContained Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_ISREGIONCONTAINED_3900
     * @tc.name      : testIsRegionContained0039
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testIsRegionContained0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        let flag: boolean = false;
        flag = region.isRegionContained(null)
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of RegionIsRegionContained Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of RegionIsRegionContained Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_OP_4000
     * @tc.name      : testOp0040
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testOp0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        region.setRect(200, 200, 400, 400);
        let othregion = new drawing.Region();
        othregion.setRect(110, 110, 240, 240);
        let flag: boolean = false;
        flag = region.op(null, null);
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of RegionOp Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of RegionOp Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_QUICKREJECT_4100
     * @tc.name      : testQuickReject0041
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testQuickReject0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        region.setRect(100, 100, 400, 400);
        let flag: boolean = false;
        flag = region.quickReject(null, 50, 70, 70);
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of RegionQuickReject Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of RegionQuickReject Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETPATH_4200
     * @tc.name      : testSetPath0042
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetPath0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setRect(100, 100, 400, 400);
        path.arcTo(50, 50, 300, 300, 0, 359);
        let flag: boolean = false;
        flag = region.setPath(null, region);
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of RegionSetPath Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of RegionSetPath Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHI_REGION_SETRECT_4300
     * @tc.name      : testSetRect0043
     * @tc.desc      : test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testSetRect0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        let flag: boolean = false;
        flag = region.setRect(null, 50, 300, 300);
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of RegionSetRect Manager error' + err.code);
          done();
        } else {
          console.log('test enum value of RegionSetRect Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })
  })
}
