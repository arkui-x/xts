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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from "@ohos/hypium"
import drawing from "@ohos.graphics.drawing"

export default function drawingCodeTest() {
  describe('drawingCodeTest', () => {
    console.info('describe drawingCodeTest start!!!');
    beforeAll(() => {
      console.info('before all');
    })
    beforeEach(() => {
      console.info('before each');
    })
    afterEach(async (done: Function) => {
      console.info('afterEach');
      done();
    })
    afterAll(() => {
      console.info('afterAll');
    })

    /**
     * @tc.number SUB_GRAPHIC_DrawingCode_PathMoveTo0100
     * @tc.name Test PathMoveTo0001
     * @tc.desc test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('PathMoveTo0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      console.info('test PathMoveTo0001 begin');
      try {
        let path = new drawing.Path();
        path.moveTo(null, 10);
        console.log('test enum value of PathMoveTo Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PathMoveTo Manager error ' + err.code);
          done();
        } else {
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number SUB_GRAPHIC_DrawingCode_PathLineTo0200
     * @tc.name Test PathLineTo0002
     * @tc.desc test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('PathLineTo0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.lineTo(null, 15);
        console.log('test enum value of PathLineTo Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PathLineTo Manager error ' + err.code);
          done();
        } else {
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number SUB_GRAPHIC_DrawingCode_PathArcTo0300
     * @tc.name Test PathArcTo0003
     * @tc.desc test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('PathArcTo0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.arcTo(null, 15, 10, 10, 10, 10);
        console.log('test enum value of PathArcTo Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PathArcTo Manager error ' + err.code);
          done();
        } else {
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number SUB_GRAPHIC_DrawingCode_PathQuadTo0400
     * @tc.name Test PathQuadTo0004
     * @tc.desc test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('PathQuadTo0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.quadTo(null, 15, 10, 10);
        console.log('test enum value of PathQuadTo Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PathQuadTo Manager error ' + err.code);
          done();
        } else {
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number SUB_GRAPHIC_DrawingCode_PathCubicTo0500
     * @tc.name Test PathCubicTo0005
     * @tc.desc test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('PathCubicTo0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let path = new drawing.Path();
        path.moveTo(10, 10);
        path.cubicTo(null, 10, 10, 10, 15, 15);
        console.log('test enum value of PathCubicTo Manager success');
        expect().assertFail();
        done();
      } catch (err) {
        if (err.code == 401) {
          console.log('test enum value of PathCubicTo Manager error' + err.code);
          done();
        } else {
          expect().assertFail();
          done();
        }
      }
    })

    /**
     * @tc.number SUB_GRAPHIC_DrawingCode_RegionSetPath0600
     * @tc.name Test RegionSetPath0006
     * @tc.desc test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('RegionSetPath0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setRect(100, 100, 400, 400);
        path.arcTo(50, 50, 300, 300, 0, 359);
        let flag: boolean = false;
        flag = region.setPath(null,region);
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
     * @tc.number SUB_GRAPHIC_DrawingCode_RegionSetPathTwo0700
     * @tc.name Test RegionSetPath0007
     * @tc.desc test the drawing of create
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('RegionSetPath0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      try {
        let region = new drawing.Region();
        let path = new drawing.Path();
        region.setRect(100, 100, 400, 400);
        path.arcTo(50, 50, 300, 300, 0, 359);
        let flag: boolean = false;
        flag = region.setPath(null,region);
        done()
      } catch (err) {
        if (err.code == 401) {
          console.log('RegionSetPathTwo test enum value of RegionSetPath Manager error' + err.code);
          done();
        } else {
          console.log('RegionSetPathTwo test enum value of RegionSetPath Manager error1' + JSON.stringify(err))
          expect().assertFail();
          done();
        }
      }
    })
  })
}