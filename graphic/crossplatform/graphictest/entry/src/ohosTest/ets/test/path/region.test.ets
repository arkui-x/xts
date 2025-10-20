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
import image from '@ohos.multimedia.image';
import common2D from '@ohos.graphics.common2D';

export default function drawingTsRegionTest() {
  describe('DrawingTsRegionTest', () => {
    let pixel: image.PixelMap;
    beforeAll(async () => {
      let color: ArrayBuffer = new ArrayBuffer(40000); // 96为需要创建的像素buffer大小，取值为：height * width *4
      let opts: image.InitializationOptions = {
        editable: true, pixelFormat: 3, size: {
          height: 100, width: 100
        }
      }
      pixel = await image.createPixelMap(color, opts);
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0100
     * @tc.name      : testRegionSetPathNormal0001
     * @tc.desc      : testRegionSetPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testRegionSetPathNormal0001', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testRegionSetPathNormal0001';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setRect(100, 100, 400, 400);
        path.arcTo(50, 50, 300, 300, 0, 359);
        region.setPath(path,region);
        canvas.drawRegion(region);
        console.info(msg + `setPath successed`);
      } catch (e) {
        console.info(msg + `setPath failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0200
     * @tc.name      : testRegionSetPathMultipleCalls0002
     * @tc.desc      : testRegionSetPathMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testRegionSetPathMultipleCalls0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testRegionSetPathMultipleCalls0002';
      try {
        let canvas = new drawing.Canvas(pixel);
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setRect(100, 100, 400, 400);
        path.arcTo(50, 50, 300, 300, 0, 359);
        let flag: boolean = false;
        for (let index = 0; index < 20; index++) {
          flag = region.setPath(path,region);
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0300
     * @tc.name      : testRegionIsComplexNormal0003
     * @tc.desc      : testRegionIsComplexNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testRegionIsComplexNormal0003', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testRegionIsComplexNormal0003';
      let region = new drawing.Region();
      try {
        let flag: boolean = region.isComplex();
        console.info(msg + `Region isComplex flag success`);
        expect(flag).assertEqual(false);
      } catch (e) {
        console.info(msg + `Region isComplex flag error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region = new drawing.Region(100,100,200,200);
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
      region.setPath(path,region);
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0400
     * @tc.name      : testRegionGetBoundsNormal0004
     * @tc.desc      : testRegionGetBoundsNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testRegionGetBoundsNormal0004', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testRegionGetBoundsNormal0004';
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
      region = new drawing.Region(0,0,0,0);
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
      region.setRect(0,10.2632,100.25474,100.2884);
      try {
        let rect8: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect8 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect8)}`);
        expect(rect8.left == 0 && rect8.top == 10 && rect8.right == 100 && rect8.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect8 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(-100,-100.98788,-50,-50);
      try {
        let rect9: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect9 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect9)}`);
        expect(rect9.left == -100 && rect9.top == -100 && rect9.right == -50 && rect9.bottom == -50).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect9 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(100,100.25,-100,-100.255);
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
      region.setPath(path,region);
      try {
        let rect11: common2D.Rect = region.getBounds();
        console.info(msg + `Region getBounds rect11 success`);
        console.info(msg + `rect11: ${JSON.stringify(rect11)}`);
        expect(rect11.left == 100 && rect11.top == 100 && rect11.right == 300 && rect11.bottom == 300).assertEqual(true);
      } catch (e) {
        console.info(msg + `Region getBounds rect11 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0500
     * @tc.name      : testRegionGetBoundaryPathNormal0005
     * @tc.desc      : testRegionGetBoundaryPathNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testRegionGetBoundaryPathNormal0005', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testRegionGetBoundaryPathNormal0005';
      let region = new drawing.Region();
      try {
        let getpath = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath success`);
        expect(getpath != null || getpath != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let region1 = new drawing.Region(region);
      try {
        let getpath2 = region1.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath2 success`);
        expect(getpath2 != null || getpath2 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region = new drawing.Region(0,0,0,0);
      try {
        let getpath3 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath3 success`);
        expect(getpath3 != null || getpath3 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 20, 20, 20);
      try {
        let getpath4 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath4 success`);
        expect(getpath4 != null || getpath4 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(10, 10, 10, 20);
      try {
        let getpath5 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath5 success`);
        expect(getpath5 != null || getpath5 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(20, 20, 20, 20);
      try {
        let getpath6 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath6 success`);
        expect(getpath6 != null || getpath6 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath6 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(50, 50, 300, 300);
      try {
        let getpath7 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath7 success`);
        expect(getpath7 != null || getpath7 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath7 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(0,100.2632,600.25474,500.2884);
      try {
        let getpath8 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath8 success`);
        expect(getpath8 != null || getpath8 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath8 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(-100,-100.98788,450,450);
      try {
        let getpath9 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath9 success`);
        expect(getpath9 != null || getpath9 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath9 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(100,100.25,-100,-100.255);
      try {
        let getpath10 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath10 success`);
        expect(getpath10 != null || getpath10 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath10 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let path = new drawing.Path()
      region.setRect(100, 100, 400, 400);
      path.arcTo(50, 50, 300, 300, 0, 359);
      region.setPath(path,region);
      try {
        let getpath11 = region.getBoundaryPath();
        console.info(msg + `Region getBoundaryPath getpath11 success`);
        expect(getpath11 != null || getpath11 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `Region getBoundaryPath getpath11 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0600
     * @tc.name      : testRegionOffsetNormal0006
     * @tc.desc      : testRegionOffsetNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testRegionOffsetNormal0006', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testRegionOffsetNormal0006';
      let region = new drawing.Region();
      try {
        region.offset(10,20);
        console.info(msg + `Region offset 1 success`);
      } catch (e) {
        console.info(msg + `Region offset 1 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(50, 50, 300, 300);
      try {
        region.offset(-50,-50);
        console.info(msg + `Region offset 2 success`);
      } catch (e) {
        console.info(msg + `Region offset 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        region.offset(100.25,150.852);
        region.offset(100.25,0);
        console.info(msg + `Region offset 3 success`);
      } catch (e) {
        console.info(msg + `Region offset 3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        region.offset(-100.25,300.25);
        console.info(msg + `Region offset 4 success`);
      } catch (e) {
        console.info(msg + `Region offset 4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let path = new drawing.Path()
      region.setRect(100, 100, 400, 400);
      path.arcTo(50, 50, 300, 300, 0, 359);
      region.setPath(path,region);
      try {
        region.offset(-100.25,500.25);
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0700
     * @tc.name      : testRegionSetRegionNormal0007
     * @tc.desc      : testRegionSetRegionNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testRegionSetRegionNormal0007', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL0, () => {
      let msg = 'testRegionSetRegionNormal0007';
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
      region.setRect(0,10.2632,100.25474,100.2884);
      try {
        region2.setRegion(region);
        console.info(msg + `Region region2 setRegion 2 success`);
      } catch (e) {
        console.info(msg + `Region region2 setRegion 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(-100,-100.98788,-50,-50);
      try {
        region2.setRegion(region);
        console.info(msg + `Region region2 setRegion 3 success`);
      } catch (e) {
        console.info(msg + `Region region2 setRegion 3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      region.setRect(100,100.25,-100,-100.255)
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
      region.setPath(path,region);
      try {
        region2.setRegion(region);
        console.info(msg + `Region region2 setRegion 4 success`);
      } catch (e) {
        console.info(msg + `Region region2 setRegion 4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_REGION_0800
     * @tc.name      : testRegionGetBoundsMultipleCalls0002
     * @tc.desc      : testRegionGetBoundsMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testRegionGetBoundsMultipleCalls0002', TestType.FUNCTION|Size.MEDIUMTEST|Level.LEVEL3, () => {
      let msg = 'testRegionGetBoundsMultipleCalls0002';
      let region = new drawing.Region();
      region.setRect(100, 100, 400, 400);
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect = region.getBounds();
          console.info(msg + `region getBounds success step: ` + i);
          console.info(msg + `rect: ${JSON.stringify(rect)}`);
          expect(rect.left == 100 && rect.top == 100 && rect.right == 400 && rect.bottom == 400).assertEqual(true);
        } catch (e) {
          console.info(msg + `drawing region getBounds error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })
  })
}
